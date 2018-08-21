%% @author billcyz
%% @doc @todo Add description to rtmessage_user_service.


-module(rtmessage_user_service).
-behaviour(gen_server).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).

%% ====================================================================
%% API functions
%% ====================================================================
-export([]).

%% Start user service
-spec start_link(list()) -> {ok, pid()}.
start_link(UserInfo) ->
	gen_server:start_link(?MODULE, UserInfo, []).

%% ====================================================================
%% Behavioural functions
%% ====================================================================

-record(state, {node, msg_box, user_box, user_name, user_id}).

init([UserName, UserId, LandNode]) ->
	%% Fetch user contact
	UserBox = [],
	%% Fetch messages
	UserMsgBox = [],
	{ok, #state{node = LandNode,
				user_box = UserBox,
				msg_box = UserMsgBox, 
				user_name = UserName, 
				user_id = UserId}}.

%% ====================================================================
%% Internal functions
%% ====================================================================

%% Register user in system when user logs in.
-spec register_user(atom(), term()) -> ok | {error, term()}.
register_user(User, UserId) ->
	1.

%% Get user contacts
-spec get_user_contacts(User :: atom(), UserId :: atom()) -> ContactList :: list().
get_user_contact(User, UserId) ->
	ContactList = [].


