
	DOUBLE PRECISION MGASS,A0,D0,X,Y,A(2),D(2)
	DATA A/-1.0,3.0/
	DATA D/0.5,15.0/
	WRITE(*,*)
	DO 30 I=1,2
	  A0=A(I)
	  D0=D(I)
	  X=-10.0
	  DO 10 J=0,4
	    Y=MGASS(A0,D0,X)
	    WRITE(*,100) A0,D0,X,Y
	    X=X+5.0
10	  CONTINUE
30	CONTINUE
100	FORMAT(1X,'P(',F6.2, ' , ',F6.2,' , ',F6.2,')=',D13.6)
	WRITE(*,*)
	END

