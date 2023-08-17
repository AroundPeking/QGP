
	SUBROUTINE GPBS1(T,H,Y,M,F,EPS,D,B,U,V,W)
	DIMENSION Y(M),D(M),B(10,M),G(10)
	DIMENSION U(M),V(M),W(M)
	DOUBLE PRECISION Y,D,B,G,U,V,T,H,X,HH,DD,Q,W
	DO 20 J=1,M
20	V(J)=Y(J)
	X=T
	NN=1
	HH=H
	G(1)=HH
	CALL EULER(X,Y,M,HH,F,D,W)
	DO 30 J=1,M
	  B(1,J)=Y(J)
	  U(J)=Y(J)
30	CONTINUE
	K=2
40	NN=NN+NN
	HH=HH/2.0
	G(K)=HH


	DO 50 J=1,M
50	Y(J)=V(J)
	T=X
	DO 60 J=1,NN
	  CALL EULER(T,Y,M,HH,F,D,W)
	  T=T+HH
60	CONTINUE
	DO 80 J=1,M
	  DD=Y(J)
	  DO 70 II=1,K-1
	    Q=DD-B(II,J)
	    IF (ABS(Q)+1.0.EQ.1.0) THEN
	      DD=SIGN(1.0D+35,Q)
	      DD=DD*SIGN(1.0D0,G(K)-G(II))
	    ELSE
	      DD=(G(K)-G(II))/Q
	    END IF
70	  CONTINUE
	  B(K,J)=DD
80	CONTINUE
	DO 100 J=1,M
	  DD=0.0
	  DO 90 II=K-1,1,-1
	    DD=B(II+1,J)+DD
	    IF (ABS(DD)+1.0D0.EQ.1.0D0) THEN
	      DD=SIGN(1.0D+35,DD)
	      DD=DD*SIGN(1.0D0,-G(II))
	    ELSE
	      DD=-G(II)/DD
	    END IF
90	  CONTINUE
	  Y(J)=DD+B(1,J)
100	CONTINUE
	P=0.0
	DO 110 J=1,M
	  Q=ABS(Y(J)-U(J))
	  IF (Q.GT.P) P=Q
110	CONTINUE
	IF ((P.GE.EPS).AND.(K.LT.7)) THEN
	  DO 120 J=1,M
120	  U(J)=Y(J)
	  K=K+1
	  GOTO 40
	END IF
	T=X
	RETURN
	END

	SUBROUTINE EULER(T,Y,M,H,F,D,A)
	DIMENSION Y(M),D(M),A(M)
	DOUBLE PRECISION A,Y,D,T,H,X
	CALL F(T,Y,M,D)
	DO 20 I=1,M
20	A(I)=Y(I)+H*D(I)
	X=T+H
	CALL F(X,A,M,D)
	DO 30 I=1,M
30	D(I)=Y(I)+H*D(I)
	DO 40 I=1,M
40	Y(I)=(A(I)+D(I))/2.0
	RETURN
	END

