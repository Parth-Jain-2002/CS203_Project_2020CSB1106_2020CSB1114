`include "../Smart_home_automation.v"
module visitor_counter_tb;
    reg clk;
    reg reset,ir1,ir2;
    wire [7:0] count;

    visitor_counter vc(.clk(clk), .reset(reset), .ir_sensor1(ir1), .ir_sensor2(ir2),.curr_visitor(count));

    initial
    begin
    clk = 0;
    end

    always
    #1 clk = ~clk;

    initial
    begin

    #5 reset=1'b1;
    $display("To show the functionality of visitor module");
    #10 reset=1'b0;
    ir1=1'b0; ir2=1'b0;
    #10
    ir1=1'b1; ir2=1'b0;
    #10
    $display("time=%4d: reset: %b IR-sensor1: %b , IR-sensor2: %b, Visitor_count: %d",$time,reset,ir1,ir2,count);
    ir1=1'b0; ir2=1'b1;
    #10
    $display("time=%4d: reset: %b IR-sensor1: %b , IR-sensor2: %b, Visitor_count: %d",$time,reset,ir1,ir2,count);
    ir1=1'b0; ir2=1'b0;
    #10
    ir1=1'b1; ir2=1'b0;
    #10
    $display("time=%4d: reset: %b IR-sensor1: %b , IR-sensor2: %b, Visitor_count: %d",$time,reset,ir1,ir2,count);
    ir1=1'b0; ir2=1'b1;
    #10
    $display("time=%4d: reset: %b IR-sensor1: %b , IR-sensor2: %b, Visitor_count: %d",$time,reset,ir1,ir2,count);
    ir1=1'b0; ir2=1'b0;
    #10
    ir1=1'b1; ir2=1'b0;
    #10
    $display("time=%4d: reset: %b IR-sensor1: %b , IR-sensor2: %b, Visitor_count: %d",$time,reset,ir1,ir2,count);
    ir1=1'b0; ir2=1'b1;
    #10
    $display("time=%4d: reset: %b IR-sensor1: %b , IR-sensor2: %b, Visitor_count: %d",$time,reset,ir1,ir2,count);
    ir1=1'b0; ir2=1'b0;
    #10
    ir1=1'b1; ir2=1'b0;
    #10
    $display("time=%4d: reset: %b IR-sensor1: %b , IR-sensor2: %b, Visitor_count: %d",$time,reset,ir1,ir2,count);
    ir1=1'b0; ir2=1'b1;
    #10
    $display("time=%4d: reset: %b IR-sensor1: %b , IR-sensor2: %b, Visitor_count: %d",$time,reset,ir1,ir2,count);
    ir1=1'b0; ir2=1'b0;
    #10
    ir1=1'b0; ir2=1'b1;
    #10
    $display("time=%4d: reset: %b IR-sensor1: %b , IR-sensor2: %b, Visitor_count: %d",$time,reset,ir1,ir2,count);
    ir1=1'b1; ir2=1'b0;
    #10
    $display("time=%4d: reset: %b IR-sensor1: %b , IR-sensor2: %b, Visitor_count: %d",$time,reset,ir1,ir2,count);
    ir1=1'b0; ir2=1'b0;
    end

    initial #1000 $finish;

    initial
    begin
    $dumpfile("test1.vcd");
    $dumpvars;
    end

endmodule