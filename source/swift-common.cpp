#include <string>

#include "swift-common/swift-common.hpp"

exported_class::exported_class()
    : m_name {"swift-common"}
{
}

auto exported_class::name() const -> char const*
{
  return m_name.c_str();
}
