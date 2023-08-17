
	SUBROUTINE ISQT2(X,Y,M,MM,N,A,Q,S,R,V,U,B)
	DIMENSION X(M,N),Y(N),A(MM),B(MM,MM),V(M)
	DOUBLE PRECISION X,Y,A,B,V,Q,S,R,U,YY,DYY,P,PP
	B(1,1)=N
	DO 20 J=2,MM
	  B(1,J)=0.0
	  DO 10 I=1,N
10	  B(1,J)=B(1,J)+X(J-1,I)
	  B(J,1)=B(1,J)
20	CONTINUE
	DO 50 I=2,MM
	  DO 40 J=I,MM
	    B(I,J)=0.0
	    DO 30 K=1,N
30	    B(I,J)=B(I,J)+X(I-1,K)*X(J-1,K)
	    B(J,I)=B(I,J)
40	  CONTINUE
50	CONTINUE
	A(1)=0.0
	DO 60 I=1,N
60	A(1)=A(1)+Y(I)
	DO 80 I=2,MM
	  A(I)=0.0
	  DO 70 J=1,N
70	  A(I)=A(I)+X(I-1,J)*Y(J)
80	CONTINUE
	CALL ACHOL(B,MM,1,A,L)
	YY=0.0
	DO 90 I=1,N
90	YY=YY+Y(I)/N
	Q=0.0
	DYY=0.0
	U=0.0

	DO 110 I=1,N
	  P=A(1)
	  DO 100 J=1,M
100	  P=P+A(J+1)*X(J,I)
	  Q=Q+(Y(I)-P)*(Y(I)-P)
	  DYY=DYY+(Y(I)-YY)*(Y(I)-YY)
	  U=U+(YY-P)*(YY-P)
110	CONTINUE
	S=SQRT(Q/N)
	R=SQRT(1.0-Q/DYY)
	DO 150 J=1,M
	  P=0.0
	  DO 140 I=1,N
	    PP=A(1)
	    DO 130 K=1,M
	      IF (K.NE.J) PP=PP+A(K+1)*X(K,I)
130	    CONTINUE
	    P=P+(Y(I)-PP)*(Y(I)-PP)
140	  CONTINUE
	  V(J)=SQRT(1.0-Q/P)
150	CONTINUE
	RETURN
	END

