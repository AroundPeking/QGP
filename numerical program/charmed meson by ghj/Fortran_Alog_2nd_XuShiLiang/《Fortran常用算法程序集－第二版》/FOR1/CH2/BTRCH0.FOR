
	DIMENSION T(5),TT(5),B(6,6),C(6,6),A(6),R(6),P(6)
	DOUBLE PRECISION T,TT,B,T0,C,A,R,P
	DATA T/5.0,4.0,3.0,2.0,1.0/
	DATA TT/-1.0,-2.0,-3.0,-4.0,-5.0/
	T0=10.0
	CALL BTRCH(T0,T,TT,5,6,B,L,A,R,P)
	IF (L.NE.0) THEN
	  WRITE(*,10) ((B(I,J),J=1,6),I=1,6)
	  DO 50 I=1,6
	  DO 50 J=1,6
	    C(I,J)=0.0
	    DO 20 K=1,J-1
20	    C(I,J)=C(I,J)+B(I,K)*T(J-K)
	    C(I,J)=C(I,J)+B(I,J)*T0
	    DO 30 K=J+1,6
30	    C(I,J)=C(I,J)+B(I,K)*TT(K-J)
50	  CONTINUE
	  WRITE(*,*)
	  WRITE(*,10) ((C(I,J),J=1,6),I=1,6)
	  WRITE(*,*)
	END IF
10	FORMAT(1X,6D13.6)
	END

