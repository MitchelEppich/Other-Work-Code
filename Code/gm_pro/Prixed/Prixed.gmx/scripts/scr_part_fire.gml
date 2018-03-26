Sname = part_system_create();
part_system_position(Sname, self.x, self.y);
part_system_depth(Sname, self.depth - 1);
particle1 = part_type_create();
part_type_shape(particle1,pt_shape_square);
part_type_size(particle1,0.20,0.60,-0.01,0);
part_type_scale(particle1,0.20,0.20);
part_type_color3(particle1,16744448,33023,255);
part_type_alpha3(particle1,0.10,0.80,0.80);
part_type_speed(particle1,0.70,2.60,-0.02,0);
part_type_direction(particle1,85,95,0,9);
part_type_gravity(particle1,0,270);
part_type_orientation(particle1,0,0,10,20,1);
part_type_blend(particle1,1);
part_type_life(particle1,10,10);

emitter1 = part_emitter_create(Sname);
part_emitter_region(Sname,emitter1,-16,16,-7,7,ps_shape_ellipse,1);
part_emitter_burst(Sname,emitter1,particle1,5);
