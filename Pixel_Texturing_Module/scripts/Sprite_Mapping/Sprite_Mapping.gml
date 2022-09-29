function Sprite_Texture_From_Map(spr_tmp, spr_map, spr_tex){
	//Store the sprites in a buffer
	
	var buff1 = Buffer_Store_All_Sprite_Frames(spr_tmp);
	var buff2 = Buffer_Store_All_Sprite_Frames(spr_map);
	var buff3 = Buffer_Store_All_Sprite_Frames(spr_tex);
			
	
	//Convert Sprite Tempate to textured sprite
	var buff_new = Buff_Pixel_Match_From_Map(buff1, buff2, buff3);

	var frames = sprite_get_number(spr_tmp);
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
	buffer_delete(buff1);
	buffer_delete(buff2);
	buffer_delete(buff3);
	
	//set the sprite speed to be the same as the template
	sprite_set_speed(sprite,sprite_get_speed(spr_tmp),spritespeed_framespersecond);
	return sprite;

}
function Buffer_Store_All_Sprite_Frames(sprite){
	//Draw all frames of the sprite to the surface
	var frames = sprite_get_number(sprite);
	var spr_w =sprite_get_width(sprite)*frames;
	var spr_h = sprite_get_height(sprite);
	var _surf = surface_create(spr_w, spr_h);	
	surface_set_target(_surf);
		
	for(var f=0; f<frames;++f){
		draw_sprite(sprite,f,
		sprite_get_xoffset(sprite)+sprite_get_width(sprite)*f,
		sprite_get_yoffset(sprite));
	}
			
	surface_reset_target();
	
		
	var _buff = buffer_create(spr_w * spr_h * 4, buffer_fixed, 1);
	buffer_get_surface(_buff, _surf, 0);
		
	surface_free(_surf);
	
	return _buff;
}

function Buff_Get_Pixel_Data(buffer,offset){
	return [buffer_peek(buffer,offset,buffer_u8), buffer_peek(buffer,offset+1,buffer_u8),
	buffer_peek(buffer,offset+2,buffer_u8), buffer_peek(buffer,offset+3,buffer_u8)];
	
}

function Buffer_Stringify_Pixel_Data(buffer,offset){
	return string(buffer_peek(buffer,offset,buffer_u8)) + string(buffer_peek(buffer,offset+1,buffer_u8))
	+ string(buffer_peek(buffer,offset+2,buffer_u8)) +  string(buffer_peek(buffer,offset+3,buffer_u8));
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