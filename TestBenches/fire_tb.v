`include "../Smart_home_automation.v"

module fire_tb;
    reg clk;
    reg s;
    wire a;

    fire f(.clk(clk), .f_sensor(s),.f_alarm(a));

    initial
    begin
    clk = 0;
    end

    always
    #1 clk = ~clk;

    initial
    begin

    #5 
    $display("To show the functionality of fire module");
    #10
    s=1'b0;
    #10
    $display("time=%4d: Fire-sensor: %b , Fire-alaram: %b",$time,s,a);
    s=1'b1;
    #10
    $display("time=%4d: Fire-sensor: %b , Fire-alaram: %b",$time,s,a);
    s=1'b1;
    #10
    $display("time=%4d: Fire-sensor: %b , Fire-alaram: %b",$time,s,a);
    s=1'b0;
    #10
    $display("time=%4d: Fire-sensor: %b , Fire-alaram: %b",$time,s,a);
    s=1'b0;
    end

    initial #1000 $finish;

    initial
    begin
    $dumpfile("test1.vcd");
    $dumpvars;
    end

endmodule