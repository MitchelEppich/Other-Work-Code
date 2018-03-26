Sname = part_system_create();
part_system_position(Sname, self.x, self.y);
part_system_depth(Sname, self.depth-1);
particle1 = part_type_create();
part_type_shape(particle1,pt_shape_square);
part_type_size(particle1,0.10,3,-0.04,0.03);
part_type_scale(particle1,0.05,0.05);
part_type_color2(particle1,16512,64);
part_type_alpha1(particle1,0.10);
part_type_speed(particle1,0.30,1,0,0);
part_type_direction(particle1,0,359,0,10);
part_type_gravity(particle1,0.03,180);
part_type_orientation(particle1,0,0,0,0,1);
part_type_blend(particle1,0);
part_type_life(particle1,60,60);

emitter1 = part_emitter_create(Sname);
part_emitter_region(Sname,emitter1,12,-12,6,-6,ps_shape_ellipse,1);
part_emitter_burst(Sname,emitter1,particle1,5);
