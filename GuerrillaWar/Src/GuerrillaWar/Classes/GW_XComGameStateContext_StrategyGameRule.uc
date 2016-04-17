class GW_XComGameStateContext_StrategyGameRule extends XComGameStateContext_StrategyGameRule;

static function XComGameState CreateStrategyGameStart(optional XComGameState StartState, optional bool bSetRandomSeed=true, optional bool bTutorialEnabled=false, optional int SelectedDifficulty=1, optional bool bSuppressFirstTimeVO=false)
{	
	local XComGameStateHistory History;
	local XComGameStateContext_StrategyGameRule StrategyStartContext;
	local Engine LocalGameEngine;
	local XComOnlineEventMgr EventManager;
	local array<X2DownloadableContentInfo> DLCInfos;
	local int i;
	local int Seed;
	local X2StrategyElementTemplateManager StratMgr;
	local array<X2StrategyElementTemplate> POITemplates;

	if( StartState == None )
	{
		History = `XCOMHISTORY;

		StrategyStartContext = XComGameStateContext_StrategyGameRule(class'XComGameStateContext_StrategyGameRule'.static.CreateXComGameStateContext());
		StrategyStartContext.GameRuleType = eStrategyGameRule_StrategyGameStart;
		StartState = History.CreateNewGameState(false, StrategyStartContext);
		History.AddGameStateToHistory(StartState);
	}

	if (bSetRandomSeed)
	{
		LocalGameEngine = class'Engine'.static.GetEngine();
		Seed = LocalGameEngine.GetARandomSeed();
		LocalGameEngine.SetRandomSeeds(Seed);
	}

	//Create start time
	class'XComGameState_GameTime'.static.CreateGameStartTime(StartState);

	//Create campaign settings
	class'XComGameState_CampaignSettings'.static.CreateCampaignSettings(StartState, bTutorialEnabled, SelectedDifficulty, bSuppressFirstTimeVO);

	//Create analytics object
	class'XComGameState_Analytics'.static.CreateAnalytics(StartState, SelectedDifficulty);

	//Create and add regions
	class'XComGameState_WorldRegion'.static.SetUpRegions(StartState);

	//Create and add continents
	class'XComGameState_Continent'.static.SetUpContinents(StartState);

	//Create and add region links
	class'XComGameState_RegionLink'.static.SetUpRegionLinks(StartState);

	//Create and add cities
	class'XComGameState_City'.static.SetUpCities(StartState);

	//Create and add Trading Posts (requires regions)
	class'XComGameState_TradingPost'.static.SetUpTradingPosts(StartState);

	// Create and add Black Market (requires regions)
	class'XComGameState_BlackMarket'.static.SetUpBlackMarket(StartState);

	// Create and add the Resource Cache (requires regions)
	class'XComGameState_ResourceCache'.static.SetUpResourceCache(StartState);

	// Create the POIs
	StratMgr = class'X2StrategyElementTemplateManager'.static.GetStrategyElementTemplateManager();
	POITemplates = StratMgr.GetAllTemplatesOfClass(class'X2PointOfInterestTemplate');
	`log("*********************************Initialized templates**************************************");
	// Iterate through the templates and build each POI State Object
	for (idx = 0; idx < POITemplates.Length; idx++)
	{
		`log("Templates name :" $ POITemplates[idx].DataName);
	}
	class'XComGameState_PointOfInterest'.static.SetUpPOIs(StartState);
	
	//Create XCom Techs
	class'XComGameState_Tech'.static.SetUpTechs(StartState);

	//Create Resistance HQ
	class'XComGameState_HeadquartersResistance'.static.SetUpHeadquarters(StartState, bTutorialEnabled);

	//Create X-Com HQ (Rooms, Facilities, Initial Staff)
	class'XComGameState_HeadquartersXCom'.static.SetUpHeadquarters(StartState, bTutorialEnabled);

	// Create Dark Events
	class'XComGameState_DarkEvent'.static.SetUpDarkEvents(StartState);

	//Create Alien HQ (Alien Facilities)
	class'XComGameState_HeadquartersAlien'.static.SetUpHeadquarters(StartState);

	// Create Mission Calendar
	class'XComGameState_MissionCalendar'.static.SetupCalendar(StartState);

	// Create Objectives
	class'XComGameState_Objective'.static.SetUpObjectives(StartState);

	// Finish initializing Havens
	class'XComGameState_Haven'.static.SetUpHavens(StartState);

	// Let the DLC / Mods hook the creation of a new campaign
	EventManager = `ONLINEEVENTMGR;
	DLCInfos = EventManager.GetDLCInfos(false);
	for(i = 0; i < DLCInfos.Length; ++i)
	{
		DLCInfos[i].InstallNewCampaign(StartState);
	}

	return StartState;
}