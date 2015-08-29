# platomformio

Integration with [PlatformIO](http://platformio.org/) cross-platform code
builder and the missing library manager (Ready for embedded development,
Continuous integration, Arduino and MBED compatible).

## Setup
- Install [PlatformIO](http://platformio.org/)
- Create a PlatformIO project using [platformio init](http://docs.platformio.org/en/latest/userguide/cmd_init.html) command:
  - `mkdir my-project; cd my-project`
  - `platformio init --board=uno` (answer no `N` to auto-uploading question)
  - copy your source files to `src` directory.

**Note!** If you have an error `Program "platformio" not found in PATH`,
please specify "Environment PATH to run `platformio`" in settings.

## Build

Verify your code can compile with `cmd-shift-B`:

![build](http://i.imgur.com/6h1OSt7.gif)

## Upload

Plug your Arduino in and `cmd-shift-U`:

![upload](http://i.imgur.com/sYk6qAO.gif)

## Kill Process

You can kill a process anytime with `cmd-shift-k`

## Settings

- **Environment PATH to run `platformio`:** Defaults to `PATH` from current
  Atom session. `PATH` should contain directory where `platformio` is installed.
  If you have an error `Program "platformio" not found in PATH`, then paste
  here result of `echo $PATH` (Unix) / `echo %PATH%` (Windows) command by
  typing into your terminal.

- **Verbose Builds:** Default behavior is to only show build output if there is
  an error. Check this if you want to see all build output.

- **Verbose Uploads:** Default behavior is to show all upload output. Uncheck
  this if you only want to see output if there is an error.

### Acknowledgements

*This package has [atom-script](https://github.com/rgbkrk/atom-script) to thank
for it's good looks*
