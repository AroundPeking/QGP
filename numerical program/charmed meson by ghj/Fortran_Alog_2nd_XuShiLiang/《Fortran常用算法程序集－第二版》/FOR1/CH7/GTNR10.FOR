
	EXTERNAL F
	DIMENSION Y(3),D(3),P(3),Z(4,3),G(4,3),R(4,3)
	DOUBLE PRECISION Y,D,T,H,P,Z,G,R
	DATA Y/1.0,0.0,-1.0/
	T=0.0
	H=0.001
	M=3
	WRITE(*,*)
	WRITE(*,20) T,Y(1),Y(2),Y(3)
	WRITE(*,*)
	DO 10 I=1,100
	  CALL GTNR1(T,H,Y,M,F,D,P,Z,G,R)
	  T=T+H
	  WRITE(*,20) T,Y(1),Y(2),Y(3)
	  WRITE(*,*)
10	CONTINUE
20	FORMAT(1X,'T=',F6.3,3X,'Y1=',D13.6,3X,'Y2=',D13.6,
     *         3X,'Y3=',D13.6)
	END

	SUBROUTINE F(T,Y,M,D)
	DIMENSION Y(M),D(M)
	DOUBLE PRECISION Y,D,T
	D(1)=-21*Y(1)+19*Y(2)-20*Y(3)
	D(2)=19*Y(1)-21*Y(2)+20*Y(3)
	D(3)=40*Y(1)-40*Y(2)-40*Y(3)
	RETURN
	END

