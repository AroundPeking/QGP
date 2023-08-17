
	SUBROUTINE ABAND(B,D,N,L,IL,M,IT)
	DIMENSION B(N,IL),D(N,M)
	DOUBLE PRECISION B,D,T
	IT=1
	IF (IL.NE.2*L+1) THEN
	  IT=-1
	  WRITE(*,20)
	  RETURN
	END IF
	LS=L+1
	DO 100 K=1,N-1
	  P=0.0
	  DO 10 I=K,LS
	    IF (ABS(B(I,1)).GT.P) THEN
	      P=ABS(B(I,1))
	      IS=I
	    END IF
10	  CONTINUE
	  IF (P+1.0.EQ.1.0) THEN
	    IT=0
	    WRITE(*,20)
	    RETURN
	  END IF
20	  FORMAT(1X,'***FAIL***')
	  DO 30 J=1,M
	    T=D(K,J)
	    D(K,J)=D(IS,J)
	    D(IS,J)=T
30	  CONTINUE
	  DO 40 J=1,IL
	    T=B(K,J)
	    B(K,J)=B(IS,J)
	    B(IS,J)=T
40	  CONTINUE
	  DO 50 J=1,M
50	  D(K,J)=D(K,J)/B(K,1)
	  DO 60 J=2,IL
60	  B(K,J)=B(K,J)/B(K,1)
	  DO 90 I=K+1,LS
	    T=B(I,1)
	    DO 70 J=1,M
70	    D(I,J)=D(I,J)-T*D(K,J)
	    DO 80 J=2,IL
80	    B(I,J-1)=B(I,J)-T*B(K,J)
	    B(I,IL)=0.0
90	  CONTINUE
	  IF (LS.NE.N) LS=LS+1
100	CONTINUE
	IF (ABS(B(N,1))+1.0.EQ.1.0) THEN
	  IT=0
	  WRITE(*,20)
	  RETURN
	END IF
	DO 110 J=1,M
110	D(N,J)=D(N,J)/B(N,1)
	JS=2
	DO 150 I=N-1,1,-1
	  DO 120 K=1,M
	  DO 120 J=2,JS
120	  D(I,K)=D(I,K)-B(I,J)*D(I+J-1,K)
	  IF (JS.NE.IL) JS=JS+1
150	CONTINUE
	RETURN
	END

