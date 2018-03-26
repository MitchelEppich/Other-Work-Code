Sname = part_system_create();
part_system_position(Sname, self.x, self.y - self.sprite_height / 3);
part_system_depth(Sname, self.depth-1);
particle1 = part_type_create();
part_type_shape(particle1,pt_shape_square);
part_type_size(particle1,0.10,1,0,0.03);
part_type_scale(particle1,0.06,0.06);
part_type_color2(particle1,65535,65280);
part_type_alpha1(particle1,0.40);
part_type_speed(particle1,0.30,1,0,0);
part_type_direction(particle1,0,359,0,10);
part_type_gravity(particle1,0.03,90);
part_type_orientation(particle1,0,0,0,0,1);
part_type_blend(particle1,1);
part_type_life(particle1,20,40);

emitter1 = part_emitter_create(Sname);
part_emitter_region(Sname,emitter1,6,-6,3,-3,ps_shape_ellipse,1);
part_emitter_burst(Sname,emitter1,particle1,5);
