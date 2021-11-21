`include "../Smart_home_automation.v"

module master_tb;
    reg clk, reset,fsen,ma,lock,wsen,ms,ir,man,rsen,ir1,ir2;
    reg [1:0] water_sensor;
    reg [7:0] lum,temp,moisture_sensor;
    wire [7:0] count,occupants_in;
    wire [2:0]alarms;
    wire lights_on, heat_on, cool_on, sprink_on, pump_on, mod_reset, ext_light, dalm, walm, falm, ralm, heat, cool, il, pump, sprinkler, burglar_alarm, rain_alarm, fire_alarm;
    
    ext_lights e(.clk(clk), .lum_sen(lum), .ext_light(ext_light), .reset(mod_reset));
    fire f(.clk(clk), .f_sensor(fsen),.f_alarm(falm));
    door d(.clk(clk), .magnetic_sensor(ma), .alarm(dalm), .locked(lock));
    light_control lc(.int_light(il), .lum_sen(lum), .clk(clk), .reset(mod_reset), .motion_sen(ms), .ir_sen(ir), .manual(man));
    rain r(.clk(clk), .rain_sensor(rsen),.rain_alarm(ralm));
    temp_control t(.heat(heat), .cool(cool), .clk(clk), .temp(temp), .reset(mod_reset));
    visitor_counter vc(.clk(clk), .reset(mod_reset), .ir_sensor1(ir1), .ir_sensor2(ir2),.curr_visitor(count));
    water W (.moisture_sensor(moisture_sensor), .water_sensor(water_sensor), .clk(clk) ,.pump(pump), .sprinkler(sprinkler), .reset(mod_reset));
    window w(.clk(clk), .shatter(wsen),.alarm(walm));
    alarms a(.state(alarms), .clk(clk), .reset(mod_reset), .fire(fire_alarm), .burglar(burglar_alarm), .rain(rain_alarm));

    master m( .alarms(alarms), .lights_on(lights_on), .heat_on(heat_on),
    .cool_on(cool_on), .sprink_on(sprink_on), .pump_on(pump_on), .mod_reset(mod_reset), 
    .occupants_in(occupants_in), .clk(clk), .reset(reset), .door(dalm), .windows(walm), 
    .fire(falm), .rain(ralm), .lights(ext_light), .heat(heat), .cool(cool), .water_sprink(sprinkler), 
    .water_pump(pump), .occupants(count));
    
    initial
    begin
    clk = 0;
    end

    always
    #1 clk = ~clk;

    initial begin
    reset = 1'b 0; ma=1'b0; lock=1'b0; lum=0;fsen=1'b0;man=1'b0;ir=1'b0;ms=1'b0;rsen=1'b0;ir1=1'b0;ir2=1'b0;moisture_sensor=0; water_sensor=0;wsen=1'b0;temp=0;
    #4
    // resetting module
    $display("To show the functionality of master module: All modules in one");
    reset = 1'b 1; 
    #4
    reset = 1'b 0;
    #5
    ma=1'b0; lock=1'b0; lum=90;fsen=1'b0;man=1'b0;ir=1'b1;ms=1'b1;rsen=1'b1;ir1=1'b1;ir2=1'b0;moisture_sensor=8'b 00100000; water_sensor=3;wsen=1'b1;temp=70;
    #10
    $display("time=%5d : Magnetic-sensor: %b , Locked:%b, Window-sensor: %b",$time,ma,lock, wsen);
    $display("time=%5d : Brightness = %d, External lights = %d", $time, lum, ext_light);
    $display("time=%5d : Fire-sensor: %b, Rain-sensor: %b",$time,fsen,rsen);
    $display("time=%5d : Manual:%b Reset:%b Brightness:%b IR-sensor:%b Motion-sensor:%b Internal-lights:%b",$time,man,reset,lum,ir,ms,il);
    $display("time=%5d : Temp = %d, Heat = %b, Cool = %b", $time,temp,heat,cool);
    $display("time=%5d : reset: %b IR-sensor1: %b , IR-sensor2: %b, Visitor_count: %d",$time,reset,ir1,ir2,count);
    $display("time=%5d : Moisture = %d, Water Level = %d, Pump = %b, Sprinkler = %b", $time, moisture_sensor, water_sensor, pump, sprinkler);
    $display("time=%5d : Lights-On: %b Heat:%b Cool:%b Sprink:%b Pump:%b Mod-reset:%b Alarms:%b Occupants-in:%d",$time,lights_on, heat_on, cool_on, sprink_on, pump_on, mod_reset,alarms,occupants_in);
    $display("time=%5d : Burglar alarm: %b, Fire alarm: %b, Rain alarm: %b",$time, burglar_alarm, fire_alarm, rain_alarm);
    $display("-----------------------------------------------------------------------------------------------------------------------");
    ma=1'b0; lock=1'b1;lum=20;fsen=1'b1;man=1'b0;ir=1'b1;ms=1'b0;rsen=1'b0;ir1=1'b0;ir2=1'b1;moisture_sensor=8'b 10100000; water_sensor=1;wsen=1'b0;temp=93;
    #10
    $display("time=%5d : Magnetic-sensor: %b , Locked:%b, Window-sensor: %b",$time,ma,lock, wsen);
    $display("time=%5d : Brightness = %d, External lights = %d", $time, lum, ext_light);
    $display("time=%5d : Fire-sensor: %b, Rain-sensor: %b",$time,fsen,rsen);
    $display("time=%5d : Manual:%b Reset:%b Brightness:%b IR-sensor:%b Motion-sensor:%b Internal-lights:%b",$time,man,reset,lum,ir,ms,il);
    $display("time=%5d : Temp = %d, Heat = %b, Cool = %b", $time,temp,heat,cool);
    $display("time=%5d : reset: %b IR-sensor1: %b , IR-sensor2: %b, Visitor_count: %d",$time,reset,ir1,ir2,count);
    $display("time=%5d : Moisture = %d, Water Level = %d, Pump = %b, Sprinkler = %b", $time, moisture_sensor, water_sensor, pump, sprinkler);
    $display("time=%5d : Lights-On: %b Heat:%b Cool:%b Sprink:%b Pump:%b Mod-reset:%b Alarms:%b Occupants-in:%d",$time,lights_on, heat_on, cool_on, sprink_on, pump_on, mod_reset,alarms,occupants_in);
    $display("time=%5d : Burglar alarm: %b, Fire alarm: %b, Rain alarm: %b",$time, burglar_alarm, fire_alarm, rain_alarm);
    $display("-----------------------------------------------------------------------------------------------------------------------");
    ma=1'b1; lock=1'b0;lum=20;fsen=1'b0;man=1'b0;ir=1'b0;ms=1'b1;rsen=1'b1;ir1=1'b0;ir2=1'b0;moisture_sensor=8'b 00100000; water_sensor=2;wsen=1'b1;temp=60;
    #10
    $display("time=%5d : Magnetic-sensor: %b , Locked:%b, Window-sensor: %b",$time,ma,lock, wsen);
    $display("time=%5d : Brightness = %d, External lights = %d", $time, lum, ext_light);
    $display("time=%5d : Fire-sensor: %b, Rain-sensor: %b",$time,fsen,rsen);
    $display("time=%5d : Manual:%b Reset:%b Brightness:%b IR-sensor:%b Motion-sensor:%b Internal-lights:%b",$time,man,reset,lum,ir,ms,il);
    $display("time=%5d : Temp = %d, Heat = %b, Cool = %b", $time,temp,heat,cool);
    $display("time=%5d : reset: %b IR-sensor1: %b , IR-sensor2: %b, Visitor_count: %d",$time,reset,ir1,ir2,count);
    $display("time=%5d : Moisture = %d, Water Level = %d, Pump = %b, Sprinkler = %b", $time, moisture_sensor, water_sensor, pump, sprinkler);
    $display("time=%5d : Lights-On: %b Heat:%b Cool:%b Sprink:%b Pump:%b Mod-reset:%b Alarms:%b Occupants-in:%d",$time,lights_on, heat_on, cool_on, sprink_on, pump_on, mod_reset,alarms,occupants_in);
    $display("time=%5d : Burglar alarm: %b, Fire alarm: %b, Rain alarm: %b",$time, burglar_alarm, fire_alarm, rain_alarm);
    $display("-----------------------------------------------------------------------------------------------------------------------");
    ma=1'b1; lock=1'b1;lum=90;fsen=1'b1;man=1'b0;ir=1'b0;ms=1'b0;rsen=1'b0;ir1=1'b1;ir2=1'b0;moisture_sensor=8'b 10100000; water_sensor=0;wsen=1'b0;temp=100;
    #10
    $display("time=%5d : Magnetic-sensor: %b , Locked:%b, Window-sensor: %b",$time,ma,lock, wsen);
    $display("time=%5d : Brightness = %d, External lights = %d", $time, lum, ext_light);
    $display("time=%5d : Fire-sensor: %b, Rain-sensor: %b",$time,fsen,rsen);
    $display("time=%5d : Manual:%b Reset:%b Brightness:%b IR-sensor:%b Motion-sensor:%b Internal-lights:%b",$time,man,reset,lum,ir,ms,il);
    $display("time=%5d : Temp = %d, Heat = %b, Cool = %b", $time,temp,heat,cool);
    $display("time=%5d : reset: %b IR-sensor1: %b , IR-sensor2: %b, Visitor_count: %d",$time,reset,ir1,ir2,count);
    $display("time=%5d : Moisture = %d, Water Level = %d, Pump = %b, Sprinkler = %b", $time, moisture_sensor, water_sensor, pump, sprinkler);
    $display("time=%5d : Lights-On: %b Heat:%b Cool:%b Sprink:%b Pump:%b Mod-reset:%b Alarms:%b Occupants-in:%d",$time,lights_on, heat_on, cool_on, sprink_on, pump_on, mod_reset,alarms,occupants_in);
    $display("time=%5d : Burglar alarm: %b, Fire alarm: %b, Rain alarm: %b",$time, burglar_alarm, fire_alarm, rain_alarm);
    $display("-----------------------------------------------------------------------------------------------------------------------");
    ma=1'b0; lock=1'b0; lum=90;fsen=1'b0;man=1'b0;ir=1'b1;ms=1'b1;rsen=1'b1;ir1=1'b0;ir2=1'b1;moisture_sensor=8'b 00100000; water_sensor=3;wsen=1'b1;temp=70;
    #10
    $display("time=%5d : Magnetic-sensor: %b , Locked:%b, Window-sensor: %b",$time,ma,lock, wsen);
    $display("time=%5d : Brightness = %d, External lights = %d", $time, lum, ext_light);
    $display("time=%5d : Fire-sensor: %b, Rain-sensor: %b",$time,fsen,rsen);
    $display("time=%5d : Manual:%b Reset:%b Brightness:%b IR-sensor:%b Motion-sensor:%b Internal-lights:%b",$time,man,reset,lum,ir,ms,il);
    $display("time=%5d : Temp = %d, Heat = %b, Cool = %b", $time,temp,heat,cool);
    $display("time=%5d : reset: %b IR-sensor1: %b , IR-sensor2: %b, Visitor_count: %d",$time,reset,ir1,ir2,count);
    $display("time=%5d : Moisture = %d, Water Level = %d, Pump = %b, Sprinkler = %b", $time, moisture_sensor, water_sensor, pump, sprinkler);
    $display("time=%5d : Lights-On: %b Heat:%b Cool:%b Sprink:%b Pump:%b Mod-reset:%b Alarms:%b Occupants-in:%d",$time,lights_on, heat_on, cool_on, sprink_on, pump_on, mod_reset,alarms,occupants_in);
    $display("time=%5d : Burglar alarm: %b, Fire alarm: %b, Rain alarm: %b",$time, burglar_alarm, fire_alarm, rain_alarm);
    $display("-----------------------------------------------------------------------------------------------------------------------");
    ma=1'b0; lock=1'b1;lum=20;fsen=1'b1;man=1'b0;ir=1'b1;ms=1'b0;rsen=1'b0;ir1=1'b0;ir2=1'b0;moisture_sensor=8'b 10100000; water_sensor=1;wsen=1'b0;temp=93;
    #10
    $display("time=%5d : Magnetic-sensor: %b , Locked:%b, Window-sensor: %b",$time,ma,lock, wsen);
    $display("time=%5d : Brightness = %d, External lights = %d", $time, lum, ext_light);
    $display("time=%5d : Fire-sensor: %b, Rain-sensor: %b",$time,fsen,rsen);
    $display("time=%5d : Manual:%b Reset:%b Brightness:%b IR-sensor:%b Motion-sensor:%b Internal-lights:%b",$time,man,reset,lum,ir,ms,il);
    $display("time=%5d : Temp = %d, Heat = %b, Cool = %b", $time,temp,heat,cool);
    $display("time=%5d : reset: %b IR-sensor1: %b , IR-sensor2: %b, Visitor_count: %d",$time,reset,ir1,ir2,count);
    $display("time=%5d : Moisture = %d, Water Level = %d, Pump = %b, Sprinkler = %b", $time, moisture_sensor, water_sensor, pump, sprinkler);
    $display("time=%5d : Lights-On: %b Heat:%b Cool:%b Sprink:%b Pump:%b Mod-reset:%b Alarms:%b Occupants-in:%d",$time,lights_on, heat_on, cool_on, sprink_on, pump_on, mod_reset,alarms,occupants_in);
    $display("time=%5d : Burglar alarm: %b, Fire alarm: %b, Rain alarm: %b",$time, burglar_alarm, fire_alarm, rain_alarm);
    $display("-----------------------------------------------------------------------------------------------------------------------");
    ma=1'b1; lock=1'b0;lum=20;fsen=1'b0;man=1'b0;ir=1'b0;ms=1'b1;rsen=1'b1;ir1=1'b0;ir2=1'b1;moisture_sensor=8'b 00100000; water_sensor=2;wsen=1'b1;temp=60;
    #10
    $display("time=%5d : Magnetic-sensor: %b , Locked:%b, Window-sensor: %b",$time,ma,lock, wsen);
    $display("time=%5d : Brightness = %d, External lights = %d", $time, lum, ext_light);
    $display("time=%5d : Fire-sensor: %b, Rain-sensor: %b",$time,fsen,rsen);
    $display("time=%5d : Manual:%b Reset:%b Brightness:%b IR-sensor:%b Motion-sensor:%b Internal-lights:%b",$time,man,reset,lum,ir,ms,il);
    $display("time=%5d : Temp = %d, Heat = %b, Cool = %b", $time,temp,heat,cool);
    $display("time=%5d : reset: %b IR-sensor1: %b , IR-sensor2: %b, Visitor_count: %d",$time,reset,ir1,ir2,count);
    $display("time=%5d : Moisture = %d, Water Level = %d, Pump = %b, Sprinkler = %b", $time, moisture_sensor, water_sensor, pump, sprinkler);
    $display("time=%5d : Lights-On: %b Heat:%b Cool:%b Sprink:%b Pump:%b Mod-reset:%b Alarms:%b Occupants-in:%d",$time,lights_on, heat_on, cool_on, sprink_on, pump_on, mod_reset,alarms,occupants_in);
    $display("time=%5d : Burglar alarm: %b, Fire alarm: %b, Rain alarm: %b",$time, burglar_alarm, fire_alarm, rain_alarm);
    $display("-----------------------------------------------------------------------------------------------------------------------");
    ma=1'b1; lock=1'b1;lum=90;fsen=1'b1;man=1'b0;ir=1'b0;ms=1'b0;rsen=1'b0;ir1=1'b1;ir2=1'b0;moisture_sensor=8'b 10100000; water_sensor=0;wsen=1'b0;temp=100;
    #10
    $display("time=%5d : Magnetic-sensor: %b , Locked:%b, Window-sensor: %b",$time,ma,lock, wsen);
    $display("time=%5d : Brightness = %d, External lights = %d", $time, lum, ext_light);
    $display("time=%5d : Fire-sensor: %b, Rain-sensor: %b",$time,fsen,rsen);
    $display("time=%5d : Manual:%b Reset:%b Brightness:%b IR-sensor:%b Motion-sensor:%b Internal-lights:%b",$time,man,reset,lum,ir,ms,il);
    $display("time=%5d : Temp = %d, Heat = %b, Cool = %b", $time,temp,heat,cool);
    $display("time=%5d : reset: %b IR-sensor1: %b , IR-sensor2: %b, Visitor_count: %d",$time,reset,ir1,ir2,count);
    $display("time=%5d : Moisture = %d, Water Level = %d, Pump = %b, Sprinkler = %b", $time, moisture_sensor, water_sensor, pump, sprinkler);
    $display("time=%5d : Lights-On: %b Heat:%b Cool:%b Sprink:%b Pump:%b Mod-reset:%b Alarms:%b Occupants-in:%d",$time,lights_on, heat_on, cool_on, sprink_on, pump_on, mod_reset,alarms,occupants_in);
    $display("time=%5d : Burglar alarm: %b, Fire alarm: %b, Rain alarm: %b",$time, burglar_alarm, fire_alarm, rain_alarm);
    $display("-----------------------------------------------------------------------------------------------------------------------");
    ma=1'b0; lock=1'b0; lum=90;fsen=1'b0;man=1'b0;ir=1'b1;ms=1'b1;rsen=1'b1;ir1=1'b0;ir2=1'b0;moisture_sensor=8'b 00100000; water_sensor=3;wsen=1'b1;temp=70;
    #10
    $display("time=%5d : Magnetic-sensor: %b , Locked:%b, Window-sensor: %b",$time,ma,lock, wsen);
    $display("time=%5d : Brightness = %d, External lights = %d", $time, lum, ext_light);
    $display("time=%5d : Fire-sensor: %b, Rain-sensor: %b",$time,fsen,rsen);
    $display("time=%5d : Manual:%b Reset:%b Brightness:%b IR-sensor:%b Motion-sensor:%b Internal-lights:%b",$time,man,reset,lum,ir,ms,il);
    $display("time=%5d : Temp = %d, Heat = %b, Cool = %b", $time,temp,heat,cool);
    $display("time=%5d : reset: %b IR-sensor1: %b , IR-sensor2: %b, Visitor_count: %d",$time,reset,ir1,ir2,count);
    $display("time=%5d : Moisture = %d, Water Level = %d, Pump = %b, Sprinkler = %b", $time, moisture_sensor, water_sensor, pump, sprinkler);
    $display("time=%5d : Lights-On: %b Heat:%b Cool:%b Sprink:%b Pump:%b Mod-reset:%b Alarms:%b Occupants-in:%d",$time,lights_on, heat_on, cool_on, sprink_on, pump_on, mod_reset,alarms,occupants_in);
    $display("time=%5d : Burglar alarm: %b, Fire alarm: %b, Rain alarm: %b",$time, burglar_alarm, fire_alarm, rain_alarm);
    $display("-----------------------------------------------------------------------------------------------------------------------");
    ma=1'b0; lock=1'b1;lum=20;fsen=1'b1;man=1'b0;ir=1'b1;ms=1'b0;rsen=1'b0;ir1=1'b0;ir2=1'b1;moisture_sensor=8'b 10100000; water_sensor=1;wsen=1'b0;temp=93;
    #10
    $display("time=%5d : Magnetic-sensor: %b , Locked:%b, Window-sensor: %b",$time,ma,lock, wsen);
    $display("time=%5d : Brightness = %d, External lights = %d", $time, lum, ext_light);
    $display("time=%5d : Fire-sensor: %b, Rain-sensor: %b",$time,fsen,rsen);
    $display("time=%5d : Manual:%b Reset:%b Brightness:%b IR-sensor:%b Motion-sensor:%b Internal-lights:%b",$time,man,reset,lum,ir,ms,il);
    $display("time=%5d : Temp = %d, Heat = %b, Cool = %b", $time,temp,heat,cool);
    $display("time=%5d : reset: %b IR-sensor1: %b , IR-sensor2: %b, Visitor_count: %d",$time,reset,ir1,ir2,count);
    $display("time=%5d : Moisture = %d, Water Level = %d, Pump = %b, Sprinkler = %b", $time, moisture_sensor, water_sensor, pump, sprinkler);
    $display("time=%5d : Lights-On: %b Heat:%b Cool:%b Sprink:%b Pump:%b Mod-reset:%b Alarms:%b Occupants-in:%d",$time,lights_on, heat_on, cool_on, sprink_on, pump_on, mod_reset,alarms,occupants_in);
    $display("time=%5d : Burglar alarm: %b, Fire alarm: %b, Rain alarm: %b",$time, burglar_alarm, fire_alarm, rain_alarm);
    $display("-----------------------------------------------------------------------------------------------------------------------");
    ma=1'b1; lock=1'b0;lum=20;fsen=1'b0;man=1'b0;ir=1'b0;ms=1'b1;rsen=1'b1;ir1=1'b1;ir2=1'b0;moisture_sensor=8'b 00100000; water_sensor=2;wsen=1'b1;temp=60;
    #10
    $display("time=%5d : Magnetic-sensor: %b , Locked:%b, Window-sensor: %b",$time,ma,lock, wsen);
    $display("time=%5d : Brightness = %d, External lights = %d", $time, lum, ext_light);
    $display("time=%5d : Fire-sensor: %b, Rain-sensor: %b",$time,fsen,rsen);
    $display("time=%5d : Manual:%b Reset:%b Brightness:%b IR-sensor:%b Motion-sensor:%b Internal-lights:%b",$time,man,reset,lum,ir,ms,il);
    $display("time=%5d : Temp = %d, Heat = %b, Cool = %b", $time,temp,heat,cool);
    $display("time=%5d : reset: %b IR-sensor1: %b , IR-sensor2: %b, Visitor_count: %d",$time,reset,ir1,ir2,count);
    $display("time=%5d : Moisture = %d, Water Level = %d, Pump = %b, Sprinkler = %b", $time, moisture_sensor, water_sensor, pump, sprinkler);
    $display("time=%5d : Lights-On: %b Heat:%b Cool:%b Sprink:%b Pump:%b Mod-reset:%b Alarms:%b Occupants-in:%d",$time,lights_on, heat_on, cool_on, sprink_on, pump_on, mod_reset,alarms,occupants_in);
    $display("time=%5d : Burglar alarm: %b, Fire alarm: %b, Rain alarm: %b",$time, burglar_alarm, fire_alarm, rain_alarm);
    $display("-----------------------------------------------------------------------------------------------------------------------");
    ma=1'b1; lock=1'b1;lum=90;fsen=1'b1;man=1'b0;ir=1'b0;ms=1'b0;rsen=1'b0;ir1=1'b0;ir2=1'b0;moisture_sensor=8'b 10100000; water_sensor=0;wsen=1'b0;temp=100;
    #10
    $display("time=%5d : Magnetic-sensor: %b , Locked:%b, Window-sensor: %b",$time,ma,lock, wsen);
    $display("time=%5d : Brightness = %d, External lights = %d", $time, lum, ext_light);
    $display("time=%5d : Fire-sensor: %b, Rain-sensor: %b",$time,fsen,rsen);
    $display("time=%5d : Manual:%b Reset:%b Brightness:%b IR-sensor:%b Motion-sensor:%b Internal-lights:%b",$time,man,reset,lum,ir,ms,il);
    $display("time=%5d : Temp = %d, Heat = %b, Cool = %b", $time,temp,heat,cool);
    $display("time=%5d : reset: %b IR-sensor1: %b , IR-sensor2: %b, Visitor_count: %d",$time,reset,ir1,ir2,count);
    $display("time=%5d : Moisture = %d, Water Level = %d, Pump = %b, Sprinkler = %b", $time, moisture_sensor, water_sensor, pump, sprinkler);
    $display("time=%5d : Lights-On: %b Heat:%b Cool:%b Sprink:%b Pump:%b Mod-reset:%b Alarms:%b Occupants-in:%d",$time,lights_on, heat_on, cool_on, sprink_on, pump_on, mod_reset,alarms,occupants_in);
    $display("time=%5d : Burglar alarm: %b, Fire alarm: %b, Rain alarm: %b",$time, burglar_alarm, fire_alarm, rain_alarm);
    $display("-----------------------------------------------------------------------------------------------------------------------");
    end


    initial #1000 $finish;

    initial
    begin
    $dumpfile("test1.vcd");
    $dumpvars;
    end
endmodule