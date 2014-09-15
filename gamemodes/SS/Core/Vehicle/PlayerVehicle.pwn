#include <YSI\y_hooks>


// Directory for storing player-saved vehicles
#define DIRECTORY_VEHICLE			DIRECTORY_MAIN"Vehicle/"

// Old directories for conversion
#define DIRECTORY_VEHICLE_DAT		DIRECTORY_MAIN"VehicleDat/"
#define DIRECTORY_VEHICLE_INV		DIRECTORY_MAIN"VehicleInv/"


static
	vehicle_ItemList[ITM_LST_OF_ITEMS(64)];


enum
{
	VEH_CELL_TYPE,		// 00
	VEH_CELL_HEALTH,	// 01
	VEH_CELL_FUEL,		// 02
	VEH_CELL_POSX,		// 03
	VEH_CELL_POSY,		// 04
	VEH_CELL_POSZ,		// 05
	VEH_CELL_ROTZ,		// 06
	VEH_CELL_COL1,		// 07
	VEH_CELL_COL2,		// 08
	VEH_CELL_PANELS,	// 09
	VEH_CELL_DOORS,		// 10
	VEH_CELL_LIGHTS,	// 11
	VEH_CELL_TIRES,		// 12
	VEH_CELL_ARMOUR,	// 13
	VEH_CELL_KEY,		// 14
	VEH_CELL_LOCKED,	// 15
	VEH_CELL_END
}


/*==============================================================================

	Save and Load (all)

==============================================================================*/


SavePlayerVehicles(printeach = false, printtotal = false)
{
	new
		count,
		owner[MAX_PLAYER_NAME];

	for(new i = 1; i < MAX_VEHICLES; i++)
	{
		owner[0] = EOS;
		GetVehicleOwner(i, owner);

		if(strlen(owner) >= 3)
		{
			if(!IsValidVehicle(i))
			{
				if(printeach)
					logf("ERROR: Saving vehicle ID %d for %s. Invalid vehicle ID", i, owner);

				RemoveVehicleFile(owner, printeach);
				continue;
			}

			if(veh_BitData[i] & veh_Dead)
			{
				if(printeach)
					logf("ERROR: Saving vehicle ID %d for %s. Vehicle is dead.", i, owner);

				RemoveVehicleFile(owner, printeach);
				continue;
			}

			UpdateVehicleFile(i, printeach);
			count++;
		}
	}

	if(printtotal)
		logf("Saved %d Player vehicles", count);
}

LoadPlayerVehicles(printeach = false, printtotal = false)
{
	DirectoryCheck(DIRECTORY_SCRIPTFILES DIRECTORY_VEHICLE);

	new
		dir:direc = dir_open(DIRECTORY_SCRIPTFILES DIRECTORY_VEHICLE),
		item[28],
		type;

	while(dir_list(direc, item, type))
	{
		if(type == FM_FILE)
		{
			LoadPlayerVehicle(item, printeach);
		}
	}

	dir_close(direc);

	// If no vehicles were loaded, load the old format
	// This should only ever happen once (upon transition to this new version)
	if(Iter_Count(veh_Index) == 0 && dir_exists(DIRECTORY_SCRIPTFILES DIRECTORY_VEHICLE_DAT))
		OLD_LoadPlayerVehicles(printeach, printtotal);

	if(printtotal)
		logf("Loaded %d Player vehicles", Iter_Count(veh_Index));

	return 1;
}


/*==============================================================================

	Load vehicle (individual)

==============================================================================*/


