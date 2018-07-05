-define(TX_PS_EMPTY, 0).
-define(TX_PS_WAIT, 1).
-define(TX_PS_PLAY, 2).
-define(TX_PS_SB, 4).
-define(TX_PS_BB, 8).
-define(TX_PS_FOLD, 16).
-define(TX_PS_CALL, 32).
-define(TX_PS_CHECK, 64).
-define(TX_PS_RAISE, 128).
-define(TX_PS_ALLIN, 256).
-define(TX_PS_END, 512).

-define(TX_GS_WAIT, 1).
-define(TX_GS_START, 2).
-define(TX_GS_BLINDS, 3).
-define(TX_GS_DEAL, 4).
-define(TX_GS_PREFLOP, 5).
-define(TX_GS_DEAL_3, 6).
-define(TX_GS_FLOP, 7).
-define(TX_GS_DEAL_4, 8).
-define(TX_GS_TURN, 9).
-define(TX_GS_DEAL_5, 10).
-define(TX_GS_RIVER, 11).
-define(TX_GS_END, 12).

-define(TX_ACT_TIMEOUT, 30000).
-define(TX_END_TIMEOUT, 3000).

-define(TX_PS_ANY,
		?TX_PS_WAIT bor
		?TX_PS_PLAY bor
		?TX_PS_SB bor
		?TX_PS_BB bor
		?TX_PS_FOLD bor
		?TX_PS_CALL bor
		?TX_PS_CHECK bor
		?TX_PS_RAISE bor
		?TX_PS_ALLIN bor
		?TX_PS_END).

-define(TX_PS_ACTIVE,
		?TX_PS_PLAY bor
		?TX_PS_SB bor
		?TX_PS_BB).

-define(TX_PS_STANDING,
		?TX_PS_PLAY bor
		?TX_PS_SB bor
		?TX_PS_BB bor
		?TX_PS_CALL bor
		?TX_PS_CHECK bor
		?TX_PS_RAISE bor
		?TX_PS_ALLIN).

-define(TX_PS_RESET,
		?TX_PS_SB bor
		?TX_PS_BB bor
		?TX_PS_CALL bor
		?TX_PS_CHECK bor
		?TX_PS_RAISE).

-define(TX_PS_SHOWDOWN,
		?TX_PS_PLAY bor
		?TX_PS_SB bor
		?TX_PS_BB bor
		?TX_PS_CALL bor
		?TX_PS_CHECK bor
		?TX_PS_RAISE bor
		?TX_PS_ALLIN).

-record(tx_seat, {
		  aid = none,
		  state = ?TX_PS_EMPTY,
		  bet = 0,
		  chips = 0,
		  cards = [],
		  hand = none % #tx_hand
		 }).

-record(tx_state, {
		  %% owner pid
		  owner = none,
		  %% dealer seat num
		  dealer = 0,
		  %% small blind seat num
		  sbseat = 0,
		  %% big blind seat num
		  bbseat = 0,
		  %% game state
		  state = ?TX_GS_WAIT,
		  %% aid to seat cross-reference
		  xref = maps:new(),
		  %% blinds: {small, big}
		  blinds = {10, 20},
		  %% seats tuple
		  seats,
		  %% cards
		  deck = [],
		  %% cards
		  board = [],
		  %% pot
		  pot = none,
		  %% required player count
		  required_player_count = 2,
		  timeout = 0,
		  timer = none,
		  expire = 0,
		  current = 0,
		  call = 0, % amount to call
		  winners = []
		 }).

-record(tx_hand, {
		  aid,
		  cards,
		  rank,
		  high,
		  score
		 }).

-record(tx_side_pot, {
		  members,
		  allin
		 }).

-record(tx_pot, {
		  active = [],
		  inactive = [],
		  current = none % #tx_side_pot
		 }).

