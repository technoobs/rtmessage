%% @author billcyz
%% @doc @todo Add description to rtmessage_broker.


%% Message broker that responsible for sending and receiving messages.

-module(rtmessage_broker).

%% ====================================================================
%% API functions
%% ====================================================================
-export([]).

%% Send message to receiver. 'Extra' contains rules and communication
%% config, such as 'Chat Room' or 'Chat Channel', or even 'Message Validation
%% Data'.
-spec sendMsg(From :: atom(), To :: atom(), Msg :: binary(), Extra :: list()) -> 'ok'.
sendMsg(From, To, Msg, Extra) ->
	1.

%% Receive message
-spec receiveMsg(From :: atom(), To :: atom(), Msg :: binary(), Extra :: list()) -> 'ok'.
receiveMsg(From, To, Msg, Extra) ->
	1.

%% ====================================================================
%% Internal functions
%% ====================================================================

%% Find user's message box

