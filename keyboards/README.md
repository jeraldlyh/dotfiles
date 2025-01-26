# How to flash the firmware

## Step 1: Clone the Keychron Fork of QMK Firmware

Clone Keychron's fork of the QMK firmware repository with submodules enabled:

```bash
git clone --recurse-submodules https://github.com/Keychron/qmk_firmware.git $HOME/keychron_qmk_firmware
```

This will download the firmware code, including the necessary submodules.

## Step 2: Set QMK Configuration Directory

Configure QMK to use Keychron's firmware directory:

```bash
qmk config user.keychron_qmk_firmware $HOME/keychron_qmk_firmware
```

This sets the correct path for your firmware configuration.

## Step 3: Switch to the Correct Branch

Switch to the `wireless_playground` branch, which contains the firmware for the Keychron K11 Max:

```bash
git checkout wireless_playground
```

## Step 4: Create a New Keymap

Create a new keymap for your keyboard:

```bash
qmk new-keymap -kb keychron/k11_max_ansi_encoder_rgb -km jeraldlyh
```

This will create a new keymap named `jeraldlyh` for the Keychron K11 Max found in the `keychron/k11_max/ansi_encoder/rgb/keymaps` directory.

## Step 5: Compile the Firmware

Compile the firmware for your keyboard:

```bash
qmk compile -kb keychron/k11_max_ansi_encoder_rgb -km jeraldlyh
```

## Step 6: Flash the Firmware

Install QMK Toolbox and follow the instructions to flash the firmware to your keyboard.

Ensure that the keyboard is in bootloader mode by changing the mode to `Cable` and holding down to `Esc` before plugging in the USB-C cable.
