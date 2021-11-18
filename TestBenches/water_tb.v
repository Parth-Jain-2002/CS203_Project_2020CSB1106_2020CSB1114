`include "../Smart_home_automation.v"

module WATER_TB ();
    reg [7:0] Moisture_sensor;
    reg [1:0] Water_sensor;
    wire Pump, Sprinkler;
    reg Reset, CLK;
    
    water W (Moisture_sensor, Water_sensor, CLK ,Pump, Sprinkler, Reset);

    initial begin
        CLK = 1'b 0; 
        Reset = 1'b 0; 
        #4
        // resetting module
        
        Reset = 1'b 1; 
        #4
        Reset = 1'b 0;
        #5
        Moisture_sensor = 8'b 00100000;
        Water_sensor = 2'b 10;
        #5
        $display ("time = %4d, Moisture = %d, Water Level = %d, Pump = %b, Sprinkler = %b", $time, Moisture_sensor, Water_sensor, Pump, Sprinkler);

        Moisture_sensor = 8'b 10100000;
        Water_sensor = 2'b 10;
        #5
        $display ("time = %4d, Moisture = %d, Water Level = %d, Pump = %b, Sprinkler = %b", $time, Moisture_sensor, Water_sensor, Pump, Sprinkler);
        
        Moisture_sensor = 8'b 00100000;
        Water_sensor = 2'b 01;
        #5
        $display ("time = %4d, Moisture = %d, Water Level = %d, Pump = %b, Sprinkler = %b", $time, Moisture_sensor, Water_sensor, Pump, Sprinkler);

        Moisture_sensor = 8'b 10100000;
        Water_sensor = 2'b 11;
        #5
        $display ("time = %4d, Moisture = %d, Water Level = %d, Pump = %b, Sprinkler = %b", $time, Moisture_sensor, Water_sensor, Pump, Sprinkler);
    end

    always #2 CLK = ~CLK;

    initial #1000 $finish;
    
    initial begin
        $dumpfile("water.vcd");
        $dumpvars;
    end 
endmodule