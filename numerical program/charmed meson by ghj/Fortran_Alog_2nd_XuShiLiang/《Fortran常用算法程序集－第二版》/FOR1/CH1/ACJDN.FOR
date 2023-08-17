
	SUBROUTINE ACJDN(AR,AI,N,BR,BI,M,L,JS)
	DIMENSION AR(N,N),AI(N,N),BR(N,M),BI(N,M),JS(N)
	DOUBLE PRECISION AR,AI,BR,BI,D,P,Q,S
	L=1
	DO 100 K=1,N
	  D=0.0
	  DO 10 I=K,N
	  DO 10 J=K,N
	    P=AR(I,J)*AR(I,J)+AI(I,J)*AI(I,J)
	    IF (P.GT.D) THEN
	      D=P
	      JS(K)=J
	      IS=I
	    END IF
10	  CONTINUE
	  W=D
	  IF (W+1.0.EQ.1.0) THEN
	    WRITE(*,20)
	    L=0
	    RETURN
	  END IF
20	  FORMAT(1X,'  ERR**FAIL  ')
	  DO 30 J=K,N
	    P=AR(K,J)
	    AR(K,J)=AR(IS,J)
	    AR(IS,J)=P
	    P=AI(K,J)
	    AI(K,J)=AI(IS,J)
	    AI(IS,J)=P
30	  CONTINUE
	  DO 35 J=1,M
	    P=BR(K,J)
	    BR(K,J)=BR(IS,J)
	    BR(IS,J)=P
	    P=BI(K,J)
	    BI(K,J)=BI(IS,J)
	    BI(IS,J)=P
35	  CONTINUE
	  DO 50 I=1,N
	    P=AR(I,K)
	    AR(I,K)=AR(I,JS(K))
	    AR(I,JS(K))=P
	    P=AI(I,K)
	    AI(I,K)=AI(I,JS(K))
	    AI(I,JS(K))=P
50	  CONTINUE
	  DO 60 J=K+1,N
	    P=AR(K,J)*AR(K,K)
	    Q=-AI(K,J)*AI(K,K)
	    S=(AR(K,K)-AI(K,K))*(AR(K,J)+AI(K,J))
	    AR(K,J)=(P-Q)/D
	    AI(K,J)=(S-P-Q)/D
60	  CONTINUE
	  DO 65 J=1,M
	    P=BR(K,J)*AR(K,K)
	    Q=-BI(K,J)*AI(K,K)
	    S=(AR(K,K)-AI(K,K))*(BR(K,J)+BI(K,J))
	    BR(K,J)=(P-Q)/D
	    BI(K,J)=(S-P-Q)/D
65	  CONTINUE
	  DO 90 I=1,N
	    IF (I.NE.K) THEN
	      DO 80 J=K+1,N
	        P=AR(I,K)*AR(K,J)
	        Q=AI(I,K)*AI(K,J)
	        S=(AR(I,K)+AI(I,K))*(AR(K,J)+AI(K,J))
	        AR(I,J)=AR(I,J)-P+Q
	        AI(I,J)=AI(I,J)-S+P+Q
80	      CONTINUE
	      DO 85 J=1,M
	        P=AR(I,K)*BR(K,J)
	        Q=AI(I,K)*BI(K,J)
	        S=(AR(I,K)+AI(I,K))*(BR(K,J)+BI(K,J))
	        BR(I,J)=BR(I,J)-P+Q
	        BI(I,J)=BI(I,J)-S+P+Q
85	      CONTINUE
	    END IF
90	  CONTINUE
100	CONTINUE
	DO 110 K=N,1,-1
	DO 110 J=1,M
	  P=BR(K,J)
	  BR(K,J)=BR(JS(K),J)
	  BR(JS(K),J)=P
	  P=BI(K,J)
	  BI(K,J)=BI(JS(K),J)
	  BI(JS(K),J)=P
110	CONTINUE
	RETURN
	END


