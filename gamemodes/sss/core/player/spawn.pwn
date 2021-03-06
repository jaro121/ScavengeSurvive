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


enum e_item_object
{
	ItemType:e_itmobj_type,
	e_itmobj_exdata
}


static
ItemType:	spawn_BagType,
// properties given to new players
Float:		spawn_NewBlood,
Float:		spawn_NewFood,
Float:		spawn_NewBleed,
ItemType:	spawn_NewItems[16][e_item_object],

// properties given on respawns
Float:		spawn_ResBlood,
Float:		spawn_ResFood,
Float:		spawn_ResBleed,
ItemType:	spawn_ResItems[16][e_item_object];

static
bool:		spawn_State[MAX_PLAYERS] = {false, ...},
Float:		spawn_PosX[MAX_PLAYERS],
Float:		spawn_PosY[MAX_PLAYERS],
Float:		spawn_PosZ[MAX_PLAYERS],
Float:		spawn_RotZ[MAX_PLAYERS];

new
PlayerText:	ClassButtonMale[MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...},
PlayerText:	ClassButtonFemale[MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...};


forward OnPlayerCreateChar(playerid);
forward OnPlayerSpawnChar(playerid);
forward OnPlayerSpawnNewChar(playerid);


hook OnGameModeInit()
{
	new
		newitems[16][32],
		newitems_total,

		resitems[16][32],
		resitems_total,

		bagtype[ITM_MAX_NAME];

	GetSettingString(SETTINGS_FILE, "spawn/bagtype", "Satchel", bagtype);
	spawn_BagType = GetItemTypeFromUniqueName(bagtype, true);

	if(!IsValidItemType(spawn_BagType))
	{
		err("spawn/bagtype invalid item type",
			_s("bagtype", bagtype),
			_i("itemtype", _:spawn_BagType));
	}


	GetSettingFloat(SETTINGS_FILE, "spawn/new-blood", 90.0, spawn_NewBlood);
	GetSettingFloat(SETTINGS_FILE, "spawn/new-food", 80.0, spawn_NewFood);
	GetSettingFloat(SETTINGS_FILE, "spawn/new-bleed", 0.0001, spawn_NewBleed);
	GetSettingStringArray(SETTINGS_FILE, "spawn/new-items", "Knife", newitems, newitems_total);

	for(new i; i < 16; i++)
	{
		spawn_NewItems[i][e_itmobj_type] = GetItemTypeFromUniqueName(newitems[i], true);

		if(newitems[i][0] != EOS && !IsValidItemType(spawn_NewItems[i][e_itmobj_type]))
			err("spawn/new-items invalid",
				_s("name", newitems[i]),
				_i("index", i),
				_i("itemtype", _:spawn_NewItems[i][e_itmobj_type]));
	}

	GetSettingFloat(SETTINGS_FILE, "spawn/res-blood", 100.0, spawn_ResBlood);
	GetSettingFloat(SETTINGS_FILE, "spawn/res-food", 40.0, spawn_ResFood);
	GetSettingFloat(SETTINGS_FILE, "spawn/res-bleed", 0.0, spawn_ResBleed);
	GetSettingStringArray(SETTINGS_FILE, "spawn/res-items", "AntiSepBandage", resitems, resitems_total);

	for(new i; i < 16; i++)
	{
		spawn_ResItems[i][e_itmobj_type] = GetItemTypeFromUniqueName(resitems[i], true);

		if(resitems[i][0] != EOS && !IsValidItemType(spawn_ResItems[i][e_itmobj_type]))
			err("spawn/res-items invalid",
				_s("name", newitems[i]),
				_i("index", i),
				_i("itemtype", _:spawn_ResItems[i][e_itmobj_type]));
	}
}

