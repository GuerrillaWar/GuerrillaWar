// This is an Unreal Script

class GW_Condition_IsFultonable extends X2Condition;

event name CallMeetsCondition(XComGameState_BaseObject kTarget)
{
	return 'AA_Success';

}

event name CallMeetsConditionWithSource(XComGameState_BaseObject kTarget, XComGameState_BaseObject kSource)
{
	local XComGameState_Unit TargetState, SourceState;
	local name RetCode;

	RetCode = 'AA_Success';
	TargetState = XComGameState_Unit(kTarget);
	SourceState = XComGameState_Unit(kSource);
	if (TargetState != none && SourceState != none)
	{
		if (TargetState.IsAbleToAct() && SourceState.IsEnemyUnit(TargetState))
		{
			RetCode = 'AA_NoTargets';
		}
	}
	return RetCode;
}