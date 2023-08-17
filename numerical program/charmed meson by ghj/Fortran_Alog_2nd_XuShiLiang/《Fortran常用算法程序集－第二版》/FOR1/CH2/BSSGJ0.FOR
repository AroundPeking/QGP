
	DIMENSION A(4,4),B(4,4),C(4,4),D(4)
	DOUBLE PRECISION A,B,C,D
	DATA A/5.0,7.0,6.0,5.0,7.0,10.0,8.0,7.0,
     *         6.0,8.0,10.0,9.0,5.0,7.0,9.0,10.0/
	DO 5 I=1,4
	DO 5 J=1,4
5	B(I,J)=A(I,J)
	CALL BSSGJ(A,4,L,D)
	IF (L.NE.0) THEN
	  WRITE(*,10) ((A(I,J),J=1,4),I=1,4)
	  WRITE(*,*)
	  CALL BRMUL(A,B,4,4,4,C)
	  WRITE(*,10) ((C(I,J),J=1,4),I=1,4)
	  WRITE(*,*)
	END IF
10	FORMAT(1X,4D15.6)
	END

