.ORIG x3000

    LEA	 R0, WELCOME
    PUTS 
    WELCOME	.STRINGZ "Enter 5 scores:"

    OUT


    JSR INPUT       ;TAKES INPUT FROM USER
    LEA R6, ARRAYS  ;LOAD ADDRESS OF THE ARRAY 
    STR R3, R6, #0   ;STORE R3 TO R6
    JSR CON_LETTER  ; CONVERT NUMBER TO LETTER GRADE
    JSR POP         ; POP THE INPUT

    LD R0, NEWLINE
    OUT


    JSR INPUT       ;TAKES INPUT FROM USER
    LEA R6, ARRAYS  ;LOAD ADDRESS OF THE ARRAY 
    STR R3, R6, #1   ;STORE R3 TO R6
    JSR CON_LETTER  ; CONVERT NUMBER TO LETTER GRADE
    JSR POP         ; POP THE INPUT

    LD R0, NEWLINE
    OUT


    JSR INPUT       ;TAKES INPUT FROM USER
    LEA R6, ARRAYS  ;LOAD ADDRESS OF THE ARRAY 
    STR R3, R6, #2   ;STORE R3 TO R6
    JSR CON_LETTER  ; CONVERT NUMBER TO LETTER GRADE
    JSR POP         ; POP THE INPUT

    LD R0, NEWLINE
    OUT

    

    JSR INPUT       ;TAKES INPUT FROM USER
    LEA R6, ARRAYS  ;LOAD ADDRESS OF THE ARRAY 
    STR R3, R6, #3   ;STORE R3 TO R6
    JSR CON_LETTER  ; CONVERT NUMBER TO LETTER GRADE
    JSR POP           ; POP THE INPUT


    LD R0, NEWLINE
    OUT


    JSR INPUT       ;TAKES INPUT FROM USER
    LEA R6, ARRAYS  ;LOAD ADDRESS OF THE ARRAY 
    STR R3, R6, #4   ;STORE R3 TO R6
    JSR CON_LETTER  ; CONVERT NUMBER TO LETTER GRADE
    JSR POP           ; POP THE INPUT


    LD R0, NEWLINE
    OUT




    ;INPUT SUBROUTINE
    

    INPUT	
            JSR CLEAR_REGISTER		; CLEAR REGISTERS
            


            GETC			; GET FIRST CHAR
            
            OUT			; ECHO INPUT
        
            ADD R1, R0, #0		; COPY INPUT TO R1
            ADD R1, R1, #-16
            ADD R1, R1, #-16	
            ADD R1, R1, #-16	; TRANSLATE TO DECIMAL	
            ADD R2, R2, #10		; CLEAR R2


    MULT__BY_10	ADD R3, R3, R1			; ADD INPUT TO R3, WE DO R3*10
            ADD R2, R2, #-1		; DECREMENT COUNTER 
            BRp MULT__BY_10		; LOOP UNTIL COUNTER IS ZERO SO FINALLY WE CAN GET R3*10

            GETC			    ; GET SECOND CHAR
            
            OUT			
        
            ADD R0, R0, #-16
            ADD R0, R0, #-16
            ADD R0, R0, #-16	; TRANSLATE SECOND INPUT TO DECIMAL
            ADD R3, R3, R0		; ADD FIRST INPUT(X10) TO SECOND INPUT
            

            LD R0, SPACE	    ; ADD  SPACE
            OUT			
 
    RET					







; CON_LETTER SUBROUTINE


    CON_LETTER
        AND R2, R2, #0			; CLEAR R2

A	LD R0, GRADE_A			    ; LOAD NUMBER 
		LD R1, A_LET		    ; LOAD SYMBOL 

		ADD R2, R3, R0		    ; COMPARE INPUT TO VALUE OF GRADE
		BRzp STR_GRADE		    ; IF POS OR ZERO STORE GRADE

B	AND R2, R2, #0
		LD R0, GRADE_B      
		LD R1, B_LET

		ADD R2, R3, R0
		BRzp STR_GRADE

C	AND R2, R2, #0
		LD R0, GRADE_C
		LD R1, C_LET

		ADD R2, R3, R0
		BRzp STR_GRADE

D	AND R2, R2, #0
		LD R0, GRADE_D
		LD R1, D_LET

		ADD R2, R3, R0
		BRzp STR_GRADE

