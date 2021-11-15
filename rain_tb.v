module rain_tb;
reg clk;
reg rsen;
wire ralm;

rain r(.clk(clk), .rain_sensor(rsen),.rain_alarm(ralm));

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
rsen=1'b0;
#10
$display("time=%d: Rain-sensor: %b , Rain-alaram: %b",$time,rsen,ralm);
rsen=1'b1;
#10
$display("time=%d: Rain-sensor: %b , Rain-alaram: %b",$time,rsen,ralm);
rsen=1'b1;
#10
$display("time=%d: Rain-sensor: %b , Rain-alaram: %b",$time,rsen,ralm);
rsen=1'b0;
#10
$display("time=%d: Rain-sensor: %b , Rain-alaram: %b",$time,rsen,ralm);
rsen=1'b0;
end

initial
begin
$dumpfile("test1.vcd");
$dumpvars;
end

endmodule