
	SUBROUTINE ENPQS(X,Y,N,T,Z)
	DIMENSION X(N),Y(N),B(8)
	DOUBLE PRECISION X,Y,T,Z,B,H
	Z=0.0
	IF (N.LE.0) RETURN
	IF (N.EQ.1) THEN
	  Z=Y(1)
	  RETURN
	END IF
	IF (N.LE.8) THEN
	  K=1
	  M=N
	ELSE IF (T.LT.X(5)) THEN
	  K=1
	  M=8
	ELSE IF (T.GT.X(N-4)) THEN
	  K=N-7
	  M=8
	ELSE
	  K=1
	  J=N
10	  IF (IABS(K-J).NE.1) THEN
	    L=(K+J)/2
	    IF (T.LT.X(L)) THEN
	      J=L
	    ELSE
	      K=L
	    END IF
	    GOTO 10
	  END IF
	  K=K-3
	  M=8
	END IF
	B(1)=Y(K)
	DO 30 I=2,M
	  H=Y(I+K-1)
	  DO 20 J=1,I-1
	    H=H-B(J)
	    IF (ABS(H)+1.0D0.EQ.1.0D0) THEN
	      H=SIGN(1.0D+35,H)
	      H=H*SIGN(1.0D0,X(I+K-1)-X(J+K-1))
	    ELSE
	      H=(X(I+K-1)-X(J+K-1))/H
	    END IF
20	  CONTINUE
	  B(I)=H
30	CONTINUE
	Z=B(M)
	DO 40 I=M-1,1,-1
	  IF (ABS(Z)+1.0D0.EQ.1.0D0) THEN
	    Z=SIGN(1.0D+35,Z)
	    Z=Z*SIGN(1.0D0,T-X(I+K-1))
	    Z=B(I)+Z
	  ELSE
	    Z=B(I)+(T-X(I+K-1))/Z
	  END IF
40	CONTINUE
	RETURN
	END

