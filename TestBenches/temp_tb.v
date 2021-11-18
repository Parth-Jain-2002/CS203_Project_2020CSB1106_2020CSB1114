`include "../Smart_home_automation.v"

module WATER_TB ();
    reg [7:0] Temp;
    wire Heat, Cool;
    reg Reset, CLK;
    
    temp_control T (Heat, Cool, CLK, Temp, Reset);

    initial begin
        CLK = 1'b 0; 
        Reset = 1'b 0; 
        #4
        // resetting module
        
        Reset = 1'b 1; 
        #4
        Reset = 1'b 0;
        #5
        Temp = 70;
        #5
        $display ("time = %4d, Temp = %d, Heat = %b, Cool = %b", $time, Temp, Heat, Cool);
        
        Temp = 93;
        #5
        $display ("time = %4d, Temp = %d, Heat = %b, Cool = %b", $time, Temp, Heat, Cool);

        Temp = 60;
        #5
        $display ("time = %4d, Temp = %d, Heat = %b, Cool = %b", $time, Temp, Heat, Cool);

    end

    always #2 CLK = ~CLK;

    initial #1000 $finish;
    
    initial begin
        $dumpfile("temp.vcd");
        $dumpvars;
    end 
endmodule