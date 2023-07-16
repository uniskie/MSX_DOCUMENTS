; =======================================
; Plot LOGO for MSX2+ with antialiasing
; to insert in MSXKANJI.ROM.(A1WSX ver.)
; Binary result: MSXKANJIFIX.ROM
; Size of logo: 422*80 dots
; Hex Editor Address: $399d - $3fff
; Modified by KdL 2013.05.12
; Coded in TWZ'CA3 w/ TASM80 v3.2ud
; =======================================

    .org    07A00h - 99         ; StartProg - MainProg = 99 bytes               <---------------------
;   .org    0100h               ; MSXEX.COM

MainProg:
    jp      startProg           ; filler of 3 bytes -> useful for MSXEX.COM
;\------------------------------
Line_EX_COM:
    push    de
    ld  e, 70h                  ; Line Execution Command
loc_7C2F:
    ld  d, 2Eh                  ; R#46 - Command Register
    call    wr_dat2reg
    call    wait_CE
    pop de
    ret
; ==============================
sub_7C3E:
    ld  a, 0Dh                  ; RTC#13 mode register
    out (0B4h), a
    in  a, (0B5h)
    and 0Ch
    or  2
    out (0B5h), a               ; Select Block 2
    ld  a, 0Bh                  ; Register Color/Title
    out (0B4h), a
    in  a, (0B5h)               ; (Color/Title) -> Code (Color)=0..3
    rlca
;   rlca
    and 06h                     ; 0Ch by default
    ld  c, a
    ld  b, 0
    ld  hl, tab_7CA4            ; Color table
    add hl, bc
    ld  c, (hl)
    inc hl
    ld  b, (hl)
    push    bc
;   inc hl
;   ld  e, (hl)
;   inc hl
;   ld  d, (hl)
;   ex  de, hl
; Set Palette Register address
    ld  de, 1000h               ; 00H -> R#16
    call    wr_dat2reg
; Set Palette Register 0...7
    ld  hl, 0000h               ; 0/0/0 -> black
    call    sub_7C7A
    pop hl                      ; RED/BLUE/GREEN -> bg color
    call    sub_7C7A
    ld  hl, 0444h               ; 4/4/4 -> gray
    call    sub_7C7A
    ld  hl, 0777h               ; 7/7/7 -> white
; ==============================
sub_7C7A:
    push    bc
    ld  c, 9Ah
    out (c), l
    ex  (sp), hl
    ex  (sp), hl
    out (c), h
    pop bc
    ret
; ==============================
init_VDP:
    ld  b, 8
    ld  hl, tab_7C94            ; 08h -> R#0
loc_7C8A:
    ld  d, (hl)                 ; R#n
    inc hl
    ld  e, (hl)                 ; Data
    inc hl
    call    wr_dat2reg
    djnz    loc_7C8A
    ret
; ==============================
startProg:                      ; 3A00h of MSXKANJI.ROM, 7A00h of MSX memory    <---------------------
    di
    call    sub_7ADA            ; Init
    call    sub_7A09            ; View
    ei
    ret                         ; Exit
loop4DOS:
;   jr      loop4DOS            ; Loop test for MSXEX.COM
;   
; ==============================
; View LOGO
sub_7A09:
    ld  hl, 00FFh               ;
    call    sub_7A9F            ;
;
    ld  e, h
    ld  d, 1Ah                  ; R#26
    call    wr_dat2reg
    ld  e, l
    ld  d, 1Bh                  ; R#27
    call    wr_dat2reg
;
    call    sub_7A83            ; Wait 2 VR
;
    ld  de, 0163h
    call    wr_dat2reg          ; 63h -> R#1
    ld  hl, 00E1h
    ld  de, 0FFF6h
loc_7A2A:
    inc de                      ;
    ld  b, 5
loc_7A2D:
    push    bc
    push    de
    call    sub_7A48
    pop de
    pop bc
    add hl, de
    djnz    loc_7A2D
;\------------------------------
    ld  a, e
    or  a
    jr  nz, loc_7A2A
;\------------------------------
    ld  de, 1900h
    call    wr_dat2reg          ; 00h -> R#25
    ld  de, 21Fh
    call    wr_dat2reg          ; 1Fh -> R#2
    ret
