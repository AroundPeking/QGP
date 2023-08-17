
	SUBROUTINE AGJDN(A,B,N,M,L,JS)
	DIMENSION A(N,N),B(N,M),JS(N)
	DOUBLE PRECISION A,B,D
	L=1
	DO 100 K=1,N
	  Q=0.0
	  DO 10 I=K,N
	  DO 10 J=K,N
	    IF (ABS(A(I,J)).GT.Q) THEN
	      Q=ABS(A(I,J))
	      JS(K)=J
	      IS=I
	    END IF
10	  CONTINUE
	  IF (Q+1.0.EQ.1.0) THEN
	    WRITE(*,20)
	    L=0
	    RETURN
	  END IF
20	  FORMAT(1X,'  FAIL  ')
	  DO 30 J=K,N
	    D=A(K,J)
	    A(K,J)=A(IS,J)
	    A(IS,J)=D
30	  CONTINUE
	  DO 40 J=1,M
	    D=B(K,J)
	    B(K,J)=B(IS,J)
	    B(IS,J)=D
40	  CONTINUE
	  DO 50 I=1,N
	    D=A(I,K)
	    A(I,K)=A(I,JS(K))
	    A(I,JS(K))=D
50	  CONTINUE
	  DO 60 J=K+1,N
60	  A(K,J)=A(K,J)/A(K,K)
	  DO 70 J=1,M
70	  B(K,J)=B(K,J)/A(K,K)
	  DO 90 I=1,N
	    IF (I.NE.K) THEN
	      DO 80 J=K+1,N
80	      A(I,J)=A(I,J)-A(I,K)*A(K,J)
	      DO 85 J=1,M
85	      B(I,J)=B(I,J)-A(I,K)*B(K,J)
	    END IF
90	  CONTINUE
100	CONTINUE
	DO 110 K=N,1,-1
	DO 110 J=1,M
	  D=B(K,J)
	  B(K,J)=B(JS(K),J)
	  B(JS(K),J)=D
110	CONTINUE
	RETURN
	END

