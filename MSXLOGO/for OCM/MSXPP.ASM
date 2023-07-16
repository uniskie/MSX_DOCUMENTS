; ========================================
; Plot LOGO for MSX2+ without antialiasing
; to insert in MSXKANJI.ROM. (A1WSX ver.)
; Binary result: MSXPP.ROM
; Size of logo: 400*76 dots
; Hex Editor Address: $399d - $3fff
; Modified by KdL 2013.06.23
; Modified by Uniskie 2023.07.16
; Coded in TWZ'CA3 w/ TASM80 v3.2ud
; ========================================

; ========================================
image_w .equ    400                         ; Logo width  => 422 by default
image_h .equ    76                          ; Logo height => 80  by default

dest_x  .equ    (512 - image_w) / 2         ; X dest of logo image => 2Dh by default
dest_y  .equ    20h + (80 - image_h)        ; Y dest of logo image => 20h by default
; ========================================


    .org    07A00h - 99         ; StartProg - MainProg = 99 bytes               <---------------------
;   .org    0100h               ; MSXPP.COM

MainProg:
    jp      startProg           ; filler of 3 bytes -> useful for MSXPP.COM
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
;   jr      loop4DOS            ; Loop test for MSXPP.COM
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
    ld  a, 0FCh                 ; pattern of 2nd 8 pixel in left mask ( 0F0h )  <---------------------
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
    ld  e, dest_y              ; Y dest of logo image => 20h by default        <---------------------
    ld  hl, tab_7D3B            ; Table Logo Image
;<--------------------------------- Antialiasing disabled
;    exx
;    ld  hl, tab_7CB4            ; Table Antialiasing bits
;    exx
;---------------------------------> Antialiasing disabled
;\------------------------------
loc_7B50:
    ld  a, 3
    push    af
    ld  bc, dest_x              ; X dest of logo image => 2Dh by default        <---------------------
    ld  d, 26h                  ; R#38 - Y destination register
    call    wr_dat2reg
;<--------------------------------- Antialiasing disabled
;    exx
;    ld  b, 8
;   ld  c, (hl)                 ; tab_7CB4
;    inc hl
;    exx
;---------------------------------> Antialiasing disabled
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
    ld  bc, image_w             ; Logo width => 422 by default                  <---------------------
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
;<--------------------------------- Antialiasing disabled
;    exx
;    sla c
;    djnz    loc_7B8F
;    ld  b, 8
;   ld  c, (hl)                 ; tab_7CB4
;    inc hl
;loc_7B8F:
;    exx
;    jr  nc, loc_7B61
;    dec bc
;    call    set_dest_X          ; R#36,37 - Dest X register
;    inc bc
;    ld  a, 2                    ; BLUE
;    call    set_Color
;    call    PSET_EX_COM
;---------------------------------> Antialiasing disabled
    jr  loc_7B61
;;\------------------------------
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
    .db  1Ch, 0E4h, 0, 0        ; right mask position, X=0E8h by default        <---------------------
    .db  1Ch, 0E4h, 0, 0        ; right mask position                           <---------------------
    .db  3Ch, 0E4h, 0, 0        ; right mask position                           <---------------------
    .db  3Ch, 0E4h, 0, 0        ; right mask position                           <---------------------
    .db  5Ch, 0E4h, 0, 0        ; right mask position                           <---------------------
    .db  5Ch, 0E4h, 0, 0        ; right mask position                           <---------------------
    .db  1Ch,    0, 4, 0        ; left mask position, X=0 by default
    .db  3Ch,    0, 4, 0        ; left mask position
    .db  5Ch,    0, 4, 0        ; left mask position
    .db 0D8h,    0, 0, 0
