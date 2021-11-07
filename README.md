Primary module sends inputs to various Secondary modules and acts on the output from 
Secondary modules.

*Primary Module:*
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


*Secondary Modules:*
1. Independent controller for room lights and other appliances: Turns on lights depending on outside conditions
   * INPUTS:
      * Luminosity measure
      * Motion Sensor and IR Sensor (1 bit).
      * Manual Override (1 bit)
    * OUTPUTS:
      * lights (on/off)
2. Burglar Alarm: Rings a burglar alarm in case of forced entry 
    * INPUTS:
      * Magnetic Sensor Door open/close
      * Locked (if door is locked or not)
    * OUTPUTS:
      * Burglar Alarm
3. Window security: Rings alarm in case of shattering. Also controls blinds depending on how bright it is outside.
    * INPUTS:
      * Shattering (1 bit)
      * Luminosity
    * OUTPUTS:
      * Burglar Alarm
      * Window blinds
4. Visitor Counter: Counts the number of visitors in the home
    * INPUTS:
      * 2 IR_sensor (1 bit each)
    * OUTPUTS:
      * Visitor leaving/ coming
5. Temperature Control: Turns on heating/cooling depending on the temperature
    * INPUTS:
      * Temperature
    * OUTPUTS:
      * heating on/off
      * cooling on/off
6. Rain Sensor: Rings rain alarm in case of rain
    * INPUTS:
      * Rain Sensor
    * OUTPUTS
      * Rain Alarm
7. Water Sensor( Water in the Tank): Senses the level of water in the tank and fills water accordingly.
    * INPUTS:
      * W_sensor(2 bits) detects water level in the tank
    * OUTPUTS:
      * Valve open/close
8. Soil Sensor: Senses the moisture level in the soil and turns on sprinklers depending on the moisture content and water level
    * INPUTS:
      * Moisture level
      * Water level
    * OUTPUTS:
      * Water on/off