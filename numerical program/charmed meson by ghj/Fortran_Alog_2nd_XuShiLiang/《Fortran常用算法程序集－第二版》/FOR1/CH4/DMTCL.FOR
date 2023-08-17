
	SUBROUTINE DMTCL(X,B,M,EPS,F)
	DOUBLE PRECISION R
	REAL NRND1
	A=B
	K=1
	R=1.0D0
	Y=F(X)
10	IF (A.GE.EPS) THEN
	  L=L+1
	  X1=-A+2.0*A*NRND1(R)
	  X1=X+X1
	  Y1=F(X1)
	  K=K+1
	  IF (ABS(Y1).GE.ABS(Y)) THEN
	    IF (K.GT.M) THEN
	      K=1
	      A=A/2.0
	    END IF
	    GOTO 10
	  ELSE
	    K=1
	    X=X1
	    Y=Y1
	    IF (ABS(Y).GE.EPS) GOTO 10
	  END IF
	END IF
	END

