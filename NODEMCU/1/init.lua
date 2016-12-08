print ("Привет мир")
dofile("timers.lua")
dofile("blink.lua")
a=0
while 1 do
    a=a+1
    print(a)
    --tmr.delay(1100000);
end