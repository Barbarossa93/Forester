# Forest Night - Xresources

![colortest](colortest.png)

## Installation

Detailed information about Xresources configurations can be found in the [Arch Linux Wiki](https://wiki.archlinux.org/index.php/X_resources) and [Wikipedia](https://en.wikipedia.org/wiki/X_resources).

### Manual

Copy the content of the [`forest-night`](https://raw.githubusercontent.com/jef/forest-night-xresources/master/forest-night) file into the `~/.Xresources` or `~/.Xdefaults` file and reload the settings with `xrdb`.

### Via `#include`

Copy the [`forest-night`](https://raw.githubusercontent.com/jef/forest-night-xresources/master/forest-night) file to any place and import it via `#include "/path/to/forest-night"`.

### Via `merge`

To merge the color theme into your current settings copy the [`forest-night`](https://raw.githubusercontent.com/jef/forest-night-xresources/master/forest-night) file to any place and run `xrdb -merge path/to/forest-night`.

## Credits

Based off [sainnhe's Forest Night](https://github.com/sainnhe/forest-night).
