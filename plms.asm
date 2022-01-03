DATA SEGMENT
    MENU1 DB '**********MENU**********$'
    MSG1 DB "1. CAR $"
    MSG2 DB "2. JEEP $"
    MSG3 DB "3. BUS $"
    MSG4 DB "4. BIKE $"
    MSG5 DB "5. TRUCK $"
    MSG6 DB "ENTER VEHICLE NUMBER= $"
    MSG7 DB "6. WITHDRAW $"
    MSG8 DB "8. EXIT $"
    MSG10 DB "7. SHOW VEHICLES$"
    AMOUNT DB "AMOUNT TO BE PAID= Rs.$"
    INVALID DB "INVALID VLNO $"
    WRONGIP DB 'WRONG INPUT!$' 
    FULLC DB "PARKING FOR CAR IS FULL!!!!!$"
    FULLJ DB "PARKING FOR JEEP IS FULL!!!!!$"
    FULLB DB "PARKING FOR BUS IS FULL!!!!!$"
    FULLBI DB "PARKING FOR BIKE IS FULL!!!!!$"
    FULLT DB "PARKING FOR TRUCK IS FULL!!!!!$"
    ;STRING DB "1234$" 
    VLNO DB 14 DUP(?),0
    SVLNO DB 14 DUP(?),0
    ;FILE DB 'KL21H1111.TXT',0      ;FILENAME
    MSG DB 'VEHICLE PARKED','$'  ;SUCCESS MESSAGE
    HANDLE DW ?
    TIMEP DW ?
    TIMES DW ?
    RENT DW ?
    DIFF DW ? 
    COUNT EQU 10
    CCOUNT DB '0'
    JCOUNT DB '0'
    BCOUNT DB '0'
    BICOUNT DB '0'
    TCOUNT DB '0'
    CMAX EQU 9
    JMAX EQU 9
    BMAX EQU 9
    BIMAX EQU 9
    TMAX EQU 9
DATA ENDS
CODE SEGMENT
ASSUME CS:CODE,DS:DATA
MENU PROC NEAR      ;MENU
    CALL NEWLINE
    LEA DX,MENU1
    MOV AH,09H
    INT 21H
    CALL NEWLINE
    LEA DX,MSG1
    MOV AH,09H
    INT 21H
    CALL NEWLINE
    LEA DX,MSG2
    MOV AH,09H
    INT 21H
    CALL NEWLINE
    LEA DX,MSG3
    MOV AH,09H
    INT 21H
    CALL NEWLINE
    LEA DX,MSG4
    MOV AH,09H
    INT 21H
    CALL NEWLINE
    LEA DX,MSG5
    MOV AH,09H
    INT 21H
    CALL NEWLINE 
    LEA DX,MSG7
    MOV AH,09H
    INT 21H
    CALL NEWLINE
    LEA DX,MSG10
    MOV AH,09H
    INT 21H
    CALL NEWLINE
    LEA DX,MSG8
    MOV AH,09H
    INT 21H
    RET
MENU ENDP    

VEHIC PROC NEAR      ;VEHICLE
    CALL NEWLINE
    LEA DX,MENU1
    MOV AH,09H
    INT 21H
    CALL NEWLINE
    LEA DX,MSG1
    MOV AH,09H
    INT 21H
    CALL NEWLINE
    LEA DX,MSG2
    MOV AH,09H
    INT 21H
    CALL NEWLINE
    LEA DX,MSG3
    MOV AH,09H
    INT 21H
    CALL NEWLINE
    LEA DX,MSG4
    MOV AH,09H
    INT 21H
    CALL NEWLINE
    LEA DX,MSG5
    MOV AH,09H
    INT 21H
    RET
