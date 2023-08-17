
	EXTERNAL F
	DIMENSION Y(3),D(3),A(3),B(3),C(3)
	DOUBLE PRECISION Y,D,T,H,A,B,C
	T=0.0
	Y(1)=-1.0
	Y(2)=0.0
	Y(3)=1.0
	H=0.01
	M=3
	EPS=0.00001
	WRITE(*,*)
	WRITE(*,30) T,Y(1),Y(2),Y(3)
	WRITE(*,*)
	DO 10 I=1,10
	  CALL GELR2(T,H,Y,M,F,D,EPS,A,B,C)
	  T=T+H
	  WRITE(*,30) T,Y(1),Y(2),Y(3)
	  WRITE(*,*)
10	CONTINUE
30	FORMAT(1X,'T=',F4.2,3X,'Y(1)=',D13.6,3X,'Y(2)=',D13.6,
     *         3X,'Y(3)=',D13.6)
	END

	SUBROUTINE F(T,Y,M,D)
	DIMENSION Y(M),D(M)
	DOUBLE PRECISION Y,D,T
	D(1)=Y(2)
	D(2)=-Y(1)
	D(3)=-Y(3)
	RETURN
	END

