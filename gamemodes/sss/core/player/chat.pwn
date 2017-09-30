/*==============================================================================


	Southclaws' Scavenge and Survive

		Copyright (C) 2017 Barnaby "Southclaws" Keene

		This program is free software: you can redistribute it and/or modify it
		under the terms of the GNU General Public License as published by the
		Free Software Foundation, either version 3 of the License, or (at your
		option) any later version.

		This program is distributed in the hope that it will be useful, but
		WITHOUT ANY WARRANTY; without even the implied warranty of
		MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
		See the GNU General Public License for more details.

		You should have received a copy of the GNU General Public License along
		with this program.  If not, see <http://www.gnu.org/licenses/>.


==============================================================================*/


#include <YSI\y_hooks>


// Chat modes
enum
{
		CHAT_MODE_LOCAL,		// 0 - Speak to players within chatbubble distance
		CHAT_MODE_GLOBAL,		// 1 - Speak to all players
		CHAT_MODE_RADIO,		// 2 - Speak to players on the same radio frequency
		CHAT_MODE_ADMIN			// 3 - Speak to admins
}


new
		chat_Mode[MAX_PLAYERS],
Float:	chat_Freq[MAX_PLAYERS],
bool:	chat_Quiet[MAX_PLAYERS],
		chat_MessageStreak[MAX_PLAYERS],
		chat_LastMessageTick[MAX_PLAYERS];


forward Float:GetPlayerRadioFrequency(playerid);
forward OnPlayerSendChat(playerid, text[], Float:frequency);
forward OnDiscordChat(data[]);


hook OnGameModeInit()
{
	Redis_BindMessage(gRedis, "ss.rediscord.incoming-global", "OnDiscordChat");
}

hook OnPlayerConnect(playerid)
{
	dbg("global", CORE, "[OnPlayerConnect] in /gamemodes/sss/core/player/chat.pwn");

	chat_LastMessageTick[playerid] = 0;
	return 1;
}

hook OnPlayerText(playerid, text[])
{
	dbg("global", CORE, "[OnPlayerText] in /gamemodes/sss/core/player/chat.pwn");

	if(IsPlayerMuted(playerid))
	{
		if(GetPlayerMuteRemainder(playerid) == -1)
			ChatMsgLang(playerid, RED, "MUTEDPERMAN");

		else
			ChatMsgLang(playerid, RED, "MUTEDTIMERM", MsToString(GetPlayerMuteRemainder(playerid) * 1000, "%1h:%1m:%1s"));

		return 0;
	}
	else
	{
		if(GetTickCountDifference(GetTickCount(), chat_LastMessageTick[playerid]) < 1000)
		{
			chat_MessageStreak[playerid]++;
			if(chat_MessageStreak[playerid] == 3)
			{
				TogglePlayerMute(playerid, true, 30);
				ChatMsgLang(playerid, RED, "MUTEDFLOODM");
				return 0;
			}
		}
		else
		{
			if(chat_MessageStreak[playerid] > 0)
				chat_MessageStreak[playerid]--;
		}
	}

	chat_LastMessageTick[playerid] = GetTickCount();

	if(chat_Mode[playerid] == CHAT_MODE_LOCAL)
		PlayerSendChat(playerid, text, 0.0);

	if(chat_Mode[playerid] == CHAT_MODE_GLOBAL)
		PlayerSendChat(playerid, text, 1.0);

	if(chat_Mode[playerid] == CHAT_MODE_ADMIN)
		PlayerSendChat(playerid, text, 3.0);

	if(chat_Mode[playerid] == CHAT_MODE_RADIO)
		PlayerSendChat(playerid, text, chat_Freq[playerid]);

	return 0;
}

