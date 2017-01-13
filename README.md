# tupin
A scripting language for generating sample inputs like a hot knife through butter.       

### Example (now project goal)   

**Problem:** *[1000 - Greetings from LightOJ](http://www.lightoj.com/volume_showproblem.php?problem=1000)*

**Input Description:**     
Input starts with an integer T (≤ 125), denoting the number of test cases.

Each case starts with a line containing two integers a and b. a denotes the number of problems in the first computer and b denotes the number of problems in the second computer. You can safely assume that a and b will be non-negative and not greater than 10.

**Sample Input:**   
```
2
1 7
9 8
```   

***tupin*** **code**     
```c++
/* LightOJ 10000 */

T = rand(100,125); // get a random between 100 and 125, inclusive
[T];    // prints T

/* loops from 0 to T - 1 */
for range(T-1) { 
    ['\n' rand(0,10) ' ' rand(0,10)];   // prints two space separated numbers
}
```

---
All the description is of initial plan. It is subject to change with development process.
