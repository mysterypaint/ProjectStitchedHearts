function draw_entity_shadows() {
	var _instNum = instance_number(Entities);

	for (var _i = 0; _i < _instNum; _i++) {
		var _this_inst = instance_find(Entities, _i);
		draw_sprite(sprShadow, 0, _this_inst.x, _this_inst.y);
	}


}
