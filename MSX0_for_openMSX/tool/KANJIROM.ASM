D000  cp     #02          FE 02
D002  ret    nz           C0
D003  inc    hl           23
D004  inc    hl           23
D005  di                  F3
D006  ld     a,(hl)       7E
D007  inc    hl           23
D008  ld     h,(hl)       66
D009  ld     l,#00        2E 00
D00B  ld     bc,#4000     01 00 40
D00E  ld     de,#9000     11 00 90
D011  push   af           F5
D012  push   de           D5
D013  push   bc           C5
D014  call   #000c        CD 0C 00
D017  pop    bc           C1
D018  pop    de           D1
D019  ld     (de),a       12
D01A  inc    hl           23
D01B  inc    de           13
D01C  dec    bc           0B
D01D  ld     a,b          78
D01E  or     c            B1
D01F  jr     z,#d024      28 03
D021  pop    af           F1
D022  jr     #d011        18 ED
D024  pop    af           F1
D025  ei                  FB
D026  xor    a            AF
D027  ret                 C9
D028  nop                 00
D029  nop                 00
D02A  nop                 00
D02B  nop                 00
D02C  nop                 00
D02D  nop                 00
D02E  nop                 00
D02F  nop                 00
D030  cp     #03          FE 03
D032  ret    nz           C0
D033  inc    de           13
D034  ld     a,(de)       1A
D035  ld     l,a          6F
D036  inc    de           13
D037  ld     a,(de)       1A
D038  ld     h,a          67
D039  xor    a            AF
D03A  ld     de,#d200     11 00 D2
D03D  ld     (de),a       12
D03E  inc    de           13
D03F  ld     bc,#000b     01 0B 00
D042  ldir                ED B0
D044  ld     de,#9000     11 00 90
D047  ld     c,#1a        0E 1A
D049  call   #f37d        CD 7D F3
D04C  ld     de,#d200     11 00 D2
D04F  ld     c,#16        0E 16
D051  call   #f37d        CD 7D F3
D054  or     a            B7
D055  jp     nz,#d090     C2 90 D0
D058  ld     hl,#4000     21 00 40
D05B  ld     (#d20e),hl   22 0E D2
D05E  ld     hl,#0000     21 00 00
D061  ld     (#d221),hl   22 21 D2
D064  ld     hl,#0000     21 00 00
D067  ld     (#d223),hl   22 23 D2
D06A  ld     hl,#0001     21 01 00
D06D  ld     de,#d200     11 00 D2
D070  ld     c,#26        0E 26
D072  call   #f37d        CD 7D F3
D075  or     a            B7
D076  jp     nz,#d095     C2 95 D0
D079  ld     de,#d200     11 00 D2
D07C  ld     c,#10        0E 10
D07E  call   #f37d        CD 7D F3
D081  or     a            B7
D082  jp     nz,#d09a     C2 9A D0
D085  ld     de,#d0a0     11 A0 D0
D088  ld     c,#09        0E 09
D08A  call   #f37d        CD 7D F3
D08D  ret                 C9
D08E  nop                 00
D08F  nop                 00
D090  ld     de,#d0a4     11 A4 D0
D093  jr     #d088        18 F3
D095  ld     de,#d0af     11 AF D0
D098  jr     #d088        18 EE
D09A  ld     de,#d0bb     11 BB D0
D09D  jr     #d088        18 E9
D09F  nop                 00
D0A0  nop                 00
D0A1  nop                 00
D0A2  nop                 00
D0A3  inc    h            24
D0A4  rlca                07
D0A5  ld     c,a          4F
D0A6  ld     (hl),b       70
D0A7  ld     h,l          65
D0A8  ld     l,(hl)       6E
D0A9  jr     nz,#d110     20 65
D0AB  ld     (hl),d       72
D0AC  ld     (hl),d       72
D0AD  ld     a,(#0724)    3A 24 07
D0B0  ld     d,a          57
D0B1  ld     (hl),d       72
D0B2  ld     l,c          69
D0B3  ld     (hl),h       74
D0B4  ld     h,l          65
D0B5  jr     nz,#d11c     20 65
D0B7  ld     (hl),d       72
D0B8  ld     (hl),d       72
D0B9  ld     a,(#0724)    3A 24 07
D0BC  ld     b,e          43
D0BD  ld     l,h          6C
D0BE  ld     l,a          6F
D0BF  ld     (hl),e       73
D0C0  ld     h,l          65
D0C1  jr     nz,#d128     20 65
D0C3  ld     (hl),d       72
D0C4  ld     (hl),d       72
D0C5  ld     a,(#0024)    3A 24 00
D0C8  nop                 00
D0C9  nop                 00
D0CA  nop                 00
D0CB  nop                 00
D0CC  nop                 00
D0CD  nop                 00
D0CE  nop                 00
D0CF  nop                 00
D0D0  cp     #02          FE 02
D0D2  ret    nz           C0
D0D3  inc    hl           23
D0D4  inc    hl           23
D0D5  ld     a,(hl)       7E
D0D6  inc    hl           23
D0D7  ld     h,(hl)       66
D0D8  ld     l,a          6F
D0D9  ld     de,#9000     11 00 90
D0DC  push   hl           E5
D0DD  ld     a,l          7D
D0DE  and    #3f          E6 3F
D0E0  adc    hl,hl        ED 6A
D0E2  adc    hl,hl        ED 6A
D0E4  out    (#d8),a      D3 D8
D0E6  ld     a,h          7C
D0E7  and    #3f          E6 3F
D0E9  out    (#d9),a      D3 D9
D0EB  pop    hl           E1
D0EC  ld     b,#20        06 20
D0EE  in     a,(#d9)      DB D9
D0F0  ld     (de),a       12
D0F1  inc    de           13
D0F2  djnz   #d0ee        10 FA
D0F4  inc    hl           23
D0F5  ld     a,d          7A
D0F6  cp     #d0          FE D0
D0F8  jr     nz,#d0dc     20 E2
D0FA  ret                 C9
D0FB  nop                 00
D0FC  nop                 00
D0FD  nop                 00
D0FE  nop                 00
D0FF  nop                 00
D100  cp     #02          FE 02
D102  ret    nz           C0
D103  inc    hl           23
D104  inc    hl           23
D105  push   hl           E5
D106  ld     a,(hl)       7E
D107  inc    hl           23
D108  ld     h,(hl)       66
D109  ld     l,#00        2E 00
D10B  push   af           F5
D10C  push   hl           E5
D10D  ld     a,#01        3E 01
D10F  ld     hl,#4000     21 00 40
D112  call   #0024        CD 24 00
D115  pop    hl           E1
D116  pop    af           F1
D117  ld     (hl),a       77
D118  ld     hl,#4000     21 00 40
D11B  ld     de,#9000     11 00 90
D11E  ld     bc,#4000     01 00 40
D121  ldir                ED B0
D123  xor    a            AF
D124  ld     hl,#4000     21 00 40
D127  call   #0024        CD 24 00
D12A  pop    hl           E1
D12B  ret                 C9
D12C  nop                 00
D12D  nop                 00
D12E  nop                 00
D12F  nop                 00
D130  cp     #02          FE 02
D132  ret    nz           C0
D133  inc    hl           23
D134  inc    hl           23
D135  ld     a,(hl)       7E
D136  inc    hl           23
D137  ld     h,(hl)       66
D138  ld     l,a          6F
D139  push   hl           E5
D13A  ld     hl,#4000     21 00 40
D13D  ld     a,#8f        3E 8F
D13F  call   #0024        CD 24 00
D142  pop    hl           E1
D143  ld     a,#ff        3E FF
D145  ld     (#7ff9),a    32 F9 7F
D148  ld     a,(#7ff2)    3A F2 7F
D14B  ld     e,a          5F
D14C  ld     a,(#7ff8)    3A F8 7F
D14F  ld     d,a          57
D150  push   de           D5
D151  ld     a,l          7D
D152  ld     (#6800),a    32 00 68
D155  ld     a,h          7C
D156  or     a            B7
D157  jr     z,#d15b      28 02
D159  ld     a,#04        3E 04
D15B  ld     (#7ff8),a    32 F8 7F
D15E  ld     hl,#4000     21 00 40
D161  ld     de,#9000     11 00 90
D164  ld     bc,#2000     01 00 20
D167  ldir                ED B0
D169  pop    de           D1
D16A  ld     a,e          7B
D16B  ld     (#6800),a    32 00 68
D16E  ld     a,d          7A
D16F  ld     (#7ff8),a    32 F8 7F
D172  ld     hl,#4000     21 00 40
D175  ld     a,#80        3E 80
D177  call   #0024        CD 24 00
D17A  ret                 C9
