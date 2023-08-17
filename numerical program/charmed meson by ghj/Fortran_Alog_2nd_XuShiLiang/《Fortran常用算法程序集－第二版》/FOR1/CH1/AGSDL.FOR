
	SUBROUTINE AGSDL(A,B,N,X,EPS,L)
	DIMENSION A(N,N),B(N),X(N)
	DOUBLE PRECISION A,B,X,T,S,P,Q
	DO 5 I=1,N
	  IF (ABS(A(I,I))+1.0.EQ.1.0) THEN
	    L=0
	    WRITE(*,100)
	    RETURN
	  END IF
5	CONTINUE
100	FORMAT(1X,'  FAIL')
	L=100
	DO 10 I=1,N
10	X(I)=0.0
20	P=0.0
	L=L-1
	DO 50 I=1,N
	  T=X(I)
	  S=0.0
	  DO 30 J=1,N
	    IF (J.NE.I) S=S+A(I,J)*X(J)
30	  CONTINUE
	  X(I)=(B(I)-S)/A(I,I)
	  Q=ABS(X(I)-T)/(1+ABS(X(I)))
	  IF (Q.GT.P) P=Q
50	CONTINUE
	IF ((P.GE.EPS).AND.(L.NE.0)) GOTO 20
	IF (L.EQ.0) WRITE(*,100)
	RETURN
	END

