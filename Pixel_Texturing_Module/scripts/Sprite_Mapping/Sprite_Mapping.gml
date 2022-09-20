function Texture_to_Sprite(spr_tmp, tex_temp, tex){
	///@param spr_tmp the template sprite that the texture will be applied to
	///@param tex_tmp the template texture map for that sprite type
	///@param tex the texture being used to create the sprite
	
	//for each subimage in sprite
	var frames = sprite_get_number(spr_tmp);
	
	//create surface to draw to
	var spr_h = sprite_get_height(spr_tmp);
	var spr_w = sprite_get_width(spr_tmp)*frames;
	var tmp_surface = surface_create(spr_w,spr_h);
	
	var buff_size = spr_w * spr_h * 4;//buffer size in bytes
	var buff = buffer_create(buff_size,buffer_fixed,1);
	
	//draw the tmp sprite to the surface
	surface_set_target(tmp_surface);
    draw_clear_alpha(c_white, 1);
    surface_reset_target();
    buffer_get_surface(buff, tmp_surface, 0);

	//store surface sprite in buffer	
	
	show_message(buffer_get_size(buff));
	buffer_get_surface(buff,tmp_surface,0);
	
	show_message(buffer_seek(buff,buffer_seek_start,0));
	show_message(buffer_read(buff,buffer_u8));
	
}