###############################################################################
# Title: Assign02P3 Author: Anthony Prejean
# Class: CS 2318, Submitted: 10/30/12
###############################################################################
# Program: MIPS translation of a given C++ program
###############################################################################
# Pseudocode description: supplied a2p2_SampSoln.cpp
###############################################################################

#include <iostream>
#using namespace std;

                   .data

#int  a1[12],
#     a2[12],
#     a3[12];
a1:                .space 48
a2:                .space 48
a3:                .space 48



#char begA1Str[] = "beginning a1: ";
begA1Str:          .asciiz "beginning a1: "

#char proA1Str[] = "processed a1: ";
proA1Str:          .asciiz "processed a1: "

#char comA2Str[] = "          a2: ";
comA2Str:          .asciiz "          a2: "

#char comA3Str[] = "          a3: ";
comA3Str:          .asciiz "          a3: "

#char einStr[]   = "Enter integer #";
einStr:            .asciiz "Enter integer #"

#char moStr[]    = "Max of ";
moStr:             .asciiz "Max of "

#char ieStr[]    = " ints entered...";
ieStr:             .asciiz " ints entered..."

#char emiStr[]   = "Enter more ints? (n or N = no, others = yes) ";
emiStr:            .asciiz "Enter more ints? (n or N = no, others = yes) "

#char dacStr[]   = "Do another case? (n or N = no, others = yes) ";
dacStr:            .asciiz "Do another case? (n or N = no, others = yes) "

#char dlStr[]    = "================================";
dlStr:             .asciiz "================================"

#char byeStr[]   = "bye...";
byeStr:            .asciiz "bye..."

                   .text

#int main()
#{
                   .globl main
main:
#   char reply;
#   int  used1,
#        used2,
#        used3,
#        remCount,
#        anchor;
#   int* hopPtr1;
#   int* hopPtr11;
#   int* hopPtr2;
#   int* hopPtr22;
#   int* hopPtr222;
#   int* hopPtr3;
#   int* endPtr1;
#   int* endPtr2;
#   int* endPtr3;

################################################
# Register usage:
#################
# $a1: endPtr1
# $a2: endPtr2
# $a3: endPtr3
# $t0: temp holder
# $t1: used1
# $t2: used2
# $t3: used3
# $t4: hopPtr1
# $t5: hopPtr2 or remCount (non-overlappingly)
# $t6: hopPtr11 or hopPtr22 (non-overlappingly)
# $t7: hopPtr3 or hopPtr222 (non-overlappingly)
# $t8: reply or anchor (non-overlappingly)
# $t9: temp holder
# $v1: temp holder 
################################################
                   
                                                         
                #//do
begDW1:#//      {
                #used1 = 0;
                li $t1, 0
                #hopPtr1 = a1;
                la $t4, a1
                
                #//do
begDW2:#//       {
                #cout << einStr;
                li $v0, 4
                la $a0, einStr
                syscall
                   
                #cout << (used1 + 1);
                li $v0, 1
                addi $a0, $t1, 1
                syscall
                   
                #cout << ':' << ' ';
                li $v0, 11
                li $a0, ':'
                syscall
                li $a0, ' '
                syscall
                   
                #cin >> *hopPtr1;
                li $v0, 5
                syscall
                sw $v0, 0($t4)
                   
                #++used1;
                addi $t1, $t1, 1
                   
                #++hopPtr1;
                addi $t4, $t4, 4
                   
                #//if (used1 == 12)
                #if (used1 != 12) goto else1;
                li $t0, 12
                bne $t1, $t0, else1
                   
begI1:#//       {
                #cout << moStr;
                li $v0, 4
                la $a0, moStr
                syscall
                      
                #cout << 12;
                li $v0, 1
                li $a0, 12
                syscall
                      
                #cout << ieStr;
                li $v0, 4
                la $a0, ieStr
                syscall
                      
                #cout << endl;
                li $v0, 11
                li $a0, '\n'
                syscall
                     
                #reply = 'n';
                li $v1, 'n'
                      
                #goto endI1;
                j endI1
#//             }
else1:#//       else
#//             {
                #cout << emiStr;
                li $v0, 4
                la $a0, emiStr
                syscall
                      
                #cin >> reply;
                li $v0, 12
                syscall
                move $v1, $v0
                      