LoadPlayerVehicle(username[], prints)
{
	new
		filename[64],
		vehicleid,
		category,
		vehiclename[MAX_VEHICLE_TYPE_NAME],
		owner[MAX_PLAYER_NAME],
		containerid,
		data[VEH_CELL_END],
		trunksize,
		length;

	filename = DIRECTORY_VEHICLE;
	strcat(filename, username);

	length = modio_read(filename, _T<D,A,T,A>, data, false, false);

	if(length == 0)
		return 0;

	/*
		Legacy vehicle model conversion.
		Substitute missing vehicles with equivalents.
	*/
	if(400 <= data[VEH_CELL_TYPE] <= 612)
	{
		new tmp;
		printf("WARNING: Vehicle for '%s' type is model ID (%d), converting to vehicle index type.", username, data[VEH_CELL_TYPE]);
		
		tmp = GetVehicleTypeFromModel(data[VEH_CELL_TYPE]);

		if(!IsValidVehicleType(data[VEH_CELL_TYPE]))
		{
			printf("ERROR: Invalid vehicle type retrieved from model %d.", data[VEH_CELL_TYPE]);

			new modeltype = GetVehicleModelType(data[VEH_CELL_TYPE]);

			switch(modeltype)
			{
				case VTYPE_CAR: tmp = 0;
				case VTYPE_HEAVY: tmp = 12;
				case VTYPE_QUAD: tmp = 5;
				case VTYPE_MOTORBIKE: tmp = 5;
				case VTYPE_BICYCLE: tmp = 4;
				case VTYPE_HELI: tmp = 2;
				case VTYPE_PLANE: tmp = 1;
				case VTYPE_SEA: tmp = 19;
			}

			data[VEH_CELL_TYPE] = 0;
		}

		data[VEH_CELL_TYPE] = tmp;
	}

	if(!IsValidVehicleType(data[VEH_CELL_TYPE]))
	{
		logf("ERROR: Removing Vehicle file: %s, invalid vehicle type '%d'.", username, data[VEH_CELL_TYPE]);
		fremove(filename);
		return 0;
	}

	GetVehicleTypeName(data[VEH_CELL_TYPE], vehiclename);

	if(Float:data[VEH_CELL_HEALTH] < 255.5)
	{
		logf("ERROR: Removing Vehicle %s file: %s due to low health.", vehiclename, username);
		fremove(filename);
		return 0;
	}

	category = GetVehicleTypeCategory(data[VEH_CELL_TYPE]);

	if(category != VEHICLE_CATEGORY_BOAT)
	{
		if(!IsPointInMapBounds(Float:data[VEH_CELL_POSX], Float:data[VEH_CELL_POSY], Float:data[VEH_CELL_POSZ]))
		{
			if(category == VEHICLE_CATEGORY_HELICOPTER || category == VEHICLE_CATEGORY_PLANE)
			{
				data[VEH_CELL_POSZ] = _:(Float:data[VEH_CELL_POSZ] + 10.0);
			}
			else
			{
				logf("ERROR: Removing Vehicle %s file: %s because it's out of the map bounds.", vehiclename, username);
				fremove(filename);

				return 0;
			}
		}
	}

	strmid(owner, username, 0, strlen(username) - 4);

	vehicleid = CreateVehicleOfType(
		data[VEH_CELL_TYPE],
		Float:data[VEH_CELL_POSX],
		Float:data[VEH_CELL_POSY],
		Float:data[VEH_CELL_POSZ],
		Float:data[VEH_CELL_ROTZ],
		data[VEH_CELL_COL1],
		data[VEH_CELL_COL2]);

	if(!IsValidVehicle(vehicleid))
		return 0;

	SetVehicleSpawnPoint(vehicleid,
		Float:data[VEH_CELL_POSX],
		Float:data[VEH_CELL_POSY],
		Float:data[VEH_CELL_POSZ],
		Float:data[VEH_CELL_ROTZ]);

	veh_Owner[vehicleid] = owner;

	if(prints)
		logf("\t[LOAD] Vehicle %d (%s): %s for %s at %f, %f, %f", vehicleid, data[VEH_CELL_LOCKED] ? ("L") : ("U"), vehiclename, owner, data[VEH_CELL_POSX], data[VEH_CELL_POSY], data[VEH_CELL_POSZ], data[VEH_CELL_ROTZ]);

	Iter_Add(veh_Index, vehicleid);

	if(Float:data[VEH_CELL_HEALTH] > 990.0)
		data[VEH_CELL_HEALTH] = _:990.0;

	veh_Data[vehicleid][veh_health]				= Float:data[VEH_CELL_HEALTH];
	veh_Data[vehicleid][veh_Fuel]				= Float:data[VEH_CELL_FUEL];
	veh_Data[vehicleid][veh_panels]				= data[VEH_CELL_PANELS];
	veh_Data[vehicleid][veh_doors]				= data[VEH_CELL_DOORS];
	veh_Data[vehicleid][veh_lights]				= data[VEH_CELL_LIGHTS];
	veh_Data[vehicleid][veh_tires]				= data[VEH_CELL_TIRES];
	veh_Data[vehicleid][veh_armour]				= data[VEH_CELL_ARMOUR];
	veh_Data[vehicleid][veh_colour1]			= data[VEH_CELL_COL1];
	veh_Data[vehicleid][veh_colour2]			= data[VEH_CELL_COL2];
	veh_Data[vehicleid][veh_key]				= data[VEH_CELL_KEY];

	SetVehicleExternalLock(vehicleid, data[VEH_CELL_LOCKED]);

	trunksize = GetVehicleTypeTrunkSize(data[VEH_CELL_TYPE]);

	length = modio_read(filename, _T<T,D,A,T>, data, false, false);

	if(length > 0)
	{
		new
			trailerid,
			trailertrunksize,
			trailername[MAX_VEHICLE_TYPE_NAME];

		GetVehicleTypeName(data[VEH_CELL_TYPE], trailername);

		trailerid = CreateVehicleOfType(
			data[VEH_CELL_TYPE],
			Float:data[VEH_CELL_POSX],
			Float:data[VEH_CELL_POSY],
			Float:data[VEH_CELL_POSZ],
			Float:data[VEH_CELL_ROTZ],
			data[VEH_CELL_COL1],
			data[VEH_CELL_COL2]);

		trailertrunksize = GetVehicleTypeTrunkSize(data[VEH_CELL_TYPE]);

		AttachTrailerToVehicle(trailerid, vehicleid);

		SetVehicleSpawnPoint(trailerid,
			Float:data[VEH_CELL_POSX],
			Float:data[VEH_CELL_POSY],
			Float:data[VEH_CELL_POSZ],
			Float:data[VEH_CELL_ROTZ]);

		if(prints)
			logf("\t[LOAD] Trailer %d (%s): %s for %s at %f, %f, %f", trailerid, data[VEH_CELL_LOCKED] ? ("L") : ("U"), trailername, owner, data[VEH_CELL_POSX], data[VEH_CELL_POSY], data[VEH_CELL_POSZ], data[VEH_CELL_ROTZ]);

		Iter_Add(veh_Index, trailerid);

		veh_Data[trailerid][veh_health]	= Float:data[VEH_CELL_HEALTH];
		veh_Data[trailerid][veh_Fuel]	= Float:data[VEH_CELL_FUEL];
		veh_Data[trailerid][veh_panels]	= data[VEH_CELL_PANELS];
		veh_Data[trailerid][veh_doors]	= data[VEH_CELL_DOORS];
		veh_Data[trailerid][veh_lights]	= data[VEH_CELL_LIGHTS];
		veh_Data[trailerid][veh_tires]	= data[VEH_CELL_TIRES];
		veh_Data[trailerid][veh_armour]	= data[VEH_CELL_ARMOUR];
		veh_Data[trailerid][veh_key]	= data[VEH_CELL_KEY];

		if(trailertrunksize > 0)
		{
			new
				ItemType:itemtype,
				itemid,
				itemlist;

			containerid = CreateContainer(sprintf("%s trunk", trailername), trunksize, .virtual = 1);
			SetVehicleContainer(trailerid, containerid);

			length = modio_read(filename, _T<T,T,R,N>, vehicle_ItemList, false, false);
		
			itemlist = ExtractItemList(vehicle_ItemList, length);
			printf("itemlist len: %d", length);

			for(new i, j = GetItemListItemCount(itemlist); i < j; i++)
			{
				itemtype = GetItemListItem(itemlist, i);

				if(length == 0)
					break;

				if(itemtype == INVALID_ITEM_TYPE)
					break;

				if(itemtype == ItemType:0)
					break;

				itemid = CreateItem(itemtype);

				if(!IsItemTypeSafebox(itemtype) && !IsItemTypeBag(itemtype))
					SetItemArrayDataFromListItem(itemid, itemlist, i);

				printf(">> itemlist %f/%f itemtype: %d item: %d container: %d", i, j, _:itemtype, itemid, containerid);
				AddItemToContainer(containerid, itemid);
			}

			DestroyItemList(itemlist);
		}
		else
		{
			SetVehicleContainer(trailerid, INVALID_CONTAINER_ID);
		}

		UpdateVehicleData(trailerid);
		CreateVehicleArea(trailerid);
	}

	if(trunksize > 0)
	{
		new
			ItemType:itemtype,
			itemid,
			itemlist;

		containerid = CreateContainer(sprintf("%s trunk", vehiclename), trunksize, .virtual = 1);
		SetVehicleContainer(vehicleid, containerid);

		length = modio_read(filename, _T<T,R,N,K>, vehicle_ItemList, true);

		itemlist = ExtractItemList(vehicle_ItemList, length);

		for(new i, j = GetItemListItemCount(itemlist); i < j; i++)
		{
			itemtype = GetItemListItem(itemlist, i);

			if(length == 0)
				break;

			if(itemtype == INVALID_ITEM_TYPE)
				break;

			if(itemtype == ItemType:0)
				break;

			itemid = CreateItem(itemtype);

			if(!IsItemTypeSafebox(itemtype) && !IsItemTypeBag(itemtype))
				SetItemArrayDataFromListItem(itemid, itemlist, i);

			AddItemToContainer(containerid, itemid);
		}

		DestroyItemList(itemlist);
	}
	else
	{
		SetVehicleContainer(vehicleid, INVALID_CONTAINER_ID);
	}

	t:veh_BitData[vehicleid]<veh_Player>;

	UpdateVehicleData(vehicleid);
	CreateVehicleArea(vehicleid);

	return 1;
}


