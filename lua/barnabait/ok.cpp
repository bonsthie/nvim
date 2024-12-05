#include "ok.h"
#include "log.h"

ok::ok(void) {
  LOG("constructor ok empty")
}

ok::ok(const ok &src) {
  LOG("constructor ok copy")
  if (this != &src)
    *this = src;
}

ok::~ok(void) {
  LOG("destructor ok")
}

ok &ok::operator=(ok const &src) {
  if (this == &src)
    return (*this);
  return (*this);
}