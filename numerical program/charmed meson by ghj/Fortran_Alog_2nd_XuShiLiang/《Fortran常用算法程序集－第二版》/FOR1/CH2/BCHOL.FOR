
	SUBROUTINE BCHOL(A,N,DET,L)
	DIMENSION A(N,N)
	DOUBLE PRECISION A,DET
	L=1
	IF (A(1,1)+1.0.EQ.1.0) THEN
	  L=0
	  WRITE(*,10)
	  RETURN
	END IF
10	FORMAT(1X,'  FAIL')
	A(1,1)=SQRT(A(1,1))
	DET=A(1,1)
	DO 20 I=2,N
20	A(I,1)=A(I,1)/A(1,1)
	DO 60 J=2,N
	  DO 30 K=1,J-1
30	  A(J,J)=A(J,J)-A(J,K)*A(J,K)
	  IF (A(J,J)+1.0.EQ.1.0) THEN
	    L=0
	    WRITE(*,10)
	    RETURN
	  END IF
	  A(J,J)=SQRT(A(J,J))
	  DET=DET*A(J,J)
	  DO 50 I=J+1,N
	    DO 40 K=1,J-1
40	    A(I,J)=A(I,J)-A(I,K)*A(J,K)
	    A(I,J)=A(I,J)/A(J,J)
50	  CONTINUE
60	CONTINUE
	DET=DET*DET
	DO 70 I=1,N-1
	DO 70 J=I+1,N
70	A(I,J)=0.0
	RETURN
	END


