class GW_XComGameState_PointOfInterest extends XComGameState_PointOfInterest;

static function SetUpPOIs(XComGameState StartState)
{
	local array<X2StrategyElementTemplate> POITemplates;
	local XComGameState_PointOfInterest POIState;
	local int idx;

	// Grab all DarkEvent Templates
	POITemplates = GetMyTemplateManager().GetAllTemplatesOfClass(class'X2PointOfInterestTemplate');
	`log("*********************************Initialized templates**************************************");
	// Iterate through the templates and build each POI State Object
	for (idx = 0; idx < POITemplates.Length; idx++)
	{
		`log("Templates name :" $ POITemplates[idx].DataName);
		POIState = X2PointOfInterestTemplate(POITemplates[idx]).CreateInstanceFromTemplate(StartState);
		StartState.AddStateObject(POIState);
	}
}