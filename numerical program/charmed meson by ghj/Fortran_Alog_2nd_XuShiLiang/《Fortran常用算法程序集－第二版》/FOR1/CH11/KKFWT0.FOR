

	DIMENSION P(8),X(8)
	DO 10 I=1,8
10	P(I)=I
	CALL KKFWT(P,3,8,X)
	WRITE(*,*)
	WRITE(*,20) (I,X(I),I=1,8)
20	FORMAT(1X,'x(',I2,' )=',E13.6)
	WRITE(*,*)
	END

