namespace tupin
{
#define NUMBER

union NumberUnion
{
    double f;
    long long int i;

    operator double() { return f; }
    operator long long int() { return i; }
};

class Number : NumberUnion
{
  public:
    Number(double val = 0) : Object(val) {}
    Number(long long val = 0) : Object(val) {}

    operator std::string() const;

    Number &operator+=(const Number &rhs);
    Number &operator-=(const Number &rhs);
    Number &operator*=(const Number &rhs);
    Number &operator/=(const Number &rhs);
    Number &operator%=(const Number &rhs);

    Number &operator^=(const Number &rhs);
    Number &operator|=(const Number &rhs);
    Number &operator&=(const Number &rhs);
    Number &operator>>=(const Number &rhs);
    Number &operator<<=(const Number &rhs);
};

/////////////////////////////////////////////////////////////////////////////////////

Number::operator std::string() const
{
    return std::to_string(value);
}

Number &Number::operator+=(const Number &rhs)
{
    set(get() + rhs.get());
    return *this;
}
Number &Number::operator-=(const Number &rhs)
{
    set(get() - rhs.get());
    return *this;
}
Number &Number::operator*=(const Number &rhs)
{
    set(get() * rhs.get());
    return *this;
}
Number &Number::operator/=(const Number &rhs)
{
    set(get() / rhs.get());
    return *this;
}
Number &Number::operator%=(const Number &rhs)
{
    set(get() % rhs.get());
    return *this;
}

// Bit Operations

Number &Number::operator^=(const Number &rhs)
{
    set(get() ^ rhs.get());
    return *this;
}
Number &Number::operator|=(const Number &rhs)
{
    set(get() | rhs.get());
    return *this;
}
Number &Number::operator&=(const Number &rhs)
{
    set(get() & rhs.get());
    return *this;
}
Number &Number::operator<<=(const Number &rhs)
{
    set(get() << rhs.get());
    return *this;
}
Number &Number::operator>>=(const Number &rhs)
{
    set(get() >> rhs.get());
    return *this;
}

// end of file
}