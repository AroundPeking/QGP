
	DOUBLE PRECISION A(7),X(6),B(14),P(6)
	DATA X/0.9,-0.9,1.1,-1.1,1.3,-1.3/
	DATA A/-20.0,7.0,-7.0,1.0,3.0,-5.0,2.0/
	CALL OPLYS(A,7,B,14,X,6,P)
	DO 20 I=1,6
20	WRITE(*,100) I,X(I),I,P(I)
100	FORMAT(1X,'X(',I2,')=',F5.2,5X,'P(',I2,')=',D13.6)
	END

