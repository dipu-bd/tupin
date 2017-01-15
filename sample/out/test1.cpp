#include "tupin.hpp"
using namespace std;
using namespace tupin;


{
    auto T = rand(100, 125);
    cout << T;
    for (auto __i : (range(T-1))) {
        cout << "\n" << (rand(0, 10)) << " " << (rand(0, 10));
    }
}

int main() {
    return 0;
}
