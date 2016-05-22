// This is an Unreal Script

class X2DownloadableContentInfo_GuerrillaWar extends X2DownloadableContentInfo Config(Game);

static event OnPostTemplatesCreated()
{
	`log("GuerrillaWar :: Present And Correct");
}

static event OnPreMission(XComGameState NewGameState, XComGameState_MissionSite MissionState)
{
	local XComMissionLogic_Listener MissionListener;
	local GW_TacticalCleanup EndMissionListener;

	`log("GuerrillaWar :: Ensuring presence of tactical game state listeners");
	
	MissionListener = XComMissionLogic_Listener(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'XComMissionLogic_Listener', true));
	EndMissionListener = GW_TacticalCleanup(`XCOMHISTORY.GetSingleGameStateObjectForClass(class'GW_TacticalCleanup', true));

	if (MissionListener == none)
	{
		MissionListener = XComMissionLogic_Listener(NewGameState.CreateStateObject(class'XComMissionLogic_Listener'));
		NewGameState.AddStateObject(MissionListener);
	}

	MissionListener.RegisterToListen();

	if (EndMissionListener == none)
	{
		EndMissionListener = GW_TacticalCleanup(NewGameState.CreateStateObject(class'GW_TacticalCleanup'));
		NewGameState.AddStateObject(EndMissionListener);
	}

	EndMissionListener.RegisterToListen();

}
