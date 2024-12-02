# First PlatformIO project
## Install PlatformIO (MacOS)

Download the install script to a temporary folder:
``` bash
curl -fsSL -o get-platformio.py https://raw.githubusercontent.com/platformio/platformio-core-installer/master/get-platformio.py
python3 get-platformio.py
```
The installer script will prompt something like the following:
```
The full path to `platformio.exe` is `<some_path>/platformio/penv/bin/platformio`
```
This is the executable name and location. I personally prefer to create a symbolic link to it:
```bash
ln -s <some_path>/platformio/penv/bin/platformio /usr/local/bin/pio
```
but you can also follow other recommendations (e.g., modify PATH).

This installation method will create a virtual environment for PlatformIO, in contrast with what would happen if we installed it using `pip`. Don't mix up these types of installations.

## Project setup
Every project has the basic structure:
```bash
.
├── include
│   └── README
├── lib
│   └── README
├── platformio.ini
├── src
└── test
    └── README
```
This can be easily setup using `pio`. Before doing that, it is useful to know what type of board the project is used for. The supported boards are listed by the command
```bash
pio boards
```
You can filter boards with specific MCU using the MCU itself as an extra parameter. However, a large number of matches can be further filtered out using `grep`:
```bash
pio boards ESP32 | grep -i "dev module" # example for WROOM-32
```
which will output something like
```
esp32dev                             ESP32    240MHz       4MB      320KB   Espressif ESP32 Dev Module
onehorse32dev                        ESP32    240MHz       4MB      320KB   Onehorse ESP32 Dev Module
```
The board I am currently using is, according to the list, called `esp32dev`. To set up a project for that board, run:
```bash
pio project init --board esp32dev
```
This will create the above structure and populate the file `platformio.ini` with the pertinent values. 

## Compile and upload
On Linux, some `udev` rules are needed:
```bash
curl -fsSL https://raw.githubusercontent.com/platformio/platformio-core/develop/platformio/assets/system/99-platformio-udev.rules \
   | sudo tee /etc/udev/rules.d/99-platformio-udev.rules
sudo service udev restart
```
```bash
pio run                  # compile
pio run --target upload  # upload to the board specified in platformio.ino
```

## References
https://docs.platformio.org/en/latest/core/index.html
