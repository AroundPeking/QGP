
	CHARACTER*1 P(30)
	DATA P/'B','D','H','E','J','S','G','F','K','O',
     *         'E','B','D','V','M','I','W','E','V','K',
     *         'J','V','J','J','B','B','Y','E','T','E'/
	WRITE(*,*)
	WRITE(*,100) (P(I),I=1,30)
	WRITE(*,*)
	CALL LCHAP(P,30,5,25)
	WRITE(*,100) (P(I),I=1,30)
	WRITE(*,*)
100	FORMAT(1X,30A)
	END