/*==============================================================================

	Save vehicle for a specific name

==============================================================================*/


SavePlayerVehicle(vehicleid, name[MAX_PLAYER_NAME], prints = true)
{
	UpdateVehicleOwner(vehicleid, name);
	UpdateVehicleFile(vehicleid, prints);

	return 1;
}

UpdateVehicleOwner(vehicleid, name[MAX_PLAYER_NAME], prints = false)
{
	if(!IsValidVehicle(vehicleid))
		return 0;

	new lastvehicleid;

	for(lastvehicleid = 1; lastvehicleid < MAX_VEHICLES; lastvehicleid++)
	{
		if(lastvehicleid == vehicleid)
		{
			if(isnull(veh_Owner[lastvehicleid]))
				continue;

			if(!strcmp(veh_Owner[lastvehicleid], name))
				return 1;

			else
				continue;
		}

		if(isnull(veh_Owner[lastvehicleid]))
			continue;

		if(!strcmp(veh_Owner[lastvehicleid], name))
			veh_Owner[lastvehicleid][0] = EOS;
	}

	if(!isnull(veh_Owner[vehicleid]))
	{
		if(strcmp(veh_Owner[vehicleid], name))
			RemoveVehicleFileByID(vehicleid, prints);
	}

	veh_Owner[vehicleid] = name;

	return 1;
}


