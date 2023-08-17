
	DIMENSION AR(4,4),AI(4,4),BR(4),BI(4),JS(4)
	DOUBLE PRECISION AR,AI,BR,BI
	DATA AR/1.0,7.0,9.0,-2.0,3.0,2.0,15.0,-2.0,
     *          2.0,1.0,3.0,11.0,13.0,-2.0,-2.0,5.0/
	DATA AI/3.0,-2.0,9.0,-2.0,-2.0,7.0,-3.0,-2.0,
     *          1.0,5.0,15.0,7.0,6.0,8.0,1.0,6.0/
	DATA BR/2.0,7.0,3.0,9.0/
	DATA BI/1.0,2.0,-2.0,3.0/
	CALL ACGAS(AR,AI,4,BR,BI,L,JS)
	IF (L.NE.0) THEN
	  WRITE(*,10) (BR(I),I=1,4)
	  WRITE(*,10) (BI(I),I=1,4)
	END IF
10	FORMAT(1X,4D14.6)
	END

