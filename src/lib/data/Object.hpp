namespace tupin
{
#define OBJECT_BASE

template <typename T>
class ObjectBase
{
  protected:
    T __value;

  public:
    ObjectBase(const T &v) : __value(v) {}
    operator T() const { return __value; }

    const T &__get() const;
    ObjectBase<T> &__set(const T &);

    operator std::string() const;
};

//-------------------------------------------------------------------------
// Member function definitions
//-------------------------------------------------------------------------

template <typename T>
const T &ObjectBase<T>::__get() const
{
    return __value;
}

template <typename T>
ObjectBase<T> &ObjectBase<T>::__set(const T &v)
{
    __value = v;
    return *this;
}

template <typename T>
ObjectBase<T>::operator std::string() const
{
	return std::to_string(__value);
}

// end of file
}