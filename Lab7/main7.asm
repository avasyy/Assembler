format ELF executable 3

;============= invoke modules =============
include 'print.asm'
include 'longop.asm'
include 'module.asm'
;==========================================

entry start                                 ; label of start program

;================= code ===================
segment readable executable
;==========================================

start:
    
    ;-------------------------------------------------------------------
    ; print name of Developer
    ;-------------------------------------------------------------------
    print brd, 30
    print clr, 2
    print dev, lenDev
    print name, lenName
    print brd, 30
    print clr, 2
    ;-------------------------------------------------------------------
    ;-------------------------------------------------------------------
    
    ;-------------------------------------------------------------------
    ; transform value into hex number    
    ;-------------------------------------------------------------------
    push strVal 
    push value
    push 64
    call StrHex_MY
    ;-------------------------------------------------------------------
    ;-------------------------------------------------------------------

    ;-------------------------------------------------------------------
    ; print value 
    ;-------------------------------------------------------------------
    print strVal, 64
    print clr, 2
    print brd, 30
    print clr, 2
    ;-------------------------------------------------------------------
    ;-------------------------------------------------------------------

    ;-------------------------------------------------------------------
    ; division { value / 10 } via procedure DIV_LONGOP_10 
    ;-------------------------------------------------------------------
    push value
    push value
    push 10
    push 2
    call DIV_LONGOP_10
    ;-------------------------------------------------------------------
    ;-------------------------------------------------------------------

    ;-------------------------------------------------------------------
    ; transform result of division into hex number
    ;-------------------------------------------------------------------
    push buff
    push value
    push 64
    call StrHex_MY
    ;-------------------------------------------------------------------
    ;-------------------------------------------------------------------
    
    ;-------------------------------------------------------------------
    ; print result of division
    ;-------------------------------------------------------------------
    print buff, 64
    print clr, 2
    print brd, 30
    print clr, 2
    ;-------------------------------------------------------------------
    ;-------------------------------------------------------------------

    ;-------------------------------------------------------------------
    ; division { value1 / 10 } via procedure DIV_LONGOP_Nx32
    ;-------------------------------------------------------------------
    push value1
    push value1
    push 10
    push 2
    call DIV_LONGOP_Nx32
    ;-------------------------------------------------------------------
    ;-------------------------------------------------------------------
    
    ;-------------------------------------------------------------------
    ; transform result of division into hex number
    ;-------------------------------------------------------------------
    push buff
    push value1
    push 64 
    call StrHex_MY
    ;-------------------------------------------------------------------
    ;-------------------------------------------------------------------
    
    ;-------------------------------------------------------------------
    ; print result of division
    ;-------------------------------------------------------------------
    print buff, 64
    print clr, 2
    print brd, 30
    print clr, 2
    ;-------------------------------------------------------------------
    ;-------------------------------------------------------------------
    
    ;-------------------------------------------------------------------
    ; transform value3 into decimal number
    ;-------------------------------------------------------------------
    push txtDec
    push value3
    push 2
    push 64
    call StrDec_MY
    ;-------------------------------------------------------------------
    ;-------------------------------------------------------------------

    ;-------------------------------------------------------------------
    ; print value3
    ;-------------------------------------------------------------------
    print txtDec, 64
    print clr, 2
    print brd, 30
    print clr, 2
    ;-------------------------------------------------------------------
    ;-------------------------------------------------------------------
    
    ;-------------------------------------------------------------------
    ; calculating of equation
    ;-------------------------------------------------------------------
    mov eax, dword [valueX]
    sub eax, 4
    mov ecx, dword [valueM]
    sub ecx, 3
    shl eax, cl
    mov ebx, dword [valueX]
    add ebx, 4
    xor edx, edx
    div ebx
    mov dword [result], eax
    ;-------------------------------------------------------------------
    ;-------------------------------------------------------------------
    
    ;-------------------------------------------------------------------
    ; transform result of equation in decimal number
    ;-------------------------------------------------------------------
    push txtRes 
    push result
    push 1
    push 64
    call StrDec_MY
    ;-------------------------------------------------------------------
    ;-------------------------------------------------------------------
    
    ;-------------------------------------------------------------------
    ; print result of equation
    ;-------------------------------------------------------------------
    print txtRes, 64
    print clr, 2
    print brd, 30
    print clr, 2 
    ;-------------------------------------------------------------------
    ;-------------------------------------------------------------------

    
;================= exit =================
    mov eax, 1                              ; sys_exit
    mov ebx, 0                              ; code of error
    
    int 0x80
;========================================

;================= data =================
segment readable writeable
;========================================

dev      db "Developer: "                   ; word { developer }
lenDev   = $-dev                            ; length of string { dev }
name     db "Savchenko Yuriy", 0xa, 0xd     ; name of developer
lenName  = $-name                           ; length of string { developer }

buff    db 64 dup(0)                        ; text buffer string for output result
strVal  db 64 dup(0)                        ; text buffer string for output value
txtDec  db 64 dup(0)                        ; text buffer string for output in Dec
txtRes  db 64 dup(0)                        ; text buffer string for output result in Dec
clr     db 0xa, 0xd                         ; step on the new line
brd     db 30 dup ('-')                     ; border

value   dd 3445, 3445                       ; divider
value1  dd 3445, 3445                       ; divider
value2  dd 3445, 3445                       ; divider
value3  dd 17808, 17809                     ; value for transform into decimal number
valueX  dd 5                                ; value X
valueM  dd 10                               ; value M
result  dd 1 dup(0)                         ; result of equation
