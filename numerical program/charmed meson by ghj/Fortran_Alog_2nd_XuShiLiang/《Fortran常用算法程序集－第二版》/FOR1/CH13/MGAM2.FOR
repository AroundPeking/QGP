
	FUNCTION MGAM2(A,X)
	DOUBLE PRECISION MGAM2,A,X
	DOUBLE PRECISION MGAM1,P,Q,D,S,S1,P0,Q0,P1,Q1,QQ
	IF ((A.LE.0.0).OR.(X.LT.0.0)) THEN
	  IF (A.LE.0.0) THEN
	    WRITE(*,*) '  ERR** A<=0!'
	  END IF
	  IF (X.LT.0.0) THEN
	    WRITE(*,*) '  ERR** X<0!'
	  END IF
	  MGAM2=-1.0
	END IF
	IF (X+1.0.EQ.1.0) THEN
	  MGAM2=0.0
	  RETURN
	END IF
	IF (X.GT.1.0D+35) THEN
	  MGAM2=1.0
	  RETURN
	END IF
	Q=LOG(X)
	Q=A*Q
	QQ=EXP(Q)
	IF (X.LT.1.0+A) THEN
	  P=A
	  D=1.0/A
	  S=D
	  DO 10 N=1,100
	    P=1.0+P
	    D=D*X/P
	    S=S+D
	    IF (ABS(D).LT.ABS(S)*1.0D-07) THEN
	      S=S*EXP(-X)*QQ/MGAM1(A)
	      MGAM2=S
	      RETURN
	    END IF
10	  CONTINUE
	ELSE
	  S=1.0/X
	  P0=0.0
	  P1=1.0
	  Q0=1.0
	  Q1=X
	  DO 20 N=1,100
	    P0=P1+(N-A)*P0
	    Q0=Q1+(N-A)*Q0
	    P=X*P0+N*P1
	    Q=X*Q0+N*Q1
	    IF (ABS(Q)+1.0.NE.1.0) THEN
	      S1=P/Q
	      P1=P
	      Q1=Q
	      IF (ABS((S1-S)/S1).LT.1.0D-07) THEN
	        S=S1*EXP(-X)*QQ/MGAM1(A)
	        MGAM2=1.0-S
	        RETURN
	      END IF
	      S=S1
	    END IF
	    P1=P
	    Q1=Q
20	  CONTINUE
	END IF
	WRITE(*,*) ' A too large !'
	S=1.0-S*EXP(-X)*QQ/MGAM1(A)
	MGAM2=S
	RETURN
	END

