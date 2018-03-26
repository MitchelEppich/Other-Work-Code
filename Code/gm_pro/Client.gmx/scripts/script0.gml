/// scr_received_packet(socket, buffer)
var socket = argument[0];
var buffer = argument[1];
var message_id = buffer_read(buffer, buffer_u8);

switch(message_id)
{
    case 1:
        var mx = buffer_read(buffer, buffer_u32);
        var my = buffer_read(buffer, buffer_u32);
        instance_create(mx, my, obj_click);
        
        buffer_seek(buffer, buffer_seek_start, 0);
        buffer_write(buffer, buffer_u8, 1);
        buffer_write(buffer, buffer_u32, mouse_x);
        buffer_write(buffer, buffer_u32, mouse_y);

        for(i = 0; i < ds_list_size(socket); i++)
        {
            show_debug_message("Socket : " + string(socket[| i]));
            network_send_packet(socket[| i], buffer, buffer_tell(buffer));
        }
        
        break;
}
