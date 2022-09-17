;Project #1 Rosculete Robin
.equ SWI_Open, 0x66 ;open a file
.equ SWI_Close,0x68 ;close a file
.equ SWI_PrChr,0x00 ; Write an ASCII char to Stdout
.equ SWI_PrStr, 0x69 ; Write a null-ending string
.equ SWI_PrInt,0x6b ; Write an Integer
.equ SWI_RdInt,0x6c ; Read an Integer from a file
.equ Stdout, 1 ; Set output target to be Stdout
.equ SWI_Exit, 0x11 ; Stop execution
.global _start
.text

_start:
;;;;;Opening File;;;;;;
mov r1, #0                ;seting mode to input
ldr r0, =InFileName       ;Copying memory address of input file
swi SWI_Open              ;Opening input file
bcs InFileError           ;Error checking
mov r4, r0                ;saving file handle in r4

mov r5, #0                ;using r5 to store the count of integers less than or equal to x
mov r6, #0                ;using r6 to store the count the values of the total int in the file

;;;;;;Reading and printing first int "x" ;;;;;;
mov r0, r4
swi SWI_RdInt             ;reding first int from input file "x"
mov r1, r0                ;r1 integer to print
mov r0, #Stdout           ;Printing to stdOut
swi SWI_PrInt             ;printing first  int "x"
mov r3,r1                 ;saving first integer from input file
CMP r1, r3                ;Compareing r1 and r3 (x and x)
ADDLE r5,r5,#1            ;incrementing r5 if r3 <= to r1


mov R0,#Stdout            ; print new line
ldr r1, =NL
swi SWI_PrStr             ;Printing a new line

;;;;;;Reading and printing second int  "y" ;;;;;;
mov r0,r4                 ; recalling file handle
swi SWI_RdInt             ;Reading second int  "y"
mov r1, r0
mov r0,#Stdout            ;Printing to stdOut
swi SWI_PrInt             ;printing second int "y"

CMP r1, r3                ;Compareing r1 and r3 (y and x)
ADDLE r5,r5,#1            ;incrementing r5 if r3 <= to r1
ADD r6,r6,#2              ;Adding the 2 which represents the first two integers in input file


ldr r1, =NL
swi SWI_PrStr             ;Printing a new line

;;;Looping through the remainign of input file
Loop:
mov r0,r4
swi SWI_RdInt
bcs EofReached  ;If failed to read int, we exit the loop (Eof reached)
mov r1,r0

CMP r1, r3              ;Compareing r1 and r3(All the integers in the input file and x)
ADDLE r5,r5,#1          ;incrementing r5 if r3 <= to r1

ADD r6,r6,#1            ;incrementing r6 (Count of int in file)
bal Loop

;;;;; End of file Reached;;;;;
EofReached:
;;;Printing the final count of integers that are <= to x
mov r1, r5
mov r0,#Stdout           ;Printing to stdOut
swi SWI_PrInt            ;printing second int "y"


ldr r1, =NL
swi SWI_PrStr            ;Printing a new line

;;;Printing the total count of integers in input file
mov r1, r6
swi SWI_PrInt             ;printing second int "y"

ldr r1, =NL
swi SWI_PrStr             ;Printing a new line

;;;;Priunting the last message

ldr R1, =EndOfFileMsg
swi SWI_PrStr

;;;Closing the File;;;;
mov r0,r4
swi SWI_Close

;;;;Exit Program;;;;
Exit:
swi SWI_Exit      ;exiting the program

InFileError:
mov r0, #Stdout
ldr r1, =FileOpenInpErrMsg
swi SWI_PrStr
bcs Exit         ;Exit program after the error message is printed

.data
.align
InFileName: .asciz "integers.dat"
FileOpenInpErrMsg: .asciz "Could not open intputfile"
EndOfFileMsg: .asciz "End of file reached\n"
NL: .asciz "\n" ; new line
.end