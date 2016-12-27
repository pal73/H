wifi.setmode(wifi.SOFTAP);
wifi.ap.config({ssid="ESP8266",pwd="12345678"});
gpio.mode(4, gpio.OUTPUT)
gpio.write(4,gpio.LOW)
srv=net.createServer(net.TCP) 

function handleGet(vars)
    buf = '<!DOCTYPE html>'..
            '<head>'..
                '<title>Relay</title>'..
                '<style>'..
                    'body {'..
                        'background-color: #e0e0e0;'..
                        'font-family: Tahoma, Geneva, sans-serif;'..
                        'color:#212121'..
                    '}'..
                    'form {'..
                        'text-align: center'..
                    '}'..
                    '.button {'..
                        'color: white;'..
                        'font-size: 60px;'..
                        'width: 200px;'..
                        'height: 200px;'..
                        'border-radius: 200px;'..
                        'border:0px;'..
                         'border-style: solid;'..
                        'border-color: #bdbdbd;'..
                    '}'..
                    '.button:active'..
                    '{'..
                        'font-size: 58px;'..
                        'border: 8px;'..
                        'border-style: solid;'..
                        'border-color: #bdbdbd;'..
                        
                    '}'..

                    '.on {'..
                        'background: #039be5;'..
                    '}'..
                    '.off {'..
                        'background: #757575;'..
                    '}'..
                '</style>'..
            '</head>'..
            '<body>'..
                '<h1 style="text-align: center; font-family: inherit;">Alarm</h1>'..
                '<form action="/" method="GET">'..
                    '<span>'..
                        '<input type="submit" class="button on" value="On" name="pin">'..
                    '</span>'..
                    '<span>'..
                        '<input type="submit" class="button off" value="Off" name="pin">'..
                    '</span>'..
                    '</form>'..
            '</body>'..
        '</html>';
    local _GET = {}
    if (vars ~= nil) then
        for k, v in string.gmatch(vars, "(%w+)=(%w+)&*") do 
            _GET[k] = v 
        end 
    end
    if(_GET.pin == "On") then
        gpio.write(4, gpio.HIGH);
    elseif(_GET.pin == "Off") then
        gpio.write(4, gpio.LOW);
    end
    return buf;
end

srv:listen(80,function(conn) 
    conn:on("receive", function(client,request)
        local buf = "";
        local _, _, method, path, vars = string.find(request, "([A-Z]+) (.+)?(.+) HTTP");
        if(method == nil)then 
            _, _, method, path = string.find(request, "([A-Z]+) (.+) HTTP"); 
        end
        local buf = handleGet(vars);
        client:send(buf);
        client:close();
        collectgarbage();
    end)
end)
