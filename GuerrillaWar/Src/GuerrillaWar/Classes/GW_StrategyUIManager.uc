

class GW_StrategyUIManager extends Object;


static function CityControlZoneUICard (GW_GameState_CityControlZone CCZ)
{
	local GW_UIStrategy_CityControlZone kScreen;

	if(!`HQPRES.ScreenStack.GetCurrentScreen().IsA('GW_UIStrategy_CityControlZone'))
	{
		kScreen = `HQPRES.Spawn(class'GW_UIStrategy_CityControlZone', `HQPRES);
		kScreen.bInstantInterp = false;
		kScreen.CityControlZone = CCZ;
		`HQPRES.ScreenStack.Push(kScreen);
	}

	if( `GAME.GetGeoscape().IsScanning() )
		`HQPRES.StrategyMap2D.ToggleScan();

}