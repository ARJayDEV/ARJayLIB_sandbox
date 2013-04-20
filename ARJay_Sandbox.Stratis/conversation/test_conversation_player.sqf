BIS_convMenu = [];

switch (_sentenceId) do {
	case "introduction": {
		BIS_convMenu = BIS_convMenu + [[localize "@STR_T_C_PLAYER_APPROACH", _topic, "player_approach", []]];
		BIS_convMenu = BIS_convMenu + [[localize "@STR_T_C_PLAYER_LEAVE", _topic, "player_leave", []]];
	};
	case "target_greeting": {
		BIS_convMenu = BIS_convMenu + [[localize "@STR_T_C_PLAYER_GREETING1", _topic, "player_greeting1", []]];
		BIS_convMenu = BIS_convMenu + [[localize "@STR_T_C_PLAYER_GREETING2", _topic, "player_greeting2", []]];
	};
	case "target_greeting1_response": {
		BIS_convMenu = BIS_convMenu + [[localize "@STR_T_C_PLAYER_RESPONSE1", _topic, "player_response1", []]];
		BIS_convMenu = BIS_convMenu + [[localize "@STR_T_C_PLAYER_RESPONSE2", _topic, "player_response2", []]];
		BIS_convMenu = BIS_convMenu + [[localize "@STR_T_C_PLAYER_RESPONSE3", _topic, "player_response3", []]];
	};
	case "target_response1": {
		[_this, _from, _topic] spawn {
			sleep 2;
			 _this select 0 kbTell [_this select 1, _this select 2, "player_goodbye"];
		};
	};
	case "target_response2": {
		[_this, _from, _topic] spawn {
			sleep 2;
			 _this select 0 kbTell [_this select 1, _this select 2, "player_goodbye"];
		};
	};
	case "target_response3": {
		[_this, _from, _topic] spawn {
			sleep 2;
			 _this select 0 kbTell [_this select 1, _this select 2, "player_goodbye"];
		};
	};
};

BIS_convMenu