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

static function X2CharacterTemplate CreateTemplate_AdvPsiWitchM2()
{
	local X2CharacterTemplate CharTemplate;
	CharTemplate = Super(X2Character_DefaultCharacters).CreateTemplate_AdvPsiWitchM2();
	CharTemplate.strPawnArchetypes.Remove(0, CharTemplate.strPawnArchetypes.Length);
	CharTemplate.strPawnArchetypes.AddItem("GW_GameUnits.GW_GameUnit_AdvPsiWitchM2_M");
	CharTemplate.strPawnArchetypes.AddItem("GW_GameUnits.GW_GameUnit_AdvPsiWitchM2_F");
	CharTemplate.bCanBeCarried = true;
	return CharTemplate;
}

static function X2CharacterTemplate CreateTemplate_AdvPsiWitchM3()
{
	local X2CharacterTemplate CharTemplate;
	CharTemplate = Super(X2Character_DefaultCharacters).CreateTemplate_AdvPsiWitchM3();
	CharTemplate.strPawnArchetypes.Remove(0, CharTemplate.strPawnArchetypes.Length);
	CharTemplate.strPawnArchetypes.AddItem("GW_GameUnits.GW_GameUnit_AdvPsiWitchM3_M");
	CharTemplate.strPawnArchetypes.AddItem("GW_GameUnits.GW_GameUnit_AdvPsiWitchM3_F");
	CharTemplate.bCanBeCarried = true;
	return CharTemplate;
}

static function X2CharacterTemplate CreateTemplate_AdvShieldBearerM2()
{
	local X2CharacterTemplate CharTemplate;
	CharTemplate = Super(X2Character_DefaultCharacters).CreateTemplate_AdvShieldBearerM2();
	CharTemplate.strPawnArchetypes.Remove(0, CharTemplate.strPawnArchetypes.Length);
	CharTemplate.strPawnArchetypes.AddItem("GW_GameUnits.GW_GameUnit_AdvShieldBearerM2_M");
	CharTemplate.strPawnArchetypes.AddItem("GW_GameUnits.GW_GameUnit_AdvShieldBearerM2_F");
	CharTemplate.bCanBeCarried = true;
	return CharTemplate;
}

static function X2CharacterTemplate CreateTemplate_AdvShieldBearerM3()
{
	local X2CharacterTemplate CharTemplate;
	CharTemplate = Super(X2Character_DefaultCharacters).CreateTemplate_AdvShieldBearerM3();
	CharTemplate.strPawnArchetypes.Remove(0, CharTemplate.strPawnArchetypes.Length);
	CharTemplate.strPawnArchetypes.AddItem("GW_GameUnits.GW_GameUnit_AdvShieldBearerM3_M");
	CharTemplate.strPawnArchetypes.AddItem("GW_GameUnits.GW_GameUnit_AdvShieldBearerM3_F");
	CharTemplate.bCanBeCarried = true;
	return CharTemplate;
}

static function X2CharacterTemplate CreateTemplate_AdvStunLancerM1()
{
	local X2CharacterTemplate CharTemplate;
	CharTemplate = Super(X2Character_DefaultCharacters).CreateTemplate_AdvStunLancerM1();
	CharTemplate.strPawnArchetypes.Remove(0, CharTemplate.strPawnArchetypes.Length);
	CharTemplate.strPawnArchetypes.AddItem("GW_GameUnits.GW_GameUnit_AdvStunLancerM1_M");
	CharTemplate.strPawnArchetypes.AddItem("GW_GameUnits.GW_GameUnit_AdvStunLancerM1_F");
	CharTemplate.bCanBeCarried = true;
	return CharTemplate;
}

static function X2CharacterTemplate CreateTemplate_AdvStunLancerM2()
{
	local X2CharacterTemplate CharTemplate;
	CharTemplate = Super(X2Character_DefaultCharacters).CreateTemplate_AdvStunLancerM2();
	CharTemplate.strPawnArchetypes.Remove(0, CharTemplate.strPawnArchetypes.Length);
	CharTemplate.strPawnArchetypes.AddItem("GW_GameUnits.GW_GameUnit_AdvStunLancerM2_M");
	CharTemplate.strPawnArchetypes.AddItem("GW_GameUnits.GW_GameUnit_AdvStunLancerM2_F");
	CharTemplate.bCanBeCarried = true;
	return CharTemplate;
}

static function X2CharacterTemplate CreateTemplate_AdvStunLancerM3()
{
	local X2CharacterTemplate CharTemplate;
	CharTemplate = Super(X2Character_DefaultCharacters).CreateTemplate_AdvStunLancerM3();
	CharTemplate.strPawnArchetypes.Remove(0, CharTemplate.strPawnArchetypes.Length);
	CharTemplate.strPawnArchetypes.AddItem("GW_GameUnits.GW_GameUnit_AdvStunLancerM3_M");
	CharTemplate.strPawnArchetypes.AddItem("GW_GameUnits.GW_GameUnit_AdvStunLancerM3_F");
	CharTemplate.bCanBeCarried = true;
	return CharTemplate;
}

