namespace tupin
{
#define NUMBER

class Bool : public Object<bool>
{
  public:
    Bool(bool val = false) : Object(val) {} 
};

// end of file
}