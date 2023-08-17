
	SUBROUTINE DDHRT(A,B,H,EPS,X,N,M,F)
	DIMENSION X(N)
	M=0
	Z=A
	Y=F(Z)
10	IF ((Z.GT.B+H/2.0).OR.(M.EQ.N)) RETURN
	IF (ABS(Y).LT.EPS) THEN
	  M=M+1
	  X(M)=Z
	  Z=Z+H/2.0
	  Y=F(Z)
	  GOTO 10
	END IF
	Z1=Z+H
	Y1=F(Z1)
	IF (ABS(Y1).LT.EPS) THEN
	  M=M+1
	  X(M)=Z1
	  Z=Z1+H/2.0
	  Y=F(Z)
	  GOTO 10
	END IF
	IF (Y*Y1.GT.0.0) THEN
	  Y=Y1
	  Z=Z1
	  GOTO 10
	END IF
20	IF (ABS(Z1-Z).LT.EPS) THEN
	  M=M+1
	  X(M)=(Z1+Z)/2.0
	  Z=Z1+H/2.0
	  Y=F(Z)
	  GOTO 10
	END IF
	Z0=(Z1+Z)/2.0
	Y0=F(Z0)
	IF (ABS(Y0).LT.EPS) THEN
	  M=M+1
	  X(M)=Z0
	  Z=Z0+H/2.0
	  Y=F(Z)
	  GOTO 10
	END IF
	IF (Y*Y0.LT.0.0) THEN
	  Z1=Z0
	  Y1=Y0
	ELSE
	  Z=Z0
	  Y=Y0
	END IF
	GOTO 20
	END

