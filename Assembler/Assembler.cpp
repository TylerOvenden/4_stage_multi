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
enum class string_code {
    M_ADDL,
    M_ADDH,
    M_SUBL,
    M_SUBH,
    LONG_MADDL,
    LONG_MADDH,
    LONG_MSUBL,
    LONG_MSUBH,
    NOP,
    CLZW,
    AU,
    AHU,
    AHS,
    AND,
    BCW,
    MAXWS,
    MINWS,
    MLHU,
    MLHCU,
    OR,
    PCNTW,
    ROTW,
    SFWU,
    SFHS,
    LDI,
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
    //cout << instr.substr(0, temp1);
    switch (hashit(instr.substr(0,temp1)))
    {
    // R4 instructions
    case string_code::M_ADDL:
        bin = "10000" + convertR4(instr.substr(temp1 + 1, (temp2 - temp1 - 1)));
        break;
    case string_code::M_ADDH:
        bin = "10001" + convertR4(instr.substr(temp1 + 1, (temp2 - temp1 - 1)));
        break;
    case string_code::M_SUBL:
        bin = "10010" + convertR4(instr.substr(temp1 + 1, (temp2 - temp1 - 1)));
        break;
    case string_code::M_SUBH:
        bin = "10011" + convertR4(instr.substr(temp1 + 1, (temp2 - temp1 - 1)));
        break;
    case string_code::LONG_MADDL:
        bin = "10100" + convertR4(instr.substr(temp1 + 1, (temp2 - temp1 - 1)));
        break;
    case string_code::LONG_MADDH:
        bin = "10101" + convertR4(instr.substr(temp1 + 1, (temp2 - temp1 - 1)));
        break;
    case string_code::LONG_MSUBL:
        bin = "10110" + convertR4(instr.substr(temp1 + 1, (temp2 - temp1 - 1)));
        break;
    case string_code::LONG_MSUBH:
        bin = "10111" + convertR4(instr.substr(temp1 + 1, (temp2 - temp1 - 1)));
        break;
    default:
        break;
    }    
}

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
    rd = bitset<5>(stoi(seglist[0])).to_string();
    rs1 = bitset<5>(stoi(seglist[1])).to_string();
    rs2 = bitset<5>(stoi(seglist[2])).to_string();
    rs3 = bitset<5>(stoi(seglist[3])).to_string();
    return rs2 + rs1 + rd;
}
string_code hashit(std::string const& inString) {
    //R4 functions
    if (inString == "M_ADDL") return string_code::M_ADDL;
    if (inString == "M_ADDH") return string_code::M_ADDH;
    if (inString == "M_SUBL") return string_code::M_SUBL;
    if (inString == "M_SUBH") return string_code::M_SUBH;
    //long  R4 functions
    if (inString == "LONG_MADDL") return string_code::LONG_MADDL;
    if (inString == "LONG_MADDH") return string_code::LONG_MADDH;
    if (inString == "LONG_MSUBL") return string_code::LONG_MSUBL;
    if (inString == "LONG_MSUBH") return string_code::LONG_MSUBH;

    if (inString == "NOP") return string_code::NOP;
    if (inString == "AU") return string_code::AU;
    if (inString == "AHU") return string_code::AHU;
    if (inString == "AHS") return string_code::AHS;

    if (inString == "AND") return string_code::NOP;
    if (inString == "BCW") return string_code::AU;
    if (inString == "MAXWS") return string_code::AHU;
    if (inString == "MINWS") return string_code::AHS;

    if (inString == "NOP") return string_code::NOP;
    if (inString == "AU") return string_code::AU;
    if (inString == "AHU") return string_code::AHU;
    if (inString == "AHS") return string_code::AHS;

    if (inString == "AND") return string_code::NOP;
    if (inString == "BCW") return string_code::AU;
    if (inString == "MAXWS") return string_code::AHU;
    if (inString == "MINWS") return string_code::AHS;
    if (inString == "LDI") return string_code::LDI;


    else return string_code::ERROR;
}