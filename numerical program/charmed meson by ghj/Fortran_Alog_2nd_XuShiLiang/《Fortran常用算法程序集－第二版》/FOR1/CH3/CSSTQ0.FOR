
	DIMENSION A(5,5),Q(5,5),B(5),C(5)
	DOUBLE PRECISION A,Q,B,C
	DATA A/10.0,1.0,2.0,3.0,4.0,1.0,9.0,-1.0,2.0,-3.0,2.0,
     *         -1.0,7.0,3.0,-5.0,3.0,2.0,3.0,12.0,-1.0,4.0,
     *         -3.0,-5.0,-1.0,15.0/
	N=5
	CALL CSTRQ(A,N,Q,B,C)
	EPS=0.000001
	CALL CSSTQ(N,B,C,Q,EPS,L)
	WRITE(*,*)
	WRITE(*,10)
10	FORMAT(1X,'MAT A IS:')
	WRITE(*,20) ((A(I,J),J=1,N),I=1,N)
20	FORMAT(1X,5D15.6)
	IF (L.NE.0) THEN
	  WRITE(*,*)
	  WRITE(*,30)
30	  FORMAT(1X,'MAT Q IS:')
	  WRITE(*,20) ((Q(I,J),J=1,N),I=1,N)
	  WRITE(*,*)
	  WRITE(*,40)
40	  FORMAT(1X,'MAT B IS:')
	  WRITE(*,50) (B(I),I=1,N)
50	  FORMAT(1X,5D15.6)
	END IF
	WRITE(*,*)
	END