// Many of the carries below make very little physical sense, but are set
// to can be carried because they're close enough to human animation to make
// use of the AS_Body animation set. Deformation may occur.

static function X2CharacterTemplate CreateTemplate_AdvMEC_M1()
{
	local X2CharacterTemplate CharTemplate;
	CharTemplate = Super(X2Character_DefaultCharacters).CreateTemplate_AdvMEC_M1();
	CharTemplate.strPawnArchetypes.Remove(0, CharTemplate.strPawnArchetypes.Length);
	CharTemplate.strPawnArchetypes.AddItem("GW_GameUnits.GW_GameUnit_AdvMEC_M3");
	CharTemplate.bCanBeCarried = true;
	return CharTemplate;
}

static function X2CharacterTemplate CreateTemplate_AdvMEC_M2()
{
	local X2CharacterTemplate CharTemplate;
	CharTemplate = Super(X2Character_DefaultCharacters).CreateTemplate_AdvMEC_M2();
	CharTemplate.strPawnArchetypes.Remove(0, CharTemplate.strPawnArchetypes.Length);
	CharTemplate.strPawnArchetypes.AddItem("GW_GameUnits.GW_GameUnit_AdvMEC_M2");
	CharTemplate.bCanBeCarried = true;
	return CharTemplate;
}


static function X2CharacterTemplate CreateTemplate_AndromedonRobot()
{
	local X2CharacterTemplate CharTemplate;
	CharTemplate = Super(X2Character_DefaultCharacters).CreateTemplate_AndromedonRobot();
	CharTemplate.strPawnArchetypes.Remove(0, CharTemplate.strPawnArchetypes.Length);
	CharTemplate.strPawnArchetypes.AddItem("GW_GameUnits.GW_GameUnit_Andromedon_Robot_Suit");
	CharTemplate.bCanBeCarried = true;
	return CharTemplate;
}

static function X2CharacterTemplate CreateTemplate_Archon()
{
	local X2CharacterTemplate CharTemplate;
	CharTemplate = Super(X2Character_DefaultCharacters).CreateTemplate_Archon();
	CharTemplate.strPawnArchetypes.Remove(0, CharTemplate.strPawnArchetypes.Length);
	CharTemplate.strPawnArchetypes.AddItem("GW_GameUnits.GW_GameUnit_Archon");
	CharTemplate.bCanBeCarried = true;
	return CharTemplate;
}

static function X2CharacterTemplate CreateTemplate_Berserker()
{
	local X2CharacterTemplate CharTemplate;
	CharTemplate = Super(X2Character_DefaultCharacters).CreateTemplate_Berserker();
	CharTemplate.strPawnArchetypes.Remove(0, CharTemplate.strPawnArchetypes.Length);
	CharTemplate.strPawnArchetypes.AddItem("GW_GameUnits.GW_GameUnit_Berserker");
	CharTemplate.bCanBeCarried = true;
	return CharTemplate;
}

static function X2CharacterTemplate CreateTemplate_Faceless()
{
	local X2CharacterTemplate CharTemplate;
	CharTemplate = Super(X2Character_DefaultCharacters).CreateTemplate_Faceless();
	CharTemplate.strPawnArchetypes.Remove(0, CharTemplate.strPawnArchetypes.Length);
	CharTemplate.strPawnArchetypes.AddItem("GW_GameUnits.GW_GameUnit_Faceless");
	CharTemplate.bCanBeCarried = true;
	return CharTemplate;
}

static function X2CharacterTemplate CreateTemplate_Muton()
{
	local X2CharacterTemplate CharTemplate;
	CharTemplate = Super(X2Character_DefaultCharacters).CreateTemplate_Muton();
	CharTemplate.strPawnArchetypes.Remove(0, CharTemplate.strPawnArchetypes.Length);
	CharTemplate.strPawnArchetypes.AddItem("GW_GameUnits.GW_GameUnit_Muton");
	CharTemplate.bCanBeCarried = true;
	return CharTemplate;
}

static function X2CharacterTemplate CreateTemplate_Viper()
{
	local X2CharacterTemplate CharTemplate;
	CharTemplate = Super(X2Character_DefaultCharacters).CreateTemplate_Viper();
	CharTemplate.strPawnArchetypes.Remove(0, CharTemplate.strPawnArchetypes.Length);
	CharTemplate.strPawnArchetypes.AddItem("GW_GameUnits.GW_GameUnit_Viper");
	CharTemplate.bCanBeCarried = true;
	return CharTemplate;
}


//Codex(Cyberus) does not require it (brain collected)
//Chrysallid cannot map to Body anim set
//Gatekeeper cannot map to Body anim set
//Sectopod cannot map to Body anim set
//PrototypeSectopod cannot map to Body anim set
//PsiZombie cannot map to Body anim set
//PsiZombieHuman cannot map to Body anim set