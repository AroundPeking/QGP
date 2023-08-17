
	SUBROUTINE GADMS(T,H,N,Y,M,Z,F,D,EPS,B,E,S,G)
	EXTERNAL F
	DIMENSION Y(M),D(M),Z(M,N),B(4,M),E(M),S(M),G(M)
	DOUBLE PRECISION Y,Z,D,B,T,H,A,Q,E,S,G
	A=T
	DO 5 I=1,M
5	Z(I,1)=Y(I)
	CALL F(T,Y,M,D)
	DO 10 I=1,M
10	B(1,I)=D(I)
	DO 40 I=2,4
	  IF (I.LE.N) THEN
	    T=A+(I-1)*H
	    CALL GRKT2(T,H,Y,M,F,EPS,D,E,S,G,Z(1,N))
	    DO 20 K=1,M
20	    Z(K,I)=Y(K)
	    CALL F(T,Y,M,D)
	    DO 30 K=1,M
30	    B(I,K)=D(K)
	  END IF
40	CONTINUE
	DO 100 I=5,N
	  DO 50 J=1,M
	    Q=55*B(4,J)-59*B(3,J)+37*B(2,J)-9*B(1,J)
	    Y(J)=Z(J,I-1)+H*Q/24.0
	    B(1,J)=B(2,J)
	    B(2,J)=B(3,J)
	    B(3,J)=B(4,J)
50	  CONTINUE
	  T=A+(I-1)*H
	  CALL F(T,Y,M,D)
	  DO 60 K=1,M
60	  B(4,K)=D(K)
	  DO 70 J=1,M
	    Q=9*B(4,J)+19*B(3,J)-5*B(2,J)+B(1,J)
	    Z(J,I)=Z(J,I-1)+H*Q/24.0
	    Y(J)=Z(J,I)
70	  CONTINUE
	  CALL F(T,Y,M,D)
	  DO 80 K=1,M
80	  B(4,K)=D(K)
100	CONTINUE
	T=A
	RETURN
	END

