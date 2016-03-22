class GW_DefaultCharacters extends X2Character_DefaultCharacters;

static function X2CharacterTemplate CreateTemplate_AdvTrooperM1()
{
	local X2CharacterTemplate CharTemplate;
	CharTemplate = Super(X2Character_DefaultCharacters).CreateTemplate_AdvTrooperM1();
	CharTemplate.bCanBeCarried = true;
	return CharTemplate;
}

static function X2CharacterTemplate CreateTemplate_AdvTrooperM2()
{
	local X2CharacterTemplate CharTemplate;
	CharTemplate = Super(X2Character_DefaultCharacters).CreateTemplate_AdvTrooperM2();
	CharTemplate.bCanBeCarried = true;
	return CharTemplate;
}

static function X2CharacterTemplate CreateTemplate_AdvTrooperM3()
{
	local X2CharacterTemplate CharTemplate;
	CharTemplate = Super(X2Character_DefaultCharacters).CreateTemplate_AdvTrooperM3();
	CharTemplate.bCanBeCarried = true;
	return CharTemplate;
}

static function X2CharacterTemplate CreateTemplate_AdvCaptainM1()
{
	local X2CharacterTemplate CharTemplate;
	CharTemplate = Super(X2Character_DefaultCharacters).CreateTemplate_AdvCaptainM1();
	CharTemplate.bCanBeCarried = true;
	return CharTemplate;
}

static function X2CharacterTemplate CreateTemplate_AdvCaptainM2()
{
	local X2CharacterTemplate CharTemplate;
	CharTemplate = Super(X2Character_DefaultCharacters).CreateTemplate_AdvCaptainM2();
	CharTemplate.bCanBeCarried = true;
	return CharTemplate;
}

static function X2CharacterTemplate CreateTemplate_AdvCaptainM3()
{
	local X2CharacterTemplate CharTemplate;
	CharTemplate = Super(X2Character_DefaultCharacters).CreateTemplate_AdvCaptainM3();
	CharTemplate.bCanBeCarried = true;
	return CharTemplate;
}