endI1:#//         }
#//             }
#               //while (reply != 'n' && reply != 'N');
                j DWTest2
DWTest2:
                #///if (reply != 'n' && reply != 'N') goto begDW2;
                #if (reply == 'n') goto xitDW2;
                li $t8, 'n'
                beq $v1, $t8, xitDW2
                      
                #if (reply != 'N') goto begDW2;
                li $t8, 'N'
                bne $v1, $t8, begDW2
                
xitDW2:

                #cout << begA1Str;
                li $v0, 4
                la $a0, begA1Str
                syscall
                
                #endPtr1 = a1 + used1;
                sll $v1, $t1, 2
                add $a1, $t4, $v1

                #//for (hopPtr1 = a1; hopPtr1 < endPtr1; ++hopPtr1)
                #hopPtr1 = a1;
                la $t4, a1
                
                #goto FTest1;
                j FTest1
                
begF1:#//       {
                #//if (hopPtr1 == endPtr1 - 1)
                #if (hopPtr1 != endPtr1 - 1) goto else2;
                   
                   
begI2:#//       {
                #cout << *hopPtr1 << endl;
                li $v0, 1
                lw $a0, 0($t4)
                syscall
                      
                #goto endI2;
                j endI2
                   
#//             }
else2:#//        else
#//             {
                #cout << *hopPtr1 << ' ';
                li $v0, 1
                lw $a0, 0($t4)
                syscall
                li $a0, ' '
                syscall
endI2:#//       }
                #++hopPtr1;
                addi $t4, $t4, 1
endF1:#//       }
FTest1:
                #if (hopPtr1 < endPtr1) goto begF1;
                blt $t4, $a1, begF1

                #//for (hopPtr1 = a1, hopPtr2 = a2, used2 = 0; hopPtr1 < endPtr1; ++hopPtr1, ++hopPtr2, ++used2)
                #hopPtr1 = a1;
                la $t4, a1
                
                #hopPtr2 = a2;
                la $t5, a2
                
                #used2 = 0;
                la $t2, 0
                
                #goto FTest2;
                j FTest2
                
begF2:#//        {
                #*hopPtr2 = *hopPtr1;
                la $t5, $t4
                
                #++hopPtr1;
                addi $t4, $t4, 4
                
                #++hopPtr2;
                addi $t5, $t5, 4
                
                #++used2;
                addi $t2, $t2, 1
                
endF2:#//         }
FTest2:
                #if (hopPtr1 < endPtr1) goto begF2;
                blt $t4, $a1, begF2

                #endPtr2 = a2 + used2;
                sll $v1, $t2, 2
                add $a2, $t5, $v1

                #//for (hopPtr2 = a2; hopPtr2 < endPtr2; ++hopPtr2)
                
                #hopPtr2 = a2;
                la $t5, a2
                
                #goto FTest3;
                j FTest3
                
begF3:#//        {
                #anchor = *hopPtr2;
                la $t8, $t5

                #//for (hopPtr22 = hopPtr2 + 1; hopPtr22 < endPtr2; ++hopPtr22)
                   
                #hopPtr22 = hopPtr2 + 1;
                addi $t6, $t5, 1
                   
                #goto FTest4;
                j FTest4
                   
begF4:#//       {
                #//if (*hopPtr22 == anchor)
                #if (*hopPtr22 != anchor) goto endI3;
                bne $t6, $t8, endI3
                
begI3:#//       {
                #//for (hopPtr222 = hopPtr22 + 1; hopPtr222 < endPtr2; ++hopPtr222)
                #hopPtr222 = hopPtr22 + 1;
                addi $t7, $t7, 4
                
                #goto FTest5;
                j FTest5
                
begF5:#//       {
                #*(hopPtr222 - 1) = *hopPtr222;
                addi $t7, $t7, -4
                
                #++hopPtr222;
                addi $t7, $t7, 4
                
endF5:#//       }

FTest5:
                #if (hopPtr222 < endPtr2) goto begF5;
                blt $t7, $a2, begF5
                
                #--used2;
                addi $t2, $t2, -1
                
                #--endPtr2;
                addi $a2, $a2, -4
                
                #--hopPtr22;
                addi $t6, $t6, -4
                
endI3:#//      }
                   
                #++hopPtr22;
                addi $t6, $t6, 4
                
