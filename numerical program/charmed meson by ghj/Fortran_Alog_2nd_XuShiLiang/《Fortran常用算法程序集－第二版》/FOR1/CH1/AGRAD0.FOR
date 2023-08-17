
	DIMENSION A(4,4),B(4),X(4),P(4),R(4),S(4),Q(4)
	DOUBLE PRECISION A,B,X,P,R,S,Q
	DATA A/5.0,7.0,6.0,5.0,7.0,10.0,8.0,7.0,
     *         6.0,8.0,10.0,9.0,5.0,7.0,9.0,10.0/
	DATA B/23.0,32.0,33.0,31.0/
	EPS=0.000001
	CALL AGRAD(A,4,B,EPS,X,P,R,S,Q)
	WRITE(*,*)
	WRITE(*,10) (X(I),I=1,4)
	WRITE(*,*)
10	FORMAT(1X,D15.6)
	END





