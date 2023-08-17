
	DIMENSION X(3,5),Y(5),A(4),B(4,4),V(3)
	DOUBLE PRECISION X,Y,A,B,V,Q,S,R,U
	DATA X/1.1,2.0,3.2,1.0,2.0,3.2,1.2,1.8,3.0,
     *         1.1,1.9,2.9,0.9,2.1,2.9/
	DATA Y/10.1,10.2,10.0,10.1,10.0/
	N=5
	M=3
	MM=4
	CALL ISQT2(X,Y,M,MM,N,A,Q,S,R,V,U,B)
	WRITE(*,*)
	WRITE(*,10) (I,A(I),I=1,MM)
10	FORMAT(1X,'A(',I2,' )=',D13.6)
	WRITE(*,*)
	WRITE(*,20) Q,S,R
20	FORMAT(1X,'Q=',D13.6,3X,'S=',D13.6,3X,'R=',D13.6)
	WRITE(*,*)
	WRITE(*,30) (I,V(I),I=1,M)
30	FORMAT(1X,'V(',I2,' )=',D13.6)
	WRITE(*,*)
	WRITE(*,40) U
40	FORMAT(1X,'U=',D13.6)
	WRITE(*,*)
	END

