
	SUBROUTINE AGMQR(A,M,N,B,Q,L,C)
	DIMENSION A(M,N),B(M),Q(M,M),C(N)
	DOUBLE PRECISION A,B,Q,C,D
	CALL BMAQR(A,M,N,Q,L)
	IF (L.EQ.0) RETURN
	DO 20 I=1,N
	  D=0.0
	  DO 10 J=1,M
10	  D=D+Q(J,I)*B(J)
	  C(I)=D
20	CONTINUE
	B(N)=C(N)/A(N,N)
	DO 40 I=N-1,1,-1
	  D=0.0
	  DO 30 J=I+1,N
30	  D=D+A(I,J)*B(J)
	  B(I)=(C(I)-D)/A(I,I)
40	CONTINUE
	RETURN
	END


