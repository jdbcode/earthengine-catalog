local id = 'LANDSAT/LT05/C01/T1_TOA';
local latest_id = 'LANDSAT/LT05/C02/T1_TOA';
local successor_id = 'LANDSAT/LT05/C02/T1_TOA';
local subdir = 'LANDSAT';

local ee_const = import 'earthengine_const.libsonnet';
local ee = import 'earthengine.libsonnet';
local landsat = import 'LANDSAT/landsat.libsonnet';
local spdx = import 'spdx.libsonnet';

local license = spdx.pddl_1_0;
local template = import 'templates/LT05_C01.libsonnet';

local basename = std.strReplace(id, '/', '_');
local base_filename = basename + '.json';
local latest_filename = basename + '.json';
local successor_basename = std.strReplace(successor_id, '/',  '_');
local successor_filename = successor_basename + '.json';
local self_ee_catalog_url = ee_const.ee_catalog_url + basename;
local catalog_subdir_url = ee_const.catalog_base + subdir + '/';
local latest_url = catalog_subdir_url + latest_filename;
local successor_url = catalog_subdir_url + successor_filename;

{
  stac_version: ee_const.stac_version,
  type: ee_const.stac_type.collection,
  stac_extensions: [
    ee_const.ext_eo,
  ],
  id: id,
  title: 'USGS Landsat 5 TM Collection 1 Tier 1 TOA Reflectance [deprecated]',
  deprecated: true,
  'gee:type': ee_const.gee_type.image_collection,
  description: |||
    Landsat 5 TM Collection 1 Tier 1 calibrated top-of-atmosphere (TOA) reflectance.
  ||| + landsat.toa,
  license: license.id,
  links: ee.standardLinks(subdir, id) + [
    ee.link.latest(latest_id, latest_url),
    ee.link.successor(
      successor_id, catalog_subdir_url + successor_basename + '.json'),
  ],
  keywords: [
    'global',
    'landsat',
    'toa',
    'usgs',
  ],
  providers: [
    ee.producer_provider('USGS/Google', 'https://landsat.usgs.gov/'),
    ee.host_provider(self_ee_catalog_url),
  ],
  extent: ee.extent_global('1984-03-16T16:20:00Z', '2012-05-05T17:54:06Z'),
  summaries: template.summaries,
  'gee:interval': {
    type: 'revisit_interval',
    unit: 'day',
    interval: 16,
  },
  'gee:terms_of_use': importstr 'terms_of_use.md',
}
