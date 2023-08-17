
	SUBROUTINE GELR2(T,H,Y,M,F,D,EPS,A,B,C)
	DIMENSION Y(M),D(M),A(M),B(M),C(M)
	DOUBLE PRECISION T,H,Y,D,HH,X,A,B,C
	HH=H
	N=1
	P=1.0+EPS
	DO 10 I=1,M
10	A(I)=Y(I)
20	IF (P.GE.EPS) THEN
	  DO 30 I=1,M
	    B(I)=Y(I)
	    Y(I)=A(I)
30	  CONTINUE
	  DO 70 J=1,N
	    DO 35 I=1,M
35	    C(I)=Y(I)
	    X=T+(J-1)*HH
	    CALL F(X,Y,M,D)
	    DO 40 I=1,M
40	    Y(I)=C(I)+HH*D(I)
	    X=T+J*HH
	    CALL F(X,Y,M,D)
	    DO 50 I=1,M
50	    D(I)=C(I)+HH*D(I)
	    DO 60 I=1,M
60	    Y(I)=(Y(I)+D(I))/2.0
70	  CONTINUE
	  P=0.0
	  DO 80 I=1,M
	    Q=ABS(Y(I)-B(I))
	    IF (Q.GT.P) P=Q
80	  CONTINUE
	  HH=HH/2.0
	  N=N+N
	  GOTO 20
	END IF
	RETURN
	END

