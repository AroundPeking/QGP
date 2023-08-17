
	DOUBLE PRECISION MGAM2,Y,S,T,A(3),X(3)
	DATA A/0.5,5.0,50.0/
	DATA X/0.1,1.0,10.0/
	WRITE(*,*)
	DO 10 I=0,2
	DO 10 J=0,2
	  S=A(I+1)
	  T=X(J+1)
	  Y=MGAM2(S,T)
	  WRITE(*,100) A(I+1),X(J+1),Y
10	CONTINUE
	WRITE(*,*)
100	FORMAT(1X,'gamma(',F4.1,' , ',F4.1,')=',D13.6)
	END

