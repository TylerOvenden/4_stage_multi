/*
ESE 345 MIPS ASSEMBLER
Group 2: Robert Bacigalupo and Tyler Ovenden

*/


#include <iostream>
#include <string>
#include <algorithm>
#include <sstream>

enum string_code {
    M_ADDL,
    M_ADDH,
    M_SUBL,
    M_SUBH,
    LONG_MADDL,
    LONG_MADDH,
    LONG_MSUBL,
    LONG_MSUBH
};
string_code hashit(std::string const& inString);
using namespace std;
int main()
{
    string instr;
    int temp1,temp2;
    cout << "Enter a command \n";
    cin >> instr;
    stringstream ss(instr);
    string v1, v2;
    string col, op, eq;
    string var;
  


    std::transform(instr.begin(), instr.end(), instr.begin(), ::toupper); // convert to upper case
    temp1 = instr.find('(');
    cout << temp1 <<"\n"<<(instr.substr(temp1));
    return 0;
    temp2 = instr.find(')');
    cout << instr;


    switch (hashit(instr.substr(temp1)))
    {
        // R4 instructions
    case M_ADDL:

        while (std::getline(ss, token, ',')) {
            std::cout << token << '\n';
        break;
  //  https://stackoverflow.com/questions/11719538/how-to-use-stringstream-to-separate-comma-separated-strings
    case M_SUBL:
        break;
    case M_SUBH:
        break;
    case LONG_MADDL:
        break;
    case LONG_MADDH:
        break;
    case LONG_MSUBL:
        break;
    case LONG_MSUBH:

    default:
        break;
    } 
}


string_code hashit(std::string const& inString) {
    if (inString == "M_ADDL") return M_ADDL;
    if (inString == "M_ADDH") return M_ADDH;
    if (inString == "M_SUBL") return M_SUBL;
    if (inString == "M_SUBH") return M_SUBH;
    //long functions
    if (inString == "LONG_MADDL") return LONG_MADDL;
    if (inString == "LONG_MADDH") return LONG_MADDH;
    if (inString == "LONG_MSUBL") return LONG_MSUBL;
    if (inString == "LONG_MSUBH") return LONG_MSUBH;
}