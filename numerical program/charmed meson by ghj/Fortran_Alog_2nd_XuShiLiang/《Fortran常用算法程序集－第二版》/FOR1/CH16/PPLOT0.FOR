
	DIMENSION A(50,2)
	CHARACTER XC,YC,C
	XC='+'
	YC='+'
	C='*'
	N=50
	DO 10 K=1,N
	  FI=0.2*(K-1)
	  A(K,1)=2.0+FI*COS(FI)
	  A(K,2)=FI*SIN(FI)
10	CONTINUE
	CALL PPLOT(N,A,XC,YC,C,XD,YD)
	END

