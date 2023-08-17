
       	DIMENSION A(4,4),B(4,2),JS(4)
	DOUBLE PRECISION A,B
	DATA A/1.0,7.0,9.0,-2.0,3.0,2.0,15.0,-2.0,2.0,1.0,3.,11.,13.,
     *         -2.0,-2.0,5.0/
	DATA B/9.0,6.0,11.0,-2.0,0.0,4.0,7.0,-1.0/
	N=4
	M=2
	CALL AGJDN(A,B,N,M,L,JS)
	IF (L.NE.0) THEN
	  WRITE(*,10) ((B(I,J),I=1,4),J=1,2)
	END IF
10	FORMAT(1X,4D15.6)
	END

