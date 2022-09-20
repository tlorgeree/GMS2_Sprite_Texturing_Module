if(ds_list_size(queue)>0){
	var spr_w = sprite_get_width(queue[|0][0]);
	var spr_h = sprite_get_height(queue[|0][0]);
	var spr_w_adj = spr_w * sprite_get_number(queue[|0][0]);
	if(!surface_exists(surface)){
		surface = surface_create(spr_w_adj,spr_h);
	}
}