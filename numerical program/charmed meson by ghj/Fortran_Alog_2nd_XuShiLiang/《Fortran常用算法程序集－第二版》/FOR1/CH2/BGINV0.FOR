
	DIMENSION A(5,5),U(5,5),V(5,5),C(5,5)
	DIMENSION S(6),E(6),WORK(6)
	DOUBLE PRECISION A,U,V,C,S,E,WORK
	DATA A/1.0,6.0,1.0,16.0,2.0,2.0,7.0,2.0,17.0,
     *         4.0,3.0,8.0,13.0,8.0,3.0,4.0,9.0,0.0,
     *         9.0,4.0,11.0,10.0,11.0,13.0,6.0/
	M=5
	N=5
	KA=6
	EPS=0.000001
	WRITE(*,*)
	WRITE(*,10)
10	FORMAT(1X,'MAT A IS:')
	WRITE(*,60) ((A(I,J),J=1,N),I=1,M)
	CALL BGINV(M,N,A,C,L,EPS,U,V,KA,S,E,WORK)
	IF (L.EQ.0) THEN
	  WRITE(*,*)
	  WRITE(*,50)
50	  FORMAT(1X,'MAT A+ IS:')
	  WRITE(*,60) ((C(I,J),J=1,M),I=1,N)
60	  FORMAT(1X,5D13.6)
	  WRITE(*,*)
	END IF
	CALL BGINV(N,M,C,A,L,EPS,U,V,KA,S,E,WORK)
	IF (L.EQ.0) THEN
	  WRITE(*,70)
70	  FORMAT(1X,'MAT A++ IS:')
	  WRITE(*,60) ((A(I,J),J=1,N),I=1,M)
	  WRITE(*,*)
	END IF
	END

