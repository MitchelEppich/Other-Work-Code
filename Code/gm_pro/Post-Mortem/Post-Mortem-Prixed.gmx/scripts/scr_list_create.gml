/// scr_list_create(element, ...)

// Create helping variables
selection = 0;
currLen = 0;
currSelection = -1;
currElement = 0;
len = 0;

// Create the list
var list = ds_list_create();

// Add elements passed in elements to list
if (argument_count != 0) 
    for (var i = 0; i < argument_count; i++) {
        ds_list_add(list, argument[i]);
    }

// Return new list
return list;
