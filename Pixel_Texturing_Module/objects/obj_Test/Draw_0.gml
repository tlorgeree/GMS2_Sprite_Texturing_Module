//Draw to surface
if (mouse_check_button(mb_left)){
 surface_set_target(surface);

 draw_circle(mouse_x, mouse_y, brush_size, false);

 surface_reset_target();
}

//Draw surface
draw_surface(surface, 0, 0);

