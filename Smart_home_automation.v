// Primary Module
module primary_module(clk,reset,);
    
endmodule

module burglar_alarm(magnetic_sensor,alarm, locked);
    input magnetic_sensor, locked;
    output alarm;
    
endmodule

module fire(f_sensor,f_alarm);
    input f_sensor;
    output f_alarm;

endmodule

module visitor_counter(ir_sensor1,ir_sensor2,visitor);
    input ir_sensor1,ir_sensor2;
    output visitor;
    
endmodule

module lum_out(lum_sen,out);
    input [7:0] lum_sen;
    output out;
endmodule

module soil(moisture_sensor,soil_sprinkler);
    input [7:0] moisture_sensor;
    output soil_sprinkler;

endmodule

module rain(rain_sensor,rain_alarm);
    input rain_sensor;
    output rain_alarm;
endmodule

module water(water_sensor,out);
    input [1:0] water_sensor;
    output out;
    
endmodule

module light_control(out, lux, motion_sen, ir_sen, manual);
    input [7:0] lux;
    input motion_sen, ir_sen, manual, clk;
    output out;

endmodule

module window (alarm, blinds, shatter, lux);
    input [7:0] lux;
    input shatter;
    output [1:0] blinds;
    output alarm;
endmodule

module temp_control (heat, cool, temp);
    input [7:0] temp;
    output heat, cool;
endmodule

