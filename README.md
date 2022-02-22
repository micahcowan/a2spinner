a2spinner
=====

Creates an animated "spinner" prompt on your Apple \]\[ for your enjoyment and amusement!

Download the DOS 3.3 disk from [the Releases page](https://github.com/micahcowan/a2spinner/releases), or [try it out in your web browser](http://micah.cowan.name/apple2js/apple2js.html#spinner)!

To use with ProDOS, use CiderPress or ProDOS/DOS conversion utilities to copy `SPINNER` to a ProDOS disk, and then from within ProDOS,
do a `BLOAD SPINNER` followed by `IN#A$300`.

## Notes on building

To build via the Makefile, you'll need cc65 installed, and also **deater**'s [dos33fsprogs](https://github.com/deater/dos33fsprogs).
Note that **deater**'s repo contains many, many more things than you need for building this project - only the bits in `utils/dos33fs-utils`
and `utils/asoft_basic-utils` are needed. You can go into those dirs and build them individually (and then place them somewhere on your path, so my Makefile will find them!).
