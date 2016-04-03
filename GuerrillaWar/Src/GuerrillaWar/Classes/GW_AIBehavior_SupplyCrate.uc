// This is an Unreal Script
class GW_AIBehavior_SupplyCrate extends XGAIBehavior;

state ExecutingAI
{
Begin:	
	SkipTurn();
	GotoState('EndOfTurn');
}