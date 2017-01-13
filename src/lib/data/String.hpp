namespace tupin
{
#define NUMBER

class String : public Object<std::string>
{
  public:
    String(std::string val) : Object(val) {}
};

// end of file
}
