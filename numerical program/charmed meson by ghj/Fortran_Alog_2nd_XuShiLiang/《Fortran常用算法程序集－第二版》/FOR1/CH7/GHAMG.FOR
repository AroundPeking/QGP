
	SUBROUTINE GHAMG(T,H,N,Y,M,Z,F,D,EPS,B,U,BB,CC,GG)
	EXTERNAL F
	DIMENSION Y(M),D(M),Z(M,N),B(4,M),U(M),BB(M),CC(M),GG(M)
	DOUBLE PRECISION Y,D,Z,B,U,A,T,H,Q,BB,CC,GG
	A=T
	DO 5 I=1,M
5	Z(I,1)=Y(I)
	CALL F(T,Y,M,D)
	DO 10 I=1,M
10	B(1,I)=D(I)
	DO 40 I=2,4
	  IF (I.LE.N) THEN
	    T=A+(I-1)*H
	    CALL GRKT2(T,H,Y,M,F,EPS,D,BB,CC,GG,Z(1,N))
	    DO 20 K=1,M
20	    Z(K,I)=Y(K)
	    CALL F(T,Y,M,D)
	    DO 30 K=1,M
30	    B(I,K)=D(K)
	  END IF
40	CONTINUE
	DO 45 I=1,M
45	U(I)=0.0
	DO 100 I=5,N
	  DO 50 J=1,M
	    Q=2*B(4,J)-B(3,J)+2*B(2,J)
	    IF (I.EQ.5) THEN
	      Y(J)=Z(J,1)+4*H*Q/3.0
	    ELSE
	      Y(J)=Z(J,I-4)+4*H*Q/3.0
	    END IF
50	  CONTINUE
	  DO 70 J=1,M
70	  Y(J)=Y(J)+112*U(J)/121.0
	  T=A+(I-1)*H
	  CALL F(T,Y,M,D)
	  DO 80 J=1,M
	    Q=(9*Z(J,I-1)-Z(J,I-3)+3*H*(D(J)+2*B(4,J)-B(3,J)))/8.0
	    U(J)=Q-Y(J)
	    Z(J,I)=Q-9*U(J)/121.0
	    Y(J)=Z(J,I)
	    B(2,J)=B(3,J)
	    B(3,J)=B(4,J)
80	  CONTINUE
	  CALL F(T,Y,M,D)
	  DO 90 K=1,M
90	  B(4,K)=D(K)
100	CONTINUE
	T=A
	RETURN
	END

