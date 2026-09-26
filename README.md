<p align="center">
  <img width="560" height="144" alt="DevilutionX" src="https://github.com/user-attachments/assets/7ac73801-ef7b-4cc1-8442-a191a2a0a1ce" />
</p>

[![Discord](https://img.shields.io/discord/518540764754608128?color=%237289DA&logo=discord&logoColor=%23FFFFFF)](https://discord.gg/devilutionx-518540764754608128)
[![Downloads](https://img.shields.io/github/downloads/diasurgical/devilutionX/total.svg)](https://github.com/diasurgical/devilutionX/releases/latest)
[![Codecov](https://codecov.io/gh/diasurgical/devilutionX/branch/master/graph/badge.svg)](https://codecov.io/gh/diasurgical/devilutionX)

DevilutionX is a source port of Diablo and Hellfire that makes the game easy to run on modern systems, with engine improvements, bug fixes, and optional quality-of-life features. See the [manual](https://github.com/diasurgical/devilutionX/wiki) for the full feature list and the [changelog](docs/CHANGELOG.md) for what has changed.

<p align="center">
<img width="853" height="480" alt="DevilutionX gameplay" src="https://github.com/user-attachments/assets/ee902926-6382-4ee5-b1c2-7947e8b434e9" />
</p>

<sub>*(The health-bar and XP-bar are off by default but can be enabled in the [game settings](https://github.com/diasurgical/DevilutionX/wiki/Config-File). Widescreen can also be disabled.)*</sub>

## Install

You need the data from the original game: buy Diablo on [GoG.com](https://www.gog.com/game/diablo) or Battle.net, or use the shareware [`spawn.mpq`](https://github.com/diasurgical/devilutionx-assets/releases/latest/download/spawn.mpq) in place of `DIABDAT.MPQ` to play the shareware portion.

1. Download the latest [DevilutionX release](https://github.com/diasurgical/devilutionX/releases/latest) and extract it.
2. Copy `DIABDAT.MPQ` from the CD or your Diablo installation into the DevilutionX folder ([extract it from the GoG installer](https://github.com/diasurgical/devilutionX/wiki/Extracting-MPQs-from-the-GoG-installer)).
3. For the Hellfire expansion, also copy `hellfire.mpq`, `hfmonk.mpq`, `hfmusic.mpq`, and `hfvoice.mpq`.

See [docs/installing.md](docs/installing.md) for detailed, per-platform instructions.

## Build from source

```bash
make install   # install build dependencies (macOS / Debian / Ubuntu)
make build     # configure and compile with CMake
make run       # launch the game (needs the MPQ data files)
make test      # run the test suite
make help      # list all targets
```

For all other platforms (Windows, consoles, mobile, …) see [docs/building.md](docs/building.md).

## Contributing

Help is welcome: [coding](docs/CONTRIBUTING.md), [documentation](https://github.com/diasurgical/devilutionX/wiki), testing, or simply hanging out on [Discord](https://discord.gg/devilutionx-518540764754608128). Interested in modding? Check out the [community mods](https://github.com/diasurgical/DevilutionX/wiki/Community-Mods).

## Credits

- The original [Devilution](https://github.com/diasurgical/devilution#credits) project and [everyone](https://github.com/diasurgical/devilutionX/graphs/contributors) who worked on Devilution/DevilutionX
- [Nikolay Popov](https://www.instagram.com/nikolaypopovz/) for UI and graphics
- [WiAParker](https://wiaparker.pl/projekty/diablo-hellfire/) for the Polish voice pack
- And thanks to all who support the project, report bugs, and help spread the word ❤️

## Legal

DevilutionX is released under the Sustainable Use License (see [LICENSE](LICENSE.md)). The source code is for non-commercial use only: you may not charge others for access to it or any derivative work thereof.

Diablo® — Copyright © 1996 Blizzard Entertainment, Inc. All rights reserved. Diablo and Blizzard Entertainment are trademarks or registered trademarks of Blizzard Entertainment, Inc. in the U.S. and/or other countries. DevilutionX and its maintainers are in no way associated with or endorsed by Blizzard Entertainment®.
