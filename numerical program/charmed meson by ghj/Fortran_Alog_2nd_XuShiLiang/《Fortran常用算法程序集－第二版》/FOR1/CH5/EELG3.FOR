
	SUBROUTINE EELG3(X1,H,N,Y,T,Z)
	DIMENSION Y(N)
	DOUBLE PRECISION X1,H,Y,T,Z,S,XI,XJ
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
	IF (T.LE.(X1+H)) THEN
	  K=1
	  M=3
	ELSE IF (T.GE.(X1+(N-2)*H)) THEN
	  K=N-2
	  M=N
	ELSE
	  I=(T-X1)/H+1
	  IF (ABS(T-X1-I*H).GE.ABS(T-X1-(I-1)*H)) THEN
	    K=I-1
	    M=I+1
	  ELSE
	    K=I
	    M=I+2
	  END IF
	END IF
	Z=0.0
	DO 30 I=K,M
	  S=1.0
	  XI=X1+(I-1)*H
	  DO 20 J=K,M
	    IF (J.NE.I) THEN
	      XJ=X1+(J-1)*H
	      S=S*(T-XJ)/(XI-XJ)
	    END IF
20	  CONTINUE
	  Z=Z+S*Y(I)
30	CONTINUE
	RETURN
	END

