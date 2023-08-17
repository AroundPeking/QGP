
	DIMENSION AR(4,4),AI(4,4),BR(4,2),BI(4,2),JS(4)
	DOUBLE PRECISION AR,AI,BR,BI
	DATA AR/1.0,7.0,9.0,-2.0,3.0,2.0,15.0,-2.0,
     *          2.0,1.0,3.0,11.0,13.0,-2.0,-2.0,5.0/
	DATA AI/3.0,-2.0,9.0,-2.0,-2.0,7.0,-3.0,-2.0,
     *          1.0,5.0,15.0,7.0,6.0,8.0,1.0,6.0/
	DATA BR/2.0,7.0,3.0,9.0,1.0,2.0,-2.0,3.0/
	DATA BI/1.0,2.0,-2.0,3.0,2.0,7.0,3.0,9.0/
	CALL ACJDN(AR,AI,4,BR,BI,2,L,JS)
	WRITE(*,*)
	IF (L.NE.0) THEN
	  DO 5 J=1,2
	    WRITE(*,10) (BR(I,J),I=1,4)
	    WRITE(*,10) (BI(I,J),I=1,4)
	    WRITE(*,*)
5	  CONTINUE
	END IF
10	FORMAT(1X,4D14.6)
	END

