/// scr_received_packet(socket, buffer)
var socket = argument[0];
var buffer = argument[1];
var message_id = buffer_read(buffer, buffer_u8);

switch(message_id)
{
    case 1:
        var xx = buffer_read(buffer, buffer_u32);
        var yy = buffer_read(buffer, buffer_u32);
        npc[? socket].x = xx;
        npc[? socket].y = yy;
        /*
        buffer_seek(buffer, buffer_seek_start, 0);
        buffer_write(buffer, buffer_u8, message_id);
        buffer_write(buffer, buffer_u32, mx);
        buffer_write(buffer, buffer_u32, my);

        show_debug_message("Sending Data Back To Clients...");
        for(i = 0; i < ds_list_size(socket); i++)
        {
            if(async_load[? "id"] == socket[| i])
            {
                show_debug_message("Skipping Send Client...");
                continue;
            }
            show_debug_message("Socket : " + string(socket[| i]));
            network_send_packet(socket[| i], buffer, buffer_tell(buffer));
            
            show_debug_message("Data Successfully Sent...");
        }
        */
        break;
}
