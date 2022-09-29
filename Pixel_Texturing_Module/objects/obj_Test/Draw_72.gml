if(keyboard_check_pressed(ord("D"))){ 
	ind++;
	if (ind >= array_length(sprite)) ind = 0;
	sprite_index = sprite[ind];
}
