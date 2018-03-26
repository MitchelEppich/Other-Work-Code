/// time_trigger ( time )
c_currentTime = get_time();
c_relativeTime = c_currentTime - c_creationTime;
print(c_relativeTime);
if (c_relativeTime mod argument0 < 0.01)
    return true;
    
return false;
