/// scr_send_packet(message_id)
var message_id = argument[0];

buffer_seek(buffer, buffer_seek_start, 0);

switch(message_id)
{
    case "update_position":
        buffer_write(buffer, buffer_u8, 1);
        buffer_write(buffer, buffer_u32, x);
        buffer_write(buffer, buffer_u32, y);
        break;
}

network_send_packet(socket, buffer, buffer_tell(buffer));
