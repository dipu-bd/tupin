namespace tupin
{
#define NUMBER

class Number : public Object<long long>
{
  public:
    Number(long long val = 0) : Object(val) {} 

    Number& operator += (const Number& rhs);
    Number& operator -= (const Number& rhs);
    Number& operator *= (const Number& rhs);
    Number& operator /= (const Number& rhs);
    Number& operator %= (const Number& rhs);

    Number& operator ^= (const Number& rhs);
    Number& operator |= (const Number& rhs);
    Number& operator &= (const Number& rhs);
    Number& operator >>= (const Number& rhs);
    Number& operator <<= (const Number& rhs); 
};

// Arithmatic Operations 

Number& Number::operator += (const Number& rhs)
{
    set(get() + rhs.get());
    return *this;
}
Number& Number::operator -= (const Number& rhs)
{
    set(get() - rhs.get());
    return *this;
}
Number& Number::operator *= (const Number& rhs)
{
    set(get() * rhs.get());
    return *this;
}
Number& Number::operator /= (const Number& rhs)
{
    set(get() / rhs.get());
    return *this;
}
Number& Number::operator %= (const Number& rhs)
{
    set(get() % rhs.get());
    return *this;
}

// Bit Operations

Number& Number::operator ^= (const Number& rhs)
{
    set(get() ^ rhs.get());
    return *this;
}
Number& Number::operator |= (const Number& rhs)
{
    set(get() | rhs.get());
    return *this;
}
Number& Number::operator &= (const Number& rhs)
{
    set(get() & rhs.get());
    return *this;
}
Number& Number::operator <<= (const Number& rhs)
{
    set(get() << rhs.get());
    return *this;
}
Number& Number::operator >>= (const Number& rhs)
{
    set(get() >> rhs.get());
    return *this;
} 

// end of file
}