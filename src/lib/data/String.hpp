namespace tupin
{
#define STRING

class String : public Object<char *>
{
  protected:
    size_t __len;

  public:
    ~String() 	{ delete __value; }

	String() : Object(new char[0]) { set(""); } 
	template<typename M> String(const M& v) : Object(new char[0]) {	set(v); } 

    void 	clear();
    size_t 	size() const;
    char 	at(size_t) const;
	String&	repeat(unsigned short);

    char&	operator[](size_t i);    	
	String&	operator*=(unsigned short);
    String 	operator*(unsigned short)const;		
 
    template<typename M> void 		set(const M&);

    template<typename M> String&	append(const M&);    
	template<typename M> String&	operator=(const M&);
    template<typename M> String&	operator+=(const M&);	
    template<typename M> String		operator+(const M&) const;

    template<typename M> bool operator<(const M&) const;
    template<typename M> bool operator>(const M&) const;
    template<typename M> bool operator==(const M&) const;
    template<typename M> bool operator!=(const M&) const;
    template<typename M> bool operator<=(const M&) const;
    template<typename M> bool operator>=(const M&) const;

/*
	// Input from stream
    friend std::istream& operator<<(std::istream& is, String& str) {
		std::string tmp;
        is >> tmp; 
		str = tmp;
		return is;
    } 
*/
};

////////////////////////////////////////////////////////////////////////////////////

template <typename T> std::string to_string(T value)
{
    std::ostringstream oss;
    oss << value;
    return oss.str();
}

void String::clear()
{
    __len = 0;
    if (__value)
		delete __value;
}

template<typename M>
void String::set(const M& val)
{
    clear();
    __value = new char[4];
	std::string s = to_string(val);	
    std::strcat(__value, s.data());	
	__len = s.size();
}

size_t String::size() const
{
    return __len;
}

char String::at(size_t i) const
{
    return (i >= 0 && i < __len) ? __value[i] : 0;
}

template<typename M>
String& String::append(const M& r)
{
	std::string s = to_string(r);
    std::strcat(__value, s.data());
    __len += s.size();
    return *this;
}

String& String::repeat(unsigned short n)
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

char& String::operator[](size_t i)
{
    if (i < 0 || i >= __len)
    {
		throw std::out_of_range("Array index out of bound");
    }
	return __value[i];
}

template<typename M>	
String& String::operator=(const M& r)
{
	set(r);
    return *this;
}

template<typename M>	
String &String::operator+=(const M& r)
{
    return append(r);
}
 
String &String::operator*=(unsigned short n)
{
    return repeat(n);
}

template<typename M>	
String String::operator+(const M& r) const
{
    return String(__value).append(r);
}
 
String String::operator*(unsigned short n) const
{
    return String(__value).repeat(n);
}

////////////////////////////////////////////////////////////////////////////////////

template<typename M>
bool String::operator<(const M& r) const
{
	std::string s = to_string(r);
    return std::strcmp(__value, s.data()) < 0;
}

template<typename M>
bool String::operator>(const M& r) const
{
    std::string s = to_string(r);
    return std::strcmp(__value, s.data()) > 0;
}

template<typename M>
bool String::operator==(const M& r) const
{
	std::string s = to_string(r);
    return !std::strcmp(__value, s.data());
}

template<typename M>
bool String::operator!=(const M& r) const
{
	std::string s = to_string(r);
    return std::strcmp(__value, s.data());
}

template<typename M>
bool String::operator<=(const M& r) const
{
	std::string s = to_string(r);
    return std::strcmp(__value, s.data()) <= 0;
}

template<typename M>
bool String::operator>=(const M& r) const
{
	std::string s = to_string(r);
    return std::strcmp(__value, s.data()) >= 0;
}

// end of file
}
