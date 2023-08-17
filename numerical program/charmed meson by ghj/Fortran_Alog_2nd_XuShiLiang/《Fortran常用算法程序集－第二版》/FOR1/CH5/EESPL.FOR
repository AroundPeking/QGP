
	SUBROUTINE EESPL(X1,H,N,Y,K,T,Z,A,B,C,D)
	DIMENSION Y(N)
	DOUBLE PRECISION X1,H,Y,T,Z,A,B,C,D,
     *                   U1,U2,U3,U4,U5,S,G1,G2
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
	  Z=(Y(2)*(T-X1)-Y(1)*(T-X1-H))/H
	  K=1
	  A=Y(1)
	  B=(Y(2)-Y(1))/H
	  C=0.0
	  D=0.0
	  RETURN
	END IF
	S=1.0
	IF (K.LE.0) THEN
	  S=-1.0
	  A=X1+H
	  B=X1+(N-1)*H
	  IF (T.LE.A) THEN
	    K=1
	  ELSE IF (T.GE.B) THEN
	    K=N-1
	  ELSE
	    K=1+(T-X1)/H
	  END IF
	END IF
	IF (K.GE.N) K=N-1
	U3=(Y(K+1)-Y(K))/H
	IF (N.EQ.3) THEN
	  IF (K.EQ.1) THEN
	    U4=(Y(3)-Y(2))/H
	    U5=2.0*U4-U3
	    U2=2.0*U3-U4
	    U1=2.0*U2-U3
	  ELSE IF (K.EQ.2) THEN
	    U2=(Y(2)-Y(1))/H
	    U1=2.0*U2-U3
	    U4=2.0*U3-U2
	    U5=2.0*U4-U3
	  END IF
	ELSE
	  IF (K.LE.2) THEN
	    U4=(Y(K+2)-Y(K+1))/H
	    IF (K.EQ.2) THEN
	      U2=(Y(2)-Y(1))/H
	      U1=2*U2-U3
	      IF (N.EQ.4) THEN
	        U5=2.0*U4-U3
	      ELSE
	        U5=(Y(K+3)-Y(K+2))/H
	      END IF
	    ELSE
	      U2=2*U3-U4
	      U1=2*U2-U3
	      U5=(Y(K+3)-Y(K+2))/H
	    END IF
	  ELSE IF (K.GE.(N-2)) THEN
	    U1=(Y(K-1)-Y(K-2))/H
	    U2=(Y(K)-Y(K-1))/H
	    IF (K.EQ.(N-2)) THEN
	      U4=(Y(N)-Y(N-1))/H
	      U5=2*U4-U3
	      IF (N.EQ.4) THEN
	        U1=2.0*U2-U3
	      ELSE
	        U1=(Y(K-1)-Y(K-2))/H
	      END IF
	    ELSE
	      U4=2*U3-U2
	      U5=2*U4-U3
	      U1=(Y(K-1)-Y(K-2))/H
	    END IF
	  ELSE
	    U2=(Y(K)-Y(K-1))/H
	    U1=(Y(K-1)-Y(K-2))/H
	    U4=(Y(K+2)-Y(K+1))/H
	    U5=(Y(K+3)-Y(K+2))/H
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
	C=(3*U3-2*G1-G2)/H
	D=(G2+G1-2*U3)/(H*H)
	IF (S.LT.0.0) THEN
	  S=T-(X1+(K-1)*H)
	  Z=A+B*S+C*S*S+D*S*S*S
	END IF
	RETURN
	END

