namespace tupin
{
#define NUMBER

class Number : public Object<long long>
{
  public:
    Number(long long val = 0) : Object(val) {} 
};
 

// end of file
}