public OnDiscordChat(data[])
{
	new
		user[MAX_PLAYER_NAME],
		message[256],
		delim;

	while(delim <= MAX_PLAYER_NAME && data[delim] != ':')
		delim++;
	
	if(delim > MAX_PLAYER_NAME)
	{
		err("OnDiscordChat sent malformed message: '%s'", data);
		return;
	}

	strmid(user, data, 0, delim, MAX_PLAYER_NAME);
	strmid(message, data, delim, strlen(data), 256);

	log("[CHAT] [DISCORD] [%s]: %s", user, message);

	new
		line1[256],
		line2[128];

	format(line1, 256, "[DISCORD] "C_TEAL"%s"C_WHITE": %s", user, TagScan(message));

	TruncateChatMessage(line1, line2);

	return;
}

PlayerSendChat(playerid, chat[], Float:frequency)
{
	if(!IsPlayerLoggedIn(playerid))
		return 0;

	if(GetTickCountDifference(GetTickCount(), GetPlayerServerJoinTick(playerid)) < 1000)
		return 0;

	if(CallLocalFunction("OnPlayerSendChat", "dsf", playerid, chat, frequency))
		return 0;

	if(isnull(chat))
		return 0;

	new
		line1[256],
		line2[128];

	if(frequency == 0.0)
	{
		log("[CHAT] [LOCAL] [%p]: %s", playerid, chat);

		new
			Float:x,
			Float:y,
			Float:z;

		GetPlayerPos(playerid, x, y, z);

		format(line1, 256, "[Local] (%d) %P"C_WHITE": %s",
			playerid,
			playerid,
			TagScan(chat));

		TruncateChatMessage(line1, line2);

		foreach(new i : Player)
		{
			if(IsPlayerInRangeOfPoint(i, 40.0, x, y, z))
			{
				SendClientMessage(i, CHAT_LOCAL, line1);

				if(!isnull(line2))
					SendClientMessage(i, CHAT_LOCAL, line2);
			}
		}

		SetPlayerChatBubble(playerid, TagScan(chat), WHITE, 40.0, 10000);

		return 1;
	}
	else if(frequency == 1.0)
	{
		log("[CHAT] [GLOBAL] [%p]: %s", playerid, chat);

		format(line1, 256, "[Global] (%d) %P"C_WHITE": %s",
			playerid,
			playerid,
			TagScan(chat));

		Redis_SendMessage(gRedis, "ss.rediscord.outgoing-global", sprintf("%p (%d):%s", playerid, playerid, chat));

		TruncateChatMessage(line1, line2);

		foreach(new i : Player)
		{
			if(chat_Quiet[i])
				continue;

			SendClientMessage(i, WHITE, line1);

			if(!isnull(line2))
				SendClientMessage(i, WHITE, line2);
		}

		SetPlayerChatBubble(playerid, TagScan(chat), WHITE, 40.0, 10000);

		return 1;
	}
	else if(frequency == 2.0)
	{
		log("[CHAT] [LOCALME] [%p]: %s", playerid, chat);

		new
			Float:x,
			Float:y,
			Float:z;

		GetPlayerPos(playerid, x, y, z);

		format(line1, 256, "[Local] %P %s",
			playerid,
			TagScan(chat));

		TruncateChatMessage(line1, line2);

		foreach(new i : Player)
		{
			if(IsPlayerInRangeOfPoint(i, 40.0, x, y, z))
			{
				SendClientMessage(i, CHAT_LOCAL, line1);

				if(!isnull(line2))
					SendClientMessage(i, CHAT_LOCAL, line2);
			}
		}

		SetPlayerChatBubble(playerid, TagScan(chat), CHAT_LOCAL, 40.0, 10000);

		return 1;
	}
	else if(frequency == 3.0)
	{
		log("[CHAT] [ADMIN] [%p]: %s", playerid, chat);

		format(line1, 256, "%C[Admin] (%d) %P"C_WHITE": %s",
			GetAdminRankColour(GetPlayerAdminLevel(playerid)),
			playerid,
			playerid,
			TagScan(chat));

		TruncateChatMessage(line1, line2);

		foreach(new i : Player)
		{
			if(GetPlayerAdminLevel(i) > 0)
			{
				SendClientMessage(i, CHAT_LOCAL, line1);

				if(!isnull(line2))
					SendClientMessage(i, CHAT_LOCAL, line2);
			}
		}

		return 1;
	}
	else
	{
		log("[CHAT] [RADIO] [%.2f] [%p]: %s", frequency, playerid, chat);

		format(line1, 256, "[%.2f] (%d) %P"C_WHITE": %s",
			frequency,
			playerid,
			playerid,
			TagScan(chat));

		TruncateChatMessage(line1, line2);

		foreach(new i : Player)
		{
			if(-0.05 < frequency - chat_Freq[i] < 0.05)
			{
				SendClientMessage(i, CHAT_RADIO, line1);

				if(!isnull(line2))
					SendClientMessage(i, CHAT_RADIO, line2);
			}
		}

		SetPlayerChatBubble(playerid, TagScan(chat), WHITE, 40.0, 10000);

		return 1;
	}
}

