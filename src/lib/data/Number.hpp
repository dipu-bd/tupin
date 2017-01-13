#include "Object.hpp"

class Number : public Object
{
  public:
    virtual std::string toString(const char *fmt) const = 0;
};
