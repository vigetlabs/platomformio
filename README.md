# platomformio

Integration with [PlatformIO](http://platformio.org/) an open source ecosystem
for IoT development. Cross-platform code builder and library manager.
Continuous and IDE integration. Arduino and MBED compatible.
Ready for Cloud compiling.

*Atmel AVR & SAM, Espressif, Freescale Kinetis, Nordic nRF51, NXP LPC,
Silicon Labs EFM32, ST STM32, TI MSP430 & Tiva, Teensy, Arduino, mbed,
libOpenCM3, ESP8266, etc.*

## Setup
1. Install [PlatformIO](http://platformio.org/)
2. Set the `Environment PATH` package setting with the result of `echo $PATH` (Unix) / `echo %PATH%` (Windows).
2. Create a PlatformIO project using [platformio init](http://docs.platformio.org/en/latest/userguide/cmd_init.html) command:
  - Create empty directory for the new project (Unix `mkdir my-project; cd my-project`)
  - `platformio init --board=TYPE`, where `TYPE` can be found in [Embedded Boards Explorer](http://platformio.org/#!/boards)
3. Place your source files to `src` directory
4. Open any file from `src` directory and then Build/Upload.


**Note!** If you have an error `Program "platformio" not found in PATH`,
please specify "Environment PATH to run `platformio`" in settings.

## Build

Verify your code can compile with `cmd-shift-B`:

![build](http://i.imgur.com/6h1OSt7.gif)

## Upload

Plug your board in and `cmd-shift-U`:

![upload](http://i.imgur.com/sYk6qAO.gif)

## Upload using Programmer

Plug your board in and `cmd-shift-P`. Please make sure to read
[Upload using Programmer for Atmel AVR](http://docs.platformio.org/en/latest/platforms/atmelavr.html#upload-using-programmer)
first.

## Upload SPIFFS firmware

Plug your board in and `cmd-shift-F`. Please make sure to read
[Uploading files to file system SPIFFS for ESP8266](http://docs.platformio.org/en/latest/platforms/espressif.html#uploading-files-to-file-system-spiffs)
first.


## Kill Process

You can kill a process anytime with `cmd-shift-k`

## Settings

- **Environment PATH to run `platformio`:** Defaults to `PATH` from current
  Atom session. Paste here result of
  `echo $PATH` (Unix) / `echo %PATH%` (Windows) command by typing into your terminal.

- **Verbose Builds:** Default behavior is to only show build output if there is
  an error. Check this if you want to see all build output.

- **Verbose Uploads:** Default behavior is to show all upload output. Uncheck
  this if you only want to see output if there is an error.

### Contributors

- [efatsi](https://github.com/efatsi)
- [ivankravets](https://github.com/ivankravets)
- [RomFouq](https://github.com/RomFouq)

### Acknowledgements

*This package has [atom-script](https://github.com/rgbkrk/atom-script) to thank
for it's good looks*
