/// scr_send_packet(socket, message_id)

var socket = argument[0];
var message_id = argument[1];

var size = 1024;
var type = buffer_fixed;
var alignment = 1;
var buffer = buffer_create(size, type, alignment);
  
buffer_seek(buffer, buffer_seek_start, 0);
          
switch(message_id)
{
    case "assign_client_id":
        buffer_write(buffer, buffer_u8, 0);
        buffer_write(buffer, buffer_u32, 10000000 + ds_list_size(socket));
        break;
}

network_send_packet(socket, buffer, buffer_tell(buffer));
        
buffer_delete(buffer);
