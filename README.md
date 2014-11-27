# Gnosis
[![Build Status](https://travis-ci.org/Solistra/gnosis.svg?branch=master)][travis]
[![Coverage Status](https://coveralls.io/repos/Solistra/gnosis/badge.png?branch=master)][coverage]

1. _noun: spiritual knowledge; mystical enlightenment._
2. _noun: the act or process of knowing._

## Summary
Gnosis performs in-memory decryption of the contents of encrypted RGSSAD archives (as used by the RPG Maker series) to binary strings via a class representing the archive. Encrypted archives may be searched for specific contents which can then be decrypted to a string -- perfect for implementing custom Ruby game players by converting the binary string directly into an IO instance with the Ruby `StringIO` class present in the standard library.

## Installation
At present, Gnosis is still in early development. As such, you will need to clone [the GitHub repository][repo] and install its development dependencies in order to do anything with it:

```sh
$ git clone https://github.com/Solistra/gnosis.git
$ cd gnosis/
$ gem install bundler
$ bundle install
```

## Disclaimer
This library has been designed to help facilitate the loading of the RPG Maker series' encrypted RGSS archives for alternative game players written in a compliant Ruby implementation. As such, Gnosis simply decrypts the requested contents of encrypted RGSSAD archives as binary strings which are intended to be used for loading resources, _not_ for writing them to disk.

Gnosis exists to ease the development of alternatives to the native `Game.exe` files given by the RPG Maker series by default -- it is _not_ designed to encourage piracy of encrypted resources.

**In short, ethical usage of Gnosis is your responsibility as a user, not the library itself.**

## Attribution
The decryption algorithms used by this library are based upon algorithms previously released by [Porkness][porkness] for a fork of the [OpenRGSS][openrgss] project with specific modifications for this library.

Unfortunately, the original source of these algorithms could not be located -- please open an issue if you know the original source so they can be properly attributed.

## License
Gnosis is made available under the terms of the LGPL version 3 license. See the included LICENSE file for more information.

[coverage]: https://coveralls.io/r/Solistra/gnosis?branch=master
[repo]:     https://www.github.com/Solistra/gnosis
[openrgss]: http://openrgss.org
[porkness]: https://www.github.com/Porkness
[travis]:   https://travis-ci.org/Solistra/gnosis
