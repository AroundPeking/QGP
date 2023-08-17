
	SUBROUTINE ALDLE(A,N,M,C,L)
	DIMENSION A(N,N),C(N,M)
	DOUBLE PRECISION A,C
	L=1
	IF (ABS(A(1,1))+1.0.EQ.1.0) THEN
	  L=0
	  WRITE(*,10)
	  RETURN
	END IF
10	FORMAT(1X,'FAIL')
	DO 20 I=2,N
20	A(I,1)=A(I,1)/A(1,1)
	DO 60 I=2,N-1
	  DO 30 J=2,I
30	  A(I,I)=A(I,I)-A(I,J-1)*A(I,J-1)*A(J-1,J-1)
	  DO 50 K=I+1,N
	    DO 40 J=2,I
40	    A(K,I)=A(K,I)-A(K,J-1)*A(I,J-1)*A(J-1,J-1)
	    IF (ABS(A(I,I))+1.0.EQ.1.0) THEN
	      L=0
	      WRITE(*,10)
	      RETURN
	    END IF
	    A(K,I)=A(K,I)/A(I,I)
50	  CONTINUE
60	CONTINUE
	DO 70 J=2,N
70	A(N,N)=A(N,N)-A(N,J-1)*A(N,J-1)*A(J-1,J-1)
	DO 80 J=1,M
	DO 80 I=2,N
	DO 80 K=2,I
80	C(I,J)=C(I,J)-A(I,K-1)*C(K-1,J)
	DO 90 I=2,N
	DO 90 J=I,N
90	A(I-1,J)=A(I-1,I-1)*A(J,I-1)
	IF (ABS(A(N,N))+1.0.EQ.1.0) THEN
	  L=0
	  WRITE(*,10)
	  RETURN
	END IF
	DO 150 J=1,M
	  C(N,J)=C(N,J)/A(N,N)
	  DO 140 K=2,N
	    K1=N-K+2
	    DO 130 K2=K1,N
	      K3=N-K+1
	      C(K3,J)=C(K3,J)-A(K3,K2)*C(K2,J)
130	    CONTINUE
	    C(K3,J)=C(K3,J)/A(K3,K3)
140	  CONTINUE
150	CONTINUE
	RETURN
	END

