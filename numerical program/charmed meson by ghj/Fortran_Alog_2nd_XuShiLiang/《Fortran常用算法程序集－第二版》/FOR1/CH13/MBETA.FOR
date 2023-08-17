
	FUNCTION MBETA(A,B,X)
	DOUBLE PRECISION MBETA,A,B,X
	DOUBLE PRECISION Y,BETA,MGAM1
	IF (A.LE.0.0) THEN
	  WRITE(*,*) ' ERR** A<=0 !'
	  MBETA=-1.0
	  RETURN
	END IF
	IF (B.LE.0.0) THEN
	  WRITE(*,*) ' ERR** B<=0 !'
	  MBETA=-1.0
	  RETURN
	END IF
	IF ((X.LT.0.0).OR.(X.GT.1.0)) THEN
	  WRITE(*,*) ' ERR** X<0 or X>1 !'
	  MBETA=1.0D+35
	  RETURN
	END IF
	IF ((X+1.0.EQ.1.0).OR.(X+1.0.EQ.2.0)) THEN
          Y=0.0
	ELSE
	  Y=A*LOG(X)+B*LOG(1.0-X)
	  Y=EXP(Y)
	  Y=Y*MGAM1(A+B)/(MGAM1(A)*MGAM1(B))
	END IF
	IF (X.LT.(A+1.0)/(A+B+2.0)) THEN
	  Y=Y*BETA(A,B,X)/A
	ELSE
	  Y=1.0-Y*BETA(B,A,1.0-X)/B
	END IF
	MBETA=Y
	RETURN
	END

	FUNCTION BETA(A,B,X)
	DOUBLE PRECISION BETA,A,B,X
	DOUBLE PRECISION D,P0,Q0,P1,Q1,S0,S1
	P0=0.0
	Q0=1.0
	P1=1.0
	Q1=1.0
	DO 10 K=1,100
	  D=(A+K)*(A+B+K)*X
	  D=-D/((A+K+K)*(A+K+K+1.0))
	  P0=P1+D*P0
	  Q0=Q1+D*Q0
	  S0=P0/Q0
	  D=K*(B-K)*X
	  D=D/((A+K+K-1.0)*(A+K+K))
	  P1=P0+D*P1
	  Q1=Q0+D*Q1
	  S1=P1/Q1
	  IF (ABS(S1-S0).LT.ABS(S1)*1.0D-07) THEN
	    BETA=S1
	    RETURN
	  END IF
10	CONTINUE
	WRITE(*,*) ' A or B too big !'
	BETA=S1
	RETURN
	END

