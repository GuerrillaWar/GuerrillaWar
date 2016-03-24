class GW_DefaultCharacters extends X2Character_DefaultCharacters;

static function X2CharacterTemplate CreateTemplate_AdvTrooperM1()
{
	local X2CharacterTemplate CharTemplate;
	CharTemplate = Super(X2Character_DefaultCharacters).CreateTemplate_AdvTrooperM1();
	CharTemplate.strPawnArchetypes.Remove(0, CharTemplate.strPawnArchetypes.Length);
	CharTemplate.strPawnArchetypes.AddItem("GW_GameUnits.GW_GameUnit_AdvTrooperM1_M");
	CharTemplate.strPawnArchetypes.AddItem("GW_GameUnits.GW_GameUnit_AdvTrooperM1_F");
	CharTemplate.bCanBeCarried = true;
	return CharTemplate;
}

static function X2CharacterTemplate CreateTemplate_AdvTrooperM2()
{
	local X2CharacterTemplate CharTemplate;
	CharTemplate = Super(X2Character_DefaultCharacters).CreateTemplate_AdvTrooperM2();
	CharTemplate.strPawnArchetypes.Remove(0, CharTemplate.strPawnArchetypes.Length);
	CharTemplate.strPawnArchetypes.AddItem("GW_GameUnits.GW_GameUnit_AdvTrooperM2_M");
	CharTemplate.strPawnArchetypes.AddItem("GW_GameUnits.GW_GameUnit_AdvTrooperM2_F");
	CharTemplate.bCanBeCarried = true;
	return CharTemplate;
}

static function X2CharacterTemplate CreateTemplate_AdvTrooperM3()
{
	local X2CharacterTemplate CharTemplate;
	CharTemplate = Super(X2Character_DefaultCharacters).CreateTemplate_AdvTrooperM3();
	CharTemplate.strPawnArchetypes.Remove(0, CharTemplate.strPawnArchetypes.Length);
	CharTemplate.strPawnArchetypes.AddItem("GW_GameUnits.GW_GameUnit_AdvTrooperM3_M");
	CharTemplate.strPawnArchetypes.AddItem("GW_GameUnits.GW_GameUnit_AdvTrooperM3_F");
	CharTemplate.bCanBeCarried = true;
	return CharTemplate;
}

static function X2CharacterTemplate CreateTemplate_AdvCaptainM1()
{
	local X2CharacterTemplate CharTemplate;
	CharTemplate = Super(X2Character_DefaultCharacters).CreateTemplate_AdvCaptainM1();
	CharTemplate.strPawnArchetypes.Remove(0, CharTemplate.strPawnArchetypes.Length);
	CharTemplate.strPawnArchetypes.AddItem("GW_GameUnits.GW_GameUnit_AdvCaptainM1_M");
	CharTemplate.strPawnArchetypes.AddItem("GW_GameUnits.GW_GameUnit_AdvCaptainM1_F");
	CharTemplate.bCanBeCarried = true;
	return CharTemplate;
}

static function X2CharacterTemplate CreateTemplate_AdvCaptainM2()
{
	local X2CharacterTemplate CharTemplate;
	CharTemplate = Super(X2Character_DefaultCharacters).CreateTemplate_AdvCaptainM2();
	CharTemplate.strPawnArchetypes.Remove(0, CharTemplate.strPawnArchetypes.Length);
	CharTemplate.strPawnArchetypes.AddItem("GW_GameUnits.GW_GameUnit_AdvCaptainM2_M");
	CharTemplate.strPawnArchetypes.AddItem("GW_GameUnits.GW_GameUnit_AdvCaptainM2_F");
	CharTemplate.bCanBeCarried = true;
	return CharTemplate;
}

static function X2CharacterTemplate CreateTemplate_AdvCaptainM3()
{
	local X2CharacterTemplate CharTemplate;
	CharTemplate = Super(X2Character_DefaultCharacters).CreateTemplate_AdvCaptainM3();
	CharTemplate.strPawnArchetypes.Remove(0, CharTemplate.strPawnArchetypes.Length);
	CharTemplate.strPawnArchetypes.AddItem("GW_GameUnits.GW_GameUnit_AdvCaptainM3_M");
	CharTemplate.strPawnArchetypes.AddItem("GW_GameUnits.GW_GameUnit_AdvCaptainM3_F");
	CharTemplate.bCanBeCarried = true;
	return CharTemplate;
}

static function X2CharacterTemplate CreateTemplate_Sectoid()
{
	local X2CharacterTemplate CharTemplate;
	CharTemplate = Super(X2Character_DefaultCharacters).CreateTemplate_Sectoid();
	CharTemplate.strPawnArchetypes.Remove(0, CharTemplate.strPawnArchetypes.Length);
	CharTemplate.strPawnArchetypes.AddItem("GW_GameUnits.GW_GameUnit_Sectoid");
	CharTemplate.bCanBeCarried = true;
	return CharTemplate;
}