
%% Finding which way should the message goes.

-module(rtmessage_routing).
-include_lib("eunit/include/eunit.hrl").

-export([]).

%%====================================================================
%% API
%%====================================================================


%% -- Register communication channel --
-spec register_channel(atom, atom) -> 'ok'.
register_channel(Sender, Receiver) ->
    1.

%%====================================================================
%% Internal functions
%%====================================================================

reverse_test() ->
	io:format("sss"),
	lists:reverse([1,2,3]).

length_test() -> ?assert(length([1,2,3]) =:= 3).




