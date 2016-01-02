## 0.7.0
* Added new commands:
  - `Uploading using Programmer` for Atmel AVR
  - `Uploading SPIFFS image` for Espressif ESP8266

## 0.6.3
* Improved handling of process.env.PATH and user's specified PATH
* Updated README with detailed instructions how to use this package

## 0.6.2
* Fixed incorrect processing of process.env.PATH when package's setting is empty

## 0.6.1
* Minor tweak to determining project directory (@RomFouq)
* Bug fix: Avoid Atom error if active panel isn't a text editor (@RomFouq)

## 0.6.0
* Can run PlatformIO commands from lib directory (@RomFouq)

## 0.5.1
* Updated PlatformIO commands according 2.3 release

## 0.5.0
* Allowed to specify own environment `PATH` for `platformio` command.
  By default `PATH` is set to value from the current Atom session.

## 0.2.0
* Logging output in a much nicer format
* Added settings for verbose outputs

## 0.1.0 - First Release
* Added platformio build & upload shortcuts
* Logging process output in console