/*==============================================================================

	Write vehicle data to file

==============================================================================*/


UpdateVehicleFile(vehicleid, prints = false)
{
	new
		filename[MAX_PLAYER_NAME + 22],
		session,
		vehiclename[MAX_VEHICLE_TYPE_NAME],
		data[VEH_CELL_END];

	format(filename, sizeof(filename), DIRECTORY_VEHICLE"%s.dat", veh_Owner[vehicleid]);

	session = modio_getsession_write(filename);

	if(session != -1)
		modio_close_session_write(session);

	GetVehicleTypeName(GetVehicleType(vehicleid), vehiclename);

	data[VEH_CELL_TYPE] = GetVehicleType(vehicleid);

	GetVehicleHealth(vehicleid, Float:data[1]);

	data[VEH_CELL_FUEL] = _:GetVehicleFuel(vehicleid);
	GetVehiclePos(vehicleid, Float:data[VEH_CELL_POSX], Float:data[VEH_CELL_POSY], Float:data[VEH_CELL_POSZ]);
	GetVehicleZAngle(vehicleid, Float:data[VEH_CELL_ROTZ]);
	data[VEH_CELL_COL1] = veh_Data[vehicleid][veh_colour1];
	data[VEH_CELL_COL2] = veh_Data[vehicleid][veh_colour2];
	GetVehicleDamageStatus(vehicleid, data[VEH_CELL_PANELS], data[VEH_CELL_DOORS], data[VEH_CELL_LIGHTS], data[VEH_CELL_TIRES]);
	data[VEH_CELL_ARMOUR] = 0;
	data[VEH_CELL_KEY] = veh_Data[vehicleid][veh_key];

	if(prints)
		logf("[SAVE] Vehicle %d (%s): %s for %s at %f, %f, %f", vehicleid, IsVehicleLocked(vehicleid) ? ("L") : ("U"), vehiclename, veh_Owner[vehicleid], Float:data[VEH_CELL_POSX], Float:data[VEH_CELL_POSY], Float:data[VEH_CELL_POSZ]);

	if(!IsVehicleOccupied(vehicleid))
		data[VEH_CELL_LOCKED] = IsVehicleLocked(vehicleid);

	// push the data, forcewrite is false
	// forceclose is also false, the file will be closed on the next call
	// autowrite is set to false to stop the timer from going off
	modio_push(filename, _T<D,A,T,A>, VEH_CELL_END, data, false, false, false);

	// Now do trailers with the same modio parameters

	new trailerid = GetVehicleTrailer(vehicleid);

	if(IsValidVehicle(trailerid))
	{
		new containerid = GetVehicleContainer(trailerid);

		data[VEH_CELL_TYPE] = GetVehicleType(trailerid);
		GetVehicleHealth(trailerid, Float:data[VEH_CELL_HEALTH]);
		data[VEH_CELL_FUEL] = _:0.0;
		GetVehiclePos(trailerid, Float:data[VEH_CELL_POSX], Float:data[VEH_CELL_POSY], Float:data[VEH_CELL_POSZ]);
		GetVehicleZAngle(trailerid, Float:data[VEH_CELL_ROTZ]);
		data[VEH_CELL_COL1] = veh_Data[trailerid][veh_colour1];
		data[VEH_CELL_COL2] = veh_Data[trailerid][veh_colour2];
		GetVehicleDamageStatus(trailerid, data[VEH_CELL_PANELS], data[VEH_CELL_DOORS], data[VEH_CELL_LIGHTS], data[VEH_CELL_TIRES]);
		data[VEH_CELL_ARMOUR] = 0;
		data[VEH_CELL_KEY] = veh_Data[trailerid][veh_key];
		data[VEH_CELL_LOCKED] = IsVehicleLocked(trailerid);

		// TDAT = Trailer Data
		modio_push(filename, _T<T,D,A,T>, VEH_CELL_END, data, false, false, false);

		if(IsValidContainer(containerid))
		{
			new
				items[64],
				itemcount,
				itemlist;

			for(new i, j = GetContainerSize(containerid); i < j; i++)
			{
				items[i] = GetContainerSlotItem(containerid, i);

				if(!IsValidItem(items[i]))
					break;

				itemcount++;
			}

			itemlist = CreateItemList(items, itemcount);
			GetItemList(itemlist, vehicle_ItemList);

			// TTRN = Trailer Trunk
			modio_push(filename, _T<T,T,R,N>, GetItemListSize(itemlist), vehicle_ItemList, false, false, false);

			DestroyItemList(itemlist);
		}

		GetVehicleTypeName(GetVehicleType(trailerid), vehiclename);

		if(prints)
			logf("[SAVE] Trailer %d (%s): %s for %s at %f, %f, %f", trailerid, IsVehicleLocked(trailerid) ? ("L") : ("U"), vehiclename, veh_Owner[vehicleid], Float:data[VEH_CELL_POSX], Float:data[VEH_CELL_POSY], Float:data[VEH_CELL_POSZ]);
	}

	new containerid = GetVehicleContainer(vehicleid);

	if(!IsValidContainer(containerid))
	{
		modio_close_session_write(modio_getsession_write(filename));
		return 1;
	}

	new
		items[64],
		itemcount,
		itemlist;

	for(new i, j = GetContainerSize(containerid); i < j; i++)
	{
		items[i] = GetContainerSlotItem(containerid, i);

		if(!IsValidItem(items[i]))
			break;

		itemcount++;
	}

	itemlist = CreateItemList(items, itemcount);
	GetItemList(itemlist, vehicle_ItemList);

	// forcewrite is true, and forceclose is true by default.
	// File will be written and closed ready for the next call.
	// Resulting in reusing modio sessions instead of registering new ones.
	modio_push(filename, _T<T,R,N,K>, GetItemListSize(itemlist), vehicle_ItemList, true, true);

	DestroyItemList(itemlist);

	return 1;
}

