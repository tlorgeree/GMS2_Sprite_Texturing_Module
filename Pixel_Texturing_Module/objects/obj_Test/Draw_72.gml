if(keyboard_check_pressed(ord("D"))){ 
	
	sprite_index = Find_Match_2_Sprites(spr_Sprite_Template, spr_Texture_Map_Template,spr_Example_Texture_3);
	image_index = 0;
	image_speed = sprite_get_speed(spr_Sprite_Template)/30;
	show_message(string(sprite_get_number(sprite_index)));
	
	
}
