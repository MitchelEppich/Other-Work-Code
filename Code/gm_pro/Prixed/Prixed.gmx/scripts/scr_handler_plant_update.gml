var this = argument0;

if(this.state < this.max_state - 1) {
    if(global.tick mod this.rate == 0) this.state++;
}

image_index = this.state;
