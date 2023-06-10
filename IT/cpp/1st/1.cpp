#include <iostream>
int main(void)
{
using namespace std;
int ch;
// should be int, not char
int count = 0;
while ((ch = cin.get()) != EOF) // test for end-of-fileLoops and Text Input
{

	cout<<ch;
	cout.put(char(ch));
++count;
}
cout << endl << count << " characters read\n";
int c='c';
cout << c <<endl;
cout.put(char(c))<<endl;
return 0;
}
