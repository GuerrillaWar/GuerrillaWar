class GW_StrategyElement_DefaultMissionSources extends X2StrategyElement_DefaultMissionSources config(GameData);

static function X2DataTemplate CreateGuerillaOpTemplate()
{
	local X2MissionSourceTemplate Template;
	local RewardDeckEntry DeckEntry;

	`CREATE_X2TEMPLATE(class'X2MissionSourceTemplate', Template, 'MissionSource_GuerillaOp');
	Template.bIncreasesForceLevel = false;
	Template.bShowRewardOnPin = true;
	Template.OnSuccessFn = GuerillaOpOnSuccess;
	Template.OnFailureFn = GuerillaOpOnFailure;
	Template.OnExpireFn = GuerillaOpOnExpire;
	Template.DifficultyValue = 1;
	Template.OverworldMeshPath = "UI_3D.Overwold_Final.GorillaOps";
	Template.MissionImage = "img:///UILibrary_StrategyImages.X2StrategyMap.Alert_Guerrilla_Ops";
	Template.GetMissionDifficultyFn = GetMissionDifficultyFromMonth;
	Template.SpawnMissionsFn = SpawnGuerillaOpsMissions;
	Template.MissionPopupFn = GuerillaOpsPopup;
	Template.WasMissionSuccessfulFn = OneStrategyObjectiveCompleted;

	DeckEntry.RewardName = 'Reward_Supplies';
	DeckEntry.Quantity = 3;
	Template.RewardDeck.AddItem(DeckEntry);
	DeckEntry.RewardName = 'Reward_Scientist';
	DeckEntry.Quantity = 3;
	Template.RewardDeck.AddItem(DeckEntry);
	DeckEntry.RewardName = 'Reward_Engineer';
	DeckEntry.Quantity = 3;
	Template.RewardDeck.AddItem(DeckEntry);
	DeckEntry.RewardName = 'Reward_Soldier';
	DeckEntry.Quantity = 1;
	Template.RewardDeck.AddItem(DeckEntry);
	DeckEntry.RewardName = 'Reward_Intel';
	DeckEntry.Quantity = 2;
	Template.RewardDeck.AddItem(DeckEntry);

	return Template;
}

static function X2DataTemplate CreateRetaliationTemplate()
{
	local X2MissionSourceTemplate Template;

	`CREATE_X2TEMPLATE(class'X2MissionSourceTemplate', Template, 'MissionSource_Retaliation');
	Template.bIncreasesForceLevel = false;
	Template.bDisconnectRegionOnFail = true;
	Template.DifficultyValue = 1;
	Template.OnSuccessFn = RetaliationOnSuccess;
	Template.OnFailureFn = RetaliationOnFailure;
	Template.OnExpireFn = RetaliationOnExpire;
	Template.OverworldMeshPath = "UI_3D.Overwold_Final.Retaliation";
	Template.MissionImage = "img:///UILibrary_StrategyImages.X2StrategyMap.Alert_Retaliation";
	Template.GetMissionDifficultyFn = GetMissionDifficultyFromMonth;
	Template.CreateMissionsFn = CreateRetaliationMission;
	Template.SpawnMissionsFn = SpawnRetaliationMission;
	Template.MissionPopupFn = RetaliationPopup;
	Template.WasMissionSuccessfulFn = OneStrategyObjectiveCompleted;

	return Template;
}