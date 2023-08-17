
	CHARACTER*1 P(30)
	DIMENSION M(10)
	DATA P/'B','D','H','E','J','S','G','F','K','O',
     *         'E','B','D','V','M','I','W','E','V','K',
     *         'J','V','J','J','B','B','Y','E','T','E'/
	WRITE(*,*)
	WRITE(*,100) (P(I),I=1,30)
	WRITE(*,*)
	CALL LCQCK(P,30,5,25,M,10,L)
	IF (L.NE.0) THEN
	  WRITE(*,100) (P(I),I=1,30)
	END IF
	WRITE(*,*)
100	FORMAT(1X,30A)
	END

