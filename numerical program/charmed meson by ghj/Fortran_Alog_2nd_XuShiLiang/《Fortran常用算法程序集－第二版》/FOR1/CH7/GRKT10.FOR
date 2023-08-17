
	EXTERNAL F
	DIMENSION Y(3),D(3),Z(3,11),B(3)
	DOUBLE PRECISION Y,D,Z,T,H,B
	T=0.0
	Y(1)=-1.0
	Y(2)=0.0
	Y(3)=1.0
	H=0.01
	M=3
	N=11
	CALL GRKT1(T,Y,M,H,N,Z,F,D,B)
	WRITE(*,*)
	DO 10 I=1,N
	  T=(I-1)*H
	  WRITE(*,50) T
	  WRITE(*,100) (Z(J,I),J=1,M)
	  WRITE(*,*)
10	CONTINUE
50	FORMAT(1X,'T=',F7.3)
100	FORMAT(1X,'Y(1)=',D13.6,3X,'Y(2)=',D13.6,3X,'Y(3)=',D13.6)
	END

	SUBROUTINE F(T,Y,M,D)
	DIMENSION Y(m),D(m)
	DOUBLE PRECISION Y,D,T
	D(1)=Y(2)
	D(2)=-Y(1)
	D(3)=-Y(3)
	RETURN
	END