VEHIC ENDP
FILECREATE PROC NEAR
    CALL NEWLINE 
    LEA DX,MSG6
    MOV AH,09H
    INT 21H 
    LEA SI,VLNO  ;INPUT VLNO I.E FILENAME
    MOV CX,COUNT-1
    L1:MOV AH,01H
       INT 21H
       MOV [SI],AL
       INC SI
       DEC CX
       JNZ L1
    MOV AL,"."                           
    MOV [SI],AL
    INC SI
    MOV AL,"T"
    MOV [SI],AL
    INC SI
    MOV AL,"X"
    MOV [SI],AL
    INC SI
    MOV AL,"T"
    MOV [SI],AL
    MOV DL, 10   ;NEW LINE
    MOV AH, 02h
    INT 21H
    MOV DL, 13
    MOV AH, 02H
    INT 21H  
    ;File Creation Part
    MOV AL,00H                 ; For file creation, AX=3C00H and CX=0000H
    MOV AH,3CH
    LEA DX,VLNO                ; Load the file path to DX
    MOV CX,0000H               ; Create the File, AX=3C00H
    INT 21H
    MOV HANDLE,AX                            
    LEA DX,MSG                
    MOV AH,09H
    INT 21H
    MOV DL, 10   ;NEW LINE
    MOV AH, 02h
    INT 21H
    MOV DL, 13
    MOV AH, 02H
    INT 21H  
    XOR AX,AX
    RET
FILECREATE ENDP
SEAVLNO PROC NEAR
    CALL NEWLINE
    LEA DX,MSG6
    MOV AH,09H
    INT 21H 
    LEA SI,SVLNO  ;INPUT VLNO I.E FILENAME
    MOV CX,COUNT-1
    L2:MOV AH,01H
       INT 21H
       MOV [SI],AL
       INC SI
       DEC CX
       JNZ L2
    MOV AL,"."
    MOV [SI],AL
    INC SI
    MOV AL,"T"
    MOV [SI],AL
    INC SI
    MOV AL,"X"
    MOV [SI],AL
    INC SI
    MOV AL,"T"
    MOV [SI],AL
    RET  
SEAVLNO ENDP 
NEWLINE PROC NEAR
    MOV DL, 10   ;NEW LINE
    MOV AH, 02h
    INT 21H
    MOV DL, 13
    MOV AH, 02H
    INT 21H  
    RET
NEWLINE ENDP
WRITETIME PROC NEAR
    CALL TIME
    MOV AH,3DH
    MOV AL,2H
    LEA DX,VLNO
    INT 21H
    MOV BX,AX
    MOV CX,2
    MOV AH,40H
    LEA DX,TIMEP
    INT 21H
    MOV AH,3EH
    INT 21H
    RET
WRITETIME ENDP
TIME PROC NEAR    ;CALC TIME 
    MOV AH,2CH
    INT 21H
    XOR AX,AX
    MOV DX,3CH  
    MOV AL,CH
    MUL DX
    MOV BX,AX
    MOV CH,0H
    ADD BX,CX
    MOV TIMEP,BX
    RET
TIME ENDP
PRINTVEHICLE PROC NEAR
    CALL NEWLINE
    LEA DX,MSG1
    MOV AH,09H
    INT 21H
    MOV AH,0EH
    MOV AL,CCOUNT
    INT 10H
    CALL NEWLINE
    LEA DX,MSG2
    MOV AH,09H
    INT 21H
    MOV AH,0EH
    MOV AL,JCOUNT
    INT 10H
    CALL NEWLINE
    LEA DX,MSG3
    MOV AH,09H
    INT 21H
    MOV AH,0EH
    MOV AL,BCOUNT
    INT 10H
    CALL NEWLINE
    LEA DX,MSG4
    MOV AH,09H
    INT 21H
    MOV AH,0EH
    MOV AL,BICOUNT
    INT 10H
    CALL NEWLINE
    LEA DX,MSG5
    MOV AH,09H
    INT 21H
    MOV AH,0EH
    MOV AL,TCOUNT
    INT 10H
    CALL NEWLINE
    RET
