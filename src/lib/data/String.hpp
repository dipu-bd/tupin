namespace tupin
{
#define NUMBER

class Number : public ObjectBase<const char * T>
{
  public:
    Number(CHARR v = 0) : ObjectBase(v)
    {
    }

    operator std::string() const
    {
        char out[20];
        sprintf(out, "%lld", value);
        return out;
    }
};

// end of file
}