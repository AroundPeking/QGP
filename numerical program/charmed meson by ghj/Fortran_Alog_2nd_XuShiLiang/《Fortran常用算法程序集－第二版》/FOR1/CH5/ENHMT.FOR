
	SUBROUTINE ENHMT(X,Y,DY,N,T,Z)
	DIMENSION X(N),Y(N),DY(N)
	DOUBLE PRECISION X,Y,DY,T,Z,S,P,Q
	Z=0.0
	DO 30 I=1,N
	  S=1.0
	  DO 10 J=1,N
	    IF (J.NE.I) S=S*(T-X(J))/(X(I)-X(J))
10	  CONTINUE
	  S=S*S
	  P=0.0
	  DO 20 J=1,N
	    IF (J.NE.I) P=P+1.0/(X(I)-X(J))
20	  CONTINUE
	  Q=Y(I)+(T-X(I))*(DY(I)-2*Y(I)*P)
	  Z=Z+Q*S
30	CONTINUE
	RETURN
	END

