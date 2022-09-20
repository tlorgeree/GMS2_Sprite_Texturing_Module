if(!surface_exists(surface)){
	surface = surface_create(room_width,room_height);
	buffer_set_surface(buffer, surface, 0);
}

//Save surface
buffer_get_surface(buffer, surface, 0);
