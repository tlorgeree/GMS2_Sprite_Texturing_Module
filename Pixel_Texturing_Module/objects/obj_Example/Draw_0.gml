/// @description Insert description here
// You can write your code in this editor


if(buffer !=-1){
	show_debug_message(surface_get_target());
	//draw_clear_alpha(c_white,0);
	
	surface_set_target(surface);
	show_debug_message(surface_get_target());
	show_debug_message("drawing");
	
	
	surface_reset_target();
	
	draw_surface(surface,50,50);
}