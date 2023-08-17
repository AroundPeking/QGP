
	DOUBLE PRECISION X,Y,MBSL1
	WRITE(*,*)
	DO 10 N=0,5
	  X=0.05
	  DO 20 I=1,4
	    Y=MBSL1(N,X)
	    WRITE(*,100) N,X,Y
	    X=X*10.0
20	  CONTINUE
10	CONTINUE
100	FORMAT(1X,'N=',I2,2X,'X=',F7.3,3X,'J(n,x)=',D13.6)
	WRITE(*,*)
	END

