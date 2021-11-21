`include "../Smart_home_automation.v"

module alarms_tb;
    reg clk, reset;
    reg [2:0]state;
    wire fire, rain, burglar;

    alarms A (.state(state), .clk(clk), .reset(reset), .fire(fire), .burglar(burglar), rain);

    initial
    begin
    clk = 0;
    end

    always
    #1 clk = ~clk;

    initial
    begin
    #5 reset=1'b1;
    $display("To show the functionality of alarms module");
    #5 reset=1'b0;
    #10
    state=3'b000;
    #10
    $display("time=%4d: Alarm-states: %3b , Fire-Alarm: %b , Burglar-Alarm: %b , Rain-Alarm: %b",$time,state,fire,burglar,rain);
    #5 reset=1'b1;
    #5 reset=1'b0;
    state=3'b001;
    #10
    $display("time=%4d: Alarm-states: %3b , Fire-Alarm: %b , Burglar-Alarm: %b , Rain-Alarm: %b",$time,state,fire,burglar,rain);
    #5 reset=1'b1;
    #5 reset=1'b0;
    state=3'b010;
    #10
    $display("time=%4d: Alarm-states: %3b , Fire-Alarm: %b , Burglar-Alarm: %b , Rain-Alarm: %b",$time,state,fire,burglar,rain);
    #5 reset=1'b1;
    #5 reset=1'b0;
    state=3'b100;
    #10
    $display("time=%4d: Alarm-states: %3b , Fire-Alarm: %b , Burglar-Alarm: %b , Rain-Alarm: %b",$time,state,fire,burglar,rain);
    #5 reset=1'b1;
    #5 reset=1'b0;
    state=3'b110;
    #10
    $display("time=%4d: Alarm-states: %3b , Fire-Alarm: %b , Burglar-Alarm: %b , Rain-Alarm: %b",$time,state,fire,burglar,rain);
    
    end
    
    initial #1000 $finish;

    initial
    begin
    $dumpfile("test1.vcd");
    $dumpvars;
    end

endmodule