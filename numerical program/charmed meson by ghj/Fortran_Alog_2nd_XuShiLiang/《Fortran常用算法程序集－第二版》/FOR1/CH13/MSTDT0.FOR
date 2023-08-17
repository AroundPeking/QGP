
	DOUBLE PRECISION MSTDT,T,Y
	WRITE(*,*)
	DO 10 N=1,5
	  T=0.5
	  Y=MSTDT(T,N)
	  WRITE(*,100) T,N,Y
	  T=5.0
	  Y=MSTDT(T,N)
	  WRITE(*,100) T,N,Y
10	CONTINUE
100	FORMAT(1X,'P(',F4.2,' , ',I2,')=',D13.6)
	WRITE(*,*)
	END

