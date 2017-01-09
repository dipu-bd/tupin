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
T = rand(1,125)
['T']
for range(T-1) : [\n'rand(0,10)' 'rand(0,10)']
```

**Explanation**     

- Each third brackets pair is a print command which prints the content inside the brackets exactly as it appears.
- `rand` is a function which returns a random value.
- You can use single quotes inside third brackets to execute a code and print it. Similarly the variable T was printed.
- `for` indicates the start of a loop. Next should be either a variable or a range. A rangle must be defined in the loop (like python, except it is inclusive).
- Every single line is one statement. Statesments can be grouped together with curly brackets. Use semicolon to use multiple statesment in a single line.

---
All the description is of initial plan. It is subject to change with development process.
