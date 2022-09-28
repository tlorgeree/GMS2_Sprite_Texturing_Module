if(keyboard_check_pressed(ord("D"))){ 
	/*var spr_tmp = spr_Sprite_Template;
	var buff = Sprite_to_Buffer(spr_tmp);
	
	var sprW =sprite_get_width(spr_tmp)*sprite_get_number(spr_tmp);
		var sprH = sprite_get_height(spr_tmp);
		show_message(string(sprW*sprH));
		//Draw the sprite into a surface
		surface_test = surface_create(sprW, sprH);

	buffer_set_surface(buff,surface_test,0);*/
	
	Find_Match_2_Sprites(spr_Sprite_Template, spr_Texture_Map_Template);
}