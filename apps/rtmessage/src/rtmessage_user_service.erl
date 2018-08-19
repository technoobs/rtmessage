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
-spec start_link()

%% Register user in system when user logs in.
-spec register_user(atom(), term()) -> ok | {error, term()}.
register_user(User, UserId) ->
	1.



