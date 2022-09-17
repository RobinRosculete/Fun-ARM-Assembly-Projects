;Project #2 Rosculete Robin
.equ SWI_Open, 0x66 ;open a file
.equ SWI_Close,0x68 ;close a file
.equ SWI_PrChr,0x00 ;Write an ASCII char to Stdout-
.equ SWI_PrStr, 0x69 ;Write a null-ending string
.equ SWI_RdStr, 0x6a ;Read a string from a file
.equ Stdout, 1 ;Set output target to be Stdout
.equ SWI_Exit, 0x11 ;Stop execution
.global _start
.text

main:
;;;Opening the input File;;;;
ldr r0,=InFileName      ;Seting name for input file
mov r1,#0               ;Seting mode to input
swi SWI_Open            ;open input file
bcs InFileError         ;Throw error if there is a problem with opening the inputfile
ldr r1,=InFileHandle    ;loading the file handle
str r0,[r1]             ;saving the file handle

;;;;Reading string from input File ;;;;;;
ldr r1, =InFileHandle  ;Loading the input file handle
str r0,[r1]            ;Storing the file handle in memory 
ldr r1,= MyString
mov r2, #100           ;Setting the max number of bytes in r2
swi SWI_RdStr          ;Reading the string from the input file
bcs ReadError          ;Read error check

;;;;Closing  the input file ;;;;; 
ldr r0,=InFileHandle
ldr r0,[r0]
swi SWI_Close

;;saving string from r1 in r10 so we can retrieve the changed string
mov r10, r1 

;;Looping to check characters in the string and make the appropriate 
Loop:
ldrb r7,[r1] ;Reading characters from string one by one

;;;; checking if end of string reached
cmp r7, #0         ;if r7 == 0 end of string is reached
bEQ  EndOfString   ;Go to EndOfString function, terminate loop

;;;;Jumping over special characters
cmp r7, #65        
bLT loopIncrement  ;If ASCII value is less than 65(special char), jump to loopIncrement function

cmp r7, #122
bGT loopIncrement ;If ASCII value is greater than 122(special char), jump to loopIncrement function

cmp r7, #91       ;comparing with '['
bEQ loopIncrement ;If equal => special char => jump over

cmp r7, #92       ;comparing with '\'
bEQ loopIncrement ;If equal => special char => jump over

cmp r7, #93       ;comparing with ']'
bEQ loopIncrement ;If equal => special char => jump over

cmp r7, #94       ;comparing with '^'
bEQ loopIncrement ;If equal => special char => jump over

cmp r7, #95       ;comparing with '_'
bEQ loopIncrement ;If equal => special char => jump over

cmp r7, #96       ;comparing with '`'
bEQ loopIncrement ;If equal => special char => jump over


;;;;;;Checking if character == a,e,i,o,u
cmp r7, #97        ;Comparing r7 with a
subEQ r7,r7,#32    ;if equal uppercase the vowel

cmp r7, #101       ;Comparing r7 with e
subEQ r7,r7,#32    ;if equal uppercase the vowel

cmp r7, #105       ;Comparing r7 with i
subEQ r7,r7,#32    ;if equal uppercase the vowel

cmp r7, #111       ;Comparing r7 with o
subEQ r7,r7,#32    ;if equal uppercase the vowel

cmp r7, #117       ;Comparing r7 with u
subEQ r7,r7,#32    ;if equal uppercase the vowel
strb r7,[r1]       ;loading any new changenges of the string 

;;;;;;Checking if character == A,E,I,O,U, if nconstants replace wit '-'
check_A:        
cmp r7, #65       ;Comparing char with 'A'
bEQ loopIncrement ;If it is equal we jump to looIncrement
bNE check_E       ; if it is not equal we jumpe to check E

check_E:     
cmp r7, #69        ;Comparing char with 'E'
bEQ loopIncrement  ;If it is equal we jump to loopIncrement
bNE check_I        ;if it is not equal we jumpe to check I


check_I:
cmp r7, #73        ;Comparing char with 'I'
bEQ loopIncrement  ;If it is equal we jump to loopIncrement
bNE check_O        ;if it is not equal we jumpe to check O

check_O:
cmp r7, #79        ;Comparing char with 'O'
bEQ loopIncrement  ;If it is equal we jump to loopIncrement
bNE check_U        ;if it is not equal we jumpe to check U

check_U:
cmp r7, #85       ;Comparing char with 'U'
bEQ loopIncrement ;If it is equal we jump to loopIncrement
movNE r7, #45  ;iF it is not equal => char is constant => change constant to '-'

strb r7,[r1]      ;storeing any new changed consanants to '-'

;incrementing loop
loopIncrement:
add r1, r1,#1    ;Increment r1 
b Loop           ; go back to the top of Loop(Looping again)


EndOfString:
;;;;When end of string is reached  we close the Input file ;;;;;
ldr r0,=InFileHandle  
ldr r0,[r0]
swi SWI_Close

;;;Printing changed string to opuput file ;;; 
PrintToOutFile:

;;;Opening ouptut file;;;;;
ldr r0,=OutFileName    ;Set oput file name
mov r1,#1              ;seting mode to output mode
swi SWI_Open           ;Opening file for output
bcs OutFileError       ;Error checking
ldr r1, =OutFileHandle ;loading output file handle
str r0,[r1]            ; saving the file handle

;;;writing string to output file;;;;;
ldr r0,=OutFileHandle  ;load the output file handle
ldr r0,[r0]            ;R0 = file handle
mov r1, r10            ;Seting r1 equla to modified string (r1 = r10)
swi SWI_PrStr          ;output string to file

;;;Printing write succes messsage to Stdout
mov r0, #Stdout
ldr r1, =WriteSuccessMsg
swi SWI_PrStr  

;;;Closing Output file if error occurred;;;;;;;
ldr r0,=OutFileHandle
ldr r0,[r0]
swi SWI_Close
b Exit

;;;;Exit Program;;;;
Exit:
;;;Closing Output file if error occurred;;;;;;;
ldr r0,=OutFileHandle
ldr r0,[r0]
swi SWI_Close

;;;;Closing  the input file if error occurred;;;;; 
ldr r0,=InFileHandle
ldr r0,[r0]
swi SWI_Close

swi SWI_Exit      ;exiting the program

;; Printitng error message for input file error
InFileError:
mov r0, #Stdout
ldr r1, =InFileErrorMsg
swi SWI_PrStr
b Exit         ;Exit program after the error message is printed

;; Printitng error message for output file error
OutFileError:
mov r0, #Stdout
ldr r1, =OutFileErrorMsg
swi SWI_PrStr
b Exit         ;Exit program after the error message is printed

;; Printitng error message for reading string from input file error
ReadError:
mov r0, #Stdout
ldr r1, =ReadErrorMsg
swi SWI_PrStr
b Exit 
 
.data
.align
InFileHandle: .skip 4 ; infile handle 
OutFileHandle: .skip 4 ; out file handle
InFileName: .asciz "input.txt"    ;Input file name
OutFileName: .asciz "output.txt"  ;output file name
InFileErrorMsg: .asciz "Unable to open intput file.\n"    ;Infile open error message
OutFileErrorMsg: .asciz "Unable to open output file.\n"   ;OutFile open error message
ReadErrorMsg: .asciz "Unable to read String from input file.\n"  ;Read string from input file error
WriteSuccessMsg: .asciz "Modified string was successfully printed to the output file\n" ;New string was outputed successgully to the output file
MyString: .skip 100   ;Allocating room for 100 characters
.end