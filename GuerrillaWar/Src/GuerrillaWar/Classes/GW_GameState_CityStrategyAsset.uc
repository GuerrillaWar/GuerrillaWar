class GW_GameState_CityStrategyAsset extends GW_GameState_StrategyAsset;

var() protected name                                    m_CityTemplateName;
var() protected{mutable} transient X2CityTemplate		m_CityTemplate;

function LoadCityTemplate(X2CityTemplate Template)
{
	Location = Template.Location;
	m_CityTemplateName = Template.DataName;
	m_CityTemplate = Template;
}

function StaticMesh GetStaticMesh()
{
	if (m_TemplateName == 'StrategyAsset_CityControlZone')
	{
		return StaticMesh(`CONTENT.RequestGameArchetype("UI_3D.Overworld.Council_Icon"));
	}
	else
	{
		return StaticMesh(`CONTENT.RequestGameArchetype("UI_3D.Overworld.CityLights"));
	}
}

function X2CityTemplate GetCityTemplate()
{
	if (m_CityTemplate == none)
	{
		m_CityTemplate = X2CityTemplate(GetMyTemplateManager().FindStrategyElementTemplate(m_CityTemplateName));
	}
	return m_CityTemplate;
}

function String GetCityDisplayName()
{
	return GetCityTemplate().DisplayName;
}
