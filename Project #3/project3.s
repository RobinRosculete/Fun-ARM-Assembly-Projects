;Project #3 Robin Rosculete 

;Figure 16, 8-segment display aliases
.equ SEG_A,0x80
.equ SEG_B,0x40 
.equ SEG_C,0x20 
.equ SEG_D,0x08 
.equ SEG_E,0x04 
.equ SEG_F,0x02 
.equ SEG_G,0x01 
.equ SEG_P,0x10

;Setting values to light up multiple segments at a time, of the 8 segment display
.equ ZERO, SEG_A|SEG_B|SEG_C|SEG_D|SEG_E|SEG_G
.equ ONE, SEG_B|SEG_C
.equ TWO, SEG_A|SEG_B|SEG_F|SEG_E|SEG_D
.equ THREE, SEG_A|SEG_B|SEG_F|SEG_C|SEG_D
.equ FOUR, SEG_G|SEG_F|SEG_B|SEG_C
.equ FIVE, SEG_A|SEG_G|SEG_F|SEG_C|SEG_D
.equ SIX, SEG_A|SEG_G|SEG_F|SEG_E|SEG_D|SEG_C
.equ SEVEN, SEG_A|SEG_B|SEG_C
.equ EIGHT, SEG_A|SEG_B|SEG_C|SEG_D|SEG_E|SEG_F|SEG_G
.equ NINE, SEG_A|SEG_B|SEG_C|SEG_D|SEG_F|SEG_G
.equ E, SEG_A|SEG_G|SEG_F|SEG_E|SEG_D
.equ OFF, 0


;Start up function, to return everything to the start up state, in case of reset
startUp:
swi 0x206    ;clearing the LCD Display

mov r0,#OFF  ;Setting r0 to #OFF, to turn of the 8-Segment dispaly
swi 0x200    ;Turning off the 8-Segment dispaly

;Displaying 0 to the LCD screen
mov r0,#4   
mov r1,#1
mov r2, #OFF
swi 0x205  ;display a integer to the LCD screen


mainLoop:
 
swi 0x202        ;checking if one of the black button has been pressed

cmp r0,#0x01     ;checking if the black left black button
bEQ startUp      ;If black button pressed we reset the program

cmp r0,#0x02     ;checking if the black right black button has been pressed
bEQ startUp      ;If black button pressed we reset the program

swi 0x203         ;checking if one of the blue button has been pressed

cmp r0,#0x01      ;Checking if one of the unassigned buttons is pressed
movEQ r0, #E      ;If preseed set r0 to #E
swiEQ 0x200       ;Display E on the 8 segment display
bEQ  ErrorFunction  ;If one of the unassigned buttons is pressed jump to errorFunction

cmp r0,#0x02      ;Checking if the blue button representing 7 has been pressed
movEQ r0, #SEVEN  ;If pressed set r0 to #SEVEN
swiEQ 0x200       ;light up the 8 segment Display to print 7
addEQ r2, r2,#7   ;if equal Add 7 to r2
bEQ  Display       ;if equal Jumpt to Display function, to display new sum to LCD screen

cmp r0,#0x04      ;Checking if the blue button representing 8 has been pressed
movEQ r0, #EIGHT  ;If pressed set r0 to #EIGHT
swiEQ 0x200       ;light up the 8 segment Display to print 8
addEQ r2, r2,#8   ;if equal Add 8 to r2
bEQ  Display      ;if equal Jumpt to Display function, to display new sum to LCD screen

cmp r0,#0x08      ;Checking if the blue button representing 9 has been pressed
movEQ r0, #NINE   ;If pressed set r0 to #NINE
swiEQ 0x200       ;light up the 8 segment Display to print 9
addEQ r2, r2,#9   ;if equal Add 9 to r2
bEQ  Display      ;if equal Jumpt to Display function, to display new sum to LCD screen

cmp r0,#0x10     ;Checking if one of the unassigned buttons is pressed
movEQ r0, #E     ;If preseed set r0 to #E
swiEQ 0x200      ;Display E on the 8 segment display
bEQ  ErrorFunction ;If one of the unassigned buttons is pressed jump to errorFunction

cmp r0,#0x20       ;Checking if the blue button representing 4 has been pressed
movEQ r0, #FOUR    ;If pressed set r0 to #FOUR
swiEQ 0x200        ;light up the 8 segment Display to print 4
addEQ r2, r2,#4    ;if equla Add 4 to r2
bEQ  Display       ;if equal Jump to Display function, to display new sum to LCD screen

