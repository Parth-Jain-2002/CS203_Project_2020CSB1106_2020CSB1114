
# **Home Automation System**
The System consists of a *Primary module* that monitors the output from Secondary modules and acts on the output from Secondary modules.

## Primary Module:
1. INPUTS: 
    * Outputs from all the secondary modules
2. OUTPUTS:
    * Fire Alarm
    * Burglar/ Theft Alarm
    * Visitor Counter
    * Rain Alarm
    * Sprinkler control
    * Water valve control
    * External lights


## Secondary Modules:
1. **Controller for room lights and other appliances:** Turns on lights depending on outside conditions
   * INPUTS:
      * Luminosity measure
      * Motion Sensor and IR Sensor (1 bit).
      * Manual Override (1 bit)
    * OUTPUTS:
      * lights (on/off)
2. **Burglar Alarm:** Rings a burglar alarm in case of forced entry 
    * INPUTS:
      * Magnetic Sensor Door open/close
      * Locked (if door is locked or not)
    * OUTPUTS:
      * Burglar Alarm Signal
3. **Window security:** Rings alarm in case of shattering. Also controls blinds depending on how bright it is outside.
    * INPUTS:
      * Shattering (1 bit)
    * OUTPUTS:
      * Burglar Alarm Signal
4. **Fire Alarm:** Fire alarm incase of fire.
	* INPUTS:
		* Fire/ smoke sensor
	* OUTPUTS:
		* Fire alarm signal
5. **Alarm Module:** Sends signal to fire alarm/ burglar alarm/ rain alarm
	* INPUTS: 
		* Alarm Signals (Concatenated 3 bit input) routed form the primary module
	* OUTPUT:
		* Fire Alarm
		* Burglar Alarm
		* Rain Alarm     
6. **Visitor Counter:** Counts the number of visitors in the home
    * INPUTS:
      * 2 IR_sensor (1 bit each)
    * OUTPUTS:
      * Occupant count
7. **Temperature Control:** Turns on heating/cooling depending on the temperature
    * INPUTS:
      * Temperature
    * OUTPUTS:
      * heating on/off
      * cooling on/off
8. **Rain Sensor:** Rings rain alarm in case of rain
    * INPUTS:
      * Rain Sensor
    * OUTPUTS
      * Rain Alarm
9. **Water Controller:** Senses the level of water in the tank and fills water accordingly. Also has integrated sprinkler control for watering plants smartly.
    * INPUTS:
      * W_sensor(2 bits) detects water level in the tank
      * Moisture Sensor: The moisture level in the soil.
    * OUTPUTS:
      * Valve open/close
      * Sprinklers on/off

*Note: All modules have clock signal and reset signals as inputs as well.*

The resulting system is modular and can be adapted to any home with different specifications.