hook OnPlayerConnect(playerid)
{
	spawn_State[playerid] = false;

//	defer LoadClassUI(playerid);
//}
//
//timer LoadClassUI[1](playerid)
//{
	ClassButtonMale[playerid]		=CreatePlayerTextDraw(playerid, 250.000000, 200.000000, "~n~Male~n~~n~");
	PlayerTextDrawAlignment			(playerid, ClassButtonMale[playerid], 2);
	PlayerTextDrawBackgroundColor	(playerid, ClassButtonMale[playerid], 255);
	PlayerTextDrawFont				(playerid, ClassButtonMale[playerid], 1);
	PlayerTextDrawLetterSize		(playerid, ClassButtonMale[playerid], 0.500000, 2.000000);
	PlayerTextDrawColor				(playerid, ClassButtonMale[playerid], -1);
	PlayerTextDrawSetOutline		(playerid, ClassButtonMale[playerid], 0);
	PlayerTextDrawSetProportional	(playerid, ClassButtonMale[playerid], 1);
	PlayerTextDrawSetShadow			(playerid, ClassButtonMale[playerid], 1);
	PlayerTextDrawUseBox			(playerid, ClassButtonMale[playerid], 1);
	PlayerTextDrawBoxColor			(playerid, ClassButtonMale[playerid], 255);
	PlayerTextDrawTextSize			(playerid, ClassButtonMale[playerid], 44.000000, 100.000000);
	PlayerTextDrawSetSelectable		(playerid, ClassButtonMale[playerid], true);

	ClassButtonFemale[playerid]		=CreatePlayerTextDraw(playerid, 390.000000, 200.000000, "~n~Female~n~~n~");
	PlayerTextDrawAlignment			(playerid, ClassButtonFemale[playerid], 2);
	PlayerTextDrawBackgroundColor	(playerid, ClassButtonFemale[playerid], 255);
	PlayerTextDrawFont				(playerid, ClassButtonFemale[playerid], 1);
	PlayerTextDrawLetterSize		(playerid, ClassButtonFemale[playerid], 0.500000, 2.000000);
	PlayerTextDrawColor				(playerid, ClassButtonFemale[playerid], -1);
	PlayerTextDrawSetOutline		(playerid, ClassButtonFemale[playerid], 0);
	PlayerTextDrawSetProportional	(playerid, ClassButtonFemale[playerid], 1);
	PlayerTextDrawSetShadow			(playerid, ClassButtonFemale[playerid], 1);
	PlayerTextDrawUseBox			(playerid, ClassButtonFemale[playerid], 1);
	PlayerTextDrawBoxColor			(playerid, ClassButtonFemale[playerid], 255);
	PlayerTextDrawTextSize			(playerid, ClassButtonFemale[playerid], 44.000000, 100.000000);
	PlayerTextDrawSetSelectable		(playerid, ClassButtonFemale[playerid], true);
}

PrepareForSpawn(playerid)
{
	SetPlayerSpawnedState(playerid, true);

	SetCameraBehindPlayer(playerid);
	SetAllWeaponSkills(playerid, 500);

	GangZoneShowForPlayer(playerid, MiniMapOverlay, 0x000000FF);
	// ShowWatch(playerid);
	CancelSelectTextDraw(playerid);
}

Error:PlayerSpawnExistingCharacter(playerid)
{
	if(IsPlayerSpawned(playerid))
		return Error(1);

	if(!LoadPlayerChar(playerid))
		return Error(2);

	new
		Float:x,
		Float:y,
		Float:z,
		Float:r;

	GetPlayerSpawnPos(playerid, x, y, z);
	GetPlayerSpawnRot(playerid, r);

	Streamer_UpdateEx(playerid, x, y, z, 0, 0);
	SetPlayerPos(playerid, x, y, z);
	SetPlayerFacingAngle(playerid, r);

	if(GetPlayerWarnings(playerid) > 0)
	{
		if(GetPlayerWarnings(playerid) >= 5)	
			SetPlayerWarnings(playerid, 0);

		ChatMsgLang(playerid, YELLOW, "WARNCOUNTER", GetPlayerWarnings(playerid));
	}

	// TODO: reintegrate
	// SetPlayerClothes(playerid, GetPlayerClothesID(playerid));
	FreezePlayer(playerid, gLoginFreezeTime * 1000);

	PrepareForSpawn(playerid);

	if(GetPlayerStance(playerid) == 1)
	{
		ApplyAnimation(playerid, "SUNBATHE", "PARKSIT_M_OUT", 4.0, 0, 0, 0, 0, 0);
	}
	else if(GetPlayerStance(playerid) == 2)
	{
		ApplyAnimation(playerid, "SUNBATHE", "PARKSIT_M_OUT", 4.0, 0, 0, 0, 0, 0);
	}
	else if(GetPlayerStance(playerid) == 3)
	{
		ApplyAnimation(playerid, "ROB_BANK", "SHP_HandsUp_Scr", 4.0, 0, 1, 1, 1, 0);
	}

	log("player spawned existing character",
		_i("playerid", playerid),
		_f("x", x),
		_f("y", y),
		_f("z", z),
		_f("r", r));

	CallLocalFunction("OnPlayerSpawnChar", "d", playerid);

	return NoError();
}

