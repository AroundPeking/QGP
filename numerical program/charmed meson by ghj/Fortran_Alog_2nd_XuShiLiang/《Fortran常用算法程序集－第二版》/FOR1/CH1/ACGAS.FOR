
	SUBROUTINE ACGAS(AR,AI,N,BR,BI,L,JS)
	DIMENSION AR(N,N),AI(N,N),BR(N),BI(N),JS(N)
	DOUBLE PRECISION AR,AI,BR,BI,D,P,Q,S
	L=1
	DO 100 K=1,N-1
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
	  P=BR(K)
	  BR(K)=BR(IS)
	  BR(IS)=P
	  P=BI(K)
	  BI(K)=BI(IS)
	  BI(IS)=P
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
	  P=BR(K)*AR(K,K)
	  Q=-BI(K)*AI(K,K)
	  S=(AR(K,K)-AI(K,K))*(BR(K)+BI(K))
	  BR(K)=(P-Q)/D
	  BI(K)=(S-P-Q)/D
	  DO 90 I=K+1,N
	    DO 80 J=K+1,N
	      P=AR(I,K)*AR(K,J)
	      Q=AI(I,K)*AI(K,J)
	      S=(AR(I,K)+AI(I,K))*(AR(K,J)+AI(K,J))
	      AR(I,J)=AR(I,J)-P+Q
	      AI(I,J)=AI(I,J)-S+P+Q
80	    CONTINUE
	    P=AR(I,K)*BR(K)
	    Q=AI(I,K)*BI(K)
	    S=(AR(I,K)+AI(I,K))*(BR(K)+BI(K))
	    BR(I)=BR(I)-P+Q
	    BI(I)=BI(I)-S+P+Q
90	  CONTINUE
100	CONTINUE
	D=AR(N,N)*AR(N,N)+AI(N,N)*AI(N,N)
	W=D
	IF (W+1.0.EQ.1.0) THEN
	  L=0
	  WRITE(*,20)
	  RETURN
	END IF
	P=AR(N,N)*BR(N)
	Q=-AI(N,N)*BI(N)
	S=(AR(N,N)-AI(N,N))*(BR(N)+BI(N))
	BR(N)=(P-Q)/D
	BI(N)=(S-P-Q)/D
	DO 200 I=N-1,1,-1
	  DO 150 J=I+1,N
	    P=AR(I,J)*BR(J)
	    Q=AI(I,J)*BI(J)
	    S=(AR(I,J)+AI(I,J))*(BR(J)+BI(J))
	    BR(I)=BR(I)-P+Q
	    BI(I)=BI(I)-S+P+Q
150	  CONTINUE
200	CONTINUE
	JS(N)=N
	DO 110 K=N,1,-1
	  P=BR(K)
	  BR(K)=BR(JS(K))
	  BR(JS(K))=P
	  P=BI(K)
	  BI(K)=BI(JS(K))
	  BI(JS(K))=P
110	CONTINUE
	RETURN
	END


