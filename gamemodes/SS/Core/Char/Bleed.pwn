//new const MIN_BLEED_RATE = 0.01;
//new const MAX_BLEED_RATE = 0.4;


static
Float:	bld_BleedRate[MAX_PLAYERS];


ptask BleedUpdate[100](playerid)
{
	if(!IsPlayerSpawned(playerid))
	{
		RemovePlayerAttachedObject(playerid, ATTACHSLOT_BLOOD);
		return;
	}

	if(IsPlayerOnAdminDuty(playerid))
	{
		RemovePlayerAttachedObject(playerid, ATTACHSLOT_BLOOD);		
		return;
	}

	if(bld_BleedRate[playerid] > 0.0)
	{
		if(frandom(1.0) < 0.7)
			GivePlayerHP(playerid, -bld_BleedRate[playerid]);

		if(IsPlayerInAnyVehicle(playerid))
		{
			if(IsPlayerAttachedObjectSlotUsed(playerid, ATTACHSLOT_BLOOD))
			{
				if(frandom(1.0) < 1.0 - bld_BleedRate[playerid])
					RemovePlayerAttachedObject(playerid, ATTACHSLOT_BLOOD);
			}
			else
			{
				if(frandom(1.0) < bld_BleedRate[playerid])
					SetPlayerAttachedObject(playerid, ATTACHSLOT_BLOOD, 18706, 1,  0.088999, 0.020000, 0.044999,  0.088999, 0.020000, 0.044999,  1.179000, 1.510999, 0.005000);
			}
		}
		else
		{
			RemovePlayerAttachedObject(playerid, ATTACHSLOT_BLOOD);
		}
	}
	else
	{
		if(IsPlayerAttachedObjectSlotUsed(playerid, ATTACHSLOT_BLOOD))
			RemovePlayerAttachedObject(playerid, ATTACHSLOT_BLOOD);

		GivePlayerHP(playerid, 0.000925925); // One third of the health bar regenerates each real-time hour
	}

	if(IsPlayerUnderDrugEffect(playerid, drug_Morphine))
	{
		SetPlayerDrunkLevel(playerid, 2200);

		if(random(100) < 80)
			GivePlayerHP(playerid, 0.05);
	}

	return;
}

stock SetPlayerBleedRate(playerid, Float:rate)
{
	if(!IsPlayerConnected(playerid))
		return 0;

	bld_BleedRate[playerid] = rate;

	return 1;
}

forward Float:GetPlayerBleedRate(playerid);
stock Float:GetPlayerBleedRate(playerid)
{
	if(!IsPlayerConnected(playerid))
		return 0.0;

	return bld_BleedRate[playerid];
}
