
	SUBROUTINE AGGJE(A,N,B,L,JS)
	DIMENSION A(N,N),B(N),JS(N)
	DOUBLE PRECISION A,B,T
	L=1
	DO 100 K=1,N
	  D=0.0
	  DO 10 I=K,N
	  DO 10 J=K,N
	    IF (ABS(A(I,J)).GT.D) THEN
	      D=ABS(A(I,J))
	      JS(K)=J
	      IS=I
	    END IF
10	  CONTINUE
	  IF (D+1.0.EQ.1.0) THEN
	    WRITE(*,20)
	    L=0
	    RETURN
	  END IF
20	  FORMAT(1X,'  FAIL  ')
	  DO 30 J=K,N
	    T=A(K,J)
	    A(K,J)=A(IS,J)
	    A(IS,J)=T
30	  CONTINUE
	  T=B(K)
	  B(K)=B(IS)
	  B(IS)=T
	  DO 50 I=1,N
	    T=A(I,K)
	    A(I,K)=A(I,JS(K))
	    A(I,JS(K))=T
50	  CONTINUE
	  T=A(K,K)
	  DO 60 J=K+1,N
	    IF (A(K,J).NE.0.0) A(K,J)=A(K,J)/T
60	  CONTINUE
	  B(K)=B(K)/T
	  DO 80 J=K+1,N
	    IF (A(K,J).NE.0.0) THEN
	      DO 70 I=1,N
	        IF ((I.NE.K).AND.(A(I,K).NE.0.0)) THEN
                  A(I,J)=A(I,J)-A(I,K)*A(K,J)
	        END IF
70	      CONTINUE
	    END IF
80	  CONTINUE
	  DO 90 I=1,N
	    IF ((I.NE.K).AND.(A(I,K).NE.0.0)) THEN
              B(I)=B(I)-A(I,K)*B(K)
	    END IF
90	  CONTINUE
100	CONTINUE
	DO 110 K=N,1,-1
	  IF (K.NE.JS(K)) THEN
	    T=B(K)
	    B(K)=B(JS(K))
	    B(JS(K))=T
	  END IF
110	CONTINUE
	RETURN
	END

