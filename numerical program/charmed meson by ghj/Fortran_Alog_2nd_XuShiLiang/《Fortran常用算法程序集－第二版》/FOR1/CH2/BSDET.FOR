
	SUBROUTINE BSDET(A,N,DET)
	DIMENSION A(N,N)
	DOUBLE PRECISION A,DET,F,D,Q
	F=1.0
	DET=1.0
	DO 100 K=1,N-1
	  Q=0.0
	  DO 10 I=K,N
	  DO 10 J=K,N
	    IF (ABS(A(I,J)).GT.Q) THEN
	      Q=ABS(A(I,J))
	      IS=I
	      JS=J
	    END IF
10	  CONTINUE
	  IF (Q+1.0.EQ.1.0) THEN
	    DET=0.0
	    RETURN
	  END IF
	  IF (IS.NE.K) THEN
	    F=-F
	    DO 20 J=K,N
	      D=A(K,J)
	      A(K,J)=A(IS,J)
	      A(IS,J)=D
20	    CONTINUE
	  END IF
	  IF (JS.NE.K) THEN
	    F=-F
	    DO 30 I=K,N
	      D=A(I,JS)
	      A(I,JS)=A(I,K)
	      A(I,K)=D
30	    CONTINUE
	  END IF
	  DET=DET*A(K,K)
	  DO 50 I=K+1,N
	    D=A(I,K)/A(K,K)
	    DO 40 J=K+1,N
40	    A(I,J)=A(I,J)-D*A(K,J)
50	  CONTINUE
100	CONTINUE
	DET=F*DET*A(N,N)
	RETURN
	END

