
	EXTERNAL F
	X=0.5
	Y=0.5
	B=1.0
	M=10
	EPS=1.0E-5
	CALL DCMTC(X,Y,B,M,EPS,F)
	WRITE(*,*)
	WRITE(*,100) X,Y
	WRITE(*,*)
100	FORMAT(5X,'Z=',E13.6, '+j',E13.6)
	END

	FUNCTION F(X,Y)
	U=X*X-Y*Y-6*X+13
	V=2*X*Y-6*Y
	F=SQRT(U*U+V*V)
	END

