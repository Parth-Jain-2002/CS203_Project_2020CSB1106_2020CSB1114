`include "../Smart_home_automation.v"

module light_control_tb;
    reg clk,reset,ms,ir,man;
    reg [7:0] lum;
    wire il;

    light_control lc(.int_light(il), .lum_sen(lum), .clk(clk), .reset(reset), .motion_sen(ms), .ir_sen(ir), .manual(man));

    initial
    begin
    clk = 0;
    end

    always
    #1 clk = ~clk;

    initial
    begin

    #5 reset=1'b1;man=1'b0;
    $display("To show the functionality of light control module");
    #10 reset=1'b0;
    lum=8'b10000000; ir=1'b0 ; ms=1'b0;
    #10
    $display("time=%4d: Manual:%b Reset:%b Brightness:%b IR-sensor:%b Motion-sensor:%b Internal-lights:%b",$time,man,reset,lum,ir,ms,il);
    lum=8'b00001000; ir=1'b0 ; ms=1'b0;
    #10
    $display("time=%4d: Manual:%b Reset:%b Brightness:%b IR-sensor:%b Motion-sensor:%b Internal-lights:%b",$time,man,reset,lum,ir,ms,il);
    lum=8'b00001000; ir=1'b1 ; ms=1'b1;
    #10
    $display("time=%4d: Manual:%b Reset:%b Brightness:%b IR-sensor:%b Motion-sensor:%b Internal-lights:%b",$time,man,reset,lum,ir,ms,il);
    lum=8'b00001000; ir=1'b1 ; ms=1'b0;
    #10
    $display("time=%4d: Manual:%b Reset:%b Brightness:%b IR-sensor:%b Motion-sensor:%b Internal-lights:%b",$time,man,reset,lum,ir,ms,il);
    lum=8'b10000000; ir=1'b1 ; ms=1'b1;
    #10
    $display("time=%4d: Manual:%b Reset:%b Brightness:%b IR-sensor:%b Motion-sensor:%b Internal-lights:%b",$time,man,reset,lum,ir,ms,il);
    lum=8'b0000001; ir=1'b0 ; ms=1'b1;
    #10
    $display("time=%4d: Manual:%b Reset:%b Brightness:%b IR-sensor:%b Motion-sensor:%b Internal-lights:%b",$time,man,reset,lum,ir,ms,il);
    lum=8'b00001000; ir=1'b0 ; ms=1'b0;
    #10
    $display("time=%4d: Manual:%b Reset:%b Brightness:%b IR-sensor:%b Motion-sensor:%b Internal-lights:%b",$time,man,reset,lum,ir,ms,il);
    lum=8'b10000000; ir=1'b1 ; ms=1'b1;
    #10
    $display("time=%4d: Manual:%b Reset:%b Brightness:%b IR-sensor:%b Motion-sensor:%b Internal-lights:%b",$time,man,reset,lum,ir,ms,il);
    end

    initial #1000 $finish;

    initial
    begin
    $dumpfile("test1.vcd");
    $dumpvars;
    end

endmodule