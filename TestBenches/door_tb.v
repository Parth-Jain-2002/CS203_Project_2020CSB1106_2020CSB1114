`include "../Smart_home_automation.v"

module door_tb;
reg clk, ma, lock;
wire dalm;

door d(.clk(clk), .magnetic_sensor(ma), .alarm(dalm), .locked(lock));

initial
begin
clk = 0;
end

always
#1 clk = ~clk;

initial
begin

#5 
$display("To show the functionality of door module");
#10
ma=1'b0;lock=1'b0;
#10
$display("time=%d: Magnetic-sensor: %b , Locked:%b , Door-alaram: %b",$time,ma,lock,dalm);
ma=1'b0;lock=1'b1;
#10
$display("time=%d: Magnetic-sensor: %b , Locked:%b , Door-alaram: %b",$time,ma,lock,dalm);
ma=1'b1;lock=1'b0;
#10
$display("time=%d: Magnetic-sensor: %b , Locked:%b , Door-alaram: %b",$time,ma,lock,dalm);
ma=1'b1;lock=1'b1;
#10
$display("time=%d: Magnetic-sensor: %b , Locked:%b , Door-alaram: %b",$time,ma,lock,dalm);
end

initial
begin
$dumpfile("test1.vcd");
$dumpvars;
end

endmodule