10 MAXFILES=3: ON STOP GOSUB 420: STOP ON: ON ERROR GOTO 420
25 ' *** MSX LOGO GENERATOR by uniskie 20234.07.16 ***
20 ' *** base on [MSX3 LOGO GENERATOR by KdL 2014.05.21] ***
30 SCREEN 0: KEY OFF: COLOR 2,0,0: WIDTH 80: LOCATE,4: FILES "MSX?????.SC6
60 DEFINTA-Z: X1=422: Y1=80: DIM A(X1+1)
70 LOCATE,0: PRINT"Unofficial MSX++ Logo by uniskie (2023.07.16)": PRINT
80 INPUT"Input a file name or RETURN for default MSX++ logo ";F$ :IF F$="" THEN F$="msxpp"
85 IF F$="MSXPP" OR F$="msxpp" THEN X1=400: Y1=76
86 IF F$="MSXEX" OR F$="msxex" THEN X1=422: Y1=80
105 f$=f$+".sc6"
110 OPEN "tab_7D3B.asm" FOR OUTPUT AS #1
120 OPEN "tab_7CB4.asm" FOR OUTPUT AS #2
125 OPEN "GRP:" AS #3
130 SCREEN 6
140 BLOAD F$,S
150 COLOR=(0,0,0,7): COLOR=(1,7,7,7)
160 COLOR=(2,4,4,7): COLOR=(3,0,0,0)
170 FORX=0TOX1-1: A(X)=POINT(X,Y): IF A(X)=0 THEN PSET(X,Y),3
180 NEXT X
190 K=0: X=0: PRINT#1,"      .db";: PRINT#2,"      .db %";
200 N=0: GOSUB 230: K=1
210 N=1: GOSUB 230
220 GOTO 200
230 IF X=X1 THEN GOSUB 270: GOSUB 330: PRINT#1,", 254": PRINT#2,"": BT=0: GOTO 310
240 IF BT=8 THEN BT=0: PRINT#2,", %";
250 IF A(X)=N THEN Q=Q+1 ELSE 270
260 X=X+1: GOTO 230
270 IF Q=0 THEN RETURN
280 IF BT<8 THEN BT=BT+1
290 IF K=0 THEN GOSUB 360: GOTO 300 ELSE GOSUB 340
300 Q=0: RETURN
310 Y=Y+1: IF Y=Y1 THEN PRINT#1,"      .db 254": GOTO 390
315 PSET(0,211-8),0:print #3,y
320 GOTO 170
330 IF BT<8 THEN BT=BT+1: PRINT#2,"0";: GOTO 330 ELSE RETURN
340 IF A(X)=2 THEN PRINT#1,",";STR$(Q+1);: PRINT#2,"1";: X=X+1: RETURN
345 IF (Q>253) AND (Q<X1) THEN PRINT#1,", 253, 0,";STR$(Q-253);: PRINT#2,"0";: RETURN
350 PRINT#1,",";STR$(Q);: PRINT#2,"0";: RETURN
360 IF A(X)=2 THEN PRINT#1,STR$(Q+1);: PRINT#2,"1";: X=X+1: RETURN
370 IF Q=X1 THEN PRINT#1," 255";: PRINT#2,"0";: RETURN
375 IF (Q>253) AND (Q<X1) THEN PRINT#1," 253, 0,";STR$(Q-253);: PRINT#2,"0";: RETURN
380 PRINT#1,STR$(Q);: PRINT#2,"0";: RETURN
390 CLOSE#1
400 CLOSE#2
410 COLOR=(2,4,4,4): A$=INPUT$(1)
420 RUN
