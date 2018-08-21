%% @author billcyz
%% @doc @todo Add description to rtmessage_users_server.

%% User management server

-module(rtmessage_users_server).
-behaviour(gen_server).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

%% ====================================================================
%% API functions
%% ====================================================================
-export([start_link/1]).

%% Start user management server
-spec start_link(atom()) -> {ok, pid()} | 'ignore' | {error, term()}.
start_link(ServerId) ->
	gen_server:start_link({local, rtmsg_users}, ?MODULE, 
						  [{server_id, ServerId}], []).


%% ====================================================================
%% Behavioural functions
%% ====================================================================
-record(state, {server_id, users, sup_id}).

init([{_, ServerId}]) ->
	{ok, SupPid} = start_user_sup(),
	{ok, #state{server_id = ServerId, users = [], sup_id = SupPid}}.

%% Handle Cast
%% >> Remove user
handle_cast({log_out, [{User, UserId}]}, State) ->
	UsersList = State#state.users,
	{noreply, State#state{users = lists:delete({User, UserId}, UsersList)}};
handle_cast(_Request, State) -> {noreply, State}.

%% Handle Call
%% >> Register user to server
handle_call({register, [{User, UserId}]}, _From, State) ->
	UsersList = State#state.users,
	case lists:member({User, UserId}, UsersList) of
		true -> {reply, duplicate_user, State};
		false ->
			start_user_process({User, UserId}, node()),
			Reply = {ok, [{User, UserId}, State#state.server_id]},
			{reply, Reply, State#state{users = [{User, UserId} | UsersList]}}
	end.

%% Handle Info
handle_info(_Info, State) -> {noreply, State}.

%% Code Change
code_change(_Old, State, _Extra) -> {ok, State}.

%% Terminate
terminate(_Reason, _State) -> 'ok'.

%% ====================================================================
%% Internal functions
%% ====================================================================

%% Start supervisor for users
-spec start_user_sup() -> {ok, pid()}.
start_user_sup() ->
	supervisor:start_link({local, rtmsg_users_sup}, rtmessage_user_service_sup, []).

%% Start user process for each user
-spec start_user_process(tuple(), node()) -> {ok, list()}.
start_user_process(User, LandNode) ->
	{UserName, UserId} = User,
	ChildSpec = {UserId,
				 {rtmessage_user_service, start_link, [UserName, UserId, LandNode]},
				 permanent, 500, worker, [rtmessage_user_service]},
	supervisor:start_child(rtmsg_users_sup, ChildSpec).
