`include "../Smart_home_automation.v"

module window_tb;
    reg clk;
    reg wsen;
    wire walm;

    window w(.clk(clk), .shatter(wsen),.alarm(walm));

    initial
    begin
    clk = 0;
    end

    always
    #1 clk = ~clk;

    initial
    begin

    #5 
    $display("To show the functionality of window module");
    #10
    wsen=1'b0;
    #10
    $display("time=%4d: Window-sensor: %b , Window-alaram: %b",$time,wsen,walm);
    wsen=1'b1;
    #10
    $display("time=%4d: Window-sensor: %b , Window-alaram: %b",$time,wsen,walm);
    wsen=1'b1;
    #10
    $display("time=%4d: Window-sensor: %b , Window-alaram: %b",$time,wsen,walm);
    wsen=1'b0;
    #10
    $display("time=%4d: Window-sensor: %b , Window-alaram: %b",$time,wsen,walm);
    wsen=1'b0;
    end
    
    initial #1000 $finish;

    initial
    begin
    $dumpfile("test1.vcd");
    $dumpvars;
    end

endmodule