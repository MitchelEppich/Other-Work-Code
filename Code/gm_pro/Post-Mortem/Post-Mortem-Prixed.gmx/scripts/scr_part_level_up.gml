Sname = part_system_create();
part_system_position(Sname, self.x, self.y);
part_system_depth(Sname, self.depth-1);
particle1 = part_type_create();
part_type_shape(particle1,pt_shape_square);
part_type_size(particle1,0.10,0.30,0,0.30);
part_type_scale(particle1,0.2,0.2);
part_type_color3(particle1,16777215,8454143,8454143);
part_type_alpha3(particle1,0.50,0.70,0.90);
part_type_speed(particle1,1,1,0,0);
part_type_direction(particle1,0,359,0,0);
part_type_gravity(particle1,0.10,90);
part_type_orientation(particle1,0,0,0,0,0);
part_type_blend(particle1,0);
part_type_life(particle1,30,60);

emitter1 = part_emitter_create(Sname);
part_emitter_region(Sname,emitter1,7,-7,-10,10,ps_shape_ellipse,0);
part_emitter_burst(Sname,emitter1,particle1,50);
