class GW_GameState_EvacZoneSpawner extends XComGameState_BaseObject config(GameCore);

var private const config string XComEvacBlueprintMapName;
var private const config string AlienEvacBlueprintMapName;

var() const config int PositiveXDimension;
var() const config int PositiveYDimension;
var() const config int NegativeXDimension;
var() const config int NegativeYDimension;

var() protectedwrite Vector CenterLocation;

// The number of player turns remaining before the zone spawns
var int Countdown;
var() protectedwrite ETeam Team;

static function GW_GameState_EvacZoneSpawner PlaceEvacZoneSpawner(
	XComGameState NewGameState, Vector SpawnLocation, optional ETeam InTeam = eTeam_XCom
)	{
	local XComGameState_EvacZone EvacState;
	local GW_GameState_EvacZoneSpawner SpawnerState;
	local X2Actor_EvacZone EvacZoneActor;

	EvacState = GetEvacZone(InTeam);
	if (EvacState == none)
	{
		SpawnerState = GW_GameState_EvacZoneSpawner(NewGameState.CreateStateObject(class'GW_GameState_EvacZoneSpawner'));
		SpawnerState.Team = InTeam;
	}
	else
	{
		EvacZoneActor = X2Actor_EvacZone( EvacState.GetVisualizer( ) );
		if (EvacZoneActor != none)
		{
			EvacZoneActor.Destroy( );
		}

		NewGameState.RemoveStateObject(EvacState.ObjectID);
		SpawnerState = GW_GameState_EvacZoneSpawner(NewGameState.CreateStateObject(class'GW_GameState_EvacZoneSpawner'));
		SpawnerState.Team = InTeam;
	}

	SpawnerState.Countdown = 4;
	SpawnerState.CenterLocation = SpawnLocation;
	NewGameState.AddStateObject(SpawnerState);

	SpawnerState.RegisterListener();

	return SpawnerState;
}

function RegisterListener () {
	local Object ThisObj;
	ThisObj = self;
	`XEVENTMGR.RegisterForEvent(ThisObj, 'PlayerTurnBegun', OnTurnBegun, ELD_OnStateSubmitted);
}

// This is called at the start of each AI turn
function EventListenerReturn OnTurnBegun(Object EventData, Object EventSource, XComGameState GameState, Name EventID)
{
	local XComGameState NewGameState;
	local X2GameRuleset Ruleset;
	local GW_GameState_EvacZoneSpawner NewSpawnerState;
	local Object ThisObj;
	ThisObj = self;

	Ruleset = `XCOMGAME.GameRuleset;

	if( Countdown > 0 )
	{
		NewGameState = class'XComGameStateContext_ChangeContainer'.static.CreateChangeState("UpdateEvacCountdown");
		NewSpawnerState = GW_GameState_EvacZoneSpawner(NewGameState.CreateStateObject(class'GW_GameState_EvacZoneSpawner', ObjectID));
		--NewSpawnerState.Countdown;
		NewGameState.AddStateObject(NewSpawnerState);

		if( NewSpawnerState.Countdown == 0 )
		{
			XComGameStateContext_ChangeContainer(NewGameState.GetContext()).BuildVisualizationFn = BuildVisualization;
			class'XComGameState_EvacZone'.static.PlaceEvacZone(NewGameState, CenterLocation, Team);

			`XEVENTMGR.UnRegisterFromEvent(ThisObj, 'PlayerTurnBegun');
		}
		Ruleset.SubmitGameState(NewGameState);
	}

	return ELR_NoInterrupt;
}





function BuildVisualization(XComGameState GameState, out array<VisualizationTrack> VisualizationTracks)
{
	local XComGameState_EvacZone EvacZone;
	local VisualizationTrack Track;
	local GW_GameState_EvacZoneSpawner EvacSpawner;
	local X2Action_PlayEffect EvacSpawnerEffectAction;
	local VisualizationTrack STrack;

	foreach GameState.IterateByClassType(class'XComGameState_EvacZone', EvacZone)
	{
		Track.StateObject_OldState = EvacZone;
		Track.StateObject_NewState = EvacZone;
		class'X2Action_SyncVisualizer'.static.AddToVisualizationTrack(Track, GameState.GetContext());
		VisualizationTracks.AddItem(Track);
	}

	foreach GameState.IterateByClassType(class'GW_GameState_EvacZoneSpawner', EvacSpawner)
	{
		STrack.StateObject_OldState = EvacSpawner;
		STrack.StateObject_NewState = EvacSpawner;
		EvacSpawnerEffectAction = X2Action_PlayEffect(class'X2Action_PlayEffect'.static.AddToVisualizationTrack(STrack, GameState.GetContext()));
		EvacSpawnerEffectAction.EffectName = "GW_Effects.GW_Evac_Warmup";
		EvacSpawnerEffectAction.EffectLocation = EvacSpawner.CenterLocation;
		EvacSpawnerEffectAction.bStopEffect = true;
		VisualizationTracks.AddItem(STrack);
	}

}

static function XComGameState_EvacZone GetEvacZone(optional ETeam InTeam = eTeam_XCom)
{
	local XComGameState_EvacZone EvacState;
	local XComGameStateHistory History;

	History = `XCOMHISTORY;
	foreach History.IterateByClassType(class'XComGameState_EvacZone', EvacState)
	{
		if(EvacState.Team == InTeam)
		{
			return EvacState;
		}
	}

	return none;
}

function string GetEvacZoneBlueprintMap()
{
	if(Team == eTeam_Alien)
	{
		return AlienEvacBlueprintMapName;
	}
	else
	{
		return XComEvacBlueprintMapName;
	}
}

DefaultProperties
{
	Team=eTeam_XCom
}