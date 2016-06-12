
class GW_GameState_StrategyAsset extends XComGameState_GeoscapeEntity;



//---------------------------------------------------------------------------------------
//----------- XComGameState_GeoscapeEntity Implementation -------------------------------
//---------------------------------------------------------------------------------------

protected function bool CanInteract()
{
	return true;
}

//---------------------------------------------------------------------------------------
function bool AboutToExpire()
{
	return false;
}

function class<UIStrategyMapItem> GetUIClass()
{
	return class'UIStrategyMapItem_Mission';
}

function string GetUIWidgetFlashLibraryName()
{
	return string(class'UIPanel'.default.LibID);
}

function string GetUIPinImagePath()
{
	return "";
}

// The static mesh for this entities 3D UI
function StaticMesh GetStaticMesh()
{
	return StaticMesh(`CONTENT.RequestGameArchetype("UI_3D.Overwold_Final.Council_VIP"));
}

// Scale adjustment for the 3D UI static mesh
function vector GetMeshScale()
{
	local vector ScaleVector;

	ScaleVector.X = 0.8;
	ScaleVector.Y = 0.8;
	ScaleVector.Z = 0.8;

	return ScaleVector;
}

function Rotator GetMeshRotator()
{
	local Rotator MeshRotation;

	MeshRotation.Roll = 0;
	MeshRotation.Pitch = 0;
	MeshRotation.Yaw = 0;

	return MeshRotation;
}

function bool ShouldBeVisible()
{
	return true;
}

//function bool ShowFadedPin()
//{
//	return (bNotAtThreshold || bBuilding);
//}

function bool RequiresSquad()
{
	return true;
}


function UpdateGameBoard()
{
}



function RemoveEntity(XComGameState NewGameState)
{
	`assert(false);
}

function string GetUIButtonIcon()
{
	return "img:///UILibrary_StrategyImages.X2StrategyMap.MissionIcon_Advent";
}
