// This is an Unreal Script

class GW_Archetypes_UpdateCarryAnimSets extends Object
	dependson(XComContentManager, X2CharacterTemplateManager);

static function UpdateCharacterArchetypes()
{
	local X2CharacterTemplateManager Manager;

	Manager = class'X2CharacterTemplateManager'.static.GetCharacterTemplateManager();

	`log("GuerrillaWar :: Updating Character Templates");
	UpdateCharacterForCarrying(Manager.FindCharacterTemplate('AdvCaptainM1'));
	UpdateCharacterForCarrying(Manager.FindCharacterTemplate('AdvCaptainM2'));
	UpdateCharacterForCarrying(Manager.FindCharacterTemplate('AdvCaptainM3'));
	UpdateCharacterForCarrying(Manager.FindCharacterTemplate('AdvTrooperM1'));
	UpdateCharacterForCarrying(Manager.FindCharacterTemplate('AdvTrooperM2'));
	UpdateCharacterForCarrying(Manager.FindCharacterTemplate('AdvTrooperM3'));
	UpdateCharacterForCarrying(Manager.FindCharacterTemplate('Sectoid'));
	UpdateCharacterForCarrying(Manager.FindCharacterTemplate('AdvPsiWitchM2'));
	UpdateCharacterForCarrying(Manager.FindCharacterTemplate('AdvPsiWitchM3'));
	UpdateCharacterForCarrying(Manager.FindCharacterTemplate('AdvShieldBearerM2'));
	UpdateCharacterForCarrying(Manager.FindCharacterTemplate('AdvShieldBearerM3'));
	UpdateCharacterForCarrying(Manager.FindCharacterTemplate('AdvStunLancerM1'));
	UpdateCharacterForCarrying(Manager.FindCharacterTemplate('AdvStunLancerM2'));
	UpdateCharacterForCarrying(Manager.FindCharacterTemplate('AdvStunLancerM3'));

	UpdateCharacterForCarrying(Manager.FindCharacterTemplate('AdvMEC_M1'));
	UpdateCharacterForCarrying(Manager.FindCharacterTemplate('AdvMEC_M2'));
	UpdateCharacterForCarrying(Manager.FindCharacterTemplate('AndromedonRobot'));
	UpdateCharacterForCarrying(Manager.FindCharacterTemplate('Archon'));
	UpdateCharacterForCarrying(Manager.FindCharacterTemplate('Berserker'));
	UpdateCharacterForCarrying(Manager.FindCharacterTemplate('Faceless'));
	UpdateCharacterForCarrying(Manager.FindCharacterTemplate('Muton'));
	UpdateCharacterForCarrying(Manager.FindCharacterTemplate('Viper'));
	UpdateCharacterForCarrying(Manager.FindCharacterTemplate('Gatekeeper'));
}

static function UpdateCharacterForCarrying(X2CharacterTemplate Template)
{
	local string ArchetypeIdentifier;
	local XComAlienPawn APawn;
	local XComContentManager ContentMgr;
	ContentMgr = `CONTENT;

	Template.bCanBeCarried = true;
	class'X2CharacterTemplateManager'.static.GetCharacterTemplateManager().AddCharacterTemplate(Template, true);

	foreach Template.strPawnArchetypes(ArchetypeIdentifier)
	{
		`log("GuerrillaWar :: Adding Carry Animations to" @ ArchetypeIdentifier);
		APawn = XComAlienPawn(ContentMgr.RequestGameArchetype(ArchetypeIdentifier));
		APawn.CarryingUnitAnimSets.AddItem(AnimSet'Soldier_ANIM.Anims.AS_Carry');
		APawn.BeingCarriedAnimSets.AddItem(AnimSet'Soldier_ANIM.Anims.AS_Body');
	}
}