PRINTVEHICLE ENDP
START:
    MOV AX,DATA
    MOV DS,AX
    XOR AX,AX
    LOOP1:
    CALL MENU
    CALL NEWLINE
    MOV AH,01H
    INT 21H
    CMP AL,'1'
    JZ CAR
    CMP AL,'2'
    JZ  JEEP
    CMP AL,'3'
    JZ BUS
    CMP AL,'4'
    JZ BIKE
    CMP AL,'5'
    JZ TRUCK
    CMP AL,'6'
    JZ DELETE
    CMP AL,'7'
    JZ PVEHICLE
    CMP AL,'8'
    JZ EXIT    
    CALL NEWLINE
    MOV DX,OFFSET WRONGIP
    MOV AH,9
    INT 21H
    
    MOV DX,10
    MOV AH,2
    INT 21H
    JMP LOOP1
                 ;CHAR PRINT 
      
    MOV AH,0EH
    MOV AL,CCOUNT
    INT 10H
    CAR:             ;CAR
        MOV AH,CCOUNT
        CMP AH,'3'
        JNZ CONT
        CALL NEWLINE
        MOV DX,OFFSET FULLC
        MOV AH,09H
        INT 21H
        JMP LOOP1
     CONT:
        INC CCOUNT
        CALL FILECREATE
        CALL WRITETIME
        JMP LOOP1
    JEEP:           ;JEEP
        MOV AH,JCOUNT
        CMP AH,'3'
        JNZ CONT2
        CALL NEWLINE
        MOV DX,OFFSET FULLJ
        MOV AH,09H
        INT 21H
        JMP LOOP1
     CONT2:
        INC JCOUNT
        CALL FILECREATE
        CALL WRITETIME
        JMP LOOP1
    BUS:          ;BUS
        MOV AH,BCOUNT
        CMP AH,'3'
        JNZ CONT3
       CALL NEWLINE
       MOV DX,OFFSET FULLB
        MOV AH,09H
        INT 21H
        JMP LOOP1
     CONT3:
        INC BCOUNT
        CALL FILECREATE
        CALL WRITETIME
        JMP LOOP1
    BIKE:          ;BIKE
        MOV AH,BICOUNT
        CMP AH,'3'
        JNZ CONT4
        CALL NEWLINE
        MOV DX,OFFSET FULLBI
        MOV AH,09H
        INT 21H
        JMP LOOP1
     CONT4:
        INC BICOUNT
        CALL FILECREATE
        CALL WRITETIME
        JMP LOOP1
    TRUCK:        ;TRUCK
        MOV AH,TCOUNT
        CMP AH,'3'
        JNZ CONT5
        CALL NEWLINE
        MOV DX,OFFSET FULLT
        MOV AH,09H
        INT 21H
        JMP LOOP1
     CONT5:
        INC TCOUNT
        CALL FILECREATE
        CALL WRITETIME
        JMP LOOP1             
            
    DELETE:
        CALL SEAVLNO
        MOV AH,3DH
        MOV AL,2H
        LEA DX,SVLNO
        INT 21H
        CMP AX,'5'
        JZ INVAL
        MOV BX,AX
        MOV AH,3FH
        MOV CX,2
        LEA DX,TIMES
        INT 21H
        CALL TIME 
        CALL NEWLINE
        MOV CX,TIMES
        MOV BX,TIMEP
        SUB BX,CX
        CHECK:CALL VEHIC
            CALL NEWLINE
            MOV AH,01H
            INT 21H
            CMP AL,'1'
            JZ DCAR
            CMP AL,'2'
            JZ  DJEEP
            CMP AL,'3'
            JZ DBUS
            CMP AL,'4'
            JZ DBIKE
            CMP AL,'5'
            JZ DTRUCK
            JMP CHECK
        DCAR:DEC CCOUNT
             MOV DX,5 
             MOV AX,BX
             MUL DX
             JMP CONTI
        DJEEP:DEC JCOUNT
             MOV DX,5 
             MOV AX,BX
             MUL DX
             JMP CONTI
        DBUS:DEC BCOUNT
             MOV DX,10 
             MOV AX,BX
             MUL DX
             JMP CONTI
        DBIKE:DEC BICOUNT
             MOV DX,3 
             MOV AX,BX
             MUL DX
             JMP CONTI
        DTRUCK:DEC TCOUNT
             MOV DX,10 
             MOV AX,BX
             MUL DX
             JMP CONTI
        CONTI:
        MOV BX,AX
        CALL NEWLINE
        LEA DX,AMOUNT
        MOV AH,09H
        INT 21H
        MOV AX,BX
        AAM
        MOV BX,AX
        MOV DL,BH
        ADD DL,30H
        MOV AH,02H
        INT 21H
        MOV DL,BL
        ADD DL,30H
        MOV AH,02H
        INT 21H
        JMP LOOP1
        INVAL:
            LEA DX,INVALID
            MOV AH,09H
            INT 21H
            JMP LOOP1
    PVEHICLE:
        CALL PRINTVEHICLE
        JMP LOOP1        
    EXIT:
    MOV AH,4CH
    INT 21H
    HLT
CODE ENDS
END START