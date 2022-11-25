/*
ESE 345 MIPS ASSEMBLER
Group 2: Robert Bacigalupo and Tyler Ovenden

*/


#include <iostream>
#include <string>
#include <algorithm>
#include <sstream>
#include <bitset>
#include <vector>
using namespace std;
enum string_code {
    M_ADDL,
    M_ADDH,
    M_SUBL,
    M_SUBH,
    LONG_MADDL,
    LONG_MADDH,
    LONG_MSUBL,
    LONG_MSUBH,
    ERROR
};
string_code hashit(std::string const& inString);
string convertR3(string instr);
string convertR4(string instr);

int main()
{
    string instr;
    string bin;
    int temp1,temp2;
    cout << "Enter a command \n";
    cin >> instr;
  
  

    std::transform(instr.begin(), instr.end(), instr.begin(), ::toupper); // convert to upper case
    temp1 = instr.find('(');
    temp2 = instr.find(')');
   // cout << instr.substr(temp1+1,(temp2-temp1-1));
   
    cout << instr.substr(0, temp1);
    switch (hashit(instr.substr(0,temp1)))
    {
    // R4 instructions
    case M_ADDL:
        //bin = "10010" + convertR4(instr.substr(temp1, (temp2 - temp1 - 1)));
        bin = convertR4("1,2,3");
        break;
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
    cout << bin;
}
// NEED TO FIX THESE FUNCTIONS

string convertR3(string instr) {
    stringstream test(instr);
    string segment;
    vector<std::string> seglist;
    string rs2, rs1, rd;
    while (std::getline(test, segment, ','))
    {
        seglist.push_back(segment);
    }
    rd = bitset<5>(stoi(seglist[0])).to_string();
    rs1 = bitset<5>(stoi(seglist[1])).to_string();
    rs2 = bitset<5>(stoi(seglist[2])).to_string();
    return rs2 + rs1 + rd;
}
string convertR4(string instr) {
    stringstream test(instr);
    string segment;
    vector<std::string> seglist;
    string rs2, rs1, rs3, rd;
    while (std::getline(test, segment, ','))
    {
        seglist.push_back(segment);
    }
    cout << "R4 conversion\n" << seglist[0] << "\n" << seglist[1] << "\n" << seglist[2] << "\n" << seglist[3] << "\n";
    /*rd = bitset<5>(stoi(seglist[0])).to_string();
    rs1 = bitset<5>(stoi(seglist[1])).to_string();
    rs2 = bitset<5>(stoi(seglist[2])).to_string();
    rs3 = bitset<5>(stoi(seglist[3])).to_string();*/
    return rs2 + rs1 + rd;
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
    else return ERROR;
}