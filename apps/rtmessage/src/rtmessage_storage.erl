%% @author billcyz
%% @doc @todo Add description to rtmessage_storage.


-module(rtmessage_storage).
-behaviour(gen_server).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

%% ====================================================================
%% API functions
%% ====================================================================
-export([]).

-define(UserTables, [login_users, user_contacts]).
-define(MessageTables, [users_message]).

start_link() ->
	gen_server:start_link({local, ?MODULE}, ?Module, [], []).

%% ====================================================================
%% Behavioural functions
%% ====================================================================
-record(state, {node}).

init([]) ->
	ok = prepare_users_table(?UserTables),
	ok = prepare_users_message_table(?MessageTables),
    {ok, #state{node = node()}}.



%% ====================================================================
%% Internal functions
%% ====================================================================

%% Prepare required tables for users
-spec prepare_users_table(TableList :: list()) -> 'ok'.
prepare_users_table([H|T]) ->
	case ets:info(H) of
		undefined -> create_users_table(H);
		_ -> prepare_users_table(T)
	end;
prepare_users_table([]) -> 'ok'.

%% Prepare required tables for user message
-spec prepare_users_message_table(TableList :: list()) -> 'ok'.
prepare_users_message_table([H|T]) ->
	case ets:info(H) of
		undefined -> create_users_message_table(H);
		_ -> prepare_users_message_table(T)
	end;
prepare_users_message_table([]) -> 'ok'.

%% Create users table
-spec create_users_table(TableName :: atom()) -> atom().
create_users_table(TableName) ->
	case TableName of
		login_users -> ets:new(login_users, [set, private, named_table,
											 {write_concurrency, true},
											 {read_concurrency, true}]);
		user_contacts -> ets:new(user_contacts, [set, private, named_table,
												 {write_concurrency, true},
												 {read_concurrency, true}])
	end.

%% Create message table
-spec create_users_message_table(TableName :: atom()) -> atom().
create_users_message_table(TableName) ->
	case TableName of
		users_message -> ets:new(users_message, [bag, private, named_table,
												 {write_concurrency, true},
												 {read_concurrency, true}])
	end.










