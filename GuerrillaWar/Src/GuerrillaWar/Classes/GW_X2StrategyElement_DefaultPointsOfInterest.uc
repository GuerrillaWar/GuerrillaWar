class GW_X2StrategyElement_DefaultPointsOfInterest extends X2StrategyElement
	dependson(X2PointOfInterestTemplate);

static function array<X2DataTemplate> CreateTemplates()
{
	local array <X2DataTemplate> Templates;

	Templates.AddItem(CreateGWPOISupplyLineRaidTemplate());

	return Templates;
}

static function X2DataTemplate CreateGWPOISupplyLineRaidTemplate()
{
	local X2PointOfInterestTemplate Template;
	`CREATE_X2POINTOFINTEREST_TEMPLATE(Template, 'GW_POI_SupplyLineRaid');
	Template.CanAppearFn = CanGOpsAppear;

	return Template;
}

function bool CanGOpsAppear(XComGameState_PointOfInterest POIState)
{
	return (class'UIUtilities_Strategy'.static.GetAlienHQ().ChosenDarkEvents.Length > 0);
}