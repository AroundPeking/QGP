
	SUBROUTINE ENSPL(X,Y,N,K,T,Z,A,B,C,D)
	DIMENSION X(N),Y(N)
	DOUBLE PRECISION X,Y,T,Z,G1,G2,U1,U2,U3,U4,U5,A,B,C,D,S
	Z=0.0
	IF (N.LE.0) RETURN
	IF (N.EQ.1) THEN
	  Z=Y(1)
	  K=0
	  A=Y(1)
	  B=0.0
	  C=0.0
	  D=0.0
	  RETURN
	END IF
	IF (N.EQ.2) THEN
	  Z=(Y(1)*(T-X(2))-Y(2)*(T-X(1)))/(X(1)-X(2))
	  K=1
	  A=Y(1)
	  B=(Y(2)-Y(1))/(X(2)-X(1))
	  C=0.0
	  D=0.0
	  RETURN
	END IF
	S=1.0
	IF (K.LE.0) THEN
	  S=-1.0
	  IF (T.LE.X(2)) THEN
	    K=1
	  ELSE IF (T.GE.X(N)) THEN
	    K=N-1
	  ELSE
	    K=1
	    M=N
10	    IF (IABS(K-M).NE.1) THEN
	      L=(K+M)/2
	      IF (T.LT.X(L)) THEN
	        M=L
	      ELSE
	        K=L
	      END IF
	      GOTO 10
	    END IF
	  END IF
	END IF
	IF (K.GE.N) K=N-1
	U3=(Y(K+1)-Y(K))/(X(K+1)-X(K))
	IF (N.EQ.3) THEN
	  IF (K.EQ.1) THEN
	    U4=(Y(3)-Y(2))/(X(3)-X(2))
	    U5=2.0*U4-U3
	    U2=2.0*U3-U4
	    U1=2.0*U2-U3
	  ELSE IF (K.EQ.2) THEN
	    U2=(Y(2)-Y(1))/(X(2)-X(1))
	    U1=2.0*U2-U3
	    U4=2.0*U3-U2
	    U5=2.0*U4-U3
	  END IF
	ELSE 
	  IF (K.LE.2) THEN
	    U4=(Y(K+2)-Y(K+1))/(X(K+2)-X(K+1))
	    IF (K.EQ.2) THEN
	      U2=(Y(2)-Y(1))/(X(2)-X(1))
	      U1=2*U2-U3
	      IF (N.EQ.4) THEN
	        U5=2.0*U4-U3
	      ELSE
	        U5=(Y(5)-Y(4))/(X(5)-X(4))
	      END IF
	    ELSE
	      U2=2*U3-U4
	      U1=2*U2-U3
	      U5=(Y(4)-Y(3))/(X(4)-X(3))
	    END IF
	  ELSE IF (K.GE.(N-2)) THEN
	    U2=(Y(K)-Y(K-1))/(X(K)-X(K-1))
	    IF (K.EQ.(N-2)) THEN
	      U4=(Y(N)-Y(N-1))/(X(N)-X(N-1))
	      U5=2*U4-U3
	      IF (N.EQ.4) THEN
	        U1=2.0*U2-U3
	      ELSE
	        U1=(Y(K-1)-Y(K-2))/(X(K-1)-X(K-2))
	      END IF
	    ELSE
	      U4=2*U3-U2
	      U5=2*U4-U3
	      U1=(Y(K-1)-Y(K-2))/(X(K-1)-X(K-2))
	    END IF
	  ELSE
	    U2=(Y(K)-Y(K-1))/(X(K)-X(K-1))
	    U1=(Y(K-1)-Y(K-2))/(X(K-1)-X(K-2))
	    U4=(Y(K+2)-Y(K+1))/(X(K+2)-X(K+1))
	    U5=(Y(K+3)-Y(K+2))/(X(K+3)-X(K+2))
	  END IF
	END IF
	A=ABS(U4-U3)
	B=ABS(U1-U2)
	IF ((A+1.0.EQ.1.0).AND.(B+1.0.EQ.1.0)) THEN
	  G1=(U2+U3)/2.0
	ELSE
	  G1=(A*U2+B*U3)/(A+B)
	END IF
	A=ABS(U4-U5)
	B=ABS(U3-U2)
	IF ((A+1.0.EQ.1.0).AND.(B+1.0.EQ.1.0)) THEN
	  G2=(U3+U4)/2.0
	ELSE
	  G2=(A*U3+B*U4)/(A+B)
	END IF
	A=Y(K)
	B=G1
	D=X(K+1)-X(K)
	C=(3*U3-2*G1-G2)/D
	D=(G2+G1-2*U3)/(D*D)
	IF (S.LT.0.0) THEN
	  S=T-X(K)
	  Z=A+B*S+C*S*S+D*S*S*S
	END IF
	RETURN
	END

