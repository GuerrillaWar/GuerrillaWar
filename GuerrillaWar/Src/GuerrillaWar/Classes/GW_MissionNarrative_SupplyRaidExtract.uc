// This is an Unreal Script

class GW_MissionNarrative_SupplyRaidExtract extends X2MissionNarrative;

static function array<X2DataTemplate> CreateTemplates()
{
    local array<X2MissionNarrativeTemplate> Templates;

    Templates.AddItem(AddDefaultSupplyRaidExtractATTMissionNarrativeTemplate());
	Templates.AddItem(AddDefaultSabotageMissionNarrativeTemplate());

    return Templates;
}



static function X2MissionNarrativeTemplate AddDefaultSupplyRaidExtractATTMissionNarrativeTemplate()
{
    local X2MissionNarrativeTemplate Template;

    `CREATE_X2MISSIONNARRATIVE_TEMPLATE(Template, 'DefaultSupplyRaidExtractATT');

    Template.MissionType = "SupplyRaidExtractATT";
    Template.NarrativeMoments[0]="X2NarrativeMoments.TACTICAL.SupplyRaid.SupplyRaid_TacIntroATT";
    Template.NarrativeMoments[1]="X2NarrativeMoments.TACTICAL.SupplyRaid.SupplyRaid_ManyCratesDestroyed";
    Template.NarrativeMoments[2]="X2NarrativeMoments.TACTICAL.SupplyRaid.SupplyRaid_FirstCrateDestroyed";
    Template.NarrativeMoments[3]="X2NarrativeMoments.TACTICAL.support.T_Support_Alien_Tech_Crate_Spotted_Central";
    Template.NarrativeMoments[4]="X2NarrativeMoments.TACTICAL.General.CEN_Gen_BurnoutSecured_02";
    Template.NarrativeMoments[5]="X2NarrativeMoments.TACTICAL.SupplyRaid.SupplyRaid_AllCratesDestroyed";
    Template.NarrativeMoments[6]="X2NarrativeMoments.TACTICAL.General.GenTactical_SecureRetreat";
    Template.NarrativeMoments[7]="X2NarrativeMoments.TACTICAL.General.GenTactical_ConsiderRetreat";
    Template.NarrativeMoments[8]="X2NarrativeMoments.TACTICAL.General.GenTactical_PartialEVAC";
    Template.NarrativeMoments[9]="X2NarrativeMoments.TACTICAL.General.GenTactical_FullEVAC";
    Template.NarrativeMoments[10]="X2NarrativeMoments.TACTICAL.General.GenTactical_SquadWipe";
    Template.NarrativeMoments[11]="X2NarrativeMoments.TACTICAL.General.GenTactical_MissionExtroFailure";
    Template.NarrativeMoments[12]="X2NarrativeMoments.TACTICAL.General.GenTactical_MissionExtroPartialSuccess";
    Template.NarrativeMoments[13]="X2NarrativeMoments.TACTICAL.General.GenTactical_MissionExtroTotalSuccess";
    Template.NarrativeMoments[14]="X2NarrativeMoments.TACTICAL.General.GenTactical_TacWinOnly";
    Template.NarrativeMoments[15]="X2NarrativeMoments.TACTICAL.General.GenTactical_SquadWipe";

    return Template;
}


static function X2MissionNarrativeTemplate AddDefaultSabotageMissionNarrativeTemplate()
{
    local X2MissionNarrativeTemplate Template;

    `CREATE_X2MISSIONNARRATIVE_TEMPLATE(Template, 'DefaultSabotageGC');

	Template.MissionType = "SabotageGC";
    Template.NarrativeMoments[0]="X2NarrativeMoments.TACTICAL.SabotageCC.SabotageCC_BombDetonated";
    Template.NarrativeMoments[1]="X2NarrativeMoments.TACTICAL.SabotageCC.SabotageCC_HeavyLossesIncurred";
    Template.NarrativeMoments[2]="X2NarrativeMoments.TACTICAL.SabotageCC.SabotageCC_TacIntro";
    Template.NarrativeMoments[3]="X2NarrativeMoments.TACTICAL.SabotageCC.SabotageCC_BombSpotted";
    Template.NarrativeMoments[4]="X2NarrativeMoments.TACTICAL.General.GenTactical_SquadWipe";
    Template.NarrativeMoments[5]="X2NarrativeMoments.TACTICAL.SabotageCC.SabotageCC_CompletionNag";
    Template.NarrativeMoments[6]="X2NarrativeMoments.TACTICAL.SabotageCC.SabotageCC_AllEnemiesDefeated";
    Template.NarrativeMoments[7]="X2NarrativeMoments.TACTICAL.SabotageCC.SabotageCC_AreaSecuredMissionEnd";
    Template.NarrativeMoments[8]="X2NarrativeMoments.TACTICAL.SabotageCC.SabotageCC_BombPlantedEnd";
    Template.NarrativeMoments[9]="X2NarrativeMoments.TACTICAL.SabotageCC.SabotageCC_BombPlantedContinue";

    return Template;
}
