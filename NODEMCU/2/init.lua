
print("Reload")
--dofile("spa2.lua")
local pinstat=TRUE;
int_cntr=0;
gpio.mode(5,gpio.INT,gpio.PULLUP)
gpio.trig(5,"up", function(level)
                       if level==1 then
                       int_cntr=int_cntr+1 
                       pinstat=not pinstat 
                       gpio.mode(4,gpio.OUTPUT)
                       
                       if pinstat then
                            gpio.write(4,1)
                       else 
                            gpio.write(4,gpio.LOW)
                       end  
                       print(level, "      ", int_cntr)   
                       end
                       tmr.delay(500000)
                       
                       end)
