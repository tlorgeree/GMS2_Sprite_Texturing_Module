function Sprite_to_Buffer(spr_tmp){
	///@param spr_tmp the template sprite that the texture will be applied to
	///@param tex_tmp the template texture map for that sprite type
	///@param tex the texture being used to create the sprite
		
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
		
		return _sprBuff;
		
}

function Find_Match_2_Sprites(spr_tmp, spr_tmp2, spr_tmp3){
	//store spr 1 in buff1 this is sprite template
	var frames = sprite_get_number(spr_tmp);
	var spr_w =sprite_get_width(spr_tmp)*frames;
	var spr_h = sprite_get_height(spr_tmp);

	//Draw the sprite into a surface
	var _surf = surface_create(spr_w, spr_h);
		
	surface_set_target(_surf);
		
	for(var f=0; f<frames;++f){
		draw_sprite(spr_tmp,f,sprite_get_xoffset(spr_tmp)+sprite_get_width(spr_tmp)*f,sprite_get_yoffset(spr_tmp));
	}
			
	surface_reset_target();
		
	//Get the color data into a surface
	var _sprBuff = buffer_create(spr_w * spr_h * 4, buffer_fixed, 1);
	buffer_get_surface(_sprBuff, _surf, 0);
		
	//Free the surface and return the buffer
	surface_free(_surf);
		
		
	//store spr 2 in buff2 this is texture template
	var spr_w2 =sprite_get_width(spr_tmp2)*sprite_get_number(spr_tmp2);
	var spr_h2 = sprite_get_height(spr_tmp2);

	//Draw the sprite into a surface
	var _surf2 = surface_create(spr_w2, spr_h2);
		
	surface_set_target(_surf2);
		
	for(var f2=0; f2<sprite_get_number(spr_tmp2);++f2){
		draw_sprite(spr_tmp2,f2, sprite_get_width(spr_tmp2)*f2,0);
	}
			
	surface_reset_target();
		
	//Get the color data into a surface
	var _sprBuff2 = buffer_create(spr_w2 * spr_h2 * 4, buffer_fixed, 1);
	buffer_get_surface(_sprBuff2, _surf2, 0);
		
	//Free the surface and return the buffer
	surface_free(_surf2);
	
	//store spr 3 in buff3 this is texture to be applied
	var spr_w3 =sprite_get_width(spr_tmp3)*sprite_get_number(spr_tmp3);
	var spr_h3 = sprite_get_height(spr_tmp3);

	//Draw the sprite into a surface
	var _surf3 = surface_create(spr_w3, spr_h3);
		
	surface_set_target(_surf3);
		
	for(var f3=0; f3<sprite_get_number(spr_tmp3);++f3){
		draw_sprite(spr_tmp3,f3,sprite_get_width(spr_tmp3)*f3,0);
	}
			
	surface_reset_target();
		
	//Get the color data into a surface
	var _sprBuff3 = buffer_create(spr_w3 * spr_h3 * 4, buffer_fixed, 1);
	buffer_get_surface(_sprBuff3, _surf3, 0);
		
	//Free the surface and return the buffer
	surface_free(_surf3);
	
	//Convert Sprite Tempate to textured sprite
	var buff_new = Buff_Pixel_Match_From_Map(_sprBuff,_sprBuff2,_sprBuff3);
	
	var spr_w =sprite_get_width(spr_tmp)*frames;
	var spr_h = sprite_get_height(spr_tmp);

	var _surf = surface_create(spr_w, spr_h);
	buffer_seek(buff_new,buffer_seek_start,0);
	buffer_set_surface(buff_new,_surf,0);
	
	var sprite = sprite_create_from_surface(_surf,0,0,spr_w/frames,spr_h,0,0,
		sprite_get_xoffset(spr_tmp),sprite_get_yoffset(spr_tmp));
	
	
	for (var i = 1; i < frames; ++i)
	{
		sprite_add_from_surface(sprite, _surf, i*(spr_w/frames), 0, spr_w/frames, spr_h, 0, 0);
	}
	
	surface_free(_surf);
	buffer_delete(buff_new);
	buffer_delete(_sprBuff);
	buffer_delete(_sprBuff2);
	buffer_delete(_sprBuff3);

	return sprite;

}

function Buff_Get_Pixel_Data(buffer,offset){
	return [buffer_peek(buffer,offset,buffer_u8), buffer_peek(buffer,offset+1,buffer_u8),
	buffer_peek(buffer,offset+2,buffer_u8), buffer_peek(buffer,offset+3,buffer_u8)];
	
}

function Buffer_Stringify_Pixel_Data(buffer,offset){
	return string(buffer_peek(buffer,offset,buffer_u8)) + string(buffer_peek(buffer,offset+1,buffer_u8))
	+ string(buffer_peek(buffer,offset+2,buffer_u8)) +  string(buffer_peek(buffer,offset+3,buffer_u8));
}
function Buff_Pixel_Match_Report(buff1, buff2){
	var operations = 0;
	//show_message(buffer_get_size(buff1));
	//show_message(buffer_get_size(buff2));

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

function Buff_Pixel_Match_From_Map(buff_spr, buff_tem, buff_tex){
	var map = ds_map_create();
	
	//create color dictionary from map
	for(var j = 0; j < buffer_get_size(buff_tem);j += 4){
		var str = Buffer_Stringify_Pixel_Data(buff_tem,j);
		if(is_undefined(ds_map_find_value(map, str))){//if not in map
			ds_map_add(map,str,Buff_Get_Pixel_Data(buff_tex,j)); //add color to map
		}
	}
	
	//Go through sprite and replace colors with texture using map.
	for(var i = 0; i < buffer_get_size(buff_spr);i += 4){
		if(buffer_peek(buff_spr,i+3,buffer_u8)!=0){//if the pixel isn't transparent
			var curr_pix = Buffer_Stringify_Pixel_Data(buff_spr,i);
			var map_find = ds_map_find_value(map, curr_pix);
			if(!is_undefined(map_find)){
				//if color is found in dictionary, apply corresponding texture color
				for(var b = 0; b<=2; ++b){
					buffer_seek(buff_spr, buffer_seek_start,i+b)
					buffer_write(buff_spr,buffer_u8,map_find[b]);
				}
			}
		}
	}
	
	//delete the ds_map
	ds_map_destroy(map);
	
	//return the modified buffer
	return buff_spr;
}