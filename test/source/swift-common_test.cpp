#include <string>

#include "swift-common/swift-common.hpp"

auto main() -> int
{
  auto const exported = exported_class {};

  return std::string("swift-common") == exported.name() ? 0 : 1;
}
