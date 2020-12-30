/* 
 * vim:et:sw=2:
 *
 * Copyright (c) 2020 Nikita Ermakov <sh1r4s3@mail.si-head.nl>
 * SPDX-License-Identifier: MIT
 *
 * Description:
 *   Three LEDs connected to the GPIO pins 5, 6, 7 flashing randomly using
 *   xorshift PRNG method [1].
 *
 * [1] DOI: 10.18637/jss.v008.i14
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
/* a7 is the seed for xorshift PRNG */
  la a2, GPIO_PORTB_BASE + GPIO_OCTL_OFFSET
  li a7, 0x1337cafe
loop:
  jal xorshift
  addi a3, a0, 5

  andi a4, a4, 0b000 << GPIO_OCTL_PIN5
  li a5, 1
  sll a5, a5, a3
  or a4, a4, a5
  sw a4, 0(a2)

  la a6, 200000
sleep:
  addi a6, a6, -1
  bnez a6, sleep
  j loop 

xorshift:
  slli t1, a7, 1
  xor a7, a7, t1
  srli t1, a7, 3
  xor a7, a7, t1
  slli t1, a7, 10
  xor a7, a7, t1
  
  li t1, 3
  remu a0, a7, t1
  ret
