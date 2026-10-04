# ZEVELIAN OS v2.1.0 — Horizon

A CC:Tweaked + Advanced Peripherals OS designed around a monitor, wired peripherals, Chat Box, Environment Detector, Inventory Manager and Redstone Integrator.

## v2.1 features
- Dynamic monitor sizing and selectable UI resolution/text scale: 0.5, 1, 1.5, 2, 2.5, 3, 4, 5
- Resolution-aware desktop layout
- Music Library: add/remove saved URLs, local playlist metadata, HTTP URL checks
- Speaker detection: if a CC:Tweaked Speaker is later added, the OS can use it for supported local DFPWM playback
- Web Reader: fetches a URL and shows a readable text preview
- Peripheral Center: live inventory of attached/networked peripherals
- Environment, Inventory, Redstone and Chat apps
- System diagnostics and storage information
- Safer installer with staging/backup/rollback

## Install
At the CC:Tweaked shell:
  wget https://raw.githubusercontent.com/YOUR_USERNAME/zevelian-os/main/install.lua install
  install YOUR_USERNAME

The installer defaults to repository `zevelian-os` and branch `main`.

## Important
A monitor is a display/input device, not an audio output. Internet pages and arbitrary music URLs cannot be turned into sound by the monitor alone. Actual audio playback requires a compatible Speaker peripheral and a supported audio format such as DFPWM.
