%% @author billcyz
%% @doc @todo Add description to rtmessage_user_service_sup.


-module(rtmessage_user_service_sup).
-behaviour(supervisor).
-export([init/1]).

%% ====================================================================
%% API functions
%% ====================================================================
-export([]).

-spec start_link() -> {ok, Pid()}.
start_link() ->
	supervisor:start_link({local, user_service}, ?MODULE, []).

%% ====================================================================
%% Behavioural functions
%% ====================================================================

init([]) ->
    AChild = {'AName',{'AModule',start_link,[]},
	      permanent,2000,worker,['AModule']},
    {ok,{{one_for_all,0,1}, [AChild]}}.

%% ====================================================================
%% Internal functions
%% ====================================================================