; ==============================
sub_7A48:
    push    hl
    call    sub_7A83            ; Wait 2 VR
    xor a
    sub l
    ld  e, a
    ld  a, 2
    sbc a, h
    ld  d, a
    call    sub_7A9F
    ex  de, hl
    call    sub_7A9F
    ld  bc, 559Bh
loc_7A5D:
    ld  a, 1Ah                  ; Data 1Ah
    out (99h), a
    ld  a, 91h                  ; R#17 - Control register pointer
    out (99h), a
    ex  de, hl
    in  a, (99h)
loc_7A68:
    in  a, (99h)
    and 20h                     ; Bit 5 -
    jr  z, loc_7A68             ; +1 byte free (jp -> jr)
;\------------------------------
    out (c), h
    out (c), l
    djnz    loc_7A5D
;\------------------------------
    pop hl
    ld  de, 1A00h               ; 00h -> R#26
    call    wr_dat2reg
    ld  de, 1B00h               ; 00H -> R#27
    call    wr_dat2reg
    ret
; ==============================
; WAIT 2 Vertical scanning line
sub_7A83:
    ld  a, 2                    ; S#2
    out (99h), a                ; Data = 02H
    ld  a, 8Fh                  ; R#15 - Status register pointer
    out (99h), a
loc_7A8B:
    in  a, (99h)
    and 40h                     ; Bit 6 - Flag VR
    jr  z, loc_7A8B 
;\------------------------------
loc_7A91:
    in  a, (99h)
    and 40h                     ; Bit 6 - Flag VR
    jr  nz, loc_7A91
;\------------------------------
    xor a                       ; S#0
    out (99h), a
    ld  a, 8Fh                  ; R#15 - Status register pointer
    out (99h), a
    ret
; ==============================
; hl=
sub_7A9F:
    dec hl
    ld  a, l
    srl h
    rra
    rrca
    rrca
    inc a
    and 3Fh
    ld  h, a
    inc l
    ld  a, l
    neg
    and 7
    ld  l, a
    ret
; ==============================
; Init SCREEN memory and VDP registers
sub_7ADA:
    call    sub_7A83            ; Wait 2 VR
; Set Mode Register #1
; BL = 0 Screen disabled
; IE0 = 1 Enable IE0
; M1,M2 = 00
; SI = 1 Sprite Size 16x16
; MA = 1 Sprite expansion Enable
;   ld  de, 0123h               ; 23h -> R#1
;   call    wr_dat2reg          ; +6 bytes free
;
    call    init_VDP            ;
;
    ld  a, 55h                  ;
    ld  hl, 0
    ld  c, l
    ld  b, l
    call    wr_VRAM             ; Init VRAM
;
    call    sub_7C3E
; Set Text Color=0/Back drop color=5
    ld  de, 705h        ; 05H -> R#7
    call    wr_dat2reg
;
    ld  hl, 7800h               ; Sprite color table
    ld  bc, 30h
    ld  a, 0FFh                 ; pattern of 1st 8 pixel in left mask ( 0FFh )
    call    wr_VRAM
    ld  hl, 7830h
    ld  bc, 10h
    ld  a, 0F0h                 ; pattern of 2nd 8 pixel in left mask ( 0F0h )  <---------------------
    call    wr_VRAM
    ld  hl, 7400h
    ld  a, 5
    ld  bc, 200h
    call    wr_VRAM
    ld  hl, tab_7AB2            ;
    ld  de, 7600h
    ld  bc, 28h
    call    sub_7BE5
;
    ld  de, 1903h               ; 03H -> R#25
    call    wr_dat2reg
    ld  de, 023Fh               ; 3FH -> R#2
    call    wr_dat2reg
;
    ld  de, 2D00h               ; 00H -> R#45
    call    wr_dat2reg
    ld  d, 2Ah                  ; 00H -> R#42
    call    wr_dat2reg
    inc d                       ; 00H -> R#43
    call    wr_dat2reg
    ld  d, 27h                  ; 00H -> R#39
    call    wr_dat2reg
    ld  e, 20h                  ; Y dest of logo image => 20h by default        <---------------------
    ld  hl, tab_7D3B            ; Table Logo Image
    exx
    ld  hl, tab_7CB4            ; Table Antialiasing bits
    exx
