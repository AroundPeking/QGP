
	SUBROUTINE GRKT2(T,H,Y,M,F,EPS,D,B,C,G,E)
	DIMENSION Y(M),D(M),A(4),B(M),C(M),G(M),E(M)
	DOUBLE PRECISION Y,D,A,B,C,G,T,H,X,HH,E
	HH=H
	N=1
	P=1+EPS
	X=T
	DO 5 I=1,M
5	C(I)=Y(I)
10	IF (P.GE.EPS) THEN
	  A(1)=HH/2.0
	  A(2)=A(1)
	  A(3)=HH
	  A(4)=HH
	  DO 20 I=1,M
	    G(I)=Y(I)
	    Y(I)=C(I)
20	  CONTINUE
	  DT=H/N
	  T=X
	  DO 100 J=1,N 
	    CALL F(T,Y,M,D)
	    DO 30 I=1,M
	    E(I)=Y(I)
30	    B(I)=Y(I)
	    DO 50 K=1,3
	      DO 40 I=1,M
	        Y(I)=E(I)+A(K)*D(I)
	        B(I)=B(I)+A(K+1)*D(I)/3.0
40	      CONTINUE


	      TT=T+A(K)
	      CALL F(TT,Y,M,D)
50	    CONTINUE
	    DO 60 I=1,M
60	    Y(I)=B(I)+HH*D(I)/6.0
	    T=T+DT
100	  CONTINUE
	  P=0.0
	  DO 110 I=1,M
	    Q=ABS(Y(I)-G(I))
	    IF (Q.GT.P) P=Q
110	  CONTINUE
	  HH=HH/2.0
	  N=N+N
	  GOTO 10
	END IF
	T=X
	RETURN
	END

