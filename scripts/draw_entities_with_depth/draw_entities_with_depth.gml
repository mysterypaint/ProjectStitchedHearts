/// @descrption Called from Camera Draw Event; Draws all entities and their shadows to the screen, in order of depth based on Y-position
function draw_entities_with_depth() {

	// Draw a shadow underneath every entity that currently exists
	var _instNum = instance_number(Entities);

	for (var _i = 0; _i < _instNum; _i++) {
		var _this_inst = instance_find(Entities, _i);
		draw_sprite(sprShadow, 0, _this_inst.x, _this_inst.y);
	}

	if (ds_exists(ds_depthgrid, ds_type_grid)) {
		var _depth_grid = ds_depthgrid; // Add all instances to the grid
		ds_grid_resize(_depth_grid, 2, _instNum); // Resize the current grid
		var _yy = 0;
		with (Entities) {
			_depth_grid[# 0, _yy] = id; // Add ourselves to the grid
			_depth_grid[# 1, _yy] = y; // Add our Y value, too
			_yy++;
		}
		ds_grid_sort(_depth_grid, 1, true); // Sort the depth grid by Y value (lowest Y value first)
		_yy = 0; repeat(_instNum) { // Draw all the instances in order (lowest Y value first)
			var _instanceID = _depth_grid[# 0, _yy];
			with (_instanceID) {
				draw_sprite(spr_index, (img_index % img_ani_max) + img_index_offset, x, y);
			}
			_yy++
		}
	
		ds_grid_clear(_depth_grid, 0);
	}


}
