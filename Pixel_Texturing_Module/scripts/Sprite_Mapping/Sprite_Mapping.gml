function Texture_to_Sprite(spr_tmp, tex_temp, tex){
	///@param spr_tmp the template sprite that the texture will be applied to
	///@param tex_tmp the template texture map for that sprite type
	///@param tex the texture being used to create the sprite
	
	//for each subimage in sprite
	var frames = sprite_get_number(spr_tmp);
	
	//create surface to draw to
	var spr_h = sprite_get_height(spr_tmp); show_debug_message(string(spr_h));
	var spr_w = sprite_get_width(spr_tmp);show_debug_message(string(spr_w));
	var spr_w_adj = spr_w * frames;show_debug_message(string(spr_w_adj));
	var tmp_surface = surface_create(spr_w_adj,spr_h);
	
	var buff_size = spr_w_adj * spr_h * 4;//buffer size in bytes
	var buff = buffer_create(buff_size,buffer_fast,1);
	
	//draw the tmp sprite to the surface
	surface_set_target(tmp_surface);
    draw_clear_alpha(c_white, 0);
	for(var f = 0; f<frames;++f){
		draw_sprite(spr_tmp,f,50,f*spr_w)
	}
	
    surface_reset_target();


	//store surface sprite in buffer	

	buffer_get_surface(buff,tmp_surface,0);
	
	/*for(var i =0; i<buff_size;++i){
		buffer_seek(buff,buffer_seek_start,i);
		show_debug_message(buffer_read(buff,buffer_u8));
	}*/
	surface_free(tmp_surface);
	return buff;
}

function Surface_Get_Sprite_Buffer(surface, sprite){
	var frames = sprite_get_number(sprite);
	var spr_h = sprite_get_height(sprite);
	var spr_w = sprite_get_width(sprite);
	var spr_w_adj = spr_w * frames;
}