// Primary Module
module primary_module(d_alarm,f_alarm,curr_count,light_out, soil_sprinkler, rain_alarm,water_out,
heat, cool, l_out,w_alarm,blinds, clk,reset,magnetic_sensor, locked,f_sensor,door_ir_sensor1,door_ir_sensor2,
rain_sensor, water_sensor,lum_sen,moisture_sensor,temp, r_motion_sen, r_ir_sen, manual, shatter);

    input clk, reset, magnetic_sensor, locked,f_sensor,door_ir_sensor1,door_ir_sensor2,rain_sensor;
    input [1:0] water_sensor;
    input [3:0] r_motion_sen, r_ir_sen, manual, shatter;
    input [7:0] lum_sen,moisture_sensor,temp;
    output d_alarm,f_alarm,curr_count,light_out,soil_sprinkler,rain_alarm,water_out,heat,cool;
    output [3:0] l_out,w_alarm;
    output [7:0] blinds;
    reg pre_count;
    reg [3:0] light_state;
    pre_count=0;
    light_state=4'b0000;

    always @(posedge Clk) begin
        
    end
endmodule

module burglar_alarm(magnetic_sensor,alarm, locked);
    input magnetic_sensor, locked;
    output alarm;
    // Magnetic Sensor: 1 for closed door and 0 for open door
    if(magnetic_sensor == 1'b0 && locked == 1'b1)
        alarm=1'b1;
    else
        alarm=1'b0;
endmodule

module fire(f_sensor,f_alarm);
    input f_sensor;
    output f_alarm;
    f_alarm=f_sensor;
endmodule

module visitor_counter(ir_sensor1,ir_sensor2,pre_visitor,curr_visitor);
    input ir_sensor1,ir_sensor2,previous_vis;
    output curr_visitor;
    if(ir_sensor1 == 1'b1 && ir_sensor2 == 1'b0)
        curr_visitor=pre_visitor+1;
    else if(ir_sensor1 == 1'b1 && ir_sensor2 == 1'b0)
        curr_visitor=pre_visitor-1;
    else
        curr_visitor=pre_visitor;
endmodule

module lum_out(lum_sen,out);
    input [7:0] lum_sen;
    output out;
    // Less than 64
    if(lum_sen<8'b01000000)
       out = 1'b1;
    else
       out = 1'b0;
endmodule

module soil(moisture_sensor,soil_sprinkler, water_sensor);
    input [7:0] moisture_sensor;
    input [1:0] water_sensor;
    output soil_sprinkler;
    if (water_sensor > 2'b 10){
        if (moisture_sensor < 8'b01000000)
            soil_sprinkler = 1'b1;
        else if (moisture_sensor > 8'b10000000)
            soil_sprinkler = 1'b0;
        else soil_sprinkler = 1'b0;
    }
endmodule

module rain(rain_sensor,rain_alarm);
    input rain_sensor;
    output rain_alarm;
    rain_alarm = rain_sensor;
endmodule

module water(water_sensor,out);
    input [1:0] water_sensor;
    output out;
    if(water==2'b11)
        out=1'b0;
    else
        out=1'b1;
endmodule

module temp_control (temp, heat, cool);
    input [7:0] temp;
    output heat, cool;
    if(temp> 8'b10111111) begin
       heat=1'b0;
       cool=1'b1;
    end
    else if(temp> 8'b00111111) begin
       heat=1'b1;
       cool=1'b0;
    end
    else begin
       heat=1'b0;
       cool=1'b0;
    end
endmodule

module light_control(out, lux, motion_sen, ir_sen, manual,prev_state);
    input [7:0] lux;
    input motion_sen, ir_sen, manual,prev_state;
    output out;
    // Manual has to be seen
    if (manual == 0 && lux < 8'b00010000 ) begin
       if(ir_sen == 1'b1)begin
           if(motion_sen == 1'b1)
                out=1'b1;
            else
                out=1'b0;
       end
       else
            out=prev_state;
    } 
    end
    else out = prev_state;
endmodule

module window (alarm, blinds, shatter, lux);
    input [7:0] lux;
    input shatter;
    output [1:0] blinds;
    output alarm;
    if(lux<8'b00111111) 
        blinds=2'b00;
    else if(lux>=8'b00111111 && lux<8'b01111111) 
        blinds=2'b01;
    else if(lux>=8'b01111111 && lux<8'b10111111) 
        blinds=2'b10;
    else 
        blinds=2'b11;

    alarm=shatter;
endmodule