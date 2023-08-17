
	SUBROUTINE ACHOL(A,N,M,D,L)
	DIMENSION A(N,N),D(N,M)
	DOUBLE PRECISION A,D
	L=1
	IF (A(1,1)+1.0.EQ.1.0) THEN
	  L=0
	  WRITE(*,30)
	  RETURN
	END IF
	A(1,1)=SQRT(A(1,1))
	DO 10 J=2,N
10	A(1,J)=A(1,J)/A(1,1)
	DO 100 I=2,N
	  DO 20 J=2,I
20	  A(I,I)=A(I,I)-A(J-1,I)*A(J-1,I)
	  IF (A(I,I)+1.0.EQ.1.0) THEN
	    L=0
	    WRITE(*,30)
	    RETURN
	  END IF
30	  FORMAT(1X,'FAIL')
	  A(I,I)=SQRT(A(I,I))
	  IF (I.NE.N) THEN
	    DO 50 J=I+1,N
	    DO 40 K=2,I
40	    A(I,J)=A(I,J)-A(K-1,I)*A(K-1,J)
50	    A(I,J)=A(I,J)/A(I,I)
	  END IF
100	CONTINUE
	DO 130 J=1,M
	  D(1,J)=D(1,J)/A(1,1)
	  DO 120 I=2,N
	    DO 110 K=2,I
110	    D(I,J)=D(I,J)-A(K-1,I)*D(K-1,J)
	    D(I,J)=D(I,J)/A(I,I)
120	  CONTINUE
130	CONTINUE
	DO 160 J=1,M
	  D(N,J)=D(N,J)/A(N,N)
	  DO 150 K=N,2,-1
	    DO 140 I=K,N
140	    D(K-1,J)=D(K-1,J)-A(K-1,I)*D(I,J)
	    D(K-1,J)=D(K-1,J)/A(K-1,K-1)
150	  CONTINUE
160	CONTINUE
	RETURN
	END

