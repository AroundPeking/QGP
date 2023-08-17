
	SUBROUTINE DSRRT(A,XR,XI,N,M,L,B)
	DIMENSION A(N),XR(M),XI(M),B(N)
	IF (ABS(A(1))+1.0.EQ.1.0) THEN
	  L=0
	  WRITE(*,5)
	  RETURN
	END IF
5	FORMAT(1X,'  ERR')
	L=1
	K=M
	IS=0
	W=1.0
	DO 10 I=1,N
10	B(I)=A(I)/A(1)
20	PP=ABS(B(K+1))
	IF (PP.LT.1.0E-12) THEN
	  XR(K)=0.0
	  XI(K)=0.0
	  K=K-1
	  IF (K.EQ.1) THEN
	    XR(K)=-B(2)*W/B(1)
	    XI(K)=0.0
	    RETURN
	  END IF
	  GOTO 20
	END IF
	Q=PP**(1.0/K)
	P=Q
	W=W*P
	DO 30 I=1,K
	  B(I+1)=B(I+1)/Q
	  Q=Q*P
30	CONTINUE
	X=0.0001
	X1=X
	Y=0.2
	Y1=Y
	G=1.0E+37
	DX=1.0
40	U=B(1)
	V=0.0
	DO 50 I=1,K
	  P=U*X1
	  Q=V*Y1
	  PQ=(U+V)*(X1+Y1)
	  U=P-Q+B(I+1)
	  V=PQ-P-Q
50	CONTINUE
	G1=U*U+V*V
	IF (G1.LT.G) GOTO 105
	IF (IS.NE.0) GOTO 80
60	T=T/1.67
	X1=X-T*DX
	Y1=Y-T*DY
	IF (K.GE.50) THEN
	  P=SQRT(X1*X1+Y1*Y1)
	  Q=EXP(85.0/K)
	  IF (P.GE.Q) GOTO 60
	END IF
	IF (T.GE.1.0E-03) GOTO 40
	IF (G.LE.1.0E-18) GOTO 90
65	IS=1
	DD=SQRT(DX*DX+DY*DY)
	IF (DD.GT.1.0) DD=1.0
	DC=6.28/(K+4.5)
70	C=0.0
80	C=C+DC
	DX=DD*COS(C)
	DY=DD*SIN(C)
	X1=X+DX
	Y1=Y+DY
	IF (C.LE.6.29) GOTO 40
	DD=DD/1.67
	IF (DD.GT.1.0E-07) GOTO 70
90	IF (ABS(Y).LE.1.0E-06) THEN
	  P=-X
	  Y=0.0
	  Q=0.0
	ELSE
	  P=-2.0*X
	  Q=X*X+Y*Y
	  XR(K)=X*W
	  XI(K)=-Y*W
	  K=K-1
	END IF
	DO 100 I=1,K
	  B(I+1)=B(I+1)-B(I)*P
	  B(I+2)=B(I+2)-B(I)*Q
100	CONTINUE
	XR(K)=X*W
	XI(K)=Y*W
	K=K-1
	IF (K.EQ.1) THEN
	  XR(K)=-B(2)*W/B(1)
	  XI(K)=0.0
	  RETURN
	END IF
	GOTO 20
105	G=G1
	X=X1
	Y=Y1
	IS=0
	IF (G.LE.1.0E-22) GOTO 90
	U1=K*B(1)
	V1=0.0
	DO 110 I=2,K
	  P=U1*X
	  Q=V1*Y
	  PQ=(U1+V1)*(X+Y)
	  U1=P-Q+(K-I+1)*B(I)
	  V1=PQ-P-Q
110	CONTINUE
	P=U1*U1+V1*V1
	IF (P.LE.1.0E-20) GOTO 65
	DX=(U*U1+V*V1)/P
	DY=(U1*V-V1*U)/P
	T=1.0+4.0/K
	GOTO 60
	END

