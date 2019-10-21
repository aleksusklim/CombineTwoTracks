
o=object_add();
object_event_add(o,ev_create,0,"
{
    c='CombineTwoTracks v1.1, by Kly_Men_COmpany!';
    t='Space - toggle;#right-left – pan;#up-down - switch;#Enter - replay';
    if parameter_count() <> 2{
    show_message(c+'#Usage:#CombineTwoTracks.exe 1.wav 2.wav##'+t);
    game_end();
    exit;
    }
    t=string_replace_all(t,'#',' ');
    room_caption=c+t;
    
    s1=sound_add(parameter_string(1),0,1);
    s2=sound_add(parameter_string(2),0,1);
    
    f=true;
    p=0.5;
}
");
object_event_add(o,ev_step,ev_step_normal,"
{
    a=0.01;
    if keyboard_check(vk_left)p-=a;
    if keyboard_check(vk_right)p+=a;
    if keyboard_check_pressed(vk_down){if p>=0.5 then p=1 else p=0.5;}
    if keyboard_check_pressed(vk_up){if p<=0.5 then p=0 else p=0.5;}
    if keyboard_check_pressed(vk_space)p=1-p;
    if mouse_check_button(mb_left)p=mouse_x/room_width;
    
    if keyboard_check_pressed(vk_enter) or f{
    sound_stop_all();
    sound_volume(s1,0);
    sound_volume(s2,0);
    sound_play(s1);
    sound_play(s2);
    sound_stop_all();
    sound_loop(s1);
    sound_loop(s2);
    f=false;}
    
    p=round(p/a)*a;
    
    if p>=1 then p=1;
    if p<=0 then p=0;
    
    v1=power(p,1/10);
    v2=power(1-p,1/10);
    
    sound_volume(s1,v1);
    sound_volume(s2,v2);
}
");
object_event_add(o,ev_draw,0,"
{
    w=room_width;
    h=room_height;
    z=w*p;
    draw_set_color(c_blue);
    draw_rectangle(0,0,z,h,0);
    draw_set_color(c_lime);
    draw_rectangle(z,0,w,h,0);
    draw_set_color(c_red);
    draw_rectangle(z-1,0,z+1,h,0);
}
");

r=room_add();
room_set_width(r,640);
room_set_height(r,64);
room_instance_add(r,0,0,o);
room_goto(r);
