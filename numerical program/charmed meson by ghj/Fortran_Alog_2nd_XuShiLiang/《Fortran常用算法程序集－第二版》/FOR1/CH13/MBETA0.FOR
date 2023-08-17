
	DOUBLE PRECISION MBETA,X,A0,B0,Y,A(5),B(5)
	DATA A/0.5,0.5,1.0,5.0,8.0/
	DATA B/0.5,5.0,3.0,0.5,10.0/
	WRITE(*,*)
	DO 20 J=0,5
	  X=0.2D0*J
	  WRITE(*,100) X
	  DO 10 I=1,5
	    A0=A(I)
	    B0=B(I)
	    Y=MBETA(A0,B0,X)
	    WRITE(*,200) A0,B0,Y
10	  CONTINUE
20	CONTINUE
100	FORMAT(1X,'X=',F4.2)
200	FORMAT(1X,'    B(',F5.2,' , ' F5.2,')=',D13.6)
	WRITE(*,*)
	END

