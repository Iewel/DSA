# C++编程笔记
## 变量和输出
- 变量命名规则
> 变量名可以由字母数字下划线组成，但不能以数字开头
- 变量类型
> 整型（int、short、long、long long）、
> 浮点型（float、double、long double）、
> 字符型（char）、
> 布尔型（bool）。
> 复合数据类型 枚举（enum）、结构体（struct）、联合体（union）和类（class）。

练习

定义初始化一个变量pai_val数值为 3.14， 初始化一个int类型的变量int_val变量值为5，分别输出这两个变量的值。

初始化一个bool变量数值为-100，输出bool变量的值，看看是true还是false。
```cpp
#include<iostream>
using namespace std;

int main(){
float pai_val = 3.14;
int int_val = 5;
cout << pai_val << endl;
cout << int_val << endl;
}
```
## 作用域和存储空间
