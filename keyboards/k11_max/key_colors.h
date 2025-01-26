#ifndef KEY_COLORS_H
#define KEY_COLORS_H

#include QMK_KEYBOARD_H

typedef struct {
    uint8_t r;
    uint8_t g;
    uint8_t b;
} Color;

typedef struct {
    uint16_t key;
    Color color;
} KeyColorMap;

extern const KeyColorMap key_color_map[];

Color get_key_color(uint16_t keycode);

#endif
