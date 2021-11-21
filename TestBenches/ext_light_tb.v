`include "../Smart_home_automation.v"

module WATER_TB ();
    reg [7:0] Lum_sen;
    wire Ext_light;
    reg Reset, CLK;
    
    ext_lights E (CLK, Lum_sen, Ext_light, Reset);

    initial begin
        CLK = 1'b 0; 
        Reset = 1'b 0; 
        #4
        // resetting module
        $display("To show the functionality of external lights module");
        Reset = 1'b 1; 
        #4
        Reset = 1'b 0;
        #5
        Lum_sen = 90;
        #5
        $display ("time = %4d, Brightness = %d, External lights = %d", $time, Lum_sen, Ext_light);
        
        Lum_sen = 20;
        #5
        $display ("time = %4d, Brightness = %d, External lights = %d", $time, Lum_sen, Ext_light);

        Lum_sen = 90;
        #5
        $display ("time = %4d, Brightness = %d, External lights = %d", $time, Lum_sen, Ext_light);
    end

    always #2 CLK = ~CLK;

    initial #1000 $finish;
    
    initial begin
        $dumpfile("ext_lights.vcd");
        $dumpvars;
    end 
endmodule