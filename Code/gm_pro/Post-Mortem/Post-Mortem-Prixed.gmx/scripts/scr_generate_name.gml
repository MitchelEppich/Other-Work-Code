/// scr_generate_name()
random_set_seed(randomize()) 
addlast = ""
addlastlast = ""
let = irandom(7)
if let < 3
    {
    let = 3
    }
i = 0
name = ""
while i < let
{
add = choose("M","I","K","A","F","J","R","O","S","E","F","L","N","B")
if addlast == "M" || addlast == "L" || addlast == "K" || addlast == "F" || addlast == "J" || addlast == "R" || addlast == "S" || addlast == "N" || addlast == "B" || addlast == "A"
    {
    add = choose("I","A","O","E","U")
    }
if addlast == "I" || addlast == "O" || addlast == "U"
    {
    add = choose("A","E","M","N")
    }
if add != addlast && add != addlastlast
    {
    addlastlast = addlast
    addlast = add
    name = name + add
    i++
    }
else
if add == addlast && addlast = "A" && addlast != addlastlast
    {
    addlastlast = addlast
    addlast = add
    name = name + add
    i++
    }
}

return name;
