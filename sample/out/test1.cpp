~test1.tpn:2:1:ID T
~test1.tpn:2:3:yytext[0] =
~test1.tpn:2:8:ID rand
~test1.tpn:2:9:yytext[0] (
~test1.tpn:2:12:INT 100
~test1.tpn:2:13:yytext[0] ,
~test1.tpn:2:16:INT 125
~test1.tpn:2:17:yytext[0] )
~test1.tpn:2:18:yytext[0] ;
~test1.tpn:3:1:yytext[0] [
~test1.tpn:3:2:ID T
~test1.tpn:3:3:yytext[0] ]
~test1.tpn:3:4:yytext[0] ;
~test1.tpn:6:3:FOR for
~test1.tpn:6:5:yytext[0] [
~test1.tpn:6:10:ID range
~test1.tpn:6:11:yytext[0] (
~test1.tpn:6:12:ID T
~test1.tpn:6:13:yytext[0] -
~test1.tpn:6:14:INT 1
~test1.tpn:6:15:yytext[0] )
~test1.tpn:6:16:yytext[0] ]
~test1.tpn:6:18:yytext[0] {
~test1.tpn:7:5:yytext[0] [
~test1.tpn:7:9:STRING "\n"
~test1.tpn:7:14:ID rand
~test1.tpn:7:15:yytext[0] (
~test1.tpn:7:16:INT 0
~test1.tpn:7:17:yytext[0] ,
~test1.tpn:7:19:INT 10
~test1.tpn:7:20:yytext[0] )
~test1.tpn:7:24:STRING " "
~test1.tpn:7:29:ID rand
~test1.tpn:7:30:yytext[0] (
~test1.tpn:7:31:INT 0
~test1.tpn:7:32:yytext[0] ,
~test1.tpn:7:34:INT 10
~test1.tpn:7:35:yytext[0] )
~test1.tpn:7:36:yytext[0] ]
~test1.tpn:7:37:yytext[0] ;
~test1.tpn:8:1:yytext[0] }
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

