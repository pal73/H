lighton=0
pin=4;
gpio.mode(pin,gpio.OUTPUT)
tmr.alarm(1,2000,1,function()
if lighton==0 then 
    lighton=1 
    gpio.write(pin,gpio.HIGH) 
    -- 512/1024, 50% duty cycle
else 
    lighton=0 
    gpio.write(pin,gpio.LOW) 
end 
end)
collectgarbage()
