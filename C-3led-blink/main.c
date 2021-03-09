/*
 * vim:et:sw=2:
 *
 * Copyright (c) 2021 Nikita Ermakov <sh1r4s3@mail.si-head.nl>
 * SPDX-License-Identifier: MIT
 *
 * Description:
 *   Three LEDs connected to the GPIO pins 5, 6, 7 flashing one by one
 *   consequently.
 *
 */

#include <gd32vf103.h>

void sleep(int cycles) {
  for (volatile int i = 0; i < cycles; ++i);
}

int main() {
  ahbpsc_div(8);
  gpio_enb(1);

  int pin = 5;
  gpio_ctl_bits(1, 5, GPIO_PP_50MHZ);
  gpio_ctl_bits(1, 6, GPIO_PP_50MHZ);
  gpio_ctl_bits(1, 7, GPIO_PP_50MHZ);
  while (1) {
    gpio_set_bit(1, pin);
    sleep(200000);
    gpio_clean_bit(1, pin);
    if (++pin > 7) {
      pin = 5;
    }
  }

  return 0;
}
