
	SUBROUTINE EEATK(X1,H,N,Y,T,EPS,Z)
	DIMENSION Y(N),XM(10),YM(10)
	DOUBLE PRECISION X1,H,Y,XM,YM,T,Z
	M=10
	IF (M.GT.N) M=N
	Z=0.0
	IF (M.LE.0) RETURN
	IF (N.EQ.1) THEN
	  Z=Y(1)
	  RETURN
	END IF
	IF (M.EQ.1) M=2
	IF (T.LE.X1) THEN
	  K=1
	ELSE IF (T.GE.X1+(N-1)*H) THEN
	  K=N
	ELSE
	  K=1
	  J=N
10	  IF (IABS(K-J).NE.1) THEN
	    L=(K+J)/2
	    IF (T.LT.X1+(L-1)*H) THEN
	      J=L
	    ELSE
	      K=L
	    END IF
	    GOTO 10
	  END IF
	  IF (ABS(T-X1-(L-1)*H).GT.ABS(T-X1-(J-1)*H)) K=J
	END IF
	J=1
	L=0
	DO 20 I=1,M
	  K=K+J*L
	  IF ((K.LT.1).OR.(K.GT.N)) THEN
	    L=L+1
	    J=-J
	    K=K+J*L
	  END IF
	  XM(I)=X1+(K-1)*H
	  YM(I)=Y(K)
	  L=L+1
	  J=-J
20	CONTINUE
	I=2
	P=1.0+EPS
100	IF ((I.LE.M).AND.(P.GE.EPS)) THEN
	  Z=YM(I)
	  DO 30 J=2,I
30	  Z=YM(J-1)+(T-XM(J-1))*(YM(J-1)-Z)/(XM(J-1)-XM(I))
	  YM(I)=Z
	  P=ABS(YM(I)-YM(I-1))
	  I=I+1
	  GOTO 100
	END IF
	RETURN
	END