stock GetPlayerChatMode(playerid)
{
	if(!IsValidPlayerID(playerid))
		return 0;

	return chat_Mode[playerid];
}

stock SetPlayerChatMode(playerid, chatmode)
{
	if(!IsPlayerConnected(playerid))
		return 0;

	chat_Mode[playerid] = chatmode;

	return 1;
}

stock IsPlayerGlobalQuiet(playerid)
{
	if(!IsValidPlayerID(playerid))
		return 0;

	return chat_Quiet[playerid];
}

stock Float:GetPlayerRadioFrequency(playerid)
{
	if(!IsValidPlayerID(playerid))
		return 0.0;

	return chat_Freq[playerid];
}
stock SetPlayerRadioFrequency(playerid, Float:frequency)
{
	if(!IsPlayerConnected(playerid))
		return 0;

	chat_Freq[playerid] = frequency;

	return 1;
}

CMD:g(playerid, params[])
{
	if(IsPlayerMuted(playerid))
	{
		if(GetPlayerMuteRemainder(playerid) == -1)
			ChatMsgLang(playerid, RED, "MUTEDPERMAN");

		else
			ChatMsgLang(playerid, RED, "MUTEDTIMERM", MsToString(GetPlayerMuteRemainder(playerid) * 1000, "%1h:%1m:%1s"));

		return 7;
	}

	if(isnull(params))
	{
		SetPlayerChatMode(playerid, CHAT_MODE_GLOBAL);
		ChatMsgLang(playerid, WHITE, "RADIOGLOBAL");
	}
	else
	{
		PlayerSendChat(playerid, params, 1.0);
	}

	return 7;
}

CMD:l(playerid, params[])
{
	if(isnull(params))
	{
		SetPlayerChatMode(playerid, CHAT_MODE_LOCAL);
		ChatMsgLang(playerid, WHITE, "RADIOLOCAL");
	}
	else
	{
		PlayerSendChat(playerid, params, 0.0);
	}

	return 7;
}

CMD:me(playerid, params[])
{
	PlayerSendChat(playerid, params, 2.0);

	return 1;
}

CMD:r(playerid, params[])
{
	if(isnull(params))
	{
		SetPlayerChatMode(playerid, CHAT_MODE_RADIO);
		ChatMsgLang(playerid, WHITE, "RADIOFREQUN", chat_Freq[playerid]);
	}
	else
	{
		PlayerSendChat(playerid, params, chat_Freq[playerid]);
	}

	return 7;
}

CMD:quiet(playerid, params[])
{
	if(chat_Quiet[playerid])
	{
		chat_Quiet[playerid] = false;
		ChatMsgLang(playerid, WHITE, "RADIOQUIET0");
	}
	else
	{
		chat_Quiet[playerid] = true;
		ChatMsgLang(playerid, WHITE, "RADIOQUIET1");
	}

	return 1;
}

ACMD:a[1](playerid, params[])
{
	if(isnull(params))
	{
		SetPlayerChatMode(playerid, CHAT_MODE_ADMIN);
		ChatMsgLang(playerid, WHITE, "RADIOADMINC");
	}
	else
	{
		PlayerSendChat(playerid, params, 3.0);
	}

	return 7;
}
