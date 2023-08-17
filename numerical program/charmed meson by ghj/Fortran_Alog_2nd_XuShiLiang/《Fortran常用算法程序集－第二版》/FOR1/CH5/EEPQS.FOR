
	SUBROUTINE EEPQS(X1,H,N,Y,T,Z)
	DIMENSION Y(N),B(8)
	DOUBLE PRECISION X1,H,Y,T,Z,B,HH,X2,X3
	Z=0.0
	IF (N.LE.0) RETURN
	IF (N.EQ.1) THEN
	  Z=Y(1)
	  RETURN
	END IF
	IF (N.LE.8) THEN
	  K=1
	  M=N
	ELSE IF (T.LT.(X1+H*4.0)) THEN
	  K=1
	  M=8
	ELSE IF (T.GT.(X1+(N-5)*H)) THEN
	  K=N-7
	  M=8
	ELSE
	  K=(T-X1)/H-2
	  M=8
	END IF
	B(1)=Y(K)
	DO 30 I=2,M
	  HH=Y(I+K-1)
	  X2=X1+(I+K-2)*H
	  DO 20 J=1,I-1
	    HH=HH-B(J)
	    X3=X1+(J+K-2)*H
	    IF (ABS(HH)+1.0D0.EQ.1.0D0) THEN
	      HH=SIGN(1.0D+35,HH)
	      HH=HH*SIGN(1.0D0,X2-X3)
	    ELSE
	      HH=(X2-X3)/HH
	    END IF
20	  CONTINUE
	  B(I)=HH
30	CONTINUE
	Z=B(M)
	DO 40 I=M-1,1,-1
	  HH=T-(X1+(I+K-2)*H)
	  IF (ABS(Z)+1.0D0.EQ.1.0D0) THEN
	    Z=SIGN(1.0D+35,Z)
	    Z=Z*SIGN(1.0D0,HH)
	    Z=B(I)+Z
	  ELSE
	    Z=B(I)+HH/Z
	  END IF
40	CONTINUE
	RETURN
	END

