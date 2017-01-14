namespace tupin
{
#define STRING

class String : public Object<char *>
{
  protected:
    int __len;

  public:
    String(const char *val = "");
    String(const std::string &val = "");
    ~String() { delete __value; }

    const char *get() const;
    void set(const char *val);
    void set(const std::string &val);

    String &operator=(const char *val);
    String &operator=(const std::string &val);
 
    operator std::string() const { return __value; } 
	
	/*
	bool operator<(const String &r) const;
    bool operator>(const String &r) const;
    bool operator==(const String &r) const;
    bool operator!=(const String &r) const;
    bool operator<=(const String &r) const;
    bool operator>=(const String &r) const; */
};

//------------------------------------------------------------------------------
// Constructors
//------------------------------------------------------------------------------
String::String(const char *val) : Object(new char[0])
{
    set(val);
}
String::String(const std::string &val) : Object(new char[0])
{
    set(val);
}

//------------------------------------------------------------------------------
// Set and Get overrides
//------------------------------------------------------------------------------
const char *String::get() const
{
    return __value;
}

void String::set(const char *val)
{
    if (__value)
	delete __value;
    __value = new char[2];
    strcat(__value, val);
    __len = strlen(__value);
}

void String::set(const std::string &val)
{
    set(val.data());
}

//------------------------------------------------------------------------------
// Assignment operator
//------------------------------------------------------------------------------
String &String::operator=(const char *val)
{
    set(val);
    return *this;
}
String &String::operator=(const std::string &val)
{
    set(val.data());
    return *this;
}
/*
//------------------------------------------------------------------------------
// Boolean operations
//------------------------------------------------------------------------------
bool String::operator<(const String &r) const
{
    return strcmp(get(), r.get()) < 0;
}
bool String::operator>(const String &r) const
{
    return strcmp(get(), r.get()) > 0;
}
bool String::operator==(const String &r) const
{
    return !strcmp(get(), r.get());
}
bool String::operator!=(const String &r) const
{
    return strcmp(get(), r.get());
}
bool String::operator<=(const String &r) const
{
    return strcmp(get(), r.get()) <= 0;
}
bool String::operator>=(const String &r) const
{
    return strcmp(get(), r.get()) >= 0;
}
*/
// end of file
}
