
	SUBROUTINE BMUAV(A,M,N,U,V,L,EPS,KA,S,E,WORK)
	DIMENSION A(M,N),U(M,M),V(N,N),S(KA),E(KA),WORK(KA)
	DOUBLE PRECISION A,U,V,S,E,D,WORK,DD,F,G,CS,SN,
     *                   SHH,SK,EK,B,C,SM,SM1,EM1
	IT=60
	K=N
	IF (M-1.LT.N) K=M-1
	L=M
	IF (N-2.LT.M) L=N-2
	IF (L.LT.0) L=0
	LL=K
	IF (L.GT.K) LL=L
	IF (LL.GE.1) THEN
	  DO 150 KK=1,LL
	    IF (KK.LE.K) THEN
	      D=0.0
	      DO 10 I=KK,M
10	      D=D+A(I,KK)*A(I,KK)
	      S(KK)=SQRT(D)
	      IF (S(KK).NE.0.0) THEN
                IF (A(KK,KK).NE.0.0) S(KK)=SIGN(S(KK),A(KK,KK))
	        DO 20 I=KK,M
20	        A(I,KK)=A(I,KK)/S(KK)
	        A(KK,KK)=1.0+A(KK,KK)
	      END IF
	      S(KK)=-S(KK)
	    END IF
	    IF (N.GE.KK+1) THEN
	      DO 50 J=KK+1,N
	        IF ((KK.LE.K).AND.(S(KK).NE.0.0)) THEN
	          D=0.0
	          DO 30 I=KK,M
30	          D=D+A(I,KK)*A(I,J)
	          D=-D/A(KK,KK)
	          DO 40 I=KK,M
40	          A(I,J)=A(I,J)+D*A(I,KK)
	        END IF
	        E(J)=A(KK,J)
50	      CONTINUE
	    END IF
	    IF (KK.LE.K) THEN
	      DO 60 I=KK,M
60	      U(I,KK)=A(I,KK)
	    END IF
	    IF (KK.LE.L) THEN
	      D=0.0
	      DO 70 I=KK+1,N
70	      D=D+E(I)*E(I)
	      E(KK)=SQRT(D)
	      IF (E(KK).NE.0.0) THEN
	        IF (E(KK+1).NE.0.0) E(KK)=SIGN(E(KK),E(KK+1))
	        DO 80 I=KK+1,N
80	        E(I)=E(I)/E(KK)
	        E(KK+1)=1.0+E(KK+1)
	      END IF
	      E(KK)=-E(KK)
	      IF ((KK+1.LE.M).AND.(E(KK).NE.0.0)) THEN
	        DO 90 I=KK+1,M
90	        WORK(I)=0.0
	        DO 110 J=KK+1,N
	          DO 100 I=KK+1,M
100	          WORK(I)=WORK(I)+E(J)*A(I,J)
110	        CONTINUE
	        DO 130 J=KK+1,N
	          DO 120 I=KK+1,M
120	          A(I,J)=A(I,J)-WORK(I)*E(J)/E(KK+1)
130	        CONTINUE
	      END IF
	      DO 140 I=KK+1,N
140	      V(I,KK)=E(I)
	    END IF
150	  CONTINUE
	END IF
	MM=N
	IF (M+1.LT.N) MM=M+1
	IF (K.LT.N) S(K+1)=A(K+1,K+1)
	IF (M.LT.MM) S(MM)=0.0
	IF (L+1.LT.MM) E(L+1)=A(L+1,MM)
	E(MM)=0.0
	NN=M
	IF (M.GT.N) NN=N
	IF (NN.GE.K+1) THEN
	  DO 190 J=K+1,NN
	    DO 180 I=1,M
180	    U(I,J)=0.0
	    U(J,J)=1.0
190	  CONTINUE
	END IF
	IF (K.GE.1) THEN
	  DO 250 LL=1,K
	    KK=K-LL+1
	    IF (S(KK).NE.0.0) THEN
	      IF (NN.GE.KK+1) THEN
	        DO 220 J=KK+1,NN
	          D=0.0
	          DO 200 I=KK,M
200	          D=D+U(I,KK)*U(I,J)/U(KK,KK)
	          D=-D
	          DO 210 I=KK,M
210	          U(I,J)=U(I,J)+D*U(I,KK)
220	        CONTINUE
	      END IF
	      DO 225 I=KK,M
225	      U(I,KK)=-U(I,KK)
	      U(KK,KK)=1.0+U(KK,KK)
	      IF (KK-1.GE.1) THEN
	        DO 230 I=1,KK-1