endF4:#//      }
FTest4:
               #if (hopPtr22 < endPtr2) goto begF4;
               blt $t6, $a2, begF4
               
               #++hopPtr2;
               addi $t5, $t5, 4
               
endF3:#//      }
FTest3:
               #if (hopPtr2 < endPtr2) goto begF3;
               blt $t5, $a2, begF3

               #used3 = 0;
               li, $t3, 0
               
               #hopPtr3 = a3;
               la, $t7, a3
               
               #hopPtr1 = a1;
               la, $t4, a1

               #//while (hopPtr1 < endPtr1)
               #goto WTest1;
               j WTest1
               
begW1:#//      {
               #*hopPtr3 = *hopPtr1;
               sw $t7, 0($t4)
               
               #++used3;
               addi $t3, $t3, 1
               
               #++hopPtr3;
               addi $t7, $t7, 4
               
               #anchor = *hopPtr1;
               sw $t8, 0($t4)
               
               #remCount = 0;
               li, $t9, 0

                   //for (hopPtr11 = hopPtr1 + 1; hopPtr11 < endPtr1; ++hopPtr11)
                   hopPtr11 = hopPtr1 + 1;
                   goto FTest6;
begF6://           {
                      //if (*hopPtr11 == anchor)
                      if (*hopPtr11 != anchor) goto else4;
begI4://              {
                         ++remCount;
                      goto endI4;
//                    }
else4://              else
//                    {
                         *(hopPtr11 - remCount) = *hopPtr11;
endI4://              }
                   ++hopPtr11;
endF6://           }
FTest6:
                   if (hopPtr11 < endPtr1) goto begF6;

                   used1 -= remCount;
                   endPtr1 -= remCount;
                   ++hopPtr1;
endW1://        }
WTest1:
                if (hopPtr1 < endPtr1) goto begW1;

                cout << proA1Str;

                //for (hopPtr1 = a1; hopPtr1 < endPtr1; ++hopPtr1)
                hopPtr1 = a1;
                goto FTest7;
begF7://        {
                   //if (hopPtr1 == endPtr1 - 1)
                   if (hopPtr1 != endPtr1 - 1) goto else5;
begI5://           {
                      cout << *hopPtr1 << endl;
                   goto endI5;
//                 }
else5://           else
//                 {
                      cout << *hopPtr1 << ' ';
endI5://           }
                ++hopPtr1;
endF7://        }
FTest7:
                if (hopPtr1 < endPtr1) goto begF7;

                cout << comA2Str;

                //for (hopPtr2 = a2; hopPtr2 < endPtr2; ++hopPtr2)
                hopPtr2 = a2; 
                goto FTest8;
begF8://        {
                   //if (hopPtr2 == endPtr2 - 1)
                   if (hopPtr2 != endPtr2 - 1) goto else6;
begI6://           {
                      cout << *hopPtr2 << endl;
                   goto endI6;
//                 }
else6://           else
//                 {
                      cout << *hopPtr2 << ' ';
endI6://           }
                ++hopPtr2;
endF8://        }
FTest8:
                if (hopPtr2 < endPtr2) goto begF8;

                cout << comA3Str;
                endPtr3 = a3 + used3;

                //for (hopPtr3 = a3; hopPtr3 < endPtr3; ++hopPtr3)
                hopPtr3 = a3; 
                goto FTest9;
begF9://        {
                   //if (hopPtr3 == endPtr3 - 1)
                   if (hopPtr3 != endPtr3 - 1) goto else7;
begI7://           {
                      cout << *hopPtr3 << endl;
                   goto endI7;
//                 }
else7://           else
//                 {
                      cout << *hopPtr3 << ' ';
endI7://           }
                ++hopPtr3;
endF9://        }
FTest9:
                if (hopPtr3 < endPtr3) goto begF9;

                cout << endl;
                cout << dacStr;
                cin >> reply;
                cout << endl;
//           }
             //while (reply != 'n' && reply != 'N');
DWTest1:
             ///if (reply != 'n' && reply != 'N') goto begDW1;
             if (reply == 'n') goto xitDW1;
             if (reply != 'N') goto begDW1;
xitDW1:

             cout << dlStr;
             cout << '\n';
             cout << byeStr;
             cout << '\n';
             cout << dlStr;
             cout << '\n';

             return 0;
}

