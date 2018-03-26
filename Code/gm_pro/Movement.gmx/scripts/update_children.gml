/// update_children ( x, y, parent )
c_currentKey = 0;
c_size = ds_list_size(c_children);

for (var i = 0; i < c_size; i++){

    c_currentKey = ds_list_find_value(c_children, i);
    draw_line(x, y, c_currentKey.x, c_currentKey.y);
}
