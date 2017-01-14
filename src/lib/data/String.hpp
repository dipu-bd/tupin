namespace tupin
{
#define STRING

class String : public Object<char *>
{
  protected:
    int __len;

  public:
    String(const String& v) : Object(v.__value) { }
    String(const char *v = "") : Object(new char[0]) { set(v); }
    String(const std::string &v = "") : Object(new char[0]) { set(v); }

    ~String() { delete __value; }

    operator std::string() const { return __value; }

    void set(const std::string &);
    void set(const char *);
    const char *get() const;

    char at(int) const;
    int size() const;
    String& append(const String &);
    String& repeat(unsigned short);

    String &operator=(const char *);
    String &operator=(const std::string &); 
    String &operator+=(const String &);
    String &operator*=(unsigned short);
    String operator+(const String &) const;
    String operator*(unsigned short)const;

};

//------------------------------------------------------------------------------
// Member functions
//------------------------------------------------------------------------------

void String::set(const char *val)
{
    if (__value) {
		delete __value;
	}
    __value = new char[2];
    std::strcat(__value, val);
    __len = strlen(__value);
}

void String::set(const std::string &val)
{
    set(val.data());
}

const char *String::get() const
{
    return __value;
}

//////////////////

int String::size() const
{
    return __len;
}

char String::at(int i) const
{
    if (i >= 0 && i < __len) {
		return __value[i]; 
	}
	return 0;
}


String& String::append(const String &r) 
{
	std::strcat(__value, r.get());
    __len += r.size();
    return *this;
}

String& String::repeat(unsigned short n) 
{
	char* tmp = new char[10];		// temporary value
    for (int i = sizeof(n) - 1; i >= 0; --i)
    {
		std::strcat(tmp, tmp); 			// doubles previous
		if (n & (1 << i)) {
			std::strcat(tmp, __value); 	// adds one
		}
    }
	delete __value;		// free old value
	__value = tmp;
	__len *= n;
	return *this;
}

//////////////////

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

String &String::operator+=(const String &r) 
{
	return append(r);
}

String &String::operator*=(unsigned short n) 
{
	return repeat(n);
}
 
String String::operator+(const String &r) const 
{
	return String(__value).append(r);
}

String String::operator*(unsigned short n) const
{
	return String(__value).repeat(n);
}

// end of file
}
