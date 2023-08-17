
	DOUBLE PRECISION MFFFF,F,Y
	DIMENSION N(2),M(2)
	DATA N/2,5/
	DATA M/3,10/
	WRITE(*,*)
	DO 10 I=1,2
	  N1=N(I)
	  N2=M(I)
	  F=3.5
	  Y=MFFFF(F,N1,N2)
	  WRITE(*,100) F,N1,N2,Y
	  F=9.0
	  Y=MFFFF(F,N1,N2)
	  WRITE(*,100) F,N1,N2,Y
10	CONTINUE
100	FORMAT(1X,'P(',F5.2,' , ',I2,' , ',I2,')=',D13.6)
	WRITE(*,*)
	END

