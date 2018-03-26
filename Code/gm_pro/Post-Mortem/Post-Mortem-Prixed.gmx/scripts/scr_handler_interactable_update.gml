var this = argument0;

if(global.tick mod this.rate == 0 && count >= 0 && !this.occupied) {
    count--;
    if(count <= 0) {
        count = 0;
        refuel = 0;
    }
} else if(count < 0) count *= -1;

depth = -y;
