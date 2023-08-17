
	SUBROUTINE ESLQ3(X,Y,Z,N,M,U,V,W)
	DIMENSION X(N),Y(M),Z(N,M),B(3)
	DOUBLE PRECISION X,Y,Z,U,V,W,B,HH
	NN=3
	IF (N.LE.3) THEN
	  IP=1
	  NN=N
	ELSE IF (U.LE.X(2)) THEN
	  IP=1
	ELSE IF (U.GE.X(N-1)) THEN
	  IP=N-2
	ELSE
	  I=1
	  J=N
10	  IF (IABS(I-J).NE.1) THEN
	    L=(I+J)/2
	    IF (U.LT.X(L)) THEN
	      J=L
	    ELSE
	      I=L
	    END IF
	    GOTO 10
	  END IF
	  IF (ABS(U-X(I)).LT.ABS(U-X(J))) THEN
	    IP=I-1
	  ELSE
	    IP=I
	  END IF
	END IF
	MM=3
	IF (M.LE.3) THEN
	  IQ=1
	  MM=M
	ELSE IF (V.LE.Y(2)) THEN
	  IQ=1
	ELSE IF (V.GE.Y(M-1)) THEN
	  IQ=M-2
	ELSE
	  I=1
	  J=M
20	  IF (IABS(J-I).NE.1) THEN
	    L=(I+J)/2
	    IF (V.LT.Y(L)) THEN
	      J=L
	    ELSE
	      I=L
	    END IF
	    GOTO 20
	  END IF


	  IF (ABS(V-Y(I)).LT.ABS(V-Y(J))) THEN
	    IQ=I-1
	  ELSE
	    IQ=I
	  END IF
	END IF
	DO 50 I=1,NN
	  B(I)=0.0
	  DO 40 J=1,MM
	    HH=Z(IP+I-1,IQ+J-1)
	    DO 30 K=1,MM
	      IF (K.NE.J) THEN
	        HH=HH*(V-Y(IQ+K-1))/(Y(IQ+J-1)-Y(IQ+K-1))
	      END IF
30	    CONTINUE
	    B(I)=B(I)+HH
40	  CONTINUE
50	CONTINUE
	W=0.0
	DO 70 I=1,NN
	  HH=B(I)
	  DO 60 J=1,NN
	    IF (J.NE.I) THEN
	      HH=HH*(U-X(IP+J-1))/(X(IP+I-1)-X(IP+J-1))
	    END IF
60	  CONTINUE
	  W=W+HH
70	CONTINUE
	RETURN
	END

