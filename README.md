
Primary module sends inputs to various Secondary modules and acts on the output from 
Secondary modules.

**Primary Module:**
1. INPUTS: 
    * Temperature
    * Luminosity
    * Smoke/ fire sensor
    * Rain sensor
    * Soil Sensor (Moisture)
    * Water level
2. OUTPUTS:
    * Fire Alarm
    * Burglar/ Theft Alarm
    * Visitor Counter
    * Rain Alarm
    * Sprinkler control
    * Water valve control
    * External lights


**Secondary Modules:**
1. Independent controller for room lights and other appliances: 
* INPUTS:
      * Motion Sensor and IR Sensor (1 bit).
      * Manual Override (1 bit)
    * OUTPUTS:
      * lights (on/off)
2. Burr Alarm:
    * INPUTS:
      * Magnetic Sensor Door open/close
      * Locked
    * OUTPUTS:
      * Burglar Alarm
3. Win security: (Output goes to Primary Module)
    * INPUTS:
      * Shattering (1 bit)
      * Luminosity
    * OUTPUTS:
      * Burglar Alarm
      * Window blinds luminosity sensor (8 bits)
4. Visr Counter:
    * INPUTS:
      * 2 IR_sensor (1 bit)
    * OUTPUTS:
      * Visitor leaving/ coming
5. Temature Control: 
    * INPUTS:
      * Temperature
    * OUTPUTS:
      * heating on/off
      * cooling on/off
6. Raiensor:
    * INPUTS:
      * Rain Sensor
    * OUTPUTS
      * Rain Alarm
7. WatSensor( Water in the Tank):
    * INPUTS:
      * W_sensor(2 bits) detects water level in the tank
    * OUTPUTS:
      * Valve open/close
8. Soiensor: 
    * INPUTS:
      * Moisture level
      * Water level
    * OUTPUTS:
      * Water on/off


Primary module sends inputs to various Secondary modules and acts on the output from 
Secondary modules.
