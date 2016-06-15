

class GW_StrategyUIManager extends Object;


static function CityControlZoneUICard (GW_GameState_CityControlZone CCZ)
{
	local GW_UIStrategySite_CityControlZone kScreen;

	if(!`HQPRES.ScreenStack.GetCurrentScreen().IsA('GW_UIStrategySite_CityControlZone'))
	{
		kScreen = `HQPRES.Spawn(class'GW_UIStrategySite_CityControlZone', `HQPRES);
		kScreen.bInstantInterp = false;
		kScreen.CityControlZone = CCZ;
		`HQPRES.ScreenStack.Push(kScreen);
	}

	if( `GAME.GetGeoscape().IsScanning() )
		`HQPRES.StrategyMap2D.ToggleScan();

}

static function ResistanceCampUICard (GW_GameState_ResistanceCamp Camp)
{
	local GW_UIStrategySite_ResistanceCamp kScreen;

	if(!`HQPRES.ScreenStack.GetCurrentScreen().IsA('GW_UIStrategySite_ResistanceCamp'))
	{
		kScreen = `HQPRES.Spawn(class'GW_UIStrategySite_ResistanceCamp', `HQPRES);
		kScreen.bInstantInterp = false;
		kScreen.ResistanceCamp = Camp;
		`HQPRES.ScreenStack.Push(kScreen);
	}

	if( `GAME.GetGeoscape().IsScanning() )
		`HQPRES.StrategyMap2D.ToggleScan();

}