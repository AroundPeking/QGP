
	SUBROUTINE EEHMT(X1,H,N,Y,DY,T,Z)
	DIMENSION Y(N),DY(N)
	DOUBLE PRECISION X1,H,Y,DY,T,Z,S,P,Q
	Z=0.0
	DO 30 I=1,N
	  S=1.0
	  Q=X1+(I-1)*H
	  DO 10 J=1,N
	    P=X1+(J-1)*H
	    IF (J.NE.I) S=S*(T-P)/(Q-P)
10	  CONTINUE
	  S=S*S
	  P=0.0
	  DO 20 J=1,N
	    IF (J.NE.I) P=P+1.0/(Q-(X1+(J-1)*H))
20	  CONTINUE
	  Q=Y(I)+(T-Q)*(DY(I)-2*Y(I)*P)
	  Z=Z+Q*S
30	CONTINUE
	RETURN
	END

