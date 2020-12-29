/* 
 * vim:et:sw=2:
 *
 * Copyright (c) 2020 Nikita Ermakov <sh1r4s3@mail.si-head.nl>
 * SPDX-License-Identifier: MIT
 *
 * Description:
 *   Three LEDs connected to the GPIO pins 5, 6, 7 flashing one by one
 *   consequently.
 *
 */

.include "../gd32vf103.inc"

.text
.global reset
reset:
/* Reduce clock speed to set the proper blinking rate */
  la a2, RCU_CFG0_BASE
  lw a3, 0(a2)
  li a4, (RCU_CFG0_AHBPSC_DIV_8 << RCU_CFG0_AHBPSC)
  or a3, a3, a4
  sw a3, 0(a2)
/* Enable GPIO port B clock */
  la a2, RCU_APB2EN_BASE
  lw a3, 0(a2)
  ori a3, a3, (1 << RCU_APB2EN_PBEN)
  sw a3, 0(a2)
/* Set-up GPIO */
  la a2, GPIO_PORTB_BASE + GPIO_CTL0_OFFSET
  lw a3, 0(a2)

  la a4, ~(GPIO_CTLX_MASK << GPIO_CTLX_PIN5)
  and a3, a3, a4
  la a4, (GPIO_PP_50MHZ << GPIO_CTLX_PIN5)
  or a3, a3, a4

  la a4, ~(GPIO_CTLX_MASK << GPIO_CTLX_PIN6)
  and a3, a3, a4
  la a4, (GPIO_PP_50MHZ << GPIO_CTLX_PIN6)
  or a3, a3, a4

  la a4, ~(GPIO_CTLX_MASK << GPIO_CTLX_PIN7)
  and a3, a3, a4
  la a4, (GPIO_PP_50MHZ << GPIO_CTLX_PIN7)
  or a3, a3, a4

  sw a3, 0(a2)

/* a2 is the address of the GPIO port B OCTL register */
/* a3 is the number of the diod to light up */
  la a2, GPIO_PORTB_BASE + GPIO_OCTL_OFFSET
  li a3, 5
  li a7, 8
loop:
  andi a4, a4, 0b000 << GPIO_OCTL_PIN5
  li a5, 1
  sll a5, a5, a3
  or a4, a4, a5
  sw a4, 0(a2)

  la a6, 200000

  addi a3, a3, 1
  xor t3, a3, a7
  bnez t3, sleep
  li a3, 5
sleep:
  addi a6, a6, -1
  bnez a6, sleep
  j loop 
