
	SUBROUTINE ENLGR(X,Y,N,T,Z)
	DIMENSION X(N),Y(N)
	DOUBLE PRECISION X,Y,T,Z,S
	Z=0.0
	IF (N.LE.0) RETURN
	IF (N.EQ.1) THEN
	  Z=Y(1)
	  RETURN
	END IF
	IF (N.EQ.2) THEN
	  Z=(Y(1)*(T-X(2))-Y(2)*(T-X(1)))/(X(1)-X(2))
	  RETURN
	END IF
	I=1
10	IF (X(I).LT.T) THEN
	  I=I+1
	  IF (I.LE.N) GOTO 10
	END IF
	K=I-4
	IF (K.LT.1) K=1
	M=I+3
	IF (M.GT.N) M=N

	DO 30 I=K,M
	  S=1.0
	  DO 20 J=K,M
	    IF (J.NE.I) THEN
	      S=S*(T-X(J))/(X(I)-X(J))
	    END IF
20	  CONTINUE
	  Z=Z+S*Y(I)
30	CONTINUE
	RETURN
	END

