class GW_MissionLogic_Reinforcements extends X2MissionLogic config(GuerrillaWar);

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

	structdefaultproperties
	{
		FlareCountdown = 1
		RepeatCountdown = 0
	}
};

struct ReinforcementSchedule
{
	var string MissionType;
	var eReinforcementTrigger ProgressionTrigger;
	var array<ReinforcementEncounter> Reinforcements;
};

var const config array<ReinforcementSchedule> ReinforcementSchedules;

var ReinforcementSchedule ActiveSchedule;
var bool FoundSchedule;
var bool ProgressionActive;
var int ProgressionTurn;

delegate EventListenerReturn OnEventDelegate(Object EventData, Object EventSource, XComGameState GameState, Name EventID);

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
		else
		{
			`log("Reinforcement Schedule Activated");
			ProgressionActive = true;
		}
		OnAlienTurnBegin(AdvanceReinforcementSchedule);
	}
}

function bool FindReinforcementSchedule()
{
	local XComGameStateHistory History;
	local XComGameState NewGameState;
	local XComGameState_BattleData BattleData;
	local ReinforcementSchedule Schedule;
	local string MissionType;

	History = `XCOMHISTORY;
	BattleData = XComGameState_BattleData(History.GetSingleGameStateObjectForClass(class'XComGameState_BattleData'));
	MissionType = BattleData.MapData.ActiveMission.sType;
	foreach ReinforcementSchedules(Schedule)
	{
		if (Schedule.MissionType == MissionType)
		{
			ActiveSchedule = Schedule;
			return true;
		}
	}
	return false;
}

function EventListenerReturn CheckRedAlert(Object EventData, Object EventSource, XComGameState GameState, Name EventID)
{
	if (!ProgressionActive && EventAbilityIs("RedAlert", EventData, GameState))
	{
		ProgressionActive = true;
		`log("Reinforcement Schedule Activated");
	}
	return ELR_NoInterrupt;
}

function EventListenerReturn AdvanceReinforcementSchedule(Object EventData, Object EventSource, XComGameState GameState, Name EventID)
{
	local ReinforcementEncounter Encounter;
	local bool ActivatesThisTurn;
	local int RepeatCountdown;

	if (!ProgressionActive)
	{
		return ELR_NoInterrupt;
	}
	`log("Processing Reinforcement Schedule");
	`log(ProgressionTurn);

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
			class'XComGameState_AIReinforcementSpawner'.static.InitiateReinforcements(
				Encounter.EncounterID,
				Encounter.FlareCountdown, 
				false, // bUseOverrideTargetLocation,
				, // OverrideTargetLocation, 
				40 // Spawn tiles offset
			);
			// Time to Drop
		}
	}

	ProgressionTurn = ProgressionTurn + 1;
	`log("Advancing Reinforcement Schedule");
	return ELR_NoInterrupt;
}

defaultproperties
{
	ProgressionActive = false
	ProgressionTurn = 0
}