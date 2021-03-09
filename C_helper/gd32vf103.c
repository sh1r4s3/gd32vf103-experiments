#include "gd32vf103.h"

void ahbpsc_div(int div) {
  int *cfg0 = (int *)RCU_CFG0;
  switch (div) {
  case 2:
    div = 0x8;
    break;
  case 4:
    div = 0x9;
    break;
  case 8:
    div = 0xa;
    break;
  case 16:
    div = 0xb;
    break;
  case 64:
    div = 0xc;
    break;
  case 128:
    div = 0xd;
    break;
  case 256:
    div = 0xe;
    break;
  case 512:
    div = 0xf;
    break;
  default:
    div = 0;
  }

  *cfg0 &= ~(0xf << RCU_CFG0_AHBPSC_OFFSET);
  *cfg0 |= ~(div << RCU_CFG0_AHBPSC_OFFSET);
}

void gpio_enb(int enable) {
  int *apb2en = (int *)RCU_APB2EN;
  *apb2en &= ~(1 << RCU_APB2EN_PBEN);
  if (enable) {
    *apb2en |= 1 << RCU_APB2EN_PBEN;
  }
}

void gpio_ctl_bits(unsigned int port, unsigned int pin, enum GPIO_IO_BITS mode) {
  void *gpiox_ctlx = (void *)(GPIOA_BASE + GPIOX_WIDTH*port);

  if (pin > 7) {
    gpiox_ctlx += 0x04;
  }

  *(int *)gpiox_ctlx &= ~(0xf << pin*4);
  *(int *)gpiox_ctlx |= mode << pin*4;
}

void gpio_clean_bit(unsigned int port, unsigned int pin) {
  int *gpio = (int *)(GPIOA_BASE + GPIOX_WIDTH*port + GPIOX_OCTL_OFF);
  *gpio &= ~(1 << pin);
}

void gpio_set_bit(unsigned int port, unsigned int pin) {
  int *gpio = (int *)(GPIOA_BASE + GPIOX_WIDTH*port + GPIOX_OCTL_OFF);
  *gpio |= 1 << pin;
}
