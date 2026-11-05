{
  description = "Contiki-NG toolchain for macOS (Apple Silicon)";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { nixpkgs, ... }:
    let
      system = "aarch64-darwin";

      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          segger-jlink.acceptLicense = true;
        };
      };

      nrfutil = pkgs.nrfutil.withExtensions [
        "nrfutil-device"
        "nrfutil-nrf5sdk-tools"
      ];
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        packages = [
          pkgs.gcc-arm-embedded-13 # arm-none-eabi-gcc 13.3.rel1
          nrfutil # programs the DK and the Dongle
          pkgs.segger-jlink # JLinkExe
          pkgs.jdk25 # for Cooja; sets JAVA_HOME
          pkgs.gnumake # version 4
          pkgs.srecord
          pkgs.jq
          pkgs.gawk
          pkgs.git
          pkgs.git-lfs
          pkgs.doxygen
          pkgs.uncrustify
          pkgs.ant
          pkgs.rlwrap
          pkgs.wget
          pkgs.mosquitto

          pkgs.wireshark

          (pkgs.python3.withPackages (ps: [
            ps.pyserial
            ps.pyusb
            ps.intelhex
          ]))
        ];

        hardeningDisable = [ "all" ];

        shellHook = ''
          unset CC CXX
        '';
      };

      devShells.x86_64-darwin.default = throw ''
        This toolchain requires a Mac with Apple Silicon.
        On an Intel Mac, use the Docker or the Homebrew procedure instead.
      '';
    };
}
