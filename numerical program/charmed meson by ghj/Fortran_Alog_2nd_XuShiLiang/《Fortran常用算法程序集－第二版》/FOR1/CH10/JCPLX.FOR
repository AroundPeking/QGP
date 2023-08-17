
	SUBROUTINE JCPLX(N,K,M,A,B,C,D,W,ALPHA,EPS,
     *                   FJ,FCN,XX,F,X,Z,L,XT,XF)
	DIMENSION A(N),B(N),C(K),D(K),W(K),X(N)
	DIMENSION XX(N,M),F(M),XT(N),XF(N)
	DOUBLE PRECISION A,B,C,D,W,XX,F,X,Z,XT,XF,FJ,FR,FG,T
	REAL NRND1
	INTEGER R,G
	DO 10 I=1,N
10	XX(I,1)=X(I)
	F(1)=FJ(N,X)
	DO 100 J=2,M
	  DO 20 I=1,N
	    XX(I,J)=A(I)+(B(I)-A(I))*NRND1(T)
	    X(I)=XX(I,J)
20	  CONTINUE
30	  R=1
	  G=0
40	  IF ((A(R).LE.X(R)).AND.(B(R).GE.X(R))) THEN
	    R=R+1
	    IF (R.LE.N) GOTO 40
	  ELSE
	    G=1
	  END IF
	  IF (G.EQ.0) THEN
	    CALL FCN(N,K,X,C,D,W)
	    R=1
60	    IF ((C(R).LE.W(R)).AND.(D(R).GE.W(R))) THEN
	      R=R+1
	      IF (R.LE.K) GOTO 60
	    ELSE
	      G=1
	    END IF
	  END IF
	  IF (G.NE.0) THEN
	    DO 80 R=1,N
	      Z=0.0
	      DO 70 G=1,J-1
70	      Z=Z+XX(R,G)/(J-1.0)
	      XX(R,J)=(XX(R,J)+Z)/2.0
	      X(R)=XX(R,J)
80	    CONTINUE
	    GOTO 30
	  END IF
	  F(J)=FJ(N,X)
100	CONTINUE

	L=1
110	FR=F(1)
	R=1
	DO 120 I=2,M
	  IF (F(I).GT.FR) THEN
	    R=I
	    FR=F(I)
	  END IF
120	CONTINUE
	G=1
	J=1
	FG=F(1)
	IF (R.EQ.1) THEN
	  G=2
	  J=2
	  FG=F(2)
	END IF
	DO 130 I=J+1,M
	  IF (I.NE.R) THEN
	    IF (F(I).GT.FG) THEN
	      G=I
	      FG=F(I)
	    END IF
	  END IF
130	CONTINUE
	DO 150 I=1,N
	  XF(I)=0.0
	  DO 140 J=1,M
	    IF (J.NE.R) XF(I)=XF(I)+XX(I,J)/(M-1.0)
140	  CONTINUE
	  XT(I)=(1.0+ALPHA)*XF(I)-ALPHA*XX(I,R)
150	CONTINUE
160	Z=FJ(N,XT)
	IF (Z.GT.FG) THEN
	  DO 180 I=1,N
180	  XT(I)=(XT(I)+XF(I))/2.0
	  GOTO 160
	END IF
	J=0
	DO 190 I=1,N
	  IF (A(I).GT.XT(I)) THEN
	    XT(I)=XT(I)+0.000001
	    J=1
	  END IF
	  IF (B(I).LT.XT(I)) THEN
	    XT(I)=XT(I)-0.000001
	    J=1
	  END IF
190	CONTINUE

	IF (J.NE.0) GOTO 160
	CALL FCN(N,K,XT,C,D,W)
	J=1
200	IF ((C(J).LE.W(J)).AND.(D(J).GE.W(J))) THEN
	  J=J+1
	  IF (J.LE.K) GOTO 200
	END IF
	IF (J.LE.K) THEN
	  DO 210 I=1,N
210	  XT(I)=(XT(I)+XF(I))/2.0
	  GOTO 160
	END IF
	DO 220 I=1,N
220	XX(I,R)=XT(I)
	F(R)=Z
	FR=0.0
	FG=0.0
	DO 230 J=1,M
	  FR=FR+F(J)/M
	  FG=FG+F(J)*F(J)
230	CONTINUE
	FR=(FG-M*FR*FR)/(M-1.0)
	IF (FR.GE.EPS) THEN
	  L=L+1
	  IF (L.LT.201) GOTO 110
	END IF
	DO 250 I=1,N
	  X(I)=0.0
	  DO 240 J=1,M
240	  X(I)=X(I)+XX(I,J)/M
250	CONTINUE
	Z=FJ(N,X)
	RETURN
	END