230	        U(I,KK)=0.0
	      END IF
	    ELSE
	      DO 240 I=1,M
240	      U(I,KK)=0.0
	      U(KK,KK)=1.0
	    END IF
250	  CONTINUE
	END IF
	DO 300 LL=1,N
	  KK=N-LL+1
	  IF ((KK.LE.L).AND.(E(KK).NE.0.0)) THEN
	    DO 280 J=KK+1,N
	      D=0.0
	      DO 260 I=KK+1,N
260	      D=D+V(I,KK)*V(I,J)/V(KK+1,KK)
	      D=-D
	      DO 270 I=KK+1,N
270	      V(I,J)=V(I,J)+D*V(I,KK)
280	    CONTINUE
	  END IF
	  DO 290 I=1,N
290	  V(I,KK)=0.0
	  V(KK,KK)=1.0
300	CONTINUE
	DO 305 I=1,M
	DO 305 J=1,N
305	A(I,J)=0.0
	M1=MM
	IT=60
310	IF (MM.EQ.0) THEN
	  L=0
	  IF (M.GE.N) THEN
	    I=N
	  ELSE
	    I=M
	  END IF
	  DO 315 J=1,I-1
	    A(J,J)=S(J)
	    A(J,J+1)=E(J)
315	  CONTINUE
	  A(I,I)=S(I)
	  IF (M.LT.N) A(I,I+1)=E(I)
	  DO 314 I=1,N-1
	    DO 313 J=I+1,N
	      D=V(I,J)
	      V(I,J)=V(J,I)
	      V(J,I)=D
313	    CONTINUE
314	  CONTINUE
	  RETURN
	END IF
	IF (IT.EQ.0) THEN
	  L=MM
	  IF (M.GE.N) THEN
	    I=N
	  ELSE
	    I=M
	  END IF
	  DO 316 J=1,I-1
	    A(J,J)=S(J)
	    A(J,J+1)=E(J)
316	  CONTINUE
	  A(I,I)=S(I)
	  IF (M.LT.N) A(I,I+1)=E(I)
	  DO 318 I=1,N-1
	    DO 317 J=I+1,N
	      D=V(I,J)
	      V(I,J)=V(J,I)
	      V(J,I)=D
317	    CONTINUE
318	  CONTINUE
	  RETURN
	END IF
	KK=MM
320 	KK=KK-1
	IF (KK.NE.0) THEN
	  D=ABS(S(KK))+ABS(S(KK+1))
	  DD=ABS(E(KK))
	  IF (DD.GT.EPS*D) GOTO 320
	  E(KK)=0.0
	END IF
	IF (KK.EQ.MM-1) THEN
	  KK=KK+1
	  IF (S(KK).LT.0.0) THEN
	    S(KK)=-S(KK)
	    DO 330 I=1,N
330	    V(I,KK)=-V(I,KK)
	  END IF
335	  IF (KK.NE.M1) THEN
	    IF (S(KK).LT.S(KK+1)) THEN
	      D=S(KK)
	      S(KK)=S(KK+1)
	      S(KK+1)=D
	      IF (KK.LT.N) THEN
	        DO 340 I=1,N
	          D=V(I,KK)
	          V(I,KK)=V(I,KK+1)
	          V(I,KK+1)=D
340	        CONTINUE
	      END IF
	      IF (KK.LT.M) THEN
	        DO 350 I=1,M
	          D=U(I,KK)
	          U(I,KK)=U(I,KK+1)
	          U(I,KK+1)=D
350	        CONTINUE
	      END IF
	      KK=KK+1
	      GOTO 335
	    END IF
	  END IF
	  IT=60
	  MM=MM-1
	  GOTO 310
	END IF
	KS=MM+1
