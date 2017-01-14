namespace tupin
{
#define BOOLEAN

class Bool : public Object<bool>
{
  public:
    Bool(bool val = false) : Object(val) {}

    operator std::string() const;
};

Bool::operator std::string() const
{
    return __value ? "true" : "false";
}

// end of file
}