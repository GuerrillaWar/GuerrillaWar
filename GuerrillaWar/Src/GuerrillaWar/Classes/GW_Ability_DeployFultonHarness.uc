// This is an Unreal Script
class GW_Ability_DeployFultonHarness extends X2Ability
	config(GuerrillaWar);

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;

	Templates.AddItem(CreateDeployFultonHarness());
	return Templates;
}


static function X2AbilityTemplate CreateDeployFultonHarness()
{
	local X2AbilityTemplate                 Template;
	local X2AbilityCost_Ammo                AmmoCost;
	local X2AbilityCost_ActionPoints        ActionPointCost;
	local X2AbilityTarget_Single            SingleTarget;
	local X2Condition_UnitProperty      TargetCondition, ShooterCondition;
	local X2AbilityTrigger_PlayerInput      InputTrigger;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'DeployFultonHarness');

	AmmoCost = new class'X2AbilityCost_Ammo';
	AmmoCost.iAmmo = 1;
	AmmoCost.bReturnChargesError = true;
	Template.AbilityCosts.AddItem(AmmoCost);

	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = 1;
	Template.AbilityCosts.AddItem(ActionPointCost);
	
	Template.AbilityToHitCalc = default.DeadEye;

	SingleTarget = new class'X2AbilityTarget_Single';
	Template.AbilityTargetStyle = SingleTarget;

	ShooterCondition = new class'X2Condition_UnitProperty';
	ShooterCondition.ExcludeDead = true;
	Template.AbilityShooterConditions.AddItem(ShooterCondition);

	Template.AddShooterEffectExclusions();

	TargetCondition = new class'X2Condition_UnitProperty';
	TargetCondition.CanBeCarried = true;
	TargetCondition.ExcludeAlive = false;               
	TargetCondition.ExcludeDead = false;
	TargetCondition.ExcludeFriendlyToSource = false;
	TargetCondition.ExcludeHostileToSource = false;     
	TargetCondition.RequireWithinRange = true;
	TargetCondition.WithinRange = 144;
	Template.AbilityTargetConditions.AddItem(TargetCondition);

	InputTrigger = new class'X2AbilityTrigger_PlayerInput';
	Template.AbilityTriggers.AddItem(InputTrigger);

	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_stabilize";
	Template.ShotHUDPriority = class'UIUtilities_Tactical'.const.STABILIZE_PRIORITY;
	Template.bUseAmmoAsChargesForHUD = true;
	Template.iAmmoAsChargesDivisor = 1;
	Template.Hostility = eHostility_Defensive;
	Template.eAbilityIconBehaviorHUD = eAbilityIconBehavior_AlwaysShow;
	Template.bDisplayInUITooltip = false;
	Template.bLimitTargetIcons = true;

	Template.ActivationSpeech = 'StabilizingAlly';

	Template.BuildNewGameStateFn = DeployFultonHarness_BuildGameState;
	Template.BuildVisualizationFn = DeployFultonHarness_BuildVisualization;

	return Template;
}

simulated function XComGameState DeployFultonHarness_BuildGameState( XComGameStateContext Context )
{
	local XComGameStateHistory History;
	local XComGameState NewGameState;
	local XComGameStateContext_Ability AbilityContext;
	local XComGameState_Unit Target_OriginalState, Target_NewState;	
	local XComGameState_Ability AbilityState;
	local XComGameState_Effect BleedOutEffect;
	local X2AbilityTemplate AbilityTemplate;

	History = `XCOMHISTORY;
	//Build the new game state and context
	NewGameState = History.CreateNewGameState(true, Context);	
	AbilityContext = XComGameStateContext_Ability(Context);	
	AbilityState = XComGameState_Ability(History.GetGameStateForObjectID(AbilityContext.InputContext.AbilityRef.ObjectID));
	AbilityTemplate = AbilityState.GetMyTemplate();	
	if (AbilityContext.InputContext.PrimaryTarget.ObjectID != 0)
	{
		Target_OriginalState = XComGameState_Unit(History.GetGameStateForObjectID(AbilityContext.InputContext.PrimaryTarget.ObjectID));
		Target_NewState = XComGameState_Unit(NewGameState.CreateStateObject(Target_OriginalState.Class, Target_OriginalState.ObjectID));

		//Trigger this ability here so that any the EvacActivated event is triggered before UnitRemovedFromPlay
		`XEVENTMGR.TriggerEvent('ExtractActivated', AbilityState, Target_NewState, NewGameState); 

		AbilityTemplate.ApplyCost(AbilityContext, AbilityState, Target_NewState, Target_NewState, NewGameState);	

		
		Target_NewState.bBodyRecovered = true;
		Target_NewState.RemoveStateFromPlay();

		`XEVENTMGR.TriggerEvent( 'UnitRemovedFromPlay', Target_NewState, Target_NewState, NewGameState );			
		`XEVENTMGR.TriggerEvent( 'UnitEvacuated', Target_NewState, Target_NewState, NewGameState );			

		`XWORLD.ClearTileBlockedByUnitFlag(Target_NewState);
			
		if (Target_NewState.IsBleedingOut())
		{
			//  cleanse the effect so the unit is rendered unconscious
			BleedOutEffect = Target_NewState.GetUnitAffectedByEffectState(class'X2StatusEffects'.default.BleedingOutName);
			BleedOutEffect.RemoveEffect(NewGameState, NewGameState, true);

			// Achievement: Evacuate a soldier whose bleed-out timer is still running
			if (Target_NewState.IsAlive() && Target_NewState.IsPlayerControlled())
			{
				`ONLINEEVENTMGR.UnlockAchievement(AT_EvacRescue);
			}

		}
		NewGameState.AddStateObject(Target_NewState);
	}

	//Return the game state we have created
	return NewGameState;
}

simulated function DeployFultonHarness_BuildVisualization(XComGameState VisualizeGameState, out array<VisualizationTrack> OutVisualizationTracks)
{
	local XComGameStateHistory          History;
	local XComGameState_Unit            GameStateUnit;
	local VisualizationTrack            EmptyTrack;
	local VisualizationTrack            BuildTrack;


	History = `XCOMHISTORY;

	//Build tracks for each evacuating unit
	foreach VisualizeGameState.IterateByClassType(class'XComGameState_Unit', GameStateUnit)
	{
		if (!GameStateUnit.bRemovedFromPlay)
			continue;

		//Start their track
		BuildTrack = EmptyTrack;
		BuildTrack.StateObject_OldState = History.GetGameStateForObjectID(GameStateUnit.ObjectID, eReturnType_Reference, VisualizeGameState.HistoryIndex - 1);
		BuildTrack.StateObject_NewState = VisualizeGameState.GetGameStateForObjectID(GameStateUnit.ObjectID);
		BuildTrack.TrackActor = History.GetVisualizer(GameStateUnit.ObjectID);

		//Add this potential flyover (does this still exist in the game?)
		class'XComGameState_Unit'.static.SetUpBuildTrackForSoldierRelationship(BuildTrack, VisualizeGameState, GameStateUnit.ObjectID);


		class'X2Action_Evac'.static.AddToVisualizationTrack(BuildTrack, VisualizeGameState.GetContext()); //Not being carried - rope out
		//Hide the pawn explicitly now - in case the vis block doesn't complete immediately to trigger an update
		class'X2Action_RemoveUnit'.static.AddToVisualizationTrack(BuildTrack, VisualizeGameState.GetContext());

		//Add track to vis block
		OutVisualizationTracks.AddItem(BuildTrack);
	}
	//****************************************************************************************
}
