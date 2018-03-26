Sname = part_system_create();
part_system_position(Sname, self.x, self.y-self.sprite_height / 4);
part_system_depth(Sname, self.depth-1);
particle1 = part_type_create();
part_type_shape(particle1,pt_shape_square);
part_type_size(particle1,0.20,0.20,-0.01,0.10);
part_type_scale(particle1,0.5,0.5);
part_type_color3(particle1,32768,65535,8388608);
part_type_alpha3(particle1,0.40,0.20,0.60);
part_type_speed(particle1,1,1,0,1);
part_type_direction(particle1,60,120,0.10,5);
part_type_gravity(particle1,0.20,90);
part_type_orientation(particle1,0,0,0,0,1);
part_type_blend(particle1,0);
part_type_life(particle1,60,60);

emitter1 = part_emitter_create(Sname);
part_emitter_region(Sname,emitter1,10,-10,20,-20,ps_shape_rectangle,1);
part_emitter_burst(Sname,emitter1,particle1,100);

