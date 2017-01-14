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
 
    const T &get() const;
    void set(const T &);

    const char *str() const;
};

//-------------------------------------------------------------------------
// Member function definitions
//-------------------------------------------------------------------------
 
template <typename T>
const char *Object<T>::str() const
{
    return to_string(__value).data();
}

template <typename T>
const T &Object<T>::get() const
{
    return __value;
}

template <typename T>
void Object<T>::set(const T &v)
{
    __value = v;
}

// end of file
}