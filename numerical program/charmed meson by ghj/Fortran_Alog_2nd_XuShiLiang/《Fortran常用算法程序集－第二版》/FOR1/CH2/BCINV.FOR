
	SUBROUTINE BCINV(AR,AI,N,L,IS,JS)
	DIMENSION AR(N,N),AI(N,N),IS(N),JS(N)
	DOUBLE PRECISION AR,AI,D,P,T,Q,S,B
	L=1
	DO 100 K=1,N
	  D=0.0
	  DO 10 I=K,N
	  DO 10 J=K,N
	    P=AR(I,J)*AR(I,J)+AI(I,J)*AI(I,J)
	    IF (P.GT.D) THEN
	      D=P
	      IS(K)=I
	      JS(K)=J
	    END IF
10	  CONTINUE
	  IF (D+1.0.EQ.1.0) THEN
	    L=0
	    WRITE(*,20)
	    RETURN
	  END IF
20	  FORMAT(1X,'ERR**NOT INV')
	  DO 30 J=1,N
	    T=AR(K,J)
	    AR(K,J)=AR(IS(K),J)
	    AR(IS(K),J)=T
	    T=AI(K,J)
	    AI(K,J)=AI(IS(K),J)
	    AI(IS(K),J)=T
30	  CONTINUE
	  DO 40 I=1,N
	    T=AR(I,K)
	    AR(I,K)=AR(I,JS(K))
	    AR(I,JS(K))=T
	    T=AI(I,K)
	    AI(I,K)=AI(I,JS(K))
	    AI(I,JS(K))=T
40	  CONTINUE
	  AR(K,K)=AR(K,K)/D
	  AI(K,K)=-AI(K,K)/D
	  DO 50 J=1,N
	    IF (J.NE.K) THEN
	      P=AR(K,J)*AR(K,K)
	      Q=AI(K,J)*AI(K,K)
	      S=(AR(K,J)+AI(K,J))*(AR(K,K)+AI(K,K))
	      AR(K,J)=P-Q
	      AI(K,J)=S-P-Q
	    END IF
50	  CONTINUE
	  DO 70 I=1,N
	    IF (I.NE.K) THEN
	      DO 60 J=1,N
	        IF (J.NE.K) THEN
	          P=AR(K,J)*AR(I,K)
	          Q=AI(K,J)*AI(I,K)
	          S=(AR(K,J)+AI(K,J))*(AR(I,K)+AI(I,K))
	          T=P-Q
	          B=S-P-Q
	          AR(I,J)=AR(I,J)-T
	          AI(I,J)=AI(I,J)-B
	        END IF
60	      CONTINUE
	    END IF
70	  CONTINUE
	  DO 80 I=1,N
	    IF (I.NE.K) THEN
	      P=AR(I,K)*AR(K,K)
	      Q=AI(I,K)*AI(K,K)
	      S=(AR(I,K)+AI(I,K))*(AR(K,K)+AI(K,K))
	      AR(I,K)=Q-P
	      AI(I,K)=P+Q-S
	    END IF
80	  CONTINUE
100	CONTINUE
	DO 130 K=N,1,-1
	  DO 110 J=1,N
	    T=AR(K,J)
	    AR(K,J)=AR(JS(K),J)
	    AR(JS(K),J)=T
	    T=AI(K,J)
	    AI(K,J)=AI(JS(K),J)
	    AI(JS(K),J)=T
110	  CONTINUE
	  DO 120 I=1,N
	    T=AR(I,K)
	    AR(I,K)=AR(I,IS(K))
	    AR(I,IS(K))=T
	    T=AI(I,K)
	    AI(I,K)=AI(I,IS(K))
	    AI(I,IS(K))=T
120	  CONTINUE
130	CONTINUE
	RETURN
	END

