class GW_Ability_SupplyCrate extends X2Ability;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;

	Templates.AddItem(CreateBeUselessAbility());

	return Templates;
}

static function X2DataTemplate CreateBeUselessAbility()
{
	local X2AbilityTemplate Template;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'GW_AlwaysUnconcious');

	Template.IconImage = "img:///UILibrary_PerkIcons.UIPerk_muton_bayonet"; //Could be anything
	
	Template.AbilitySourceName = 'eAbilitySource_Item';
	Template.eAbilityIconBehaviorHUD = EAbilityIconBehavior_NeverShow;
	Template.Hostility = eHostility_Neutral;
	Template.bDisplayInUITacticalText = false;

	Template.AbilityToHitCalc = default.DeadEye;
	Template.AbilityTargetStyle = default.SelfTarget;
	Template.AbilityTriggers.AddItem(default.UnitPostBeginPlayTrigger);

	Template.AddTargetEffect(class'X2StatusEffects'.static.CreateUnconsciousStatusEffect());

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;

	return Template;
}