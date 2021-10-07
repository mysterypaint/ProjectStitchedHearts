/// @description Delete the depth grid, if it exists
if (ds_exists(ds_depthgrid, ds_type_grid))
	ds_grid_destroy(ds_depthgrid);