;\------------------------------
loc_7B50:
    ld  a, 3
    push    af
    ld  bc, 2Dh                 ; X dest of logo image => 2Dh by default        <---------------------
    ld  d, 26h                  ; R#38 - Y destination register
    call    wr_dat2reg
    exx
    ld  b, 8
    ld  c, (hl)                 ; tab_7CB4
    inc hl
    exx
;\------------------------------
loc_7B61:
    call    set_dest_X          ; R#36,37 - Dest X register
    ld  a, (hl)                 ; tab_7D3B
    inc hl
    cp  0FEh                    ; End line ?
    jr  z, loc_7BA1             ; Next Y
;
    push    hl
    push    bc
    ld  bc, 422                 ; Logo width => 422 by default                  <---------------------
    jr  nc, loc_7B74            ; a=0FFh Empty line
    ld  b, 0
    ld  c, a
loc_7B74:
    call    set_NDot_X          ; R#40,41 -> Number Dots X
    pop hl
    add hl, bc
    ld  c, l
    ld  b, h
    pop hl
    pop af
    xor 3
    call    set_Color
    push    af
    call    Line_EX_COM
    exx
    sla c
    djnz    loc_7B8F
    ld  b, 8
    ld  c, (hl)
    inc hl
loc_7B8F:
    exx
    jr  nc, loc_7B61
    dec bc
    call    set_dest_X          ; R#36,37 - Dest X register
    inc bc
    ld  a, 2                    ; BLUE
    call    set_Color
    call    PSET_EX_COM
    jr  loc_7B61
;\------------------------------
loc_7BA1:
    inc e                       ; Next Y
    pop af
    ld  a, (hl)
    cp  0FEh
    jr  nz, loc_7B50
    ret
; ==============================
wr_dat2reg:
    push    af
    ld  a, e                    ; Data
    out (99h), a
    ld  a, d                    ; Register
    or  80h
    out (99h), a
    pop af
    ret
; ==============================
wait_CE:
    ld  a, 2
    call    rd_Stat_A
    rrca                        ; Bit 0 (CE) - Command Execution Flag
    jr  c, wait_CE
    rlca
    ret
; ==============================
; Read Status Register (A)
rd_Stat_A:
    out (99h), a
    ld  a, 8Fh                  ; R#15 - Status Register pointer
    out (99h), a
    push    hl
    pop hl
    in  a, (99h)                ; Read (Status Register)
    push    af
    xor a
    out (99h), a
    ld  a, 8Fh
    out (99h), a
    pop af
    ret
; ==============================
; Write VRAM
; A - byte
; HL - address
; BC - LEN
wr_VRAM:
    push    af
    call    sub_7BFA            ; Set VRAM access adress
    ld  a, c
    or  a
    jr  z, loc_7BDB
    inc b
loc_7BDB:
    pop af
loc_7BDC:
    out (98h), a
    dec c
    jr  nz, loc_7BDC            ; +1 byte free (jp -> jr)
    djnz    loc_7BDC
;\------------------------------
    ret
; ==============================
sub_7BE5:
    ex  de, hl
    call    sub_7BFA
    ex  de, hl
    ld  a, c
    or  a
    ld  a, b
    ld  b, c
    ld  c, 98h                  ; Port Data VDP
    jr  z, loc_7BF3
    inc a
loc_7BF3:
    otir
    dec a
    jr  nz, loc_7BF3
    ex  de, hl
    ret
; ==============================
; Set VRAM Access base adress
sub_7BFA:
    ld  a, h
    and 3Fh
    or  40h
    ex  af, af'
    ld  a, h
    and 0C0h
    rlca
    rlca
    out (99h), a
    ld  a, 8Eh                  ; R#14 - VRAM Access Adress
    out (99h), a
    ld  a, l
    out (99h), a
    ex  af, af'
    out (99h), a
    ex  (sp), hl
    ex  (sp), hl
    ret
; ==============================
set_NDot_X:
    ld  d, 28h                  ; R#40,41 -> Number Dots X (28h by default)
    jr  loc_7C1A
; ==============================
set_dest_X:
    ld  d, 24h                  ; R#36,37 - Dest X register
loc_7C1A:
    push    de
    ld  e, c
    call    wr_dat2reg
    ld  e, b
    inc d
    jr  loc_7C27
; ==============================
set_Color:
    push    de
    ld  e, a
    ld  d, 2Ch                  ; R#44 - Color register
loc_7C27:
    call    wr_dat2reg
    pop de
    ret
