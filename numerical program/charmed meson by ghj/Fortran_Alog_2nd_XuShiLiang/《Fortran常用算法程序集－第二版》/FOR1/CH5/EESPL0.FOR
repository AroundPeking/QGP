
	DIMENSION Y(11)
	DOUBLE PRECISION Y,X1,H,T,Z,A,B,C,D
	DATA Y/0.0384615,0.0588236,0.1,0.2,0.5,1.0,
     *         0.5,0.2,0.1,0.0588236,0.0384615/
	X1=-1.0
	H=0.2
	T=-0.65
	K=-1
	CALL EESPL(X1,H,11,Y,K,T,Z,A,B,C,D)
	WRITE(*,*)
	WRITE(*,20) T,Z
	WRITE(*,30) K
	WRITE(*,40) A,B,C,D
	WRITE(*,*)
20	FORMAT(1X,'X=',F7.3,10X,'F(X)=',D15.6)
	T=0.25
	K=-1
	CALL EESPL(X1,H,11,Y,K,T,Z,A,B,C,D)
	WRITE(*,20) T,Z
	WRITE(*,30) K
	WRITE(*,40) A,B,C,D
	WRITE(*,*)
30	FORMAT(1X,'K=',I3)
40	FORMAT(1X,'A=',D13.6,3X,'B=',D13.6,3X,
     *            'C=',D13.6,3X,'D=',D13.6)
	END

