surface = surface_create(room_width,room_height);
brush_size = 8;
//Buffer
buffer = buffer_create(4 * room_width * room_height, buffer_grow, 1);