; ==============================
PSET_EX_COM:
    push    de
    ld  e, 50h                  ; PSET Execution Command
    jp  loc_7C2F                ; R#46 - Command Register
; ==============================
; TAB init VDP registers
tab_7C94:
    .dw 0800h                   ; 08h -> R#0 Graphic 4 mode
    .dw 2301h                   ; 23h -> R#1
    .dw 2808h                   ; 28H -> R#8
    .dw 0009h                   ; 00h -> R#9
; Pattern name table base address = 7C00h
    .dw 1F02h                   ; 1FH -> R#2
; Sprite attribute table base address = 07780h
    .dw 0EF05h                  ; 0EFH -> R#5
    .dw 000Bh                   ; 00H -> R#11
; Sprite pattern generator table base address = 07800h
    .dw 0F06h                   ; 0FH -> R#6
; ==============================
; TAB PALETTE REGISTERS 0       ; 0..1 by default
tab_7CA4:
;   .dw 0007h                   ; Set Title ,1  (Blue - Black)
;   .dw 0000h
    .dw 0007h                   ; Blue bg
;
;   .dw 0420h                   ; Set Title ,2  (Green - Cyan)
;   .dw 0227h
    .dw 0510h                   ; Green bg
;
;   .dw 0272h                   ; Set Title ,3  (Red - Purple)
;   .dw 0056h
    .dw 0061h                   ; Red bg
;
;   .dw 0570h                   ; Set Title ,4  (Orange - Red)
;   .dw 0070h
    .dw 0470h                   ; Orange bg
; ==============================
; Sprite attribute
tab_7AB2:                       ; Y,X,pattern,0
    .db  1Ch, 0E8h, 0, 0        ; right mask position, X=0E8h by default        <---------------------
    .db  1Ch, 0E8h, 0, 0        ; right mask position                           <---------------------
    .db  3Ch, 0E8h, 0, 0        ; right mask position                           <---------------------
    .db  3Ch, 0E8h, 0, 0        ; right mask position                           <---------------------
    .db  5Ch, 0E8h, 0, 0        ; right mask position                           <---------------------
    .db  5Ch, 0E8h, 0, 0        ; right mask position                           <---------------------
    .db  1Ch,    0, 4, 0        ; left mask position, X=0 by default
    .db  3Ch,    0, 4, 0        ; left mask position
    .db  5Ch,    0, 4, 0        ; left mask position
    .db 0D8h                    ; .db 0D8h,    0, 0, 0 by default
; ==============================
; Table antialiasing bits
tab_7CB4:                       ; tab_7CB4 is accross to sprite attribute       <---------------------
      .db %00000000
      .db %00000000
      .db %00000000
      .db %00000000
      .db %00000000
      .db %00000000
      .db %00000000
      .db %00000000
      .db %00000000
      .db %01101110, %00000000
      .db %10011111, %00000000
      .db %01101111, %00000000
      .db %10011111, %00000000
      .db %01101111, %00000000
      .db %10011111, %00000000
      .db %01101111, %00000000
      .db %10011111, %00000000
      .db %01101111, %00000000
      .db %10011111, %00000000
      .db %01101111, %00000000
      .db %10011111, %00000000
      .db %01101111, %00000000
      .db %11111111, %00000000
      .db %00000111, %00000000
      .db %11111100
      .db %00000111, %00000000
      .db %11110100, %11000000
      .db %00000111, %00000000
      .db %11110000, %11000000
      .db %00000111, %00000000
      .db %11110100, %11000000
      .db %00000111, %00000000
      .db %11111100, %11000000
      .db %00000111, %00000000
      .db %11111100, %11000000
      .db %00001111, %00000000
      .db %11110011, %00000000
      .db %00111100
      .db %11110011, %00000000
      .db %00111100
      .db %11110011, %00000000
      .db %00111100
      .db %10000111, %00110000
      .db %01111011, %11000000
      .db %10000111, %00110000
      .db %01111011, %11000000
      .db %10000110, %00110000
      .db %01111011, %11000000
      .db %10000110, %00110000
      .db %01111010, %11000000
      .db %10000110, %00110000
      .db %01111000, %11000000
      .db %10000110, %00100100
      .db %01111010, %11110000
      .db %10000110, %00111100
      .db %01111111, %11000000
      .db %10000000, %11110000
      .db %01111111, %11000000
      .db %11010100, %11110000
      .db %00101111, %11000000
      .db %11010100, %11110000
      .db %00101111, %11000000
      .db %11010100, %11110000
      .db %00101111, %11000000
      .db %11010100, %11110000
      .db %00101111, %11000000
      .db %11010100, %11110000
      .db %00101111, %11000000
      .db %11010100, %11110000
      .db %00101111, %11000000
      .db %11010100, %01100000
      .db %00000000
      .db %00000000
      .db %00000000
      .db %00000000
      .db %00000000
      .db %00000000
      .db %00000000
      .db %00000000
      .db %00000000
