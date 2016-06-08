// This is an Unreal Script
//---------------------------------------------------------------------------------------
//  *********   FIRAXIS SOURCE CODE   ******************
//  FILE:    X2Ability_AbortMission.uc
//  AUTHOR:  
//  PURPOSE: Defines abilities related to mission abort, evac, etc
//---------------------------------------------------------------------------------------
//  Copyright (c) 2016 Firaxis Games, Inc. All rights reserved.
//--------------------------------------------------------------------------------------- 

class GW_Ability_AbortMission extends X2Ability_AbortMission;

static function X2AbilityTemplate PlaceEvacZone()
{
	local X2AbilityTemplate                 Template;
	local X2AbilityCost_ActionPoints        ActionPointCost;
	local X2AbilityCooldown_Global          Cooldown;
	local X2AbilityTarget_Cursor            CursorTarget;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'PlaceEvacZone');

	Template.RemoveTemplateAvailablility(Template.BITFIELD_GAMEAREA_Multiplayer); // Do not allow "Evac Zone Placement" in MP!

	Template.Hostility = eHostility_Neutral;
	Template.bCommanderAbility = true;
	Template.ConcealmentRule = eConceal_Never;
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_AlwaysShow;
	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.PLACE_EVAC_PRIORITY;
	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_evac";
	Template.AbilitySourceName = 'eAbilitySource_Commander';

	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);
	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);

	CursorTarget = new class'X2AbilityTarget_Cursor';
	Template.AbilityTargetStyle = CursorTarget;
	Template.TargetingMethod = class'X2TargetingMethod_EvacZone';

	
	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	ActionPointCost.bFreeCost = true;
	Template.AbilityCosts.AddItem(ActionPointCost);

	Cooldown = new class'X2AbilityCooldown_Global';
	Cooldown.iNumTurns = 5;
	Template.AbilityCooldown = Cooldown;

	Template.BuildNewGameStateFn = PlaceEvacZone_BuildGameState;
	Template.BuildVisualizationFn = PlaceEvacZone_BuildVisualization;

	return Template;
}


simulated function XComGameState PlaceEvacZone_BuildGameState( XComGameStateContext Context )
{
	local XComGameState NewGameState;
	local XComGameState_Unit UnitState;	
	local XComGameState_Ability AbilityState;	
	local XComGameStateContext_Ability AbilityContext;
	local X2AbilityTemplate AbilityTemplate;
	local XComGameStateHistory History;


	History = `XCOMHISTORY;
	//Build the new game state frame
	NewGameState = History.CreateNewGameState(true, Context);	

	AbilityContext = XComGameStateContext_Ability(NewGameState.GetContext());	
	AbilityState = XComGameState_Ability(History.GetGameStateForObjectID(AbilityContext.InputContext.AbilityRef.ObjectID, eReturnType_Reference));	
	AbilityTemplate = AbilityState.GetMyTemplate();

	UnitState = XComGameState_Unit(NewGameState.CreateStateObject(class'XComGameState_Unit', AbilityContext.InputContext.SourceObject.ObjectID));
	//Apply the cost of the ability
	AbilityTemplate.ApplyCost(AbilityContext, AbilityState, UnitState, none, NewGameState);
	NewGameState.AddStateObject(UnitState);

	`assert(AbilityContext.InputContext.TargetLocations.Length == 1);
	class'GW_GameState_EvacZoneSpawner'.static.PlaceEvacZoneSpawner(
		NewGameState, AbilityContext.InputContext.TargetLocations[0], UnitState.GetTeam()
	);

	//Return the game state we have created
	return NewGameState;	
}

simulated function PlaceEvacZone_BuildVisualization(XComGameState GameState, out array<VisualizationTrack> OutVisualizationTracks)
{
	local XComGameState_EvacZone EvacZone;
	local X2Action_PlayEffect EvacSpawnerEffectAction;
	local GW_GameState_EvacZoneSpawner EvacSpawner;
	local VisualizationTrack Track;
	local X2Actor_EvacZone EvacZoneActor;
	local VisualizationTrack STrack;

	foreach GameState.IterateByClassType(class'XComGameState_EvacZone', EvacZone)
	{
		EvacZoneActor = X2Actor_EvacZone( EvacZone.GetVisualizer( ) );
		if (EvacZoneActor != none)
		{
			EvacZoneActor.Destroy( );
		}

		GameState.RemoveStateObject(EvacZone.ObjectID);

		Track.StateObject_OldState = EvacZone;
		Track.StateObject_NewState = EvacZone;
		class'X2Action_SyncVisualizer'.static.AddToVisualizationTrack(Track, GameState.GetContext());
		OutVisualizationTracks.AddItem(Track);
	}

	foreach GameState.IterateByClassType(class'GW_GameState_EvacZoneSpawner', EvacSpawner)
	{
		STrack.StateObject_OldState = EvacSpawner;
		STrack.StateObject_NewState = EvacSpawner;
		EvacSpawnerEffectAction = X2Action_PlayEffect(class'X2Action_PlayEffect'.static.AddToVisualizationTrack(STrack, GameState.GetContext()));
		EvacSpawnerEffectAction.EffectName = "GW_Effects.GW_Evac_Warmup";
		EvacSpawnerEffectAction.EffectLocation = EvacSpawner.CenterLocation;
		EvacSpawnerEffectAction.bStopEffect = false;
		OutVisualizationTracks.AddItem(STrack);
	}


}
