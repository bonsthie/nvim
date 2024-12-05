#include "oui.h"
#include "log.h"

oui::oui(void) {
  LOG("constructor oui empty")
}

oui::oui(const oui &src) {
  LOG("constructor oui copy")
  if (this != &src)
    *this = src;
}

oui::~oui(void) {
  LOG("destructor oui")
}

oui &oui::operator=(oui const &src) {
  if (this == &src)
    return (*this);
  return (*this);
}