// todo: fix hitting ESC when choosing gender
PlayerCreateNewCharacter(playerid)
{
	SetPlayerPos(playerid, DEFAULT_POS_X + 5, DEFAULT_POS_Y, DEFAULT_POS_Z);
	SetPlayerFacingAngle(playerid, 0.0);
	SetPlayerVirtualWorld(playerid, 0);
	SetPlayerInterior(playerid, 0);

	SetPlayerCameraLookAt(playerid, DEFAULT_POS_X, DEFAULT_POS_Y, DEFAULT_POS_Z);
	SetPlayerCameraPos(playerid, DEFAULT_POS_X, DEFAULT_POS_Y, DEFAULT_POS_Z - 1.0);
	Streamer_UpdateEx(playerid, DEFAULT_POS_X, DEFAULT_POS_Y, DEFAULT_POS_Z);

	// TODO: reintegrate
	// SetPlayerBrightness(playerid, 255);
	TogglePlayerControllable(playerid, false);

	if(IsPlayerLoggedIn(playerid))
	{
		PlayerTextDrawSetString(playerid, ClassButtonMale[playerid], sprintf("~n~%s~n~~n~", @L(playerid, "GENDER_M")));
		PlayerTextDrawSetString(playerid, ClassButtonFemale[playerid], sprintf("~n~%s~n~~n~", @L(playerid, "GENDER_F")));
		PlayerTextDrawShow(playerid, ClassButtonMale[playerid]);
		PlayerTextDrawShow(playerid, ClassButtonFemale[playerid]);
		SelectTextDraw(playerid, 0xFFFFFF88);
	}

	log("player created new character",
		_i("playerid", playerid));

	CallLocalFunction("OnPlayerCreateChar", "d", playerid);
}


hook OnPlayerLogin(playerid)
{
	if(IsPlayerAlive(playerid))
	{
		new Error:e = PlayerSpawnExistingCharacter(playerid);
		if(IsError(e)) {
			err("failed to spawn existing character");
			ShowErrorDialog(playerid);
			Handled();
			return 1;
		}
		// TODO: reintegrate
		// SetPlayerBrightness(playerid, 255);
		return 1;
	}
	else
	{
		PlayerCreateNewCharacter(playerid);
		// TODO: reintegrate
		// SetPlayerBrightness(playerid, 255);
	}

	return 0;
}

hook OnPlayerClickPlayerTD(playerid, PlayerText:playertextid)
{


	if(CanPlayerLeaveWelcomeMessage(playerid))
	{
		if(playertextid == ClassButtonMale[playerid])
		{
			PlayerSpawnNewCharacter(playerid, GENDER_MALE);
		}
		if(playertextid == ClassButtonFemale[playerid])
		{
			PlayerSpawnNewCharacter(playerid, GENDER_FEMALE);
		}
	}
}

