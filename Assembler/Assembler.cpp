/*
ESE 345 MIPS ASSEMBLER
Group 2: Robert Bacigalupo and Tyler Ovenden

*/


#include <iostream>
#include <string>
#include <algorithm>
using namespace std;
int main()
{
    string instr;
    int temp;
    cout << "Enter a command";
    cin >> instr;
    
    std::transform(instr.begin(), instr.end(), instr.begin(), ::toupper); // convert to lower case
    temp = instr.find('(');
    switch (instr.substr(temp))
    {
        // R4 instructions
    case "MADD_LS":
        //maybe use sscanf in here to parse the instr itself
        //https://stackoverflow.com/questions/10235682/get-instructions-from-text-file
        break;
    case "MADD_HS":
        break;
    case "MSUB_LS":
        break;
    case "MSUB_HS":
        break;
    case "LONG MADD_LS":
        break;
    case "LONG_MADD_HS":
        break;
    case "LONG_MSUB_LS":
        break;
    case "LONG_MSUB_HS":

    default:
        break;
    }
}

// Run program: Ctrl + F5 or Debug > Start Without Debugging menu
// Debug program: F5 or Debug > Start Debugging menu

// Tips for Getting Started: 
//   1. Use the Solution Explorer window to add/manage files
//   2. Use the Team Explorer window to connect to source control
//   3. Use the Output window to see build output and other messages
//   4. Use the Error List window to view errors
//   5. Go to Project > Add New Item to create new code files, or Project > Add Existing Item to add existing code files to the project
//   6. In the future, to open this project again, go to File > Open > Project and select the .sln file
