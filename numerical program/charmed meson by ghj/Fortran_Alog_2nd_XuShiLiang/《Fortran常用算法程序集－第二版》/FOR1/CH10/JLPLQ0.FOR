
	DIMENSION A(3,6),B(3),C(6),X(6),P(3,3),D(3,6)
	DIMENSION JS(3),IIS(3),JJS(3)
	DOUBLE PRECISION A,B,C,D,P,X,S
	DATA A/2*1.0,0.0,2.0,4.0,2.0,7.0,13.0,
     *         8.0,1.0,3*0.0,1.0,3*0.0,1.0/
	DATA B/10.0,18.0,13.0/
	DATA C/-4.0,-9.0,-26.0,3*0.0/
	N=3
	M=3
	MN=6
	CALL JLPLQ(A,B,C,X,M,N,MN,S,P,D,L,JS,IIS,JJS)
	WRITE(*,*)
	IF (L.NE.0) THEN
	  WRITE(*,10) (I,X(I),I=1,MN)
	  WRITE(*,*)
	  WRITE(*,20) S
	  WRITE(*,*)
	END IF
10	FORMAT(1X,'X(',I2,' )=',D15.6)
20	FORMAT(1X,'S=',D15.6)
	END

