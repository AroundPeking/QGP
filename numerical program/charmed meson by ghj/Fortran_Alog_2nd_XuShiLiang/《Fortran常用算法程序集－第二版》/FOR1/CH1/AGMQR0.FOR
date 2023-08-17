
	DIMENSION A(4,3),B(4),Q(4,4),C(3)
	DOUBLE PRECISION A,B,Q,C
	DATA A/1.0,2.0,1.0,-1.0,1.0,1.0,-1.0,2.0,-1.0,0.0,0.0,1.0/
	DATA B/2.0,-3.0,1.0,4.0/
	M=4
	N=3
	CALL AGMQR(A,M,N,B,Q,L,C)
	IF (L.NE.0) THEN
	  WRITE(*,*)
	  WRITE(*,10) (I,B(I),I=1,N)
	  WRITE(*,*)
	  WRITE(*,20)
	  WRITE(*,30) ((Q(I,J),J=1,M),I=1,M)
	  WRITE(*,*)
	  WRITE(*,40)
	  WRITE(*,50) ((A(I,J),J=1,N),I=1,M)
	  WRITE(*,*)
	END IF
10	FORMAT(1X,'X(',I2,' )=',D15.6)
20	FORMAT(1X,'MAT Q IS:')
30	FORMAT(1X,4D15.6)
40	FORMAT(1X,'MAT R IS:')
50	FORMAT(1X,3D15.6)
	END


