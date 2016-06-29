class GW_GameState_ResistanceCamp extends GW_GameState_StrategyAsset;
//
//
//
//
//const NUM_TILES = 3;
//
//
//static function SetUpResistanceCamps(XComGameState StartState, optional bool bTutorialEnabled = false)
//{
//
//}
//
//static function ActivateCampInRegion(XComGameState NewGameState, XComGameState_WorldRegion RegionState)
//{
	//local GW_GameState_ResistanceCamp Camp;
//
	//Camp = GW_GameState_ResistanceCamp(NewGameState.CreateStateObject(class'GW_GameState_ResistanceCamp'));
	//Camp.Region = RegionState.GetReference();
	//Camp.Continent = RegionState.GetContinent().GetReference();
	//Camp.SetLocation(RegionState.GetContinent());
	//NewGameState.AddStateObject(Camp);
//}
//
//function SetLocation(XComGameState_Continent ContinentState)
//{
	//Location = ContinentState.GetRandomLocationInContinent(, self);
//}
//
//
//function StaticMesh GetStaticMesh()
//{
	//return StaticMesh(`CONTENT.RequestGameArchetype("UI_3D.Overworld.Haven"));
//}
//
//
//// GEOSCAPE_ENTITY METHODS
//protected function bool DisplaySelectionPrompt()
//{
	//class'GW_StrategyUIManager'.static.ResistanceCampUICard(self);
//
	//return true;
//}
//