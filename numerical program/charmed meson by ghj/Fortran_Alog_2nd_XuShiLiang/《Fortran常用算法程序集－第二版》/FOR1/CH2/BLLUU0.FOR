
	DIMENSION A(4,4),L(4,4),U(4,4)
	DOUBLE PRECISION A,L,U
	DATA A/2.0,3.0,2.0,4.0,4.0,3.0,4.0,2.0,
     *         4.0,12.0,-1.0,1.0,2.0,6.0,2.0,1.0/
	CALL BLLUU(A,4,L,U,K)
	IF (K.NE.0) THEN
	  WRITE(*,*)
	  WRITE(*,*) 'MAT L IS :'
	  WRITE(*,100) ((L(I,J),J=1,4),I=1,4)
	  WRITE(*,*)
	  WRITE(*,*) 'MAT U IS :'
	  WRITE(*,100) ((U(I,J),J=1,4),I=1,4)
	  WRITE(*,*)
	END IF
100	FORMAT(1X,4D15.6)
	END

