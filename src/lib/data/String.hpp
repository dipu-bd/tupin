namespace tupin
{
#define STRING

class String : public Object<std::string>
{
  public:
    String(std::string val = "") : Object(val) {}
};

// end of file
}
