class GW_MissionLogic_Reinforcements extends XComGameState_MissionLogic config(GuerrillaWar);

enum eReinforcementTrigger
{
	eReinforcementTrigger_OnMissionStart,
	eReinforcementTrigger_OnRedAlert,
};

struct ReinforcementEncounter
{
	var name EncounterID;
	var int TurnFlareDrops;
	var int FlareCountdown;
	var int RepeatCountdown;
	var int RandomTilesSpread;
	var int XOffsetFromObjective;
	var int YOffsetFromObjective;

	structdefaultproperties
	{
		FlareCountdown = 2
		RepeatCountdown = 0
		RandomTilesSpread = 40
		YOffsetFromObjective = 0
		XOffsetFromObjective = 0
	}
};

struct ReinforcementSchedule
{
	var string MissionType;
	var int MinRequiredAlertLevel;
	var int MaxRequiredAlertLevel;
	var eReinforcementTrigger ProgressionTrigger;
	var array<ReinforcementEncounter> Reinforcements;

	structdefaultproperties
	{
		MinRequiredAlertLevel = 0
		MaxRequiredAlertLevel = 1000
	}
};

var const config array<ReinforcementSchedule> ReinforcementSchedules;

var ReinforcementSchedule ActiveSchedule;
var bool FoundSchedule;
var bool ProgressionActive;
var int ProgressionTurn;

delegate EventListenerReturn OnEventDelegate(Object EventData, Object EventSource, XComGameState GameState, Name EventID);

function SetupMissionStartState(XComGameState StartState)
{
	FoundSchedule = FindReinforcementSchedule();

	if (FoundSchedule)
	{
		if (ActiveSchedule.ProgressionTrigger == eReinforcementTrigger_OnMissionStart)
		{
			ProgressionActive = true;
		}
	}
}

function RegisterEventHandlers()
{	
	FoundSchedule = FindReinforcementSchedule();

	if (FoundSchedule)
	{
		if (ActiveSchedule.ProgressionTrigger == eReinforcementTrigger_OnRedAlert)
		{
			`log("Reinforcement Schedule Awaiting RedAlert");
			OnAbilityActivated(CheckRedAlert);
		}

		OnAlienTurnBegin(AdvanceReinforcementSchedule);
	}
	else
	{
		`log("NO REINFORCEMENT SCHEDULE ACTIVATED");
	}
}

function bool FindReinforcementSchedule()
{
	local XComGameStateHistory History;
	local XComGameState_BattleData BattleData;
	local ReinforcementSchedule Schedule;
	local array<ReinforcementSchedule> Candidates;
	local string MissionType;
	local int AlertLevel;

	History = `XCOMHISTORY;
	BattleData = XComGameState_BattleData(History.GetSingleGameStateObjectForClass(class'XComGameState_BattleData'));
	AlertLevel = BattleData.GetAlertLevel();
	MissionType = BattleData.MapData.ActiveMission.sType;

	`log("Finding Reinforcement Schedule for");
	`log(MissionType);
	`log(AlertLevel);
	foreach ReinforcementSchedules(Schedule)
	{
		if (Schedule.MissionType == MissionType && AlertLevel >= Schedule.MinRequiredAlertLevel && AlertLevel <= Schedule.MaxRequiredAlertLevel)
		{
			Candidates.AddItem(Schedule);
		}
	}
	`log("Candidates:");
	`log(Candidates.Length);
	if (Candidates.Length == 0)
	{
		return false;
	}
	else
	{
		ActiveSchedule = Candidates[Rand(Candidates.Length)];
		return true;
	}
}

function EventListenerReturn CheckRedAlert(Object EventData, Object EventSource, XComGameState GameState, Name EventID)
{
	local XComGameState NewGameState;
	local GW_MissionLogic_Reinforcements NewMissionState;

	if (!ProgressionActive && EventAbilityIs("RedAlert", EventData, GameState))
	{
		ProgressionActive = true;

		NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Activate Progression");
		NewMissionState = GW_MissionLogic_Reinforcements(NewGameState.CreateStateObject(class'GW_MissionLogic_Reinforcements', ObjectID));
		NewMissionState.ProgressionActive = ProgressionActive;
		NewGameState.AddStateObject(NewMissionState);
		`XCOMGAME.GameRuleset.SubmitGameState(NewGameState);
		`log("Reinforcement Schedule Activated");
	}
	return ELR_NoInterrupt;
}

function EventListenerReturn AdvanceReinforcementSchedule(Object EventData, Object EventSource, XComGameState GameState, Name EventID)
{
	local XComGameStateHistory History;
	local XComGameState_BattleData BattleData;
	local ReinforcementEncounter Encounter;
	local bool ActivatesThisTurn, OverrideDefaultLocation;
	local int RepeatCountdown;
	local float TILE_SIZE;
	local Vector ObjectiveLocation, ReinforceLocation;
	local XComGameState NewGameState;
	local GW_MissionLogic_Reinforcements NewMissionState;

	TILE_SIZE = 96;

	History = `XCOMHISTORY;
	BattleData = XComGameState_BattleData(History.GetSingleGameStateObjectForClass(class'XComGameState_BattleData'));
	ObjectiveLocation = BattleData.MapData.ObjectiveLocation;

	if (!ProgressionActive)
	{
		return ELR_NoInterrupt;
	}
	`log("Processing Reinforcement Schedule");
	`log(ProgressionTurn);
	`log("Objective Located:");
	`log(ObjectiveLocation);

	foreach ActiveSchedule.Reinforcements(Encounter)
	{
		if (Encounter.RepeatCountdown != 0 && Encounter.TurnFlareDrops < ProgressionTurn)
		{
			RepeatCountdown = (ProgressionTurn - Encounter.TurnFlareDrops) % Encounter.RepeatCountdown;
			ActivatesThisTurn = RepeatCountdown == 0;
		}
		else 
		{
			ActivatesThisTurn = Encounter.TurnFlareDrops == ProgressionTurn;
		}
		
		if (ActivatesThisTurn)
		{
			OverrideDefaultLocation = Encounter.XOffsetFromObjective != 0 || Encounter.YOffsetFromObjective != 0;
			ReinforceLocation.X = ObjectiveLocation.X + (float(Encounter.XOffsetFromObjective) * TILE_SIZE);
			ReinforceLocation.Y = ObjectiveLocation.Y + (float(Encounter.YOffsetFromObjective) * TILE_SIZE);
			ReinforceLocation.Z = ObjectiveLocation.Z + 0.0;
			`log("ReinforceLocation:");
			`log(ReinforceLocation);

			class'XComGameState_NonstackingReinforcements'.static.InitiateReinforcements(
				Encounter.EncounterID,
				Encounter.FlareCountdown, 
				OverrideDefaultLocation, // bUseOverrideTargetLocation,
				ReinforceLocation, // OverrideTargetLocation, 
				Encounter.RandomTilesSpread // Spawn tiles offset
			);
			// Time to Drop
		}
	}

	ProgressionTurn = ProgressionTurn + 1;

	NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("Activate Progression");
	NewMissionState = GW_MissionLogic_Reinforcements(NewGameState.CreateStateObject(class'GW_MissionLogic_Reinforcements', ObjectID));
	NewMissionState.ProgressionTurn = ProgressionTurn;
	NewGameState.AddStateObject(NewMissionState);
	`XCOMGAME.GameRuleset.SubmitGameState(NewGameState);
	`log("Reinforcement Schedule Activated");
	return ELR_NoInterrupt;
}

defaultproperties
{
	ProgressionActive = false
	ProgressionTurn = 0
}