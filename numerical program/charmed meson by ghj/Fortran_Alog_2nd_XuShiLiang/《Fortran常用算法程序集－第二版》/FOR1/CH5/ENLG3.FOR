
	SUBROUTINE ENLG3(X,Y,N,T,Z)
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
	IF (T.LE.X(2)) THEN
	  K=1
	  M=3
	ELSE IF (T.GE.X(N-1)) THEN
	  K=N-2
	  M=N
	ELSE
	  K=1
	  M=N
10	  IF (IABS(K-M).NE.1) THEN
	    L=(K+M)/2
	    IF (T.LT.X(L)) THEN
	      M=L
	    ELSE
	      K=L
	    END IF
	    GOTO 10
	  END IF
	  IF (ABS(T-X(K)).LT.ABS(T-X(M))) THEN
	    K=K-1
	  ELSE
	    M=M+1
	  END IF
	END IF
	Z=0.0
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