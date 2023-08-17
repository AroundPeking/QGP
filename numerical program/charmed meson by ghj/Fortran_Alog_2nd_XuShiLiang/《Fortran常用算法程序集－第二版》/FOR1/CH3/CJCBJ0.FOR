
	DIMENSION A(5,5),V(5,5)
	DOUBLE PRECISION A,V
	DATA A/10.0,1.0,2.0,3.0,4.0,1.0,9.0,-1.0,2.0,-3.0,
     *          2.0,-1.0,7.0,3.0,-5.0,3.0,2.0,3.0,12.0,-1.0,
     *         4.0,-3.0,-5.0,-1.0,15.0/
	EPS=0.000001
	CALL CJCBJ(A,5,EPS,V)
	WRITE(*,*)
	WRITE(*,20) (A(I,I),I=1,5)
20	FORMAT(1X,D15.6)
	WRITE(*,*)
	WRITE(*,30) ((V(I,J),J=1,5),I=1,5)
30	FORMAT(1X,5D13.6)
	WRITE(*,*)
	END

