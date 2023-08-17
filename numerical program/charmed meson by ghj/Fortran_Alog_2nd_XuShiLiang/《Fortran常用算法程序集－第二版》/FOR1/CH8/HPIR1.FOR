
	SUBROUTINE HPIR1(X,Y,A,N,M,DT1,DT2,DT3)
	DIMENSION X(N),Y(N),A(M),S(20),T(20),B(20)
	DOUBLE PRECISION X,Y,A,S,T,B,DT1,DT2,DT3,
     *                   Z,D1,P,C,D2,G,Q,DT
	DO 5 I=1,M
5	A(I)=0.0
	IF (M.GT.N) M=N
	IF (M.GT.20) M=20
	Z=0.0
	DO 10 I=1,N
10	Z=Z+X(I)/N
	B(1)=1.0
	D1=N
	P=0.0
	C=0.0
	DO 20 I=1,N
	  P=P+(X(I)-Z)
	  C=C+Y(I)
20	CONTINUE
	C=C/D1
	P=P/D1
	A(1)=C*B(1)
	IF (M.GT.1) THEN
	  T(2)=1.0
	  T(1)=-P
	  D2=0.0
	  C=0.0
	  G=0.0
	  DO 30 I=1,N
	    Q=X(I)-Z-P
	    D2=D2+Q*Q
	    C=Y(I)*Q+C
	    G=(X(I)-Z)*Q*Q+G
30	  CONTINUE

	  C=C/D2
	  P=G/D2
	  Q=D2/D1
	  D1=D2
	  A(2)=C*T(2)
	  A(1)=C*T(1)+A(1)
	END IF
	DO 100 J=3,M
	  S(J)=T(J-1)
	  S(J-1)=-P*T(J-1)+T(J-2)
	  IF (J.GE.4) THEN
	    DO 40 K=J-2,2,-1
40	    S(K)=-P*T(K)+T(K-1)-Q*B(K)
	  END IF
	  S(1)=-P*T(1)-Q*B(1)
	  D2=0.0
	  C=0.0
	  G=0.0
	  DO 70 I=1,N
	    Q=S(J)
	    DO 60 K=J-1,1,-1
60	    Q=Q*(X(I)-Z)+S(K)
	    D2=D2+Q*Q
	    C=Y(I)*Q+C
	    G=(X(I)-Z)*Q*Q+G
70	  CONTINUE
	  C=C/D2
	  P=G/D2
	  Q=D2/D1
	  D1=D2
	  A(J)=C*S(J)
	  T(J)=S(J)
	  DO 80 K=J-1,1,-1
	    A(K)=C*S(K)+A(K)
	    B(K)=T(K)
	    T(K)=S(K)
80	  CONTINUE
100	CONTINUE
	DT1=0.0
	DT2=0.0
	DT3=0.0
	DO 120 I=1,N
	  Q=A(M)
	  DO 110 K=M-1,1,-1
110	  Q=Q*(X(I)-Z)+A(K)
	  DT=Q-Y(I)
	  IF (ABS(DT).GT.DT3) DT3=ABS(DT)
	  DT1=DT1+DT*DT
	  DT2=DT2+ABS(DT)
120	CONTINUE
	RETURN
	END

