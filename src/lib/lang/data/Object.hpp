#include <string>
#include "Type.hpp"

class Object
{
    virtual int __type() const = Type::UNDEFINED;

    virtual std::string toString() const = "$:$";
};