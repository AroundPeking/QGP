
	SUBROUTINE ESLGQ(X,Y,Z,N,M,U,V,W)
	DIMENSION X(N),Y(M),Z(N,M),B(10)
	DOUBLE PRECISION X,Y,Z,U,V,W,B,HH
	IF (U.LE.X(1)) THEN
	  IP=1
	  IPP=4
	ELSE IF (U.GE.X(N)) THEN
	  IP=N-3
	  IPP=N
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
	  IP=I-3
	  IPP=I+4
	END IF
	IF (IP.LT.1) IP=1
	IF (IPP.GT.N) IPP=N
	IF (V.LE.Y(1)) THEN
	  IQ=1
	  IQQ=4
	ELSE IF (V.GE.Y(M)) THEN
	  IQ=M-3
	  IQQ=M
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
	  IQ=I-3
	  IQQ=I+4
	END IF
	IF (IQ.LT.1) IQ=1
	IF (IQQ.GT.M) IQQ=M
	DO 50 I=IP,IPP
	  B(I-IP+1)=0.0
	  DO 40 J=IQ,IQQ
	    HH=Z(I,J)
	    DO 30 K=IQ,IQQ
	      IF (K.NE.J) THEN
	        HH=HH*(V-Y(K))/(Y(J)-Y(K))
	      END IF
30	    CONTINUE
	    B(I-IP+1)=B(I-IP+1)+HH
40	  CONTINUE
50	CONTINUE
	W=0.0
	DO 70 I=IP,IPP
	  HH=B(I-IP+1)
	  DO 60 J=IP,IPP
	    IF (J.NE.I) THEN
	      HH=HH*(U-X(J))/(X(I)-X(J))
	    END IF
60	  CONTINUE
	  W=W+HH
70	CONTINUE
	RETURN
	END

