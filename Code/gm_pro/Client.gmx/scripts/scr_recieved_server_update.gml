/// scr_received_server_update(buffer)
var buffer = argument[0];
var message_id = buffer_read(buffer, buffer_u8);

switch(message_id)
{
    case 0:
        client_id = buffer_read(buffer, buffer_u32);
        show_debug_message("I was set the id of " + string(client_id));
        break;
    case 1:
        var mx = buffer_read(buffer, buffer_u32);
        var my = buffer_read(buffer, buffer_u32);
        instance_create(mx, my, obj_click);      
        break;
}
