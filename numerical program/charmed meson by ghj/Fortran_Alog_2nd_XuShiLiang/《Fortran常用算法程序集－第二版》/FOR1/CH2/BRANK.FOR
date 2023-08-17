
	SUBROUTINE BRANK(A,M,N,K)
	DIMENSION A(M,N)
	DOUBLE PRECISION A,D,Q
	IF (M.GE.N) THEN
	  NN=N
	ELSE
	  NN=M
	END IF
	K=0
	DO 100 L=1,NN
	  Q=0.0
	  DO 10 I=L,M
	  DO 10 J=L,N
	    IF (ABS(A(I,J)).GT.Q) THEN
	      Q=ABS(A(I,J))
	      IS=I
	      JS=J
	    END IF
10	  CONTINUE
	  IF (Q+1.0.EQ.1.0) RETURN
	  K=K+1
	  IF (IS.NE.L) THEN
	    DO 20 J=L,N
	      D=A(L,J)
	      A(L,J)=A(IS,J)
	      A(IS,J)=D
20	    CONTINUE
	  END IF
	  IF (JS.NE.L) THEN
	    DO 30 I=L,M
	      D=A(I,JS)
	      A(I,JS)=A(I,L)
	      A(I,L)=D
30	    CONTINUE
	  END IF
	  DO 50 I=L+1,N
	    D=A(I,L)/A(L,L)
	    DO 40 J=L+1,N
40	    A(I,J)=A(I,J)-D*A(L,J)
50	  CONTINUE
100	CONTINUE
	RETURN
	END

