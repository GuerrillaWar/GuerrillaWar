class GW_UIStrategyMap_Listener extends UIScreenListener;

var UIText DisplayText;

event OnInit(UIScreen Screen)
{
	local UIStrategyMap strategyMapScreen;
	local UIPanel BGBox;
	local UILargeButton guerrillaActionButton;

	`log("Initializing UI strategy");

	strategyMapScreen = UIStrategyMap(Screen);

	// Let’s spawn a new rectangle graphic inside of the research progress bar.
	BGBox = strategyMapScreen.Spawn(class'UIPanel', strategyMapScreen);
	BGBox.InitPanel('BGBoxSimple', class'UIUtilities_Controls'.const.MC_X2BackgroundSimple);
	BGBox.OriginTopLeft();
	BGBox.SetPosition(100, 100); // This is relative to the anchor we just set.
	BGBox.SetSize(200, 200);
	BGBox.SetAlpha(50);

	
	guerrillaActionButton = BGBox.Spawn(class'UILargeButton', BGBox);
	guerrillaActionButton.InitLargeButton('TestLargeButton2', "Supply Raid", "", TestClickLargeButton );
	guerrillaActionButton.OriginTopLeft();
	guerrillaActionButton.SetPosition(10, 10);
	guerrillaActionButton.SetSize(100, 50);


	// Now we can put a new text field over that rectangle, also inside the research bar.
	DisplayText = BGBox.Spawn(class'UIText', BGBox).InitText();
	//DisplayText.SetY(BGBox.Y + 10);
	DisplayText.OriginTopLeft();
	RefreshDisplayText();

}

event OnReceiveFocus(UIScreen Screen)
{
	// If the data to display may change on other screens, you need to refresh
	// your text field when you return to this screen.
	RefreshDisplaytext();
}

function RefreshDisplayText()
{
	DisplayText.SetText( "Guerrilla Actions" /*update the value to what you want to show*/ );
}

event OnLoseFocus(UIScreen Screen)
{
}

event OnRemoved(UIScreen Screen)
{
}

public function TestClickLargeButton(UIButton Button)
{
	`log("Test clicked Large Button! " @Button.Name);
	SpawnSupplyRaidScanningSite();
}

defaultproperties
{
	ScreenClass = class'UIStrategyMap';
}

function SpawnSupplyRaidScanningSite()
{
	local XComGameState_PointOfInterest ScanningSite,POIState;
	local XComGameState NewGameState;
	//local XComGameState_WorldRegion RegionState;
	//local XComGameState_HeadquartersXCom XComHQ;
	local XComGameStateHistory History;
	local X2StrategyElementTemplateManager StratMgr;
	local X2PointOfInterestTemplate POISource;

	local array<X2StrategyElementTemplate> POITemplates;
	local int idx;
	//Init
	History = `XCOMHISTORY;
	//XComHQ = XComGameState_HeadquartersXCom(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));
	//RegionState = XComHQ.GetWorldRegion();
	NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Guerrilla War - Spawn new mission");
	StratMgr = class'X2StrategyElementTemplateManager'.static.GetStrategyElementTemplateManager();
	class'XComGameState_PointOfInterest'.static.SetUpPOIs(NewGameState);
	//Setup
	POISource = X2PointOfInterestTemplate(StratMgr.FindStrategyElementTemplate('GW_POI_SupplyLineRaid'));//('POI_Supplies'));
	ScanningSite = POISource.CreateInstanceFromTemplate(NewGameState);
	//ScanningSite = XComGameState_PointOfInterest(NewGameState.CreateStateObject(class'XComGameState_PointOfInterest', ScanningSite.ObjectID));
	
	//Print templates from manager
	POITemplates = StratMgr.GetAllTemplatesOfClass(class'X2PointOfInterestTemplate');


	//Conclude
	NewGameState.AddStateObject(ScanningSite);
	//ScanningSite.Location = RegionState.GetRandomLocationInRegion();
	ScanningSite.Spawn(NewGameState);
	ScanningSIte.bNeedsAppearedPopup = true;
	ScanningSite.SetScanHoursRemaining(2,2);
	//ScanningSite.SetScanHoursRemaining(2, 3);

	
	if(NewGameState.GetNumGameStateObjects() > 0)
	{
		`XCOMGAME.GameRuleset.SubmitGameState(NewGameState);
	}
	else
	{
		History.CleanupPendingGameState(NewGameState);
	}
}

function SpawnSupplyRaid()
{
	local XComGameStateHistory History;
	local XComGameState_HeadquartersXCom XComHQ;
	local XComGameState_MissionSite MissionState;
	local X2MissionSourceTemplate MissionSource;
	local XComGameState_WorldRegion RegionState;
	local XComGameState_Reward RewardState;
	local array<XComGameState_Reward> MissionRewards;
	local X2RewardTemplate RewardTemplate;
	local X2StrategyElementTemplateManager StratMgr;
	local XComGameState NewGameState;
	
	NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Guerrilla War - Spawn new mission");
	

	History = `XCOMHISTORY;
	XComHQ = XComGameState_HeadquartersXCom(History.GetSingleGameStateObjectForClass(class'XComGameState_HeadquartersXCom'));
	RegionState = XComHQ.GetWorldRegion();
	StratMgr = class'X2StrategyElementTemplateManager'.static.GetStrategyElementTemplateManager();
	MissionSource = X2MissionSourceTemplate(StratMgr.FindStrategyElementTemplate('MissionSource_SupplyRaid'));
	RewardTemplate = X2RewardTemplate(StratMgr.FindStrategyElementTemplate('Reward_None'));

	if(MissionSource == none || RewardTemplate == none)
	{
		return;
	}

	//NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("CHEAT: Spawn Mission");
	RewardState = RewardTemplate.CreateInstanceFromTemplate(NewGameState);
	NewGameState.AddStateObject(RewardState);
	RewardState.GenerateReward(NewGameState, , RegionState.GetReference());
	MissionRewards.AddItem(RewardState);

	MissionState = XComGameState_MissionSite(NewGameState.CreateStateObject(class'XComGameState_MissionSite'));
	NewGameState.AddStateObject(MissionState);
	MissionState.BuildMission(MissionSource, RegionState.GetRandom2DLocationInRegion(), RegionState.GetReference(), MissionRewards);

	`XCOMGAME.GameRuleset.SubmitGameState(NewGameState);

//	if(NewGameState.GetNumGameStateObjects() > 0)
//	{
//		`XCOMGAME.GameRuleset.SubmitGameState(NewGameState);
//	}
	//else
	//{
		//History.CleanupPendingGameState(NewGameState);
	//}
}

function XComGameState_MissionCalendar GetMissionCalendar(XComGameState NewGameState)
{
	local XComGameStateHistory History;
	local XComGameState_MissionCalendar CalendarState;

	foreach NewGameState.IterateByClassType(class'XComGameState_MissionCalendar', CalendarState)
	{
		break;
	}

	if(CalendarState == none)
	{
		History = `XCOMHISTORY;
		CalendarState = XComGameState_MissionCalendar(History.GetSingleGameStateObjectForClass(class'XComGameState_MissionCalendar'));
		CalendarState = XComGameState_MissionCalendar(NewGameState.CreateStateObject(class'XComGameState_MissionCalendar', CalendarState.ObjectID));
		NewGameState.AddStateObject(CalendarState);
	}

	return CalendarState;
}