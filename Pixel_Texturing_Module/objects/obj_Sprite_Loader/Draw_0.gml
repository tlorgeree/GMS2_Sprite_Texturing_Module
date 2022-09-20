if(surface_exists(surface)){
	surface_set_target(surface);
	
	for(var f = 0; f<sprite_get_number(queue[|0][0]);++f){
		draw_sprite(queue[|0][0],f,f*sprite_get_width(queue[|0][0]),0);
	}

	surface_reset_target();


	//Draw surface
	draw_surface(surface, 0, 0);
}