cmp r0,#0x40      ;Checking if the blue button representing 5 has been pressed
movEQ r0, #FIVE   ;If pressed set r0 to #FIVE
swiEQ 0x200       ;light up the 8 segment Display to print 5
addEQ r2, r2,#5   ;if equal Add 5 to r2
bEQ  Display      ;if equal Jump to Display function, to display new sum to LCD screen

cmp r0,#0x80      ;Checking if the blue button representing 6 has been pressed
movEQ r0, #SIX    ;If pressed set r0 to #SIX
swiEQ 0x200       ;light up the 8 segment Display to print 6
addEQ r2, r2,#6   ;if equal Add 6 to r2
bEQ  Display      ;if equal Jump to Display function, to display new sum to LCD screen

cmp r0,#0x100    ;Checking if one of the unassigned buttons is pressed
movEQ r0, #E     ;If preseed set r0 to #E
swiEQ 0x200      ;Display E on the 8 segment display
bEQ  ErrorFunction       ;If one of the unassigned buttons is pressed jump to errorFunction

cmp r0,#0x200     ;Checking if the blue button representing 1 has been pressed
movEQ r0, #ONE    ;If pressed set r0 to #ONE
swiEQ 0x200       ;light up the 8 segment Display to print 1
addEQ r2, r2,#1   ;if equal Add 1 to r2
bEQ  Display      ;if equal Jump to Display function, to display new sum to LCD screen

cmp r0,#0x400     ;Checking if the blue button representing 2 has been pressed
movEQ r0, #TWO    ;If pressed set r0 to #TWO
swiEQ 0x200       ;light up the 8 asegment Display to print 2
addEQ r2, r2,#2   ;if equal Add 2 to r2
bEQ  Display      ;if equal Jump to Display function, to display new sum to LCD screen

cmp r0,#0x800     ;Checking if the blue button representing 3 has been pressed
movEQ r0, #THREE  ;If pressed set r0 to #THREE
swiEQ 0x200       ;light up the 8 segment Display to print 3
addEQ r2, r2,#3   ;if equal Add 3 to r2
bEQ  Display      ;if equal Jump to Display function, to display new sum to LCD screen

cmp r0,#0x1000    ;Checking if one of the unassigned buttons is pressed
movEQ r0, #E      ;If preseed set r0 to #E
swiEQ 0x200       ;Display E on the 8 segment display
bEQ  ErrorFunction  ;If one of the unassigned buttons is pressed jump to errorFunction

cmp r0,#0x2000    ;Checking if one of the unassigned buttons is pressed
movEQ r0, #E      ;If preseed set r0 to #E
swiEQ 0x200       ;Display E on the 8 segment display
bEQ  ErrorFunction ;If one of the unassigned buttons is pressed jump to errorFunction

cmp r0,#0x4000    ;Checking if the blue button representing 0 has been pressed
movEQ r0, #ZERO   ;If pressed set r0 to #ZERO
swiEQ 0x200       ;light up the 8 segment Display to print 0

cmp r0,#0x8000     ;Checking if one of the unassigned buttons is pressed
movEQ r0, #E       ;If preseed set r0 to #E
swiEQ 0x200        ;Display E on the 8 segment display
bEQ  ErrorFunction  ;If one of the unassigned buttons is pressed jump to errorFunction


;Function purpose, to display the new sum stored in r2 to the LCD screen
Display: 
mov r0,#4
mov r1,#1
swi 0x205  ;display a integer to the LCD screen

bAL mainLoop  ;End mainLoop
 
;If unassingned blue button has been pressed we print error msg to screen then loop until user resets program
ErrorFunction:
swi 0x206    ;clearing the LCD Display

;Displaying error message to the LCD screen
mov r0,#4   
mov r1,#1
ldr r2,  =errorMessage
swi 0x204  ;display a string to the LCD screen

;Loop until the user presses a black button to reset the program
errorLoop:
swi 0x202        ; checking if one of the black buttons has been pressed
cmp r0,#0x01     ;checking if the black left black button
bEQ startUp      ;If black button pressed we reset the program

cmp r0,#0x02     ;checking if the black right black button has been pressed
bEQ startUp      ;If black button pressed we reset the program 

bNE errorLoop    ;If black button not pressed we loop again

errorMessage: .asciz "Error!Press black button to reset!" ;error masseaage in case user unassigned buttons