; ==============================
; Table LOGO
; 0FFh - Empty line
; 0FEh - New line
; 0FEh,0FEh - End LOGO
; Width line = 422 dots
tab_7D3B:                       ;                                               <---------------------
      .db 255, 254
      .db 255, 254
      .db 255, 254
      .db 255, 254
      .db 255, 254
      .db 255, 254
      .db 255, 254
      .db 255, 254
      .db 255, 254
      .db 35, 29, 29, 28, 48, 159, 43, 40, 11, 254
      .db 35, 29, 28, 30, 42, 165, 41, 41, 11, 254
      .db 34, 31, 27, 30, 38, 171, 37, 41, 13, 254
      .db 34, 31, 26, 32, 34, 175, 35, 41, 14, 254
      .db 33, 33, 25, 32, 31, 180, 31, 41, 16, 254
      .db 33, 33, 24, 34, 27, 184, 29, 41, 17, 254
      .db 32, 35, 23, 34, 25, 188, 26, 40, 19, 254
      .db 32, 35, 22, 36, 23, 190, 23, 41, 20, 254
      .db 31, 37, 21, 36, 21, 194, 20, 40, 22, 254
      .db 31, 37, 20, 38, 19, 196, 17, 41, 23, 254
      .db 30, 39, 19, 38, 18, 199, 14, 41, 24, 254
      .db 30, 39, 18, 40, 16, 201, 12, 40, 26, 254
      .db 29, 41, 17, 40, 15, 204, 8, 41, 27, 254
      .db 29, 42, 15, 42, 13, 206, 6, 40, 29, 254
      .db 28, 43, 14, 43, 12, 209, 2, 41, 30, 254
      .db 28, 44, 13, 44, 11, 250, 32, 254
      .db 27, 45, 12, 45, 10, 38, 132, 80, 33, 254
      .db 27, 46, 11, 46, 9, 35, 68, 38, 31, 76, 35, 254
      .db 26, 47, 10, 47, 9, 33, 140, 74, 36, 254
      .db 26, 48, 9, 48, 8, 32, 71, 38, 34, 70, 38, 254
      .db 25, 49, 8, 49, 8, 33, 143, 68, 39, 254
      .db 25, 50, 7, 50, 7, 35, 68, 38, 37, 65, 40, 254
      .db 24, 51, 6, 51, 7, 38, 141, 62, 42, 254
      .db 24, 52, 5, 52, 7, 70, 32, 38, 40, 59, 43, 254
      .db 23, 53, 4, 53, 7, 75, 106, 56, 45, 254
      .db 23, 54, 3, 54, 7, 78, 23, 38, 43, 53, 46, 254
      .db 22, 55, 2, 55, 8, 80, 102, 50, 48, 254
      .db 22, 113, 8, 82, 17, 38, 46, 47, 49, 254
      .db 21, 114, 9, 84, 99, 44, 51, 254
      .db 21, 115, 9, 85, 12, 38, 49, 41, 52, 254
      .db 20, 116, 10, 85, 97, 42, 52, 254
      .db 20, 117, 11, 85, 9, 14, 70, 45, 51, 254
      .db 19, 118, 12, 85, 91, 48, 49, 254
      .db 19, 31, 1, 55, 1, 31, 13, 84, 7, 14, 67, 51, 48, 254
      .db 18, 32, 2, 54, 2, 30, 16, 82, 86, 54, 46, 254
      .db 18, 31, 3, 53, 3, 31, 18, 80, 5, 38, 40, 57, 45, 254
      .db 17, 32, 4, 52, 4, 30, 21, 78, 81, 60, 43, 254
      .db 17, 31, 5, 51, 5, 31, 24, 74, 4, 38, 38, 62, 42, 254
      .db 16, 32, 6, 50, 6, 30, 29, 70, 77, 66, 40, 254
      .db 16, 31, 7, 49, 7, 31, 60, 38, 3, 38, 35, 68, 39, 254
      .db 15, 32, 8, 48, 8, 30, 64, 34, 74, 72, 37, 254
      .db 15, 31, 9, 47, 9, 31, 65, 32, 3, 38, 32, 74, 36, 254
      .db 14, 32, 10, 46, 10, 30, 65, 32, 71, 78, 34, 254
      .db 14, 31, 11, 45, 11, 31, 64, 32, 3, 38, 29, 40, 1, 39, 33, 254
      .db 13, 32, 12, 44, 12, 30, 62, 34, 68, 41, 4, 39, 31, 254
      .db 13, 31, 13, 43, 13, 31, 57, 38, 3, 14, 50, 41, 6, 39, 30, 254
      .db 12, 32, 14, 42, 14, 125, 66, 40, 10, 39, 28, 254
      .db 12, 31, 15, 41, 15, 124, 4, 14, 47, 41, 12, 39, 27, 254
      .db 11, 32, 16, 40, 16, 123, 64, 40, 16, 39, 25, 254
      .db 11, 31, 17, 39, 17, 122, 5, 38, 20, 41, 18, 39, 24, 254
      .db 10, 31, 19, 37, 19, 120, 63, 40, 22, 39, 22, 254
      .db 10, 31, 19, 37, 19, 119, 7, 38, 17, 41, 24, 39, 21, 254
      .db 9, 31, 21, 35, 21, 117, 62, 40, 28, 39, 19, 254
      .db 9, 31, 21, 35, 21, 116, 9, 38, 15, 39, 31, 39, 18, 254
      .db 8, 31, 23, 33, 23, 113, 62, 40, 34, 39, 16, 254
      .db 8, 31, 23, 33, 23, 112, 12, 38, 12, 39, 37, 39, 15, 254
      .db 7, 31, 25, 31, 25, 109, 62, 40, 40, 39, 13, 254
      .db 7, 31, 25, 31, 25, 106, 17, 38, 9, 39, 43, 39, 12, 254
      .db 6, 31, 27, 29, 27, 102, 65, 40, 46, 39, 10, 254
      .db 6, 31, 27, 29, 27, 99, 23, 38, 6, 39, 49, 39, 9, 254
      .db 5, 31, 29, 27, 29, 95, 68, 40, 52, 39, 7, 254
      .db 5, 31, 29, 27, 29, 90, 31, 38, 2, 40, 55, 39, 6, 254
      .db 255, 254
      .db 255, 254
      .db 255, 254
      .db 255, 254
      .db 255, 254
      .db 255, 254
      .db 255, 254
      .db 255, 254
      .db 255, 254
      .db 254
