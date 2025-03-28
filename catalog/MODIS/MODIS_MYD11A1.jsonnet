local id = 'MODIS/MYD11A1';
local successor_id = 'MODIS/006/MYD11A1';
local subdir = 'MODIS';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.proprietary;

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local successor_basename = std.strReplace(successor_id, '/', '_');
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;
local catalog_subdir_url = ee_const.catalog_base + subdir + '/';

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
    ee_const.ext_ver,
  ],
  id: id,
  title: 'MYD11A1.005 Land Surface Temperature and Emissivity Daily Global 1 km Grid SIN [deprecated]',
  deprecated: true,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    The MODIS/Aqua Land Surface Temperature and
    Emissivity (LST/E) product, MYD11A1, provides per-pixel temperature and
    emissivity values, which are produced daily using the generalized split-window
    LST algorithm.  This algorithm is optimally used to separate ranges of
    atmospheric column water vapor and lower boundary air surface temperatures into
    tractable sub-ranges. The surface emissivities in bands 31 and 32 are estimated
    from land cover types.

    The V5 MYD11A1 products are projected in a Sinusoidal grid by mapping the
    level-2 LST product (MYD11_L2) on 1-kilometer (precisely 0.928-km) grids. The
    MYD11A1 product comprises the following Science Data Set (SDS) layers for
    daytime and nighttime observations: LSTs, quality control assessments,
    observation times, view zenith angles, clear sky coverages, and bands 31 and 32
    emissivities from land cover types.

    The V5 Aqua/MODIS LST/E products, including MYD11A1, are validated to
    Stage-2 through field campaigns and radiance-based validation studies.

    Please visit [LP DAAC 'Citing Our Data' page](https://lpdaac.usgs.gov/citing_our_data) for information on citing LP DAAC datasets.
  |||,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.successor(
        successor_id, catalog_subdir_url + successor_basename + '.json'),
  ],
  keywords: [
    'aqua',
    'daily',
    'emissivity',
    'global',
    'lst',
    'modis',
    'myd11a1',
    'surface_temperature',
  ],
  providers: [
    ee.producer_provider('NASA LP DAAC at the USGS EROS Center', 'https://lpdaac.usgs.gov/dataset_discovery/modis/modis_products_table/myd11a1'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('2002-07-08T00:00:00Z', '2017-03-30T00:00:00Z'),
  summaries: {
    'gee:visualizations': [
      {
        display_name: 'Surface Temperature',
        filter: {
          filter_name: 'DATE_RANGE',
          time_start: '2018-04-01',
          time_end: '2018-06-01',
        },
        lookat: {
          lon: 0,
          lat: 0,
          zoom: 0,
        },
        image_visualization: {
          band_vis: {
            gain: [
              0.1,
            ],
            bias: [
              -1400.0,
            ],
            bands: [
              'LST_Day_1km',
            ],
          },
        },
      },
    ],
  },
  'gee:interval': {
    type: 'cadence',
    unit: 'day',
    interval: 1,
  },
  'gee:terms_of_use': |||
    MODIS data and products acquired through the LP DAAC have no restrictions on subsequent use, sale, or redistribution.
  |||,
  version: 'Unknown',
}
