
	SUBROUTINE HCHIR(X,Y,N,A,M,M1)
	DIMENSION X(N),Y(N),A(M1),IX(20),H(20)
	DOUBLE PRECISION X,Y,A,H,HA,HH,Y1,Y2,H1,H2,D,HM
	DO 5 I=1,M1
5	A(I)=0.0
	IF (M.GE.N) M=N-1
	IF (M.GE.20) M=19
	M1=M+1
	HA=0.0
	IX(1)=1
	IX(M1)=N
	L=(N-1)/M
	J=L
	DO 10 I=2,M
	  IX(I)=J+1
	  J=J+L
10	CONTINUE
20	HH=1.0
	DO 30 I=1,M1
	  A(I)=Y(IX(I))
	  H(I)=-HH
	  HH=-HH
30	CONTINUE
	DO 50 J=1,M
	  II=M1
	  Y2=A(II)
	  H2=H(II)
	  DO 40 I=J,M
	    D=X(IX(II))-X(IX(M1-I))
	    Y1=A(M-I+J)
	    H1=H(M-I+J)
	    A(II)=(Y2-Y1)/D
	    H(II)=(H2-H1)/D
	    II=M-I+J
	    Y2=Y1
	    H2=H1
40	  CONTINUE
50	CONTINUE
	HH=-A(M1)/H(M1)
	DO 60 I=1,M1
60	A(I)=A(I)+H(I)*HH

	DO 80 J=1,M-1
	  II=M-J
	  D=X(IX(II))
	  Y2=A(II)
	  DO 70 K=M1-J,M
	    Y1=A(K)
	    A(II)=Y2-D*Y1
	    Y2=Y1
	    II=K
70	  CONTINUE
80	CONTINUE
	HM=ABS(HH)
	IF (HM.LE.HA) THEN
	  A(M1)=-HM
	  RETURN
	END IF
	A(M1)=HM
	HA=HM
	IM=IX(1)
	H1=HH
	J=1
	DO 100 I=1,N
	  IF (I.EQ.IX(J)) THEN
	    IF (J.LT.M1) J=J+1
	  ELSE
	    H2=A(M)
	    DO 90 K=M-1,1,-1
90	    H2=H2*X(I)+A(K)
	    H2=H2-Y(I)
	    IF (ABS(H2).GT.HM) THEN
	      HM=ABS(H2)
	      H1=H2
	      IM=I
	    END IF
	  END IF
100	CONTINUE
	IF (IM.EQ.IX(1)) RETURN
	I=1
110	IF (IM.GE.IX(I)) THEN
	  I=I+1
	  IF (I.LE.M1) GOTO 110
	END IF

	IF (I.GT.M1) I=M1
	IF (I.EQ.(I/2)*2) THEN
	  H2=HH
	ELSE
	  H2=-HH
	END IF
	IF (H1*H2.GE.0.0) THEN
	  IX(I)=IM
	  GOTO 20
	END IF
	IF (IM.LT.IX(1)) THEN
	  DO 120 J=M,1,-1
120	  IX(J+1)=IX(J)
	  IX(1)=IM
	  GOTO 20
	END IF
	IF (IM.GT.IX(M1)) THEN
	  DO 130 J=2,M1
130	  IX(J-1)=IX(J)
	  IX(M1)=IM
	  GOTO 20
	END IF
	IX(I-1)=IM
	GOTO 20
	END

