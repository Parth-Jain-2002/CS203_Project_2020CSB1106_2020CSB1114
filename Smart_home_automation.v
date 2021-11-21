// Primary Module

module master ( alarms, lights_on, heat_on, cool_on, sprink_on, pump_on, mod_reset, occupants_in,
                clk, reset, door, windows, fire, rain, lights, heat, cool, water_sprink, water_pump, occupants);
    input clk, reset, door, windows, fire, rain, lights, heat, cool, water_sprink, water_pump;
    input [7:0] occupants;
    output reg [7:0] occupants_in;
    output reg [2:0]alarms;
    output reg lights_on, heat_on, cool_on, sprink_on, pump_on, mod_reset;

    always @(posedge clk or posedge reset)begin // For resetting the main module and all attached modules
        if (reset == 1'b1)begin
            lights_on = 1'b 0;  // Setting all vaues to 0
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
            alarms = {fire, door|windows, rain};    // input for the alarms module
            lights_on = lights; // Storing the state of lights
            heat_on = heat; // Storing heater state
            cool_on = cool; // Storing cooler state
            occupants_in = occupants;   // Stores the number of occupants
            pump_on = water_pump;   // Water pump state
            sprink_on = water_sprink;   // Sprinkler state
        end
    end

endmodule

// Secondary Modules
/*      SAFETY      */

module door(clk, magnetic_sensor, alarm, locked);
    input magnetic_sensor, locked, clk;
    output reg alarm;
    // Magnetic Sensor: 1 for closed door and 0 for open door
    // Locked: stores the state of the lock 1 for locked 0 for unlicked
    always @(posedge clk) begin
        if((magnetic_sensor == 1'b 0) && (locked == 1'b 1)) // in case the door is open and the state is locked
            alarm = 1'b 1;  // indicates forced entry
        else
            alarm = 1'b 0;
    end
endmodule

module fire(clk, f_sensor,f_alarm);
    input f_sensor, clk;
    // Fire sensor: 1 in case of fire
    output reg f_alarm;
    always @(posedge clk)
        f_alarm = f_sensor;
endmodule

module rain(clk, rain_sensor,rain_alarm);
    input clk, rain_sensor;
    //Rain sensor: 1 in case of rain
    output reg rain_alarm;
    always @(posedge clk) begin
        rain_alarm = rain_sensor;
    end
endmodule

module window (clk, alarm, shatter);
    input clk, shatter;
    // Shatter detection: 1 in case the window is shattered (indicates fored entry)
    output reg alarm;
    always @(posedge clk) begin
        alarm = shatter;
    end
endmodule

module alarms(state, clk, reset, fire, burglar, rain);
    input [2:0] state;  // the state of fire rain and burglar alarms is taken as input
    input clk, reset;
    // Combines output from all above modules to ring the correct alarms

    output reg fire, burglar, rain;

    always @(posedge clk or posedge reset) begin
        if (reset == 1) begin
            fire = 1'b0;
            burglar = 1'b0;
            rain = 1'b0;
        end
        else begin
            fire = state[2];
            burglar = state[1];
            rain = state[0];
        end
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
            if (state == 2'b00)begin
                if (ir_sensor1 == 1'b1 && ir_sensor2 == 1'b0) state = 2'b10;
                if (ir_sensor1 == 1'b0 && ir_sensor2 == 1'b1) state = 2'b01;
            end
            if (state == 2'b10)begin    // When 2nd ir sensor is crossed
                if (ir_sensor1 == 1'b0 && ir_sensor2 == 1'b1) begin // If first one already crossed
                    state = 2'b11; 
                    curr_visitor = curr_visitor+1; // increase occupant count
                end
                else state = state; // do nothing
            end
            if (state == 2'b01)begin    // When 1st ir sensor is crossed
                if (ir_sensor1 == 1'b1 && ir_sensor2 == 1'b0) begin // If second was already crossed
                    state = 2'b11; 
                    curr_visitor = curr_visitor - 1; // decrease visitor count
                end
                else state = state; // do nothing
            end
        end
    end
endmodule

module ext_lights(clk, lum_sen, ext_light, reset);
    input [7:0] lum_sen;
    // senses the brightness outside
    input clk, reset;

    output reg ext_light;
    
    always @(posedge clk or posedge reset) begin
        if (reset == 1'b1) ext_light = 1'b0;
        else begin 
            if(lum_sen<8'b01000000) // Turns the lights on in case outside lights are low
                ext_light = 1'b1;
            else
                ext_light = 1'b0;
        end
    end
endmodule

module light_control(int_light, lum_sen, clk, reset, motion_sen, ir_sen, manual);
    input [7:0] lum_sen;
    input clk, motion_sen, ir_sen, manual, reset;
    // ir and motion sensor to judge if someone is in the room
    // manual override
    output reg int_light;

    always @(posedge clk or posedge reset)begin
        if (reset == 1'b1 )int_light = 1'b 0;
        else begin
            if (manual == 0 && lum_sen < 8'b00010000 ) begin // If someone is in the room or someone enters the room
                if(ir_sen == 1'b1 || motion_sen == 1'b1)begin
                    if(motion_sen == 1'b1)
                        int_light = 1'b1;
                    else
                        int_light = 1'b0;   // In case no motion in the room
                end
                else
                    int_light = int_light;
            end
            else int_light = int_light; // Incase manual is engaged
        end
    end
endmodule

module temp_control (heat, cool, clk, temp, reset);
    input [7:0] temp;
    // temperature sensor
    input clk, reset;
   
    output reg heat, cool;
    // heat: 1 when heater is on
    // cool: 1 when cooler is on
   
    always @(posedge clk or posedge reset) begin
        if (reset == 1'b1)begin
            heat = 1'b0;
            cool = 1'b0;
        end
        else begin
            if(temp< 65) begin  // When it is too cool
                heat = 1'b1;
                cool = 1'b0;
            end
            else if(temp> 90) begin // When it is too hot
                heat = 1'b0;
                cool = 1'b1;
            end
            else begin  // When temperature is in comfortable range
                heat = 1'b0;
                cool = 1'b0;
            end
        end
    end
endmodule

module water(moisture_sensor, water_sensor, clk ,pump, sprinkler, reset);
    input [7:0] moisture_sensor;
    // Senses the water level in the soil
    input [1:0] water_sensor;
    // Senses the water level in the tank
    input clk, reset;
   
    output reg pump, sprinkler;
   
    always @(posedge clk or posedge reset) begin
        if (reset == 1'b1)begin
            pump = 1'b0;
            sprinkler = 1'b0;
        end
        else begin
            if(water_sensor == 2'b11)
                pump = 1'b0;    // in case tank is full pump is off
            else
                pump =1'b1;     // else pump is on
            
            if (water_sensor >= 2'b 10)begin    // if there is enough water is in the tank
                if (moisture_sensor < 8'b01000000)  // if moisture is low
                    sprinkler = 1'b1;   // springkler is turned on
                else if (moisture_sensor > 8'b10000000) // moisture is sufficient
                    sprinkler = 1'b0;   // sprinkler is turned off
            else sprinkler = 1'b0;  // sprinklers off if there is less water in the tank
            end 
        end
    end
endmodule

/************************/
