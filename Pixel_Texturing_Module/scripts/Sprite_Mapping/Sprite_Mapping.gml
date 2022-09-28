function Sprite_to_Buffer(spr_tmp){
	///@param spr_tmp the template sprite that the texture will be applied to
	///@param tex_tmp the template texture map for that sprite type
	///@param tex the texture being used to create the sprite
	
	/*
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
    //draw_clear_alpha(c_white, 0);
	//for(var f = 0; f<frames;++f){
		draw_sprite(spr_tmp,0,0,0*spr_w)
	//}
	
    surface_reset_target();


	//store surface sprite in buffer	

	buffer_get_surface(buff,tmp_surface,0);
	
	for(var i =0; i<buff_size;++i){
		buffer_seek(buff,buffer_seek_start,i);
		show_debug_message(buffer_read(buff,buffer_u8));
	}
	surface_free(tmp_surface);
	return buff;
	*/

	//gml_pragma("forceinline");
	
		//Get the size of the sprite
		
		var spr_w =sprite_get_width(spr_tmp)*sprite_get_number(spr_tmp);
		var spr_h = sprite_get_height(spr_tmp);
		show_message(string(spr_w*spr_h));
		//Draw the sprite into a surface
		var _surf = surface_create(spr_w, spr_h);
		
		surface_set_target(_surf);
		
		for(var f=0; f<sprite_get_number(spr_tmp);++f){
			draw_sprite(spr_tmp,f,sprite_get_width(spr_tmp)*f,0);
		}
			
		surface_reset_target();
		
		//Get the color data into a surface
		var _sprBuff = buffer_create(spr_w * spr_h * 4, buffer_fixed, 1);
		buffer_get_surface(_sprBuff, _surf, 0);
		
		//Free the surface and return the buffer
		surface_free(_surf);
		
		return _sprBuff;
		
}

function Find_Match_2_Sprites(spr_tmp, spr_tmp2){
	//store spr 1 in buff1
	var spr_w =sprite_get_width(spr_tmp)*sprite_get_number(spr_tmp);
	var spr_h = sprite_get_height(spr_tmp);

	//Draw the sprite into a surface
	var _surf = surface_create(spr_w, spr_h);
		
	surface_set_target(_surf);
		
	for(var f=0; f<sprite_get_number(spr_tmp);++f){
		draw_sprite(spr_tmp,f,sprite_get_width(spr_tmp)*f,0);
	}
			
	surface_reset_target();
		
	//Get the color data into a surface
	var _sprBuff = buffer_create(spr_w * spr_h * 4, buffer_fixed, 1);
	buffer_get_surface(_sprBuff, _surf, 0);
		
	//Free the surface and return the buffer
	surface_free(_surf);
		
		
	//store spr 2 in buff2
	var spr_w2 =sprite_get_width(spr_tmp2)*sprite_get_number(spr_tmp2);
	var spr_h2 = sprite_get_height(spr_tmp2);

	//Draw the sprite into a surface
	var _surf2 = surface_create(spr_w2, spr_h2);
		
	surface_set_target(_surf2);
		
	for(var f2=0; f2<sprite_get_number(spr_tmp2);++f2){
		draw_sprite(spr_tmp2,f2,sprite_get_width(spr_tmp2)*f2,0);
	}
			
	surface_reset_target();
		
	//Get the color data into a surface
	var _sprBuff2 = buffer_create(spr_w2 * spr_h2 * 4, buffer_fixed, 1);
	buffer_get_surface(_sprBuff2, _surf2, 0);
		
	//Free the surface and return the buffer
	surface_free(_surf2);
	
	
	//Find matching values
	Buff_Pixel_Match_Report(_sprBuff,_sprBuff2);
	
}

function Buff_Get_Pixel_Data(buffer,offset){
	return [buffer_peek(buffer,offset,buffer_u8), buffer_peek(buffer,offset+1,buffer_u8),
	buffer_peek(buffer,offset+2,buffer_u8), buffer_peek(buffer,offset+3,buffer_u8)];
	
}
function Buff_Pixel_Match_Report(buff1, buff2){
	
	var operations = 0;
	show_message(buffer_get_size(buff1));
	show_message(buffer_get_size(buff2));
	for(var i = 0; i < buffer_get_size(buff1);i += 4){
		if(buffer_peek(buff1,i+3,buffer_u8)!=0){
			for(var j = 0; j < buffer_get_size(buff2);j += 4){
				if(buffer_peek(buff2,j+3,buffer_u8)!=0){
					if(array_equals(Buff_Get_Pixel_Data(buff1,i),Buff_Get_Pixel_Data(buff2,j))){
						//show_debug_message("Pixels matched");
						operations++;
					}
				}
			}
		}
	}
	
	show_debug_message("This ran: " + string(operations));
}