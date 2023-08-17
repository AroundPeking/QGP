
	DIMENSION A(4,3),Q(4,4)
	DOUBLE PRECISION A,Q
	DATA A/1.0,2.0,1.0,-1.0,1.0,1.0,-1.0,2.0,-1.0,0.0,0.0,1.0/
	M=4
	N=3
	CALL BMAQR(A,M,N,Q,L)
	IF (L.NE.0) THEN
	  WRITE(*,*)
	  WRITE(*,10)
	  WRITE(*,20) ((Q(I,J),J=1,M),I=1,M)
	  WRITE(*,*)
	  WRITE(*,30)
	  WRITE(*,40) ((A(I,J),J=1,N),I=1,M)
	  WRITE(*,*)
	END IF
10	FORMAT(1X,'MAT Q IS:')
20	FORMAT(1X,4D15.6)
30	FORMAT(1X,'MAT R IS:')
40	FORMAT(1X,3D15.6)
	END


