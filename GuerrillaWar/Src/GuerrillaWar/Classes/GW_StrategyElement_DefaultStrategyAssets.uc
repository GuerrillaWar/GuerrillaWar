class GW_StrategyElement_DefaultStrategyAssets extends X2StrategyElement config(GuerrillaWar);

var name GeneClinicName;
var name RecruitmentCentreName;
var name SupplyCentreName;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> AssetTemplates;

	AssetTemplates.AddItem(CreateCityControlZone());
	AssetTemplates.AddItem(CreateSlumCity());
	AssetTemplates.AddItem(CreateResistanceCamp());
	
	return AssetTemplates;
}

static function AddSupplyCentreStructureDef(GW_StrategyAssetTemplate Template)
{
	local StrategyAssetStructureDefinition StructureDef;
	local StrategyAssetProductionDefinition ProductionDef;
	local ArtifactCost Resources;

	StructureDef.ID = default.SupplyCentreName;

	Resources.ItemTemplateName = 'Supplies';
	Resources.Quantity = 400;
	StructureDef.BuildCost.AddItem(Resources);

	StructureDef.BuildHours = 24 * 7;
	
	ProductionDef.ItemTemplateName = 'Suppplies';
	ProductionDef.CycleQuantity = 100;
	StructureDef.BaseProductionCapability.AddItem(ProductionDef);

	Template.AllowedStructures.AddItem(StructureDef);
}

static function AddGeneClinicStructureDef(GW_StrategyAssetTemplate Template)
{
	local StrategyAssetStructureDefinition StructureDef;
	local StrategyAssetProductionDefinition ProductionDef;
	local ArtifactCost Resources;

	StructureDef.ID = default.GeneClinicName;

	Resources.ItemTemplateName = 'Supplies';
	Resources.Quantity = 400;
	StructureDef.BuildCost.AddItem(Resources);

	StructureDef.BuildHours = 24 * 7;
	
	ProductionDef.ItemTemplateName = 'Suppplies';
	ProductionDef.CycleQuantity = 10;
	StructureDef.BaseProductionCapability.AddItem(ProductionDef);

	Template.AllowedStructures.AddItem(StructureDef);
}

static function X2DataTemplate CreateCityControlZone()
{
	local GW_StrategyAssetTemplate Template;

	`CREATE_X2TEMPLATE(class'GW_StrategyAssetTemplate', Template, 'StrategyAsset_CityControlZone');

	Template.AssetCategory = eStrategyAssetCategory_Static;
	Template.DefaultTeam = eTeam_Alien;
	Template.BaseInventoryCapacity = 2000;
	Template.BaseUnitCapacity = 1000;
	Template.HasCoreStructure = false;
	Template.GameStateClass = class'GW_GameState_CityStrategyAsset';
	Template.StrategyUIClass = class'GW_UIStrategyAsset_CityControlZone';
	Template.PlotTypes.AddItem('CityCenter');
	Template.PlotTypes.AddItem('SmallTown');

	AddSupplyCentreStructureDef(Template);
	AddGeneClinicStructureDef(Template);

	return Template;
}

static function X2DataTemplate CreateSlumCity()
{
	local GW_StrategyAssetTemplate Template;

	`CREATE_X2TEMPLATE(class'GW_StrategyAssetTemplate', Template, 'StrategyAsset_SlumCity');

	Template.AssetCategory = eStrategyAssetCategory_Static;
	Template.DefaultTeam = eTeam_Alien;
	Template.BaseInventoryCapacity = 1000;
	Template.BaseUnitCapacity = 400;
	Template.HasCoreStructure = false;
	Template.GameStateClass = class'GW_GameState_CityStrategyAsset';
	Template.StrategyUIClass = class'GW_UIStrategyAsset_CityControlZone';
	Template.PlotTypes.AddItem('Slums');

	AddSupplyCentreStructureDef(Template);

	return Template;
}


static function X2DataTemplate CreateResistanceCamp()
{
	local GW_StrategyAssetTemplate Template;

	`CREATE_X2TEMPLATE(class'GW_StrategyAssetTemplate', Template, 'StrategyAsset_ResistanceCamp');

	Template.AssetCategory = eStrategyAssetCategory_Buildable;
	Template.DefaultTeam = eTeam_XCom;
	Template.BaseInventoryCapacity = 1000;
	Template.BaseUnitCapacity = 100;
	Template.HasCoreStructure = false;
	Template.GameStateClass = class'GW_GameState_StrategyAsset';
	Template.StrategyUIClass = class'GW_UIStrategyAsset_ResistanceCamp';
	Template.PlotTypes.AddItem('Shanty');

	return Template;
}


defaultproperties
{
	GeneClinicName="GeneClinic"
	RecruitmentCentreName="RecruitmentCentre"
	SupplyCentreName="SupplyCentre"
}
