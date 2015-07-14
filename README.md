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

![build](https://s3.amazonaws.com/f.cl.ly/items/2h1W2N3X2r3z3a3d3s2h/platomformio-build.gif)

##Upload

Plug your Arduino in and `cmd-shift-U`:

![upload](https://s3.amazonaws.com/f.cl.ly/items/073L21113g2s0i2K3L1H/platomformio-upload.gif)

##Notes

Output from commands is piped into the web console. There are dreams to improve on this.
