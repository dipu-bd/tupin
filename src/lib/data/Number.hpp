namespace tupin
{
#define NUMBER

class Number : public ObjectBase<long long>
{
  public:
    Number(long long val = 0) : ObjectBase(val) {}
};

// end of file
}