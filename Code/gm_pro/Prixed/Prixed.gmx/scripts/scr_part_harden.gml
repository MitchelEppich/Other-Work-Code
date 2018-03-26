Sname = part_system_create();
part_system_position(Sname, self.x, self.y-self.sprite_height / 4);
part_system_depth(Sname, self.depth-1);
particle1 = part_type_create();
part_type_shape(particle1,pt_shape_square);
part_type_size(particle1,0.1,0.1,0,0.05);
part_type_scale(particle1,1,1);
part_type_color1(particle1,4227327);
part_type_alpha1(particle1,0.50);
part_type_speed(particle1,1,1,0,0);
part_type_direction(particle1,0,359,0,0);
part_type_gravity(particle1,0,270);
part_type_orientation(particle1,0,0,0,0,1);
part_type_blend(particle1,0);
part_type_life(particle1,60,60);

emitter1 = part_emitter_create(Sname);
part_emitter_region(Sname,emitter1,7,-7,10,-10,ps_shape_rectangle,1);
part_emitter_burst(Sname,emitter1,particle1,1);

