# `sciencebeam-texture` formula

This repository contains instructions for installing and configuring the `sciencebeam-texture` project.

It exposes:

- `/` (Texture)
- `/api`
- `/grobid/`

on port 443 and HTTPS (falls back to 80 and HTTP on Vagrant instances).

This repository should be structured as any Saltstack formula should, but it 
should also conform to the structure required by the [builder](https://github.com/elifesciences/builder) 
project.

See the eLife [builder example project](https://github.com/elifesciences/builder-example-project)
for a reference on how to integrate with the `builder` project.

[MIT licensed](LICENCE.txt)
