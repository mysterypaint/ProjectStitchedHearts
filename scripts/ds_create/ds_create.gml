/// @description gdi data structures
function ds_create() {
	var _id = argument[0];
	var _type = argument[1];
	var _actual_local = variable_instance_get(self, argument[0]);
	switch(_type) {
		case DS.MAP:
			if (variable_instance_exists(self, _id)) {
				if (ds_exists(_actual_local, ds_type_map))
					ds_map_destroy(_actual_local);
			}
			return ds_map_create();
			break;
		case DS.LIST:
			if (variable_instance_exists(self, _id)) {
				if (ds_exists(_actual_local, ds_type_list))
					ds_list_destroy(_actual_local);
			}
			return ds_list_create();
			break;
		case DS.GRID:
			if (variable_instance_exists(self, _id)) {
				if (ds_exists(_actual_local, ds_type_grid))
					ds_grid_destroy(_actual_local);
			}
			return ds_grid_create(argument[2], argument[3]);
			break;
	}


}
