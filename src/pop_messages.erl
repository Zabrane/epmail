%%%-------------------------------------------------------------------
%%% @author  <Kuleshov Alexander>
%%% @copyright (C) 2011, 
%%% @doc
%%%
%%% @end
%%% Created : 19 Jan 2011 by  <kuleshovmail@gmail.com>
%%%------------------------------------------------------------------

-module(pop_messages).

-export([err_message/0, ok_message/0]).

-export([is_message_user/1]).
-export([is_message_pass/1]).
-export([is_message_list/1]).
-export([is_message_retr/1]).
-export([is_message_dele/1]).
-export([is_message_uidl/1]).
-export([is_message_top/1]).

-vsn('0.3').
-author('kuleshovmail@gmail.com').

err_message() ->
    ["-ERR\r\n"].

ok_message() ->
    ["+OK"].

%
% POP3 USER USER_NAME message
% +OK || -ERR
%
is_message_user([]) ->
    error;
is_message_user(UserName) when is_list(UserName) ->
   [H | T] = string:tokens(UserName, " "),
 
   case [H | T] of
      ["user", _] ->
	   {H, T};  
      
      [_, _] ->
	  error;
      
      [_] ->
	   error;
 
      "user" ->
	   error;
       
      [] ->
	   error;
       
       _ ->
	   error
   end.

%
% POP3 PASS PASSWORD message
% +OK || -ERR
%
is_message_pass([]) ->
    error;
is_message_pass(Password) when is_list(Password) ->
   [H | T] = string:tokens(Password, " "),
   case [H | T] of
      ["pass", _] ->
	  {H, T};
       
      [_, _] ->
	  error;
       
      [_] ->
          error;

      "pass" ->
	   error;

      [] ->
	   error;
       
       _ ->
	   error
   end.

%
% POP3 LIST || num message
% +OK num message octets message
%
is_message_list([]) ->
    error;
is_message_list(Message)  ->
   [H | T] = string:tokens(Message, " "),
   case [H | T] of
      ["list", _]  ->
	  {H, T};
       
      ["list"] ->
      	   {H};
       
      [_, _] ->
	  error;
      
      [_] ->
          error;

      list ->
          error;
       
      [] ->
	   error;
      _ ->
	   error
   end.

%
% POP3 RETR num message
% +OK
% message data
% .
%
is_message_retr([]) ->
    error;
is_message_retr(Message)  ->
   [H | T] = string:tokens(Message, " "),
   case [H | T] of
      ["retr", _] ->
	  {H, T};
       
      [_, _] ->
	  error;
      
      [_] ->
          error;

      "retr" ->
	  error;
       
      [] ->
	   error;
      _ ->
	   error
	      
   end.

%
% POP3 DELE  num message
% +OK message num deleted
%
is_message_dele([]) ->
    error;
is_message_dele(Message) ->
   [H | T] = string:tokens(Message, " "),
   case [H | T] of
      ["dele", _] ->
	  {H, T};

      [_, _] ->
	  error;
       
      [_] ->
	   error;
       
      "dele" ->
	   error;
       
      [] ->
	   error;
       
       _ ->
	   error
   end.

%
% POP3 UIDL  num message
% +OK message num has (num octets)
%
is_message_uidl([]) ->
    error;
is_message_uidl(Message) ->
  [H | T] = string:tokens(Message, " "),
   case [H | T] of
      ["uidl", _]  ->
	  {H, T};
       
      ["uidl"] ->
      	   {H};
       
      [_, _] ->
	  error;
      
      [_] ->
          error;

      uidl ->
          error;
       
      [] ->
	   error;
      _ ->
	   error
   end.

%
% POP3 TOP mes num 
% 
is_message_top([]) ->
    error;
is_message_top(Message)  ->
    [H | T] = string:tokens(Message, " "),
    case [H | T] of
	["top"] ->
	    error;
	
	["top" | _]  ->
	    {H, T};
       
	[_] ->
	    error;

	top ->
	    error;
       
	[] ->
	    error;

	_ ->
	    error
    end.
