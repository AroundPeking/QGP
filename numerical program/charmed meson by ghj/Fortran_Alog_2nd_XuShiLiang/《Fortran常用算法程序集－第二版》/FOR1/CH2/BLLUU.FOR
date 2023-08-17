
	SUBROUTINE BLLUU(A,N,L,U,JT)
	DIMENSION A(N,N),L(N,N),U(N,N)
	DOUBLE PRECISION A,L,U
	DO 100 K=1,N-1
	  IF (ABS(A(K,K))+1.0.EQ.1.0) THEN
	    WRITE(*,*) '***FAIL***'
	    JT=0
	  END IF
	  DO 10 I=K+1,N
10	  A(I,K)=A(I,K)/A(K,K)
	  DO 20 I=K+1,N
	  DO 20 J=K+1,N
20	  A(I,J)=A(I,J)-A(I,K)*A(K,J)
100	CONTINUE
	DO 200 I=1,N
	  DO 30 J=1,I-1
	    L(I,J)=A(I,J)
	    U(I,J)=0.0
30	  CONTINUE
	  L(I,I)=1.0
	  U(I,I)=A(I,I)
	  DO 40 J=I+1,N
	    L(I,J)=0.0
	    U(I,J)=A(I,J)
40	  CONTINUE
200	CONTINUE
	JT=1
	END

