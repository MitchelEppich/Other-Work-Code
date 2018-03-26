Sname = part_system_create();

particle2 = part_type_create();
part_type_shape(particle2,pt_shape_circle);
part_type_size(particle2,0.10,0.10,0,0);
part_type_scale(particle2,1,1);
part_type_color3(particle2,16777088,4227327,8454143);
part_type_alpha1(particle2,1);
part_type_speed(particle2,0.10,0.10,0,0);
part_type_direction(particle2,20,160,0,20);
part_type_gravity(particle2,0,270);
part_type_orientation(particle2,0,359,0,20,1);
part_type_blend(particle2,1);
part_type_life(particle2,500,800);

emitter1 = part_emitter_create(Sname);
part_emitter_region(Sname,emitter1,x,x,y,y,0,0);
part_emitter_stream(Sname,emitter1,particle2,1);

