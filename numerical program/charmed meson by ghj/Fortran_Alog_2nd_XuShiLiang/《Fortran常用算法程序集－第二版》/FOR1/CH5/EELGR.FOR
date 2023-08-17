
	SUBROUTINE EELGR(X1,H,N,Y,T,Z)
	DIMENSION Y(N)
	DOUBLE PRECISION X1,H,Y,T,Z,S,XX,P,Q
	Z=0.0
	IF (N.LE.0) RETURN
	IF (N.EQ.1) THEN
	  Z=Y(1)
	  RETURN
	END IF
	IF (N.EQ.2) THEN
	  Z=(Y(2)*(T-X1)-Y(1)*(T-X1-H))/H
	  RETURN
	END IF
	IF (T.GT.X1) THEN
	  P=(T-X1)/H
	  I=P
	  Q=1.0*I
	  I=I+1
	  IF (P.GT.Q) I=I+1
	ELSE
	  I=1
	END IF
	K=I-4
	IF (K.LT.1) K=1
	M=I+3
	IF (M.GT.N) M=N
	Z=0.0
	DO 30 I=K,M
	  S=1.0
	  XX=X1+(I-1)*H
	  DO 20 J=K,M
	    IF (J.NE.I) THEN
	      XJ=X1+(J-1)*H
	      S=S*(T-XJ)/(XX-XJ)
	    END IF
20	  CONTINUE
	  Z=Z+S*Y(I)
30	CONTINUE
	RETURN
	END

