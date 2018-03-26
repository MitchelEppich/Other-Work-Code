///scr_effect_fireworks
Sname = part_system_create();
part_system_depth(Sname, -10000);

particle1 = part_type_create();
part_type_shape(particle1,pt_shape_flare);
part_type_size(particle1,1,1,-0.01,0);
part_type_scale(particle1,0.1,0.1);
part_type_color2(particle1,33023,65535);
part_type_alpha2(particle1,0.90,0.40);
part_type_speed(particle1,2,2,0,0.40);
part_type_direction(particle1,0,359,0,10);
part_type_gravity(particle1,0.01,270);
part_type_orientation(particle1,0,0,0,0,1);
part_type_blend(particle1,1);
part_type_life(particle1,30,30);

particle3 = part_type_create();
part_type_shape(particle3,pt_shape_square);
part_type_size(particle3,0.4,0.4,-0.01,0);
part_type_scale(particle3,0.1,0.1);
part_type_color1(particle3,33023);
part_type_alpha1(particle3,1);
part_type_speed(particle3,2,2,0.05,0.20);
part_type_direction(particle3,20,160,0,10);
part_type_gravity(particle3,0.01,270);
part_type_orientation(particle3,0,0,0,0,1);
part_type_blend(particle3,1);
part_type_life(particle3,30,30);

part_particles_create(Sname, x, y, particle3, 1);
/*
emitter1 = part_emitter_create(particle3);
part_emitter_region(Sname,emitter1,x,x,y,y,0,0);
part_emitter_burst(Sname,emitter1,particle3,5);
*/

part_type_step(particle3,1,particle1);
part_type_death(particle3,1,particle1);
