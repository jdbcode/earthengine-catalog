local id = 'FAO/GHG/1/DROSE_A';
local subdir = 'FAO';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.proprietary;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_sci,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'Drained Organic Soils Emissions (Annual)',
  version: '1.0',
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The two related FAO datasets on Drained Organic Soils provide estimates of:

    1. DROSA-A: area of Organic Soils (in hectares) drained for agricultural activities (cropland and grazed grassland)

    2. DROSE-A: carbon (C) and nitrous oxide (N2O) estimates (in gigagrams) from the agricultural drainage of
    organic soils under these land uses.

    Annual data are available at 0.0083333 X 0.0083333 resolution (~1 km at the equator), with global coverage
    for the period 1992 - 2018.

    FAOSTAT estimates follow the Intergovernmental Panel on Climate Change Guidelines
    (IPCC) and use histosols as proxy for the presence of organic soils and annual land cover maps as time-
    dependent component. Additionally, soils characteristics, land use, and climate information are applied
    in the analysis. The carbon emissions can be converted to CO2, multiplying pixel values by the ratio of
    the molecular weight of carbon dioxide (CO2) to that of C (44/12).

    Organic soils develop in wet soil ecosystems. They include tropical and boreal peatlands, high-latitude
    bogs, ferns, and mires. Organic soils cover globally a mere 3 percent of the terrestrial land area but
    represent up to 30 percent of the total soil carbon, thus playing an important role in maintaining the
    earth's carbon balance. Agriculture is a major cause of drainage of organic soils around the world.
    Drainage exposes to aerobic conditions the organic matter of organic soils that oxidizes releasing large
    amounts of harmful greenhouse gases (GHG) to the atmosphere.

    DROSA-A and DROSE-A are the basis for country and regional statistics on drained organic soils
    disseminated in three FAOSTAT datasets (Cultivation of Organic Soils; Cropland; and Grassland).
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id),
  keywords: [
    'agriculture',
    'climate_change',
    'emissions',
    'fao',
    'ghg',
    'organic_soils',
  ],
  providers: [
    ee.producer_provider('FAO UN', 'http://fao.org/economic/ess/environment/data/organic-soils/la/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('1992-01-01T00:00:00Z', null),
  summaries: {
    gsd: [
      927.67,
    ],
    'eo:bands': [
      {
        name: 'croplandc',
        description: 'C emissions from cropland organic soils',
        'gee:units': 'gigagrams',
      },
      {
        name: 'croplandn2o',
        description: 'N2O emissions from cropland organic soils',
        'gee:units': 'gigagrams',
      },
      {
        name: 'grasslandc',
        description: 'C emissions from grassland organic soils',
        'gee:units': 'gigagrams',
      },
      {
        name: 'grasslandn2o',
        description: 'N2O emissions from grassland organic soils',
        'gee:units': 'gigagrams',
      },
    ],
    'gee:visualizations': [
      {
        display_name: 'Cropland C emissions (Annual)',
        lookat: {
          lat: -0.4,
          lon: 108.0,
          zoom: 6,
        },
        image_visualization: {
          global_vis: {
            min: [
              0.1,
            ],
            max: [
              0.1,
            ],
            palette: [
              'yellow',
              'red',
            ],
            bands: [
              'croplandc',
            ],
          },
        },
      },
    ],
  },
  'sci:citation': |||
    [FAO 2020. Drained organic soils 1990 - 2019. Global, regional and country trends.
    FAOSTAT Analytical Brief Series No 4, FAO, Rome.](http://www.fao.org/3/cb0489en/cb0489en.pdf)
  |||,
  'sci:publications': [
    {
      citation: |||
        Conchedda, G. and Tubiello, F. N.: Drainage of organic soils and GHG emissions:
        Validation with country data, Earth Syst. Sci. Data Discuss.
        [10.5194/essd-12-3113-2020](https://doi.org/10.5194/essd-12-3113-2020), 2020
      |||,
      doi: '10.5194/essd-12-3113-2020',
    },
  ],
  'gee:interval': {
    type: 'cadence',
    unit: 'year',
    interval: 1,
  },
  'gee:terms_of_use': |||
    The Food and Agriculture Organization of the United Nations (FAO) is mandated to collect, analyze,
    interpret, and disseminate information related to nutrition, food, and agriculture. In this regard,
    it publishes a number of databases on topics related to FAO's mandate, and encourages the use of
    them for scientific and research purposes. Consistent with the principles of openness and sharing
    envisioned under the Open Data Licensing For Statistical Databases, and consistent with the mandate
    of FAO, data on GHG emissions from agriculture activities on organic soils as part of FAOSTAT
    - FAO's database on Food and Agriculture data, is available free to the user community.
  |||,
  'gee:user_uploaded': true,
}
