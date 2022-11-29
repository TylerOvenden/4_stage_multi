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
#include <fstream>
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
string convertLDI(string instr);
int main()
{
    string instr;
    string bin;
    int temp1,temp2;
  
    ifstream input;
    ofstream output;
    output.open("binary.txt", ios::out);
    if (!output) {
        cout << "ERROR, Couldn't open output";
        return -1;
    }
    input.open("instructions.txt", ios::in);

    if (!input) {
        instr = "ERROR()";
        output << "ERROR";
        output.close();
        return -1;
    }
    while (input) {
        try {
            bin.clear();
            instr.clear();
            getline(input, instr);

            std::transform(instr.begin(), instr.end(), instr.begin(), ::toupper); // convert to upper case
            temp1 = instr.find('(');
            temp2 = instr.find(')');
            // cout << instr.substr(temp1+1,(temp2-temp1-1));
             //cout << instr.substr(0, temp1);
            switch (hashit(instr.substr(0, temp1)))
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
            case string_code::NOP:
                bin = "1100000000000000000000000";
                break;
            case string_code::CLZW:
                bin = "1100000001" + convertR3(instr.substr(temp1 + 1, (temp2 - temp1 - 1)));
                break;
            case string_code::AU:
                bin = "1100000010" + convertR3(instr.substr(temp1 + 1, (temp2 - temp1 - 1)));
                break;
            case string_code::AHU:
                bin = "1100000011" + convertR3(instr.substr(temp1 + 1, (temp2 - temp1 - 1)));
                break;
            case string_code::AHS:
                bin = "1100000100" + convertR3(instr.substr(temp1 + 1, (temp2 - temp1 - 1)));
                break;
            case string_code::AND:
                bin = "1100000101" + convertR3(instr.substr(temp1 + 1, (temp2 - temp1 - 1)));
                break;
            case string_code::BCW:
                bin = "1100000110" + convertR3(instr.substr(temp1 + 1, (temp2 - temp1 - 1)));
                break;
            case string_code::MAXWS:
                bin = "1100000111" + convertR3(instr.substr(temp1 + 1, (temp2 - temp1 - 1)));
                break;
            case string_code::MINWS:
                bin = "1100001000" + convertR3(instr.substr(temp1 + 1, (temp2 - temp1 - 1)));
                break;
            case string_code::MLHU:
                bin = "1100001001" + convertR3(instr.substr(temp1 + 1, (temp2 - temp1 - 1)));
                break;
            case string_code::MLHCU:
                bin = "1100001010" + convertR3(instr.substr(temp1 + 1, (temp2 - temp1 - 1)));
                break;
            case string_code::OR:
                bin = "1100001011" + convertR3(instr.substr(temp1 + 1, (temp2 - temp1 - 1)));
                break;
            case string_code::PCNTW:
                bin = "1100001100" + convertR3(instr.substr(temp1 + 1, (temp2 - temp1 - 1)));
                break;
            case string_code::ROTW:
                bin = "1100001101" + convertR3(instr.substr(temp1 + 1, (temp2 - temp1 - 1)));
                break;
            case string_code::SFWU:
                bin = "1100001110" + convertR3(instr.substr(temp1 + 1, (temp2 - temp1 - 1)));
                break;
            case string_code::SFHS:
                bin = "1100001111" + convertR3(instr.substr(temp1 + 1, (temp2 - temp1 - 1)));
                break;
            case string_code::LDI:
                bin = "0" + convertLDI(instr.substr(temp1 + 1, (temp2 - temp1 - 1)));
                break;
            default:
                bin = "\n";
                break;
            }
            output << bin << "\n";
        }
        catch (...) {
            output << "ERROR" << "\n";
        }
    }
    output.close();
    input.close();
    return 0;
}


string convertLDI(string instr) {
    stringstream test(instr);
    string segment;
    vector<std::string> seglist;
    string ind, imm, rd;
    while (std::getline(test, segment, ','))
    {
        seglist.push_back(segment);
    }
    rd = bitset<5>(stoi(seglist[0])).to_string();
    imm = bitset<16>(stoi(seglist[1])).to_string();   
    ind = bitset<3>(stoi(seglist[2])).to_string();
    return imm + ind + rd;
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
    return rs3 + rs2 + rs1 + rd;
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
    if (inString == "CLZW") return string_code::CLZW;
    if (inString == "AU") return string_code::AU;
    if (inString == "AHU") return string_code::AHU;
    if (inString == "AHS") return string_code::AHS;

    if (inString == "AND") return string_code::NOP;
    if (inString == "BCW") return string_code::BCW;
    if (inString == "MAXWS") return string_code::MAXWS;
    if (inString == "MINWS") return string_code::MINWS;

    if (inString == "MLHU") return string_code::MLHU;
    if (inString == "MLHCU") return string_code::MLHCU;
    if (inString == "OR") return string_code::OR;
    if (inString == "PCNTW") return string_code::PCNTW;

    if (inString == "ROTW") return string_code::ROTW;
    if (inString == "SFWU") return string_code::SFWU;
    if (inString == "SFHS") return string_code::SFHS;
    if (inString == "LDI") return string_code::LDI;


    else return string_code::ERROR;
}