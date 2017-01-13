namespace tupin
{
#define NUMBER

class Bool : public Object<bool>
{
  public:
    Bool(bool val = false) : Object(val) {}

    operator std::string() const;
};

Bool::operator std::string() const
{
    return get() ? "true" : "false";
}

// end of file
}