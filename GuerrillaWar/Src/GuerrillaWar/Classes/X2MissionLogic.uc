//---------------------------------------------------------------------------------------
//  FILE:    X2MissionLogic.uc
//  AUTHOR:  James Rakich
//  PURPOSE: Interface for adding new mission logicto X-Com 2. Extend this class and then
//           implement CreateTemplates to produce one or more mission logic templates.
//           
//---------------------------------------------------------------------------------------


class X2MissionLogic extends XComGameState_BaseObject;

function RegisterEventHandlers()
{
	`log("running this in X2MissionLogic, should be overridden");
}

function OnAlienTurnBegin(delegate<X2EventManager.OnEventDelegate> NewDelegate)
{
	local X2EventManager EventManager;
	local Object ThisObj;
	local XComGameState_Player PlayerState;
	EventManager = `XEVENTMGR;
	ThisObj = self;
	PlayerState = `BATTLE.GetAIPlayerState();
	EventManager.RegisterForEvent(ThisObj, 'PlayerTurnBegun', NewDelegate, ELD_OnStateSubmitted, , PlayerState);
}

function OnAbilityActivated(delegate<X2EventManager.OnEventDelegate> NewDelegate)
{
	local X2EventManager EventManager;
	local Object ThisObj;
	local XComGameState_Player PlayerState;
	EventManager = `XEVENTMGR;
	ThisObj = self;
	PlayerState = `BATTLE.GetAIPlayerState();
	EventManager.RegisterForEvent(ThisObj, 'AbilityActivated', NewDelegate, ELD_OnStateSubmitted);
}

function bool EventAbilityIs(string AbilityTemplateFilter, Object EventData, XComGameState GameState)
{
	local XComGameState_Ability Ability;
	local string AbilityTemplate;
	
	Ability = XComGameState_Ability(EventData);
	if(Ability != none && GameState != none && 
	   XComGameStateContext_Ability(GameState.GetContext()).ResultContext.InterruptionStep <= 0) //Only trigger this on the first interrupt step
	{
		AbilityTemplate = string(Ability.GetMyTemplate().DataName);

		if(AbilityTemplateFilter == "" || AbilityTemplateFilter == AbilityTemplate)
		{
			return true;
		}
	}
	return false;
}