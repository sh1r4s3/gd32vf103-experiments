/*
 * vim:et:sw=2
 *
 * Copyright (c) 2021 Nikita Ermakov <sh1r4s3@mail.si-head.nl>
 * SPDX-License-Identifier: MIT
 *
 * Description:
 *   List of common constants which describe MCU. The documentation to this
 *   MCU could be found at [1] (see User Guide PDF).
 *
 *   [1] https://www.gigadevice.com/products/microcontrollers/gd32/risc-v/mainstream-line/gd32vf103-series/
 *
*/

#ifndef GD32VF103_H
#define GD32VF103_H

/*
 * Resest and Clock Unit (RCU)
 */
#define RCU_CFG0 0x40021004
#define RCU_CFG0_AHBPSC_OFFSET 4
#define RCU_APB2EN 0x40021018
#define RCU_APB2EN_PBEN 3
#define RCU_APB2EN_PAEN 2

/*
 * General Purpose I/O (GPIO)
 */
#define GPIOA_BASE 0x40010800
#define GPIOX_WIDTH 0x400
#define GPIOA_CTL0 GPIOA_BASE + 0x00
#define GPIOB_CTL0 GPIOB_BASE + 0x00
#define GPIOX_OCTL_OFF 0x0c
enum GPIO_IO_BITS {
  GPIO_PP_2MHZ = 0x2,
  GPIO_PP_10MHZ = 0x1,
  GPIO_PP_50MHZ = 0x3,
  GPIO_OD_50MHZ = 0x7,
  GPIO_PD_IN = 0x8,
  GPIO_PU_IN = 0x9
};

void ahbpsc_div(int div);
void gpio_enb(int enable);
void gpio_ctl_bits(unsigned int port, unsigned int pin, enum GPIO_IO_BITS mode);
void gpio_set_bit(unsigned int port, unsigned int pin);
void gpio_clean_bit(unsigned int port, unsigned int pin);

#endif
