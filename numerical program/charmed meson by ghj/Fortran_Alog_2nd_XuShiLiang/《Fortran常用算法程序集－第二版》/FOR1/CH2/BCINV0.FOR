
	DIMENSION AR(4,4),AI(4,4),BR(4,4)
	DIMENSION BI(4,4),CR(4,4),CI(4,4),IS(4),JS(4)
	DOUBLE PRECISION AR,AI,BR,BI,CR,CI
	DATA AR/0.2368,1.1161,0.1582,0.1968,
     *         0.2471,0.1254,1.1675,0.2071,
     *         0.2568,0.1397,0.1768,1.2168,
     *         1.2671,0.1490,0.1871,0.2271/
	DATA AI/0.1345,1.2671,-0.2836,0.3576,
     *          0.1678,0.2017,-1.1967,-1.2345,
     *          0.1825,0.7024,0.3558,2.1185,
     *          1.1161,0.2721,-0.2078,0.4773/
	DO 5 I=1,4
	DO 5 J=1,4
	  BR(I,J)=AR(I,J)
	  BI(I,J)=AI(I,J)
5	CONTINUE
	CALL BCINV(AR,AI,4,L,IS,JS)
	IF (L.NE.0) THEN
	  WRITE(*,10) ((AR(I,J),J=1,4),I=1,4)
	  WRITE(*,*)
	  WRITE(*,10) ((AI(I,J),J=1,4),I=1,4)
	  WRITE(*,*)
	  CALL BCMUL(AR,AI,BR,BI,4,4,4,CR,CI)
	  WRITE(*,10) ((CR(I,J),J=1,4),I=1,4)
	  WRITE(*,*)
	  WRITE(*,10) ((CI(I,J),J=1,4),I=1,4)
	  WRITE(*,*)
	END IF
10	FORMAT(1X,4D15.6)
	END

