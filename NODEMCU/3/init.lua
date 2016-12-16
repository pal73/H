print("version3")
wifi.setmode(wifi.STATION)
wifi.sta.config("SPA2016","UMHHwAGa")
print(wifi.sta.getip()) 

gpio.mode(3, gpio.OUTPUT)
gpio.mode(4, gpio.OUTPUT)
gpio.write(3, gpio.LOW);
gpio.write(4, gpio.LOW);

srv=net.createServer(net.TCP) 
srv:listen(80,function(conn) 
    conn:on("receive", function(client,request)

        print(request)
        local buf = "123";
        local _, _, method, path, vars = string.find(request, "([A-Z]+) (.+)?(.+) HTTP");
        if(method == nil)then 
            _, _, method, path = string.find(request, "([A-Z]+) (.+) HTTP"); 
        end
        local _GET = {}
        if (vars ~= nil)then 
            for k, v in string.gmatch(vars, "(%w+)=(%w+)&*") do 
                _GET[k] = v 
            end 
        end
        local _on,_off = "",""

        print("111")
        
        if(_GET.pin == "GPIO0ON")then
              _on = " selected=true";
              gpio.write(3, gpio.HIGH);
              print("GPIO0ON")
              
              
        elseif(_GET.pin == "GPIO0OFF")then
              _off = " selected=\"true\"";
              gpio.write(3, gpio.LOW);
              print("GPIO0OFF")
              
       
        elseif(_GET.pin == "GPIO2ON")then
              _off = " selected=\"true\"";
              gpio.write(4, gpio.HIGH);
              print("GPIO2ON")
              
        
        elseif(_GET.pin == "GPIO2OFF")then
              _off = " selected=\"true\"";
              gpio.write(4, gpio.LOW);
              print("GPIO2OFF")
        end        
        client:send(buf);
        client:close();
        collectgarbage();
    end)
end)
