
	SUBROUTINE CHHQR(A,N,U,V,EPS,JT)
	DIMENSION A(N,N),U(N),V(N)
	DOUBLE PRECISION A,U,V,W,B,C,X,Y,XY,P,Q,R,E,F,Z,G
	JT=1
	M=N
	IT=0
10	IF (M.EQ.0) RETURN
	L=M+1
40	L=L-1
	IF (ABS(A(L,L-1)).GT.EPS*(ABS(A(L-1,L-1))+ABS(A(L,L))).AND.
     *      L.GT.1) GOTO 40
	IF (L.EQ.M) THEN
	  U(M)=A(M,M)
	  V(M)=0.0
	  M=M-1
	  IT=0
	  GOTO 10
	END IF
	IF (L.EQ.M-1) THEN
	  B=-(A(M,M)+A(M-1,M-1))
	  C=A(M,M)*A(M-1,M-1)-A(M,M-1)*A(M-1,M)
	  W=B*B-4*C
	  Y=SQRT(ABS(W))
	  IF (W.GT.0.0) THEN
	    XY=1.0
	    IF (B.LT.0.0) XY=-1.0
	    U(M)=(-B-XY*Y)/2.0
	    U(M-1)=C/U(M)
	    V(M)=0.0
	    V(M-1)=0.0
	  ELSE
	    U(M)=-B/2.0
	    U(M-1)=U(M)
	    V(M)=Y/2.0
	    V(M-1)=-V(M)
	  END IF
	  M=M-2
	  IT=0
	  GOTO 10
	END IF
	IF (IT.GE.60) THEN
	  WRITE(*,50)
50	  FORMAT(1X,  'FAIL')
	  JT=0
	  RETURN
	END IF
	IT=IT+1
	DO 60 J=L+2,M
60	A(J,J-2)=0.0
	DO 70 J=L+3,M
70	A(J,J-3)=0.0
	DO 150 K=L,M-1
	  IF (K.NE.L) THEN
	    P=A(K,K-1)
	    Q=A(K+1,K-1)
	    R=0.0
	    IF (K.NE.M-1) R=A(K+2,K-1)
	  ELSE
	    X=A(M,M)+A(M-1,M-1)
	    Y=A(M-1,M-1)*A(M,M)-A(M-1,M)*A(M,M-1)
	    P=A(L,L)*(A(L,L)-X)+A(L,L+1)*A(L+1,L)+Y
	    Q=A(L+1,L)*(A(L,L)+A(L+1,L+1)-X)
	    R=A(L+1,L)*A(L+2,L+1)
	  END IF
	  IF (ABS(P)+ABS(Q)+ABS(R).NE.0.0) THEN
	    XY=1.0
	    IF (P.LT.0.0) XY=-1.0
	    S=XY*SQRT(P*P+Q*Q+R*R)
	    IF (K.NE.L) A(K,K-1)=-S
	    E=-Q/S
	    F=-R/S
	    X=-P/S
	    Y=-X-F*R/(P+S)
	    G=E*R/(P+S)
	    Z=-X-E*Q/(P+S)
	    DO 110 J=K,M
	      P=X*A(K,J)+E*A(K+1,J)
	      Q=E*A(K,J)+Y*A(K+1,J)
	      R=F*A(K,J)+G*A(K+1,J)
	      IF (K.NE.M-1) THEN
	        P=P+F*A(K+2,J)
	        Q=Q+G*A(K+2,J)
	        R=R+Z*A(K+2,J)
	        A(K+2,J)=R
	      END IF
	      A(K+1,J)=Q
	      A(K,J)=P
110	    CONTINUE
	    J=K+3
	    IF (J.GE.M) J=M
	    DO 120 I=L,J
	      P=X*A(I,K)+E*A(I,K+1)
	      Q=E*A(I,K)+Y*A(I,K+1)
	      R=F*A(I,K)+G*A(I,K+1)
	      IF (K.NE.M-1) THEN
	        P=P+F*A(I,K+2)
	        Q=Q+G*A(I,K+2)
	        R=R+Z*A(I,K+2)
	        A(I,K+2)=R
	      END IF
	      A(I,K+1)=Q
	      A(I,K)=P
120	    CONTINUE
	  END IF
150	CONTINUE
	GOTO 10
	END

