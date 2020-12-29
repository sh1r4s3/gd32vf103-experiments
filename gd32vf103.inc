/* 
 * vim:et:sw=2:syntax=asm:filetype=asm
 *
 * Copyright (c) 2020 Nikita Ermakov <sh1r4s3@mail.si-head.nl>
 * SPDX-License-Identifier: MIT
 *
 * Description:
 *   List of common constants which describe MCU. The documentation to this
 *   MCU could be found at [1] (see User Guide PDF).
 *
 *   [1] https://www.gigadevice.com/products/microcontrollers/gd32/risc-v/mainstream-line/gd32vf103-series/
 *
 */

/*
 * Resest and Clock Unit (RCU) 
 */
.equ RCU_CFG0_BASE, 0x40021004
.equ RCU_CFG0_AHBPSC, 4
.equ RCU_CFG0_AHBPSC_NODIV, 0b0000
.equ RCU_CFG0_AHBPSC_DIV_8, 0b1010
.equ RCU_CFG0_AHBPSC_DIV_512, 0b1111
.equ RCU_APB2EN_BASE, 0x40021018
.equ RCU_APB2EN_PBEN, 3

/*
 * General Purpose I/O (GPIO)
 */
.equ GPIO_PORTB_BASE, 0x40010c00
.equ GPIO_CTLX_PIN7, 7*4
.equ GPIO_CTLX_PIN6, 6*4
.equ GPIO_CTLX_PIN5, 5*4
.equ GPIO_CTLX_PIN0, 0
.equ GPIO_CTLX_MASK, 0b1111
.equ GPIO_CTL0_OFFSET, 0x00
.equ GPIO_OCTL_OFFSET, 0x0c
.equ GPIO_ISTAT_OFFSET, 0x08
.equ GPIO_OCTL_PIN5, 5
.equ GPIO_ISTAT_PIN0, 0
/* GPIO port bits  */
.equ GPIO_PP_2MHZ, 0b0010
.equ GPIO_PP_10MHZ, 0b0001
.equ GPIO_PP_50MHZ, 0b0011
.equ GPIO_PD_IN, 0b1000
.equ GPIO_PU_IN, 0b1001
