# platomformio

Simple package to run PlatformIO commands.

##Install

- `git clone git@github.com:vigetlabs/platomformio.git`
- `ln -s /full/path/to/platomformio ~/.atom/packages/platomformio`

##Setup
- Install [PlatformIO](http://platformio.org/#!/)
  - this package expects the `platformio` command to be available at `usr/local/bin/platformio`
- Create a PlatformIO project (just a folder structure with `src/`, `lib/`, and a `platformio.ini` file)
  - `mkdir my-project; cd my-project`
  - `platformio init --board=uno` (answer no `N` to auto-uploading question)
  - `touch src/blink.ino`

##Build

Verify your code can compile with `cmd-shift-B`:

![build](http://i.imgur.com/6h1OSt7.gif)

##Upload

Plug your Arduino in and `cmd-shift-U`:

![upload](http://i.imgur.com/sYk6qAO.gif)

##Kill Process

You can kill a process anytime with `cmd-shift-k`

##Settings

- *Verbose Builds:* Default behavior is to only show build output if there is an error. Check this if you want to see all build output.

- *Verbose Uploads:* Default behavior is to show all upload output. Uncheck this if you only want to see output if there is an error.