;<--------------------------------- Antialiasing disabled
; ==============================
; Table antialiasing bits
;tab_7CB4:                       ; tab_7CB4 is accross to sprite attribute       <---------------------
;---------------------------------> Antialiasing disabled
; ==============================
; Table LOGO
; 0FFh - Empty line
; 0FEh - New line
; 0FEh,0FEh - End LOGO
; Width line = 400 dots
tab_7D3B:                       ;                                               <---------------------
      .db 255, 254
      .db 255, 254
      .db 253, 0, 30, 115, 2, 254
      .db 253, 0, 30, 115, 2, 254
      .db 253, 0, 30, 115, 2, 254
      .db 253, 0, 30, 115, 2, 254
      .db 253, 0, 30, 115, 2, 254
      .db 253, 0, 30, 115, 2, 254
      .db 253, 0, 30, 115, 2, 254
      .db 253, 0, 30, 115, 2, 254
      .db 37, 14, 35, 15, 36, 82, 35, 19, 10, 115, 2, 254
      .db 36, 16, 33, 17, 31, 87, 33, 19, 11, 115, 2, 254
      .db 36, 16, 33, 17, 28, 91, 31, 19, 12, 115, 2, 254
      .db 35, 18, 31, 19, 25, 94, 29, 19, 13, 115, 2, 254
      .db 35, 18, 31, 19, 23, 97, 27, 19, 14, 115, 2, 254
      .db 34, 20, 29, 21, 21, 99, 25, 19, 15, 115, 2, 254
      .db 34, 20, 29, 21, 20, 101, 23, 19, 16, 115, 2, 254
      .db 33, 22, 27, 23, 18, 103, 21, 19, 17, 115, 2, 254
      .db 33, 22, 27, 23, 17, 105, 19, 19, 18, 115, 2, 254
      .db 32, 24, 25, 25, 16, 21, 68, 17, 17, 19, 19, 70, 13, 32, 2, 254
      .db 32, 24, 25, 25, 15, 19, 72, 17, 15, 19, 20, 69, 15, 31, 2, 254
      .db 31, 26, 23, 27, 14, 17, 75, 17, 13, 19, 21, 69, 15, 31, 2, 254
      .db 31, 26, 23, 27, 13, 17, 77, 17, 11, 19, 22, 69, 15, 31, 2, 254
      .db 30, 28, 21, 29, 12, 17, 78, 17, 9, 19, 23, 69, 15, 31, 2, 254
      .db 30, 28, 21, 29, 12, 16, 80, 17, 7, 19, 24, 69, 15, 31, 2, 254
      .db 29, 30, 19, 31, 11, 16, 81, 17, 5, 19, 25, 69, 15, 31, 2, 254
      .db 29, 30, 19, 31, 11, 16, 82, 17, 3, 19, 26, 69, 15, 31, 2, 254
      .db 28, 32, 17, 33, 10, 17, 82, 17, 1, 19, 27, 51, 51, 13, 2, 254
      .db 28, 32, 17, 16, 1, 16, 10, 18, 82, 35, 28, 50, 53, 12, 2, 254
      .db 27, 34, 15, 17, 1, 17, 9, 20, 81, 33, 29, 50, 53, 12, 2, 254
      .db 27, 16, 1, 17, 15, 16, 3, 16, 9, 25, 77, 31, 30, 50, 53, 12, 2, 254
      .db 26, 17, 1, 18, 13, 17, 3, 17, 9, 58, 44, 29, 31, 50, 53, 12, 2, 254
      .db 26, 16, 3, 17, 13, 16, 5, 16, 9, 63, 40, 27, 32, 50, 53, 12, 2, 254
      .db 25, 17, 3, 18, 11, 17, 5, 17, 9, 65, 38, 25, 33, 32, 13, 6, 51, 13, 2, 254
      .db 25, 16, 5, 17, 11, 16, 7, 16, 9, 67, 37, 23, 34, 69, 15, 31, 2, 254
      .db 24, 17, 5, 18, 9, 17, 7, 17, 9, 68, 36, 21, 35, 31, 15, 23, 15, 31, 2, 254
      .db 24, 16, 7, 17, 9, 16, 9, 16, 10, 68, 36, 19, 36, 69, 15, 31, 2, 254
      .db 23, 17, 7, 18, 7, 17, 9, 17, 11, 67, 34, 21, 35, 31, 15, 23, 15, 31, 2, 254
      .db 23, 16, 9, 17, 7, 16, 11, 16, 13, 66, 32, 23, 34, 69, 15, 31, 2, 254
      .db 22, 17, 9, 18, 5, 17, 11, 17, 15, 64, 30, 25, 33, 31, 15, 23, 15, 31, 2, 254
      .db 22, 16, 11, 17, 5, 16, 13, 16, 20, 60, 28, 27, 32, 69, 15, 31, 2, 254
      .db 21, 17, 11, 18, 3, 17, 13, 17, 54, 25, 27, 29, 31, 13, 51, 6, 13, 32, 2, 254
      .db 21, 16, 13, 17, 3, 16, 15, 16, 58, 22, 25, 31, 30, 115, 2, 254
      .db 20, 17, 13, 18, 1, 17, 15, 17, 59, 20, 24, 33, 29, 12, 53, 50, 2, 254
      .db 20, 16, 15, 17, 1, 16, 17, 16, 60, 19, 23, 35, 28, 115, 2, 254
      .db 19, 17, 15, 34, 17, 17, 60, 18, 22, 37, 27, 12, 53, 50, 2, 254
      .db 19, 16, 17, 32, 19, 16, 61, 17, 21, 19, 1, 19, 26, 115, 2, 254
      .db 18, 17, 17, 32, 19, 17, 60, 17, 20, 19, 3, 19, 25, 13, 51, 51, 2, 254
      .db 18, 16, 19, 30, 21, 16, 60, 17, 19, 19, 5, 19, 24, 115, 2, 254
      .db 17, 17, 19, 30, 21, 17, 59, 17, 18, 19, 7, 19, 23, 31, 15, 69, 2, 254
      .db 17, 16, 21, 28, 23, 16, 59, 17, 17, 19, 9, 19, 22, 115, 2, 254
      .db 16, 17, 21, 28, 23, 17, 57, 18, 16, 19, 11, 19, 21, 31, 15, 69, 2, 254
      .db 16, 16, 23, 26, 25, 16, 57, 17, 16, 19, 13, 19, 20, 115, 2, 254
      .db 15, 17, 23, 26, 25, 17, 55, 18, 15, 19, 15, 19, 19, 31, 15, 69, 2, 254
      .db 15, 16, 25, 24, 27, 16, 53, 19, 15, 19, 17, 19, 18, 115, 2, 254
      .db 14, 17, 25, 24, 27, 17, 48, 23, 14, 19, 19, 19, 17, 32, 13, 70, 2, 254
      .db 14, 16, 27, 22, 29, 86, 14, 19, 21, 19, 16, 115, 2, 254
      .db 13, 17, 27, 22, 29, 85, 14, 19, 23, 19, 15, 115, 2, 254
      .db 13, 16, 29, 20, 31, 83, 14, 19, 25, 19, 14, 115, 2, 254
      .db 12, 17, 29, 20, 31, 82, 14, 19, 27, 19, 13, 115, 2, 254
      .db 12, 16, 31, 18, 33, 80, 14, 19, 29, 19, 12, 115, 2, 254
      .db 11, 17, 31, 18, 33, 78, 15, 19, 31, 19, 11, 115, 2, 254
      .db 11, 16, 33, 16, 35, 74, 17, 19, 33, 19, 10, 115, 2, 254
      .db 10, 17, 33, 16, 35, 71, 19, 19, 35, 19, 9, 115, 2, 254
      .db 10, 16, 35, 14, 37, 65, 23, 19, 37, 19, 8, 115, 2, 254
      .db 9, 17, 173, 19, 39, 19, 7, 115, 2, 254
      .db 253, 0, 30, 115, 2, 254
      .db 253, 0, 30, 115, 2, 254
      .db 253, 0, 30, 115, 2, 254
      .db 253, 0, 30, 115, 2, 254
      .db 253, 0, 30, 115, 2, 254
      .db 253, 0, 30, 115, 2, 254
      .db 253, 0, 30, 115, 2, 254
      .db 253, 0, 30, 115, 2, 254
      .db 255, 254
      .db 255, 254
      .db 254
; ==============================
end_logo:                       ; fillers -> file lenght will be 1.635 bytes    <---------------------
      .db 255, 255
      .db 255, 255
      .db 255, 255
      .db 255
                       
;\------------------------------
    .end

