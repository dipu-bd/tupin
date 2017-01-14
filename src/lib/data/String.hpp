namespace tupin
{
#define STRING

class String : public Object<char *>
{
  protected:
    int __len;

  public:
    String(const char *v = "") : Object(new char[0]) { set(v); }
    String(const String &v) : Object(v.__value) { __len = v.size(); }
    String(const std::string &v = "") : Object(new char[0]) { set(v); }

    ~String() { delete __value; }

    void set(const char *);
    void set(const std::string &);

    void clear();
    int size() const;
    char at(int) const;
    String &append(const char *);
    String &repeat(unsigned short);

    char &operator[](int i);
    String &operator=(const char *);
    String &operator=(const std::string &);
    String &operator+=(const char *);
    String &operator*=(unsigned short);
    String operator+(const char *) const;
    String operator*(unsigned short)const;
    bool operator<(const char *) const;
    bool operator>(const char *) const;
    bool operator==(const char *) const;
    bool operator!=(const char *) const;
    bool operator<=(const char *) const;
    bool operator>=(const char *) const;
};

////////////////////////////////////////////////////////////////////////////////////

void String::clear()
{
    __len = 0;
    if (__value)
	delete __value;
}

void String::set(const char *val)
{
    clear();
    __value = new char[4];
    std::strcat(__value, val);
    __len = strlen(__value);
}

void String::set(const std::string &val)
{
    set(val.data());
}

int String::size() const
{
    return __len;
}

char String::at(int i) const
{
    return (i >= 0 && i < __len) ? __value[i] : 0;
}

String &String::append(const char *r)
{
    std::strcat(__value, r);
    __len += strlen(r);
    return *this;
}

String &String::repeat(unsigned short n)
{
    char *tmp = new char[10]; // temporary value
    for (int i = sizeof(n) - 1; i >= 0; --i)
    {
	std::strcat(tmp, tmp); // doubles previous
	if (n & (1 << i))
	{
	    std::strcat(tmp, __value); // adds one
	}
    }
    delete __value; // free old value
    __value = tmp;
    __len *= n;
    return *this;
}

////////////////////////////////////////////////////////////////////////////////////

char &String::operator[](int i)
{
    if (i < 0 || i >= __len)
    {
		throw std::out_of_range("Array index out of bound");
    }
	return __value[i];
}

String &String::operator=(const char *r)
{
    set(r);
    return *this;
}
String &String::operator=(const std::string &r)
{
    set(r.data());
    return *this;
}

String &String::operator+=(const char *r)
{
    return append(r);
}

String &String::operator*=(unsigned short n)
{
    return repeat(n);
}

String String::operator+(const char *r) const
{
    return String(__value).append(r);
}

String String::operator*(unsigned short n) const
{
    return String(__value).repeat(n);
}

////////////////////////////////////////////////////////////////////////////////////

bool String::operator<(const char *r) const
{
    return std::strcmp(__value, r) < 0;
}
bool String::operator>(const char *r) const
{
    return std::strcmp(__value, r) > 0;
}
bool String::operator==(const char *r) const
{
    return !std::strcmp(__value, r);
}
bool String::operator!=(const char *r) const
{
    return std::strcmp(__value, r);
}
bool String::operator<=(const char *r) const
{
    return std::strcmp(__value, r) <= 0;
}
bool String::operator>=(const char *r) const
{
    return std::strcmp(__value, r) >= 0;
}

// end of file
}
