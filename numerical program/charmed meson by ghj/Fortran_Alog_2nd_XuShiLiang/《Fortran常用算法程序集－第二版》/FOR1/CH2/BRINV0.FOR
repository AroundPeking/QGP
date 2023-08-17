
	DIMENSION A(4,4),B(4,4),C(4,4),IS(4),JS(4)
	DOUBLE PRECISION A,B,C
	DATA A/0.2368,1.1161,0.1582,0.1968,
     *         0.2471,0.1254,1.1675,0.2071,
     *         0.2568,0.1397,0.1768,1.2168,
     *         1.2671,0.1490,0.1871,0.2271/
	DO 5 I=1,4
	DO 5 J=1,4
5	B(I,J)=A(I,J)
	CALL BRINV(A,4,L,IS,JS)
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