# Contiki-NG toolchain for macOS (with Apple Silicon)

Development environment for the Contiki-NG networking courses at the VUB.
One command gives you the complete toolchain: the Arm compiler, nrfutil, the J-Link software, JDK 25 for Cooja, GNU Make 4 and the serial tools.

Requires a Mac with Apple Silicon. 

## Use it

Install Nix once:

```bash
sh <(curl -L https://nixos.org/nix/install) --daemon
```

Then, in any terminal:

```bash
nix --extra-experimental-features 'nix-command flakes' develop git+https://gitlab.com/etrovub/smartnets/teaching/nix-contiki-ng-macos-arm
```

The first run downloads the toolchain and takes several minutes. Later runs start immediately.

Then build as usual, from your Contiki-NG clone:

```bash
cd ~/contiki-ng/examples/hello-world
make TARGET=nrf BOARD=nrf52840/dk
```

The shell is temporary. Every terminal in which you compile must enter it first.

## Licenses

`nrfutil` and the J-Link software are proprietary. The flake sets `allowUnfree` and accepts the J-Link license on your behalf; read it at <https://www.segger.com/downloads/jlink> before using the environment.
