
	SUBROUTINE DNMTC(X,N,B,M,EPS,F,Y)
	DIMENSION X(N),Y(N)
	DOUBLE PRECISION R
	REAL NRND1
	A=B
	K=1
	R=1.0D0
	Z=F(X,N)
10	IF (A.GE.EPS) THEN
	  L=L+1
	  DO 20 I=1,N
20	  Y(I)=-A+2.0*A*NRND1(R)+X(I)
	  Z1=F(Y,N)
	  K=K+1
	  IF (Z1.GE.Z) THEN
	    IF (K.GT.M) THEN
	      K=1
	      A=A/2.0
	    END IF
	    GOTO 10
	  ELSE
	    K=1
	    DO 30 I=1,N
30	    X(I)=Y(I)
	    Z=Z1
	    IF (Z.GE.EPS) GOTO 10
	  END IF
	END IF
	END

