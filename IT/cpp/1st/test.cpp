#include<iostream>
#include<iomanip>
#include<string>
#include<cmath>
#include<fstream>
#include<cstring>
using namespace std;

struct leader
{
	char name[20];
	char id_num[20];
	int age;
};


int main()
{
	leader Xi =
	{
		"Xi Jinping",
		"110101195306153019",
		69
	};
	leader Peng =
	{
		"Peng Liyuan",
		"11010819621120576X",
		60
	};
	char ch;
	int count = 0;
	cin.get(ch);
	while ( cin.fail() == false)
	{
		cout << ch;
		++ count;
		cin.get(ch);
	}
	cout << endl << count << " characters read \n";
	cin.clear();
	cout << "Our great leader is " << Xi.name;
	cout << " and his wife is " << Peng.name << "." << endl;
	cout << Xi.name << "'s id number is " << Xi.id_num;
        cout << " and that of his wife is " << Peng.id_num << "." << endl;	
	for(int i=0; i<20; i++)
	{
		cout << Xi.name[i];
	}
	cout << endl;
	cout << &Xi.name << endl;
	cout << "size of Xi is " << sizeof(Xi.name) << endl;
	const char * Xijinping = "dictator";
        char * ps;
	cout << Xi.name << " is " << Xijinping << endl;
	cout << "who is Xi's dad? \n";
	cin.getline(Xi.name,20);
	
	ps =  Xi.name;
	cout << "before strcpy(): \n";
	cout << Xi.name << " at " << (int *) Xi.name << endl;
	cout << ps << " at " << (int *) ps << endl;
	ps = new char[strlen(Xi.name) + 1 ];
	strcpy(ps, Xi.name);
	cout << "after strcpy(): \n";
	cout << Xi.name << " at " << (int *) Xi.name << endl;
	cout << ps << " at " << (int *) ps << endl;
	delete [] ps;
	const char * a = "Xi Jinping is red sun. ";
        cout << a << endl;	
	return 0;
}
