// Primary Module

module master ( alarms, lights_on, heat_on, cool_on, sprink_on, pump_on, mod_reset, occupants_in,
                clk, reset, door, windows, fire, rain, lights, heat, cool, water_sprink, water_pump, occupants);
    input clk, reset, door, windows, fire, rain, lights, heat, cool, water_sprink, water_pump;
    input [7:0] occupants;
    output reg [7:0] occupants_in;
    output reg [2:0]alarms;
    output reg lights_on, heat_on, cool_on, sprink_on, pump_on, mod_reset;

    always @(posedge clk or posedge reset)begin
        if (reset == 1'b1)begin
            lights_on = 1'b 0;
            heat_on = 1'b 0;
            cool_on = 1'b 0;
            sprink_on = 1'b 0;
            pump_on = 1'b 0;
            alarms = 3'b 000;
            mod_reset = 1'b 1;
            #10
            mod_reset = 1'b 0;
        end

        else begin
            alarms = {fire, door|windows, rain};
            lights_on = lights;
            heat_on = heat;
            cool_on = cool;
            occupants_in = occupants;
            pump_on = water_pump;
            sprink_on = water_sprink;
        end
    end

endmodule

// Secondary Modules
/*      SAFETY      */

module door(clk, magnetic_sensor, alarm, locked);
    input magnetic_sensor, locked, clk;
    output reg alarm;
    // Magnetic Sensor: 1 for closed door and 0 for open door
    always @(posedge clk) begin
        if((magnetic_sensor == 1'b 0) && (locked == 1'b 1))
            alarm = 1'b 1;
        else
            alarm = 1'b 0;
    end
endmodule

module fire(clk, f_sensor,f_alarm);
    input f_sensor, clk;
    output reg f_alarm;
    always @(posedge clk)
        f_alarm = f_sensor;
endmodule

module rain(clk, rain_sensor,rain_alarm);
    input clk, rain_sensor;
    output reg rain_alarm;
    always @(posedge clk) begin
        rain_alarm = rain_sensor;
    end
endmodule

module window (clk, alarm, shatter);
    input clk, shatter;
    output reg alarm;
    always @(posedge clk)begin
        alarm = shatter;
    end
endmodule

module alarms(state, clk, fire, burglar, rain);
    input [2:0] state;
    input clk;

    output reg fire, burglar, rain;

    always @(posedge clk) begin
        if (state[2] ==1'b1) fire = 1'b1;
        if (state[1] ==1'b1) burglar = 1'b1;
        if (state[0] ==1'b1) rain = 1'b1;
    end
endmodule
 
/**************************/

/*            COMFORT/UTILITY             */
module visitor_counter(clk, reset, ir_sensor1, ir_sensor2,curr_visitor);
    input clk, reset, ir_sensor1,ir_sensor2;

    output reg [7:0] curr_visitor;
    
    reg [1:0] state;
    always @(posedge clk or posedge reset) begin
        if (reset == 1) begin
            state = 2'b00;
            curr_visitor = 0;
        end
        else begin
            if (state == 2'b11)
                if (ir_sensor1 == 1'b0 && ir_sensor2 == 1'b0) state = 2'b00;
            else if (state == 2'b00)begin
                if (ir_sensor1 == 1'b1 && ir_sensor2 == 1'b0) state = 2'b10;
                if (ir_sensor1 == 1'b0 && ir_sensor2 == 1'b1) state = 2'b01;
            end
            else if (state == 2'b10)begin
                if (ir_sensor1 == 1'b0 && ir_sensor2 == 1'b1) begin
                    state = 2'b11; 
                    curr_visitor = curr_visitor+1;
                end
                else state = state;
            end
            else if (state == 2'b01)begin
                if (ir_sensor1 == 1'b1 && ir_sensor2 == 1'b0) begin
                    state = 2'b11; 
                    curr_visitor = curr_visitor - 1;
                end
                else state = state;
            end
        end
    end
endmodule

module ext_lights(clk, lum_sen, ext_light, reset);
    input [7:0] lum_sen;
    input clk, reset;

    output reg ext_light;
    
    always @(posedge clk or posedge reset) begin
        if (reset == 1'b1) ext_light = 1'b0;
        else begin
            if(lum_sen<8'b01000000)
                ext_light = 1'b1;
            else
                ext_light = 1'b0;
        end
    end
endmodule

module light_control(int_light, lum_sen, clk, reset, motion_sen, ir_sen, manual);
    input [7:0] lum_sen;
    input clk, motion_sen, ir_sen, manual, reset;

    output reg int_light;

    always @(posedge clk or posedge reset)begin
        if (reset == 1'b1 )int_light = 1'b 0;
        else begin
            if (manual == 0 && lum_sen < 8'b00010000 ) begin
                if(ir_sen == 1'b1 || motion_sen == 1'b1)begin
                    if(motion_sen == 1'b1)
                        int_light = 1'b1;
                    else
                        int_light = 1'b0;
                end
                else
                    int_light = int_light;
            end
            else int_light = int_light;
        end
    end
endmodule

module temp_control (heat, cool, clk, temp, reset);
    input [7:0] temp;
    input clk, reset;
   
    output reg heat, cool;
   
    always @(posedge clk or posedge reset) begin
        if (reset == 1'b1)begin
            heat = 1'b0;
            cool = 1'b0;
        end
        else begin
            if(temp< 65) begin
                heat = 1'b1;
                cool = 1'b0;
            end
            else if(temp> 90) begin
                heat = 1'b0;
                cool = 1'b1;
            end
            else begin
                heat = 1'b0;
                cool = 1'b0;
            end
        end
    end
endmodule
/***********************/

module water(moisture_sensor, water_sensor, clk ,pump, sprinkler, reset);
    input [7:0] moisture_sensor;
    input [1:0] water_sensor;
    input clk, reset;
   
    output reg pump, sprinkler;
   
    always @(posedge clk or posedge reset) begin
        if (reset == 1'b1)begin
            pump = 1'b0;
            sprinkler = 1'b0;
        end
        else begin
            if(water_sensor == 2'b11)
                pump = 1'b0;
            else
                pump =1'b1;
            
            if (water_sensor >= 2'b 10)begin
                if (moisture_sensor < 8'b01000000)
                    sprinkler = 1'b1;
                else if (moisture_sensor > 8'b10000000)
                    sprinkler = 1'b0;
            else sprinkler = 1'b0;
            end 
        end
    end
endmodule

/************************/