; ==============================
end_logo:                       ; fillers -> file lenght will be 1.635 bytes    <---------------------
      .db 0FFh, 0FFh, 0FFh                           
      .db 0FFh, 0FFh, 0FFh                           
      .db 0FFh, 0FFh, 0FFh                           
      .db 0FFh, 0FFh, 0FFh                           
      .db 0FFh, 0FFh, 0FFh                           
      .db 0FFh, 0FFh, 0FFh                           
      .db 0FFh, 0FFh, 0FFh                           
      .db 0FFh, 0FFh, 0FFh                           
      .db 0FFh, 0FFh, 0FFh                           
      .db 0FFh, 0FFh, 0FFh                           
      .db 0FFh, 0FFh, 0FFh                           
      .db 0FFh, 0FFh, 0FFh                           
      .db 0FFh, 0FFh, 0FFh                           
      .db 0FFh, 0FFh, 0FFh                           
      .db 0FFh, 0FFh, 0FFh                           
      .db 0FFh, 0FFh, 0FFh                           
      .db 0FFh, 0FFh, 0FFh                           
      .db 0FFh, 0FFh, 0FFh                           
      .db 0FFh, 0FFh, 0FFh                           
      .db 0FFh, 0FFh, 0FFh                           
      .db 0FFh, 0FFh, 0FFh                           
      .db 0FFh, 0FFh, 0FFh                           
      .db 0FFh, 0FFh, 0FFh                           
      .db 0FFh
;\------------------------------
    .end