360	KS=KS-1
	IF (KS.GT.KK) THEN
	  D=0.0
	  IF (KS.NE.MM) D=D+ABS(E(KS))
	  IF (KS.NE.KK+1) D=D+ABS(E(KS-1))
	  DD=ABS(S(KS))
	  IF (DD.GT.EPS*D) GOTO 360
	  S(KS)=0.0
	END IF
	IF (KS.EQ.KK) THEN
	  KK=KK+1
	  D=ABS(S(MM))
	  IF (ABS(S(MM-1)).GT.D) D=ABS(S(MM-1))
	  IF (ABS(E(MM-1)).GT.D) D=ABS(E(MM-1))
	  IF (ABS(S(KK)).GT.D) D=ABS(S(KK))
	  IF (ABS(E(KK)).GT.D) D=ABS(E(KK))
	  SM=S(MM)/D
	  SM1=S(MM-1)/D
	  EM1=E(MM-1)/D
	  SK=S(KK)/D
	  EK=E(KK)/D
	  B=((SM1+SM)*(SM1-SM)+EM1*EM1)/2.0
	  C=SM*EM1
	  C=C*C
	  SHH=0.0
	  IF ((B.NE.0.0).OR.(C.NE.0.0)) THEN
	    SHH=SQRT(B*B+C)
	    IF (B.LT.0.0) SHH=-SHH
	    SHH=C/(B+SHH)
	  END IF
	  F=(SK+SM)*(SK-SM)-SHH
	  G=SK*EK
	  DO 400 I=KK,MM-1
	    CALL SSS(F,G,CS,SN)
	    IF (I.NE.KK) E(I-1)=F
	    F=CS*S(I)+SN*E(I)
	    E(I)=CS*E(I)-SN*S(I)
	    G=SN*S(I+1)
	    S(I+1)=CS*S(I+1)
	    IF ((CS.NE.1.0).OR.(SN.NE.0.0)) THEN
	      DO 370 J=1,N
	        D=CS*V(J,I)+SN*V(J,I+1)
	        V(J,I+1)=-SN*V(J,I)+CS*V(J,I+1)
	        V(J,I)=D
370	      CONTINUE
	    END IF
	    CALL SSS(F,G,CS,SN)
	    S(I)=F
	    F=CS*E(I)+SN*S(I+1)
	    S(I+1)=-SN*E(I)+CS*S(I+1)
	    G=SN*E(I+1)
	    E(I+1)=CS*E(I+1)
	    IF (I.LT.M) THEN
	      IF ((CS.NE.1.0).OR.(SN.NE.0.0)) THEN
	        DO 380 J=1,M
	          D=CS*U(J,I)+SN*U(J,I+1)
	          U(J,I+1)=-SN*U(J,I)+CS*U(J,I+1)
	          U(J,I)=D
380	        CONTINUE
	      END IF
	    END IF
400	  CONTINUE
	  E(MM-1)=F
	  IT=IT-1
	  GOTO 310
	END IF
	IF (KS.EQ.MM) THEN
	  KK=KK+1
	  F=E(MM-1)
	  E(MM-1)=0.0
	  DO 420 LL=KK,MM-1
	    I=MM+KK-LL-1
	    G=S(I)
	    CALL SSS(G,F,CS,SN)
	    S(I)=G
	    IF (I.NE.KK) THEN
	      F=-SN*E(I-1)
	      E(I-1)=CS*E(I-1)
	    END IF
	    IF ((CS.NE.1.0).OR.(SN.NE.0.0)) THEN
	      DO 410 J=1,N
	        D=CS*V(J,I)+SN*V(J,MM)
	        V(J,MM)=-SN*V(J,I)+CS*V(J,MM)
	        V(J,I)=D
410	      CONTINUE
	    END IF
420	  CONTINUE
	  GOTO 310
	END IF
	KK=KS+1
	F=E(KK-1)
	E(KK-1)=0.0
	DO 450 I=KK,MM
	  G=S(I)
	  CALL SSS(G,F,CS,SN)
	  S(I)=G
	  F=-SN*E(I)
	  E(I)=CS*E(I)
	  IF ((CS.NE.1.0).OR.(SN.NE.0.0)) THEN
	    DO 430 J=1,M
	      D=CS*U(J,I)+SN*U(J,KK-1)
	      U(J,KK-1)=-SN*U(J,I)+CS*U(J,KK-1)
	      U(J,I)=D
430	    CONTINUE
	  END IF
450	CONTINUE
	GOTO 310
	END

	SUBROUTINE SSS(F,G,CS,SN)
	DOUBLE PRECISION F,G,CS,SN,D,R
	IF ((ABS(F)+ABS(G)).EQ.0.0) THEN
	  CS=1.0
	  SN=0.0
	  D=0.0
	ELSE
	  D=SQRT(F*F+G*G)
	  IF (ABS(F).GT.ABS(G)) D=SIGN(D,F)
	  IF (ABS(G).GE.ABS(F)) D=SIGN(D,G)
	  CS=F/D
	  SN=G/D
	END IF
	R=1.0
	IF (ABS(F).GT.ABS(G)) THEN
	  R=SN
	ELSE
	  IF (CS.NE.0.0) R=1.0/CS
	END IF
	F=D
	G=R
	RETURN
	END

