/* 
 * vim:et:sw=2:
 *
 * Copyright (c) 2020 Nikita Ermakov <sh1r4s3@mail.si-head.nl>
 * SPDX-License-Identifier: MIT
 *
 * Description:
 *   Example program for GD32VF103 MCU. A LED lights up when a button is
 *   pressed. It is assumed that the button is connected to the GPIO pin 0 and
 *   LED is connected to the GPIO pin 5, both at the port B.
 *
 */

.include "../gd32vf103.inc"

.text
.global reset
reset:
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

  la a4, ~(GPIO_CTLX_MASK << GPIO_CTLX_PIN0)
  and a3, a3, a4
  la a4, (GPIO_PD_IN << GPIO_CTLX_PIN0)
  or a3, a3, a4

  sw a3, 0(a2)

  la a2, GPIO_PORTB_BASE + GPIO_OCTL_OFFSET
  la a3, GPIO_PORTB_BASE + GPIO_ISTAT_OFFSET
loop:
  lw a4, 0(a3)
  lw a5, 0(a2)
  xori a4, a4, (1 << GPIO_ISTAT_PIN0)
  srl a4, a4, GPIO_ISTAT_PIN0
  sll a4, a4, GPIO_OCTL_PIN5
  
  or a5, a5, a4
  sw a4, 0(a2)
  j loop 
