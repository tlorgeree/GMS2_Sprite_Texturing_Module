/// @description Insert description here
// You can write your code in this editor
if(keyboard_check_pressed(ord("D"))){
	buffer = Texture_to_Sprite(spr_Example_Sprite,spr_Template,spr_Example_Texture_2);
	buffer_seek(buffer, buffer_seek_start,0);
	for(var i =0; i<buffer_get_size(buffer);++i){
		buffer_seek(buffer,buffer_seek_start,i);
		show_debug_message(buffer_read(buffer,buffer_u8));
	}
	if (!surface_exists(surface)){
		surface = surface_create(sprite_get_width(spr_Template)*sprite_get_number(spr_Template),sprite_get_height(spr_Template));
	}
	buffer_set_surface(buffer,surface,0);
	
}