PlayerSpawnNewCharacter(playerid, gender)
{
	if(IsPlayerSpawned(playerid))
		return 0;

	new name[MAX_PLAYER_NAME];

	GetPlayerName(playerid, name, MAX_PLAYER_NAME);

	SetPlayerTotalSpawns(playerid, GetPlayerTotalSpawns(playerid) + 1);

	SetAccountLastSpawnTimestamp(name, gettime());
	SetAccountTotalSpawns(name, GetPlayerTotalSpawns(playerid));

	new
		backpackitem,
		tmpitem,
		Float:x,
		Float:y,
		Float:z,
		Float:r;

	GenerateSpawnPoint(playerid, x, y, z, r);
	Streamer_UpdateEx(playerid, x, y, z, 0, 0);
	SetPlayerPos(playerid, x, y, z);
	SetPlayerFacingAngle(playerid, r);
	SetPlayerVirtualWorld(playerid, 0);
	SetPlayerInterior(playerid, 0);

	if(gender == GENDER_MALE)
	{
		switch(random(6))
		{
			case 0: SetPlayerClothesID(playerid, skin_Civ0M);
			case 1: SetPlayerClothesID(playerid, skin_Civ1M);
			case 2: SetPlayerClothesID(playerid, skin_Civ2M);
			case 3: SetPlayerClothesID(playerid, skin_Civ3M);
			case 4: SetPlayerClothesID(playerid, skin_Civ4M);
			case 5: SetPlayerClothesID(playerid, skin_MechM);
			case 6: SetPlayerClothesID(playerid, skin_BikeM);
		}
	}
	else
	{
		switch(random(6))
		{
			case 0: SetPlayerClothesID(playerid, skin_Civ0F);
			case 1: SetPlayerClothesID(playerid, skin_Civ1F);
			case 2: SetPlayerClothesID(playerid, skin_Civ2F);
			case 3: SetPlayerClothesID(playerid, skin_Civ3F);
			case 4: SetPlayerClothesID(playerid, skin_Civ4F);
			case 5: SetPlayerClothesID(playerid, skin_ArmyF);
			case 6: SetPlayerClothesID(playerid, skin_IndiF);
		}
	}

	if(IsNewPlayer(playerid))
	{
		SetPlayerHP(playerid, spawn_NewBlood);
		SetPlayerFP(playerid, spawn_NewFood);
		SetPlayerBleedRate(playerid, spawn_NewBleed);
	}
	else
	{
		SetPlayerHP(playerid, spawn_ResBlood);
		SetPlayerFP(playerid, spawn_ResFood);
		SetPlayerBleedRate(playerid, spawn_ResBleed);
	}

	SetPlayerAP(playerid, 0.0);
	SetPlayerClothes(playerid, GetPlayerClothesID(playerid));
	SetPlayerGender(playerid, gender);

	SetPlayerAliveState(playerid, true);

	FreezePlayer(playerid, gLoginFreezeTime * 1000);
	PrepareForSpawn(playerid);

	PlayerTextDrawHide(playerid, ClassButtonMale[playerid]);
	PlayerTextDrawHide(playerid, ClassButtonFemale[playerid]);

	if(IsValidItemType(spawn_BagType))
	{
		backpackitem = CreateItem(spawn_BagType);

		GivePlayerBag(playerid, backpackitem);

		for(new i; i < 4; i++)
		{
			if(!IsValidItemType(spawn_ResItems[i][e_itmobj_type]))
				break;

			tmpitem = CreateItem(spawn_ResItems[i][e_itmobj_type]);

			if(spawn_ResItems[i][e_itmobj_exdata] != 0)
				SetItemExtraData(tmpitem, spawn_ResItems[i][e_itmobj_exdata]);

			AddItemToPlayer(playerid, tmpitem, true, false);
		}

		if(IsNewPlayer(playerid))
		{
			for(new i; i < 4; i++)
			{
				if(!IsValidItemType(spawn_NewItems[i][e_itmobj_type]))
					break;

				tmpitem = CreateItem(spawn_NewItems[i][e_itmobj_type]);

				if(spawn_NewItems[i][e_itmobj_exdata] != 0)
					SetItemExtraData(tmpitem, spawn_NewItems[i][e_itmobj_exdata]);

				AddItemToPlayer(playerid, tmpitem, true, false);
			}
		}
	}

	SetPlayerBrightness(playerid, 255);

	CallLocalFunction("OnPlayerSpawnNewChar", "d", playerid);

	log("[SPAWN] %p spawned new character at %.1f, %.1f, %.1f (%.1f)", playerid, x, y, z, r);

	return 1;
}


/*==============================================================================

	Interface

==============================================================================*/


// spawn_State
stock IsPlayerSpawned(playerid)
{
	if(!IsPlayerConnected(playerid))
		return 0;

	return spawn_State[playerid];
}

stock SetPlayerSpawnedState(playerid, bool:st)
{
	if(!IsPlayerConnected(playerid))
		return 0;

	spawn_State[playerid] = st;

	return 1;
}

// spawn_PosX
// spawn_PosY
// spawn_PosZ
stock GetPlayerSpawnPos(playerid, &Float:x, &Float:y, &Float:z)
{
	if(!IsPlayerConnected(playerid))
		return 0;

	x = spawn_PosX[playerid];
	y = spawn_PosY[playerid];
	z = spawn_PosZ[playerid];

	return 1;
}

stock SetPlayerSpawnPos(playerid, Float:x, Float:y, Float:z)
{
	if(!IsPlayerConnected(playerid))
		return 0;

	spawn_PosX[playerid] = x;
	spawn_PosY[playerid] = y;
	spawn_PosZ[playerid] = z;

	return 1;
}

// spawn_RotZ
stock GetPlayerSpawnRot(playerid, &Float:r)
{
	if(!IsPlayerConnected(playerid))
		return 0;

	r = spawn_RotZ[playerid];

	return 1;
}

stock SetPlayerSpawnRot(playerid, Float:r)
{
	if(!IsPlayerConnected(playerid))
		return 0;

	spawn_RotZ[playerid] = r;

	return 1;
}

IsAtDefaultPos(Float:x, Float:y, Float:z)
{
	if(-5.0 < (x - DEFAULT_POS_X) < 5.0 && -5.0 < (y - DEFAULT_POS_Y) < 5.0 && -5.0 < (z - DEFAULT_POS_Z) < 5.0)
		return 1;

	return 0;
}

IsAtConnectionPos(Float:x, Float:y, Float:z)
{
	if(1133.05 < x < 1133.059999 && -2038.40 < y < -2038.409999 && 69.09 < z < 69.099999)
		return 1;

	return 0;
}
