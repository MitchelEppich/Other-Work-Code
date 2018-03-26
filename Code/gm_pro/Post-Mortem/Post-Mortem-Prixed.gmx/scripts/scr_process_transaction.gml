/// scr_process_transaction(action)

var action = argument0;

var success = true;

var buyer = "", seller = "", item, index, price;
var c = string_copy(action, 1, 1);
// Acquire Buyer
while (c != '~') {
    buyer += c;
    action = string_delete(action, 1, 1);
    c = string_copy(action, 1, 1);
}

b = scr_get_handler(buyer);
buyer = b[? "inv_holder"];
buyer = buyer[? "inventory"];

action = string_delete(action, 1, 1);
c = string_copy(action, 1, 1);

// Acquire Seller
while (c != '~') {
    seller += c;
    action = string_delete(action, 1, 1);
    c = string_copy(action, 1, 1);
}

s = scr_get_handler(seller);
seller = s[? "inv_holder"];
seller = seller[? "inventory"];

action = string_delete(action, 1, 1);

// Acquire index
index = real(action);

// Acquire item
item = seller[| index];
item[? "index"] -= item[? "index"]%2;
price = scr_price_object(item);

// Give to buyer and take money
var buyer_d = b[? "detail"];
if (buyer_d[? "coins"] >= price) {
    buyer_d[? "coins"] -= price;
    ds_list_add(buyer, item);
} else {
    success = false;
}

// Remove from seller and give cash
seller_d = s[? "detail"];
if (success) {
    seller_d[? "coins"] += price;
    ds_list_delete(seller, index);
}

// Send output message
s = s[? "preview"];
if (!success) {
    s[? "title"] = seller_d[? "name"];
    s[? "phrase"] = "That is not nearly enough coins. Sorry.";
}
