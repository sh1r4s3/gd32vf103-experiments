/* 
 * vim:et:sw=2:
 *
 * Copyright (c) 2020 Nikita Ermakov <sh1r4s3@mail.si-head.nl>
 * SPDX-License-Identifier: MIT
 *
 * Description:
 *   Simple example of using a common 7 segments 3 digits LED display.
 *
 */

.include "../gd32vf103.inc"

.text
.global reset
reset:
/* Enable GPIO port A and B clock */
  la a2, RCU_APB2EN_BASE
  lw a3, 0(a2)
  ori a3, a3, (1 << RCU_APB2EN_PBEN)
  ori a3, a3, (1 << RCU_APB2EN_PAEN)
  sw a3, 0(a2)

/*
 * Set-up GPIO
 */
/* DIG 2,3, open-drain pins at the port B */
/* Only 2 digits in this example */
  la a2, GPIO_PORTB_BASE + GPIO_CTL1_OFFSET
  lw a3, 0(a2)

  la a4, ~(0x0ff000)
  and a3, a3, a4
  la a4, 0x077000
  or a3, a3, a4

  sw a3, 0(a2)
/* A-F, DP push-pull pins at the port A */
  la a2, GPIO_PORTA_BASE + GPIO_CTL0_OFFSET
  lw a3, 0(a2)

  la a4, ~(0x0fffffff)
  and a3, a3, a4
  la a4, 0x03333333
  or a3, a3, a4
  
  sw a3, 0(a2)
  
/*
 * Output "Hi" message
 */
loop:
/* H */
  li a2, GPIO_PORTA_BASE + GPIO_OCTL_OFFSET
  lw a3, 0(a2)
  
  li a4, ~0xffff
  and a3, a3, a4
  ori a3, a3, 0b1110110
  sw a3, 0(a2)

  li a2, GPIO_PORTB_BASE + GPIO_OCTL_OFFSET
  lw a3, 0(a2)
  
  li a4, ~0xffff
  and a3, a3, a4
  li a4, 1 << 12
  or a3, a3, a4
  sw a3, 0(a2)

  li a2, 0x100
sleep:
  addi a2, a2, -1
  bnez a2, sleep

/* i */
  li a2, GPIO_PORTB_BASE + GPIO_OCTL_OFFSET
  lw a3, 0(a2)
  
  li a4, ~0xffff
  and a3, a3, a4
  li a4, 1 << 11
  or a3, a3, a4
  sw a3, 0(a2)

  li a2, GPIO_PORTA_BASE + GPIO_OCTL_OFFSET
  lw a3, 0(a2)
  
  li a4, ~0xffff
  and a3, a3, a4
  ori a3, a3, 0b0110
  sw a3, 0(a2)

  li a2, 0x100
sleep2:
  addi a2, a2, -1
  bnez a2, sleep2


  j loop 
