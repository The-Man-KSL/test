resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'
this_is_a_map 'yes'

fx_version 'adamant'

game 'gta5'

client_script "mapzoom.lua"

description 'crm-mlos'

data_file "SCALEFORM_DLC_FILE" "stream/cayoperico/int3232302352.gfx"
data_file 'INTERIOR_PROXY_ORDER_FILE' 'interiorproxies.meta'
data_file 'TIMECYCLEMOD_FILE' 'timecycles/ocean_h_timecycle.xml'
data_file 'SCALEFORM_DLC_FILE' 'stream/minimap/int164437691.gfx'
data_file 'SCALEFORM_DLC_FILE' 'stream/minimap/int1855188787.gfx'
data_file 'SCALEFORM_DLC_FILE' 'stream/minimap/int1975778630.gfx'
data_file 'SCALEFORM_DLC_FILE' 'stream/minimap/int2439777779.gfx'
data_file 'SCALEFORM_DLC_FILE' 'stream/minimap/int2574468285.gfx'
data_file 'SCALEFORM_DLC_FILE' 'stream/minimap/int3680022772.gfx'
data_file 'DLC_ITYP_REQUEST' 'stream/foodprops/bzzz_foodpack_cookies.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/foodprops/bzzz_drinkpack_can.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/pacificbank/k4mb1_ornate_bank.ytyp'
data_file 'TIMECYCLEMOD_FILE' 'gabz_mrpd_timecycle.xml'
data_file 'TIMECYCLEMOD_FILE' 'casino_timecyc.xml'
data_file 'DLC_ITYP_REQUEST' 'stream/rockford/biker_doorab.ytyp'

files {
  "stream/cayoperico/int3232302352.gfx",
  'gta5.meta',
  'doortuning.ymt',
  'gabz_mrpd_timecycle.xml',
	'interiorproxies.meta',
  'casino_timecyc.xml',
  'stream/pacificbank/k4mb1_ornate_bank.ytyp'
}

client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    "gabz_mrpd_entitysets.lua",
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    'cl_CinemaChairs.lua',
    '@PolyZone/ComboZone.lua',
	'uj_cayoLoader.lua',
  'timecycles/ocean_h_timecycle.xml',
	'interiorproxies.meta'
}

--props
file 'stream/casino/casino_props.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/casino/casino_props.ytyp'

--TableProps
file 'stream/casino/vw_prop_vw_tables.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/casino/vw_prop_vw_tables.ytyp'

--ChipsProps
file 'stream/casino/vw_prop_vw_casinochips.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/casino/vw_prop_vw_casinochips.ytyp'

--CasinoProps
file 'stream/casino/vw_prop_vw_casino.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/casino/vw_prop_vw_casino.ytyp'

--CabinetProps
file 'stream/casino/vw_prop_vw_cabinets.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/casino/vw_prop_vw_cabinets.ytyp'

--Art5Props
file 'stream/casino/vw_prop_vw_casino_art_05.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/casino/vw_prop_vw_casino_art_05.ytyp'

--Art4Props
file 'stream/casino/vw_prop_vw_casino_art_04.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/casino/vw_prop_vw_casino_art_04.ytyp'

--Art3Props
file 'stream/casino/vw_prop_vw_casino_art_03.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/casino/vw_prop_vw_casino_art_03.ytyp'

--Art2Props
file 'stream/casino/vw_prop_vw_casino_art_02.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/casino/vw_prop_vw_casino_art_02.ytyp'

--Art1Props
file 'stream/casino/vw_prop_vw_casino_art_01.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/casino/vw_prop_vw_casino_art_01.ytyp'

--AccsProps
file 'stream/casino/vw_prop_vw_accs.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/casino/vw_prop_vw_accs.ytyp'

--Accs_01Probs
file 'stream/casino/vw_prop_vw_accs_01.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/casino/vw_prop_vw_accs_01.ytyp'