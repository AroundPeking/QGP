

	INTEGER B,C,P(100),M(30)
	N=100
	MM=30
	NN=80
	R=5.0
	B=1
	C=100
	CALL NRABS(R,B,C,N,P)
	WRITE(*,*)
	WRITE(*,10)
10	FORMAT(1X,'R:')
	WRITE(*,20) (P(I),I=1,N)
20	FORMAT(1X,10I6)
	WRITE(*,*)
	CALL LIQCK(P,N,MM,NN,M,30,L)
	IF (L.NE.0) THEN
	  WRITE(*,30)
30	  FORMAT(1X,'A:')
	  WRITE(*,20) (P(I),I=1,N)
	END IF
	WRITE(*,*)
	END