F	AND R2, R2, #0
		LD R0, GRADE_F
		LD R1, F_LET

		ADD R2, R3, R0
		BRNZP STR_GRADE


    RET


    STR_GRADE 	
            AND R0, R0, #0	 	; CLEAR R0
            ADD R0, R1, #0	 	; ADD LETTER TO R0
            JSR PUSH			; PUSH LETTER TO STACK

    RET				 		; RETURN TO MAIN


    GRADE_A .FILL #-90
    GRADE_B .FILL #-80
    GRADE_C .FILL #-70
    GRADE_D .FILL #-60
    GRADE_F .FILL #-50
    A_LET	.FILL x41
    B_LET	.FILL x42
    C_LET	.FILL x43
    D_LET	.FILL x44
    F_LET	.FILL x46







    MAXIMUM
        LD R1, TOTALVAL 	;R1 IS TOTAL TESTS 
        LEA R2, ARRAYS 		;R2 IS THE ADDRESS OF ARRAYS 
        LD R4, ARRAYS		; 1ST ARRAY COMPONENT
        ST R4, MAX_GRADE
        ADD R2, R2, #1

    LOOP_MAX 	LDR R5, R2, #0		; LOAD THE VALUE OF R2 IN R5
        NOT R4, R4
        ADD R4, R4, #1
        ADD R5, R5, R4
        BRp CHANGEMAX
        LEA R0, MAX
        PUTS
        LD R3, MAX_GRADE
        AND R1, R1, #0
        OUT

    LD R0, NEWLINE
    OUT	
    JSR CLEAR_REGISTER



    MINIMUM
        LD R1, TOTALVAL 	;R1 IS TOTAL TESTS
        LEA R2, ARRAYS 		;R2 IS THE ADDRESS OF ARRAYS 
        LD R4, ARRAYS		;  1ST ARRAY COMPONENT
        ST R4, MIN_GRADE
        ADD R2, R2, #1
        ADD R1, R1, #-1

    LOOP_MIN 	LDR R5, R2, #0		
        
        NOT R4, R4
        ADD R4, R4, #1		
        ADD R5, R5, R4
        BRn CHANGEMIN
         ADD R2, R2, #1
        LD R4, ARRAYS
        AND R5, R5,#0
        ADD R1,R1,#-1
        BRp LOOP_MIN

        LEA R0, MIN
        PUTS
        LD R3, MIN_GRADE
        AND R1, R1, #0
        OUT
        
    JSR CLEAR_REGISTER
    LD R0, NEWLINE
    OUT


            
     HALT





    NEWLINE			.FILL x5100
    SPACE			.FILL x5102 
    TOTALVAL		.FILL x5104
 

    MAX_GRADE		.BLKW 1
    MIN_GRADE		.BLKW 1



    CHANGEMIN
        LDR R4, R2, #0
        ST R4, MIN_GRADE
        ADD R2, R2, #1		; ARRAY ITERATION
        ADD R1, R1, #-1		; COUNTER ITERATION
        BRnzp LOOP_MIN

    CHANGEMAX 
        LDR R4, R2, #0
        ST R4, MAX_GRADE
        ADD R2, R2, #1		; ARRAY ITERATION
        ADD R1, R1, #-1		; COUNTER ITERATION
        BRp LOOP_MAX


    ARRAYS 	.BLKW 5

    MIN	.STRINGZ "MIN "
    MAX	.STRINGZ "MAX "
  


    
 
    ;PUSH
PUSH 
  JSR CLEAR_REGISTER		; CLEAR REGISTERS
	LD R6, POINTER		; INITIALIZE POINTER
	ADD R6, R6, #0


	ADD R6, R6, #-1		; DECREMENT POINTER
	STR R0, R6, #0		; STORE NUMBER IN R0 TO STACK
	ST R6, POINTER		; SAVE POINTER LOCATION
	
RET

POINTER	.FILL X4100		; POINTER START LOCATION

    

    ;POP
  POP	LD R6, POINTER		; LOAD POINTER LOCATION
	ADD R1, R1, R6
	LDR R0, R6, #0		; LOAD VALUE IN STACK INTO R0
	OUT			; PRINT NUMBER FROM STACK
	LD R0, SPACE		; LOAD A SPACE
	OUT			; PRINT SPACE

	ADD R6, R6, #1		; INCREMENT POINTER
	
	ST R6, POINTER		; STORE POINTER LOCATION

	
	
RET


 ;CLEAR REGISTER SUBROUTINE
    CLEAR_REGISTER	AND R1, R1, #0
            AND R2, R2, #0
            AND R3, R3, #0
            AND R4, R4, #0
            AND R5, R5, #0
            AND R6, R6, #0
    RET
       
    .END