RemoveVehicleFileByID(vehicleid, prints = true)
{
	new owner[MAX_PLAYER_NAME];

	GetVehicleOwner(vehicleid, owner);

	return RemoveVehicleFile(owner, prints);
}

RemoveVehicleFile(owner[MAX_PLAYER_NAME], prints = true)
{
	if(isnull(owner))
		return 0;

	if(prints)
		logf("[DELT] Removing player vehicle. Owner: %s", owner);

	new filename[MAX_PLAYER_NAME + 22];

	format(filename, sizeof(filename), DIRECTORY_VEHICLE"%s.dat", owner);
	fremove(filename);

	return 1;
}


/*==============================================================================

	Legacy format (Load only)

==============================================================================*/


OLD_LoadPlayerVehicles(printeach = false, printtotal = false)
{
	new
		dir:direc = dir_open(DIRECTORY_SCRIPTFILES DIRECTORY_VEHICLE_DAT),
		item[28],
		type;

	while(dir_list(direc, item, type))
	{
		if(type == FM_FILE)
		{
			OLD_LoadPlayerVehicle(item, printeach);
		}
	}

	dir_close(direc);

	dir_delete(DIRECTORY_SCRIPTFILES DIRECTORY_VEHICLE_DAT);
	dir_delete(DIRECTORY_SCRIPTFILES DIRECTORY_VEHICLE_INV);

	SavePlayerVehicles(printeach, printtotal);

	if(printtotal)
		printf("Loaded %d Player vehicles (old format)", Iter_Count(veh_Index));

	return 1;
}

OLD_LoadPlayerVehicle(filename[], prints)
{
	new
		File:file,
		filedir[64],
		vehicleid,
		category,
		vehiclename[MAX_VEHICLE_TYPE_NAME],
		trunksize,
		owner[MAX_PLAYER_NAME],
		containerid,
		array_data[VEH_CELL_END],
		array_inv[CNT_MAX_SLOTS * 3],
		itemid;

	filedir = DIRECTORY_VEHICLE_DAT;
	strcat(filedir, filename);

	if(strlen(filename) < 3)
	{
		fremove(filedir);
		return 0;
	}

	file = fopen(filedir, io_read);

	if(!file)
		return 0;

	fblockread(file, array_data, sizeof(array_data));
	fclose(file);

	if(!(400 <= array_data[VEH_CELL_TYPE] <= 612))
	{
		printf("ERROR: Removing Vehicle file: %s. Invalid model ID %d.", filename, array_data[VEH_CELL_TYPE]);
		fremove(filedir);
		return 0;
	}

	GetVehicleTypeName(array_data[VEH_CELL_TYPE], vehiclename);

	if(Float:array_data[VEH_CELL_HEALTH] < 255.5)
	{
		printf("ERROR: Removing Vehicle %s file: %s due to low health.", vehiclename, filename);
		fremove(filedir);
		return 0;
	}

	category = GetVehicleTypeCategory(array_data[VEH_CELL_TYPE]);

	if(category != VEHICLE_CATEGORY_BOAT)
	{
		if(!IsPointInMapBounds(Float:array_data[VEH_CELL_POSX], Float:array_data[VEH_CELL_POSY], Float:array_data[VEH_CELL_POSZ]))
		{
			if(category == VEHICLE_CATEGORY_HELICOPTER || category == VEHICLE_CATEGORY_PLANE)
			{
				array_data[VEH_CELL_POSZ] = _:(Float:array_data[VEH_CELL_POSZ] + 10.0);
			}
			else
			{
				printf("ERROR: Removing Vehicle %s file: %s because it's out of the map bounds.", vehiclename, filename);
				fremove(filedir);

				return 0;
			}
		}
	}

	strmid(owner, filename, 0, strlen(filename) - 4);

	if(strlen(owner) < 3)
	{
		printf("ERROR: Vehicle owner name is invalid: '%s' Length: %d", owner, strlen(owner));
		DestroyVehicle(vehicleid, 1);
		fremove(filedir);
		return 0;
	}

	vehicleid = CreateVehicleOfType(
		array_data[VEH_CELL_TYPE],
		Float:array_data[VEH_CELL_POSX],
		Float:array_data[VEH_CELL_POSY],
		Float:array_data[VEH_CELL_POSZ],
		Float:array_data[VEH_CELL_ROTZ],
		array_data[VEH_CELL_COL1],
		array_data[VEH_CELL_COL2]);

	if(!IsValidVehicle(vehicleid))
		return 0;

	SetVehicleSpawnPoint(vehicleid,
		Float:array_data[VEH_CELL_POSX],
		Float:array_data[VEH_CELL_POSY],
		Float:array_data[VEH_CELL_POSZ],
		Float:array_data[VEH_CELL_ROTZ]);

	veh_Owner[vehicleid] = owner;

	if(prints)
		printf("\t[LOAD] [OLD] Vehicle %d (%s): %s for %s at %f, %f, %f", vehicleid, array_data[VEH_CELL_LOCKED] ? ("L") : ("U"), vehiclename, owner, array_data[VEH_CELL_POSX], array_data[VEH_CELL_POSY], array_data[VEH_CELL_POSZ], array_data[VEH_CELL_ROTZ]);

	Iter_Add(veh_Index, vehicleid);

	if(Float:array_data[VEH_CELL_HEALTH] > 990.0)
		array_data[VEH_CELL_HEALTH] = _:990.0;

	veh_Data[vehicleid][veh_health]				= Float:array_data[VEH_CELL_HEALTH];
	veh_Data[vehicleid][veh_Fuel]				= Float:array_data[VEH_CELL_FUEL];
	veh_Data[vehicleid][veh_panels]				= array_data[VEH_CELL_PANELS];
	veh_Data[vehicleid][veh_doors]				= array_data[VEH_CELL_DOORS];
	veh_Data[vehicleid][veh_lights]				= array_data[VEH_CELL_LIGHTS];
	veh_Data[vehicleid][veh_tires]				= array_data[VEH_CELL_TIRES];
	veh_Data[vehicleid][veh_armour]				= array_data[VEH_CELL_ARMOUR];
	veh_Data[vehicleid][veh_colour1]			= array_data[VEH_CELL_COL1];
	veh_Data[vehicleid][veh_colour2]			= array_data[VEH_CELL_COL2];
	veh_Data[vehicleid][veh_key]				= array_data[VEH_CELL_KEY];

	SetVehicleExternalLock(vehicleid, array_data[VEH_CELL_LOCKED]);

	trunksize = GetVehicleTypeTrunkSize(array_data[VEH_CELL_TYPE]);

	if(trunksize > 0)
	{
		filedir = DIRECTORY_VEHICLE_INV;
		strcat(filedir, filename);

		file = fopen(filedir, io_read);

		if(!file)
		{
			printf("ERROR: Vehicle inventory file for '%s' is missing!", filedir);
			return 0;
		}

		fblockread(file, array_inv, sizeof(array_inv));
		fclose(file);

		containerid = CreateContainer("Trunk", trunksize, .virtual = 1);
		SetVehicleContainer(vehicleid, containerid);

		for(new i, j; j < CNT_MAX_SLOTS; i += 3, j++)
		{
			if(!IsValidItemType(ItemType:array_inv[i]) || array_inv[i] == 0)
				continue;

			itemid = CreateItem(ItemType:array_inv[i], 0.0, 0.0, 0.0);

			if(array_inv[i + 1] == 1)
			{
				if(!IsItemTypeSafebox(ItemType:array_inv[i]) && !IsItemTypeBag(ItemType:array_inv[i]))
				{
					SetItemExtraData(itemid, array_inv[i + 2]);
				}

				AddItemToContainer(containerid, itemid);
			}
		}
	}
	else
	{
		SetVehicleContainer(vehicleid, INVALID_CONTAINER_ID);
	}

	t:veh_BitData[vehicleid]<veh_Player>;

	UpdateVehicleData(vehicleid);
	CreateVehicleArea(vehicleid);

	return 1;
}
