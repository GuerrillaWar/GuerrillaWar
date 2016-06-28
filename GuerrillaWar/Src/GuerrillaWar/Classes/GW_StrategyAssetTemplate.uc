class GW_StrategyAssetTemplate extends X2StrategyElementTemplate;

enum StrategyAssetCategory
{
	eStrategyAssetCategory_Static,
	eStrategyAssetCategory_Buildable,
	eStrategyAssetCategory_Mobile,
};

struct StrategyAssetSpeed
{
	var name ID;
	var string FriendlyName;
	var float Velocity;
};

struct StrategyAssetProductionDefinition
{
	var name ItemTemplateName;
	var int CycleQuantity;
	var array<ArtifactCost> CycleCost; // costs tied to this production
	var int CycleHours;

	structdefaultproperties
	{
		CycleHours = 168;
	}
};

struct StrategyAssetStructureDefinition
{
	var name ID;

	// BUILD PARAMS
	var int BuildHours;
	var array<ArtifactCost> BuildCost;
	var StrategyRequirement BuildRequirements;

	// ONGOING PARAMS
	var array<StrategyAssetProductionDefinition> BaseProductionCapability;
	var array<ArtifactCost> UpkeepCost;
	var int UpkeepHours;

	// MISSION PARAM
	var array<name> ParcelObjectiveTags;
	var array<name> PCPObjectiveTags;

	structdefaultproperties
	{
		UpkeepHours = 168;
	}
};

var StrategyAssetCategory AssetCategory;
var eTeam DefaultTeam;
var int BaseInventoryCapacity;
var int BaseUnitCapacity;

var StrategyAssetStructureDefinition CoreStructure; // must be immediately built if this is assetCategory Buildable;
var array<StrategyAssetStructureDefinition> AllowedStructures;
var array<StrategyAssetSpeed> Speeds;
var class<GW_GameState_StrategyAsset> GameStateClass;

var array<name> PlotObjectiveTags;