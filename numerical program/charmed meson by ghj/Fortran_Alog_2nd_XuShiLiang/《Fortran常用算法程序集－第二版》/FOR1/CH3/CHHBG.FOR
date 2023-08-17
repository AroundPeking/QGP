
	SUBROUTINE CHHBG(A,N)
	DIMENSION A(N,N)
	DOUBLE PRECISION A,D,T
	DO 100 K=2,N-1
	  D=0.0
	  DO 10 J=K,N
	    IF (ABS(A(J,K-1)).GT.ABS(D)) THEN
	      D=A(J,K-1)
	      I=J
	    END IF
10	  CONTINUE
	  IF (ABS(D)+1.0.NE.1.0) THEN
	    IF (I.NE.K) THEN
	      DO 20 J=K-1,N
	      T=A(I,J)
	      A(I,J)=A(K,J)
20	      A(K,J)=T
	      DO 30 J=1,N
	      T=A(J,I)
	      A(J,I)=A(J,K)
30	      A(J,K)=T
	    END IF
	    DO 90 I=K+1,N
	      T=A(I,K-1)/D
	      A(I,K-1)=0.0
	      DO 40 J=K,N
40	      A(I,J)=A(I,J)-T*A(K,J)
	      DO 50 J=1,N
50	      A(J,K)=A(J,K)+T*A(J,I)
90	    CONTINUE
	  END IF
100	CONTINUE
	RETURN
	END

