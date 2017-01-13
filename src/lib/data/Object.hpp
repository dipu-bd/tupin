namespace tupin
{
#define OBJECT

template <typename T>
class Object
{
  protected:
    T __value;

  public:
    Object(const T &v) : __value(v) {}
    operator T() const { return __value; }

    operator std::string() const;

    const T &get() const;
    Object<T> &set(const T &);

    int compareTo(const Object<T> &) const;
};

//-------------------------------------------------------------------------
// Member function definitions
//-------------------------------------------------------------------------

template <typename T>
Object<T>::operator std::string() const
{
    return std::to_string(__value);
}

template <typename T>
const T &Object<T>::get() const
{
    return __value;
}

template <typename T>
Object<T> &Object<T>::set(const T &v)
{
    __value = v;
    return *this;
}

template <typename T>
int Object<T>::compareTo(const Object<T> &n) const
{
    if (get() < n.get())
    {
	return -1;
    }
    if (n.get() < get())
    {
	return 1;
    }
    return 0;
}

// end of file
}