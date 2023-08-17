
	SUBROUTINE CSSTQ(N,B,C,Q,EPS,L)
	DIMENSION B(N),C(N),Q(N,N)
	DOUBLE PRECISION B,C,Q,D,H,P,R,F,E,S,G
	C(N)=0.0
	D=0.0
	F=0.0
	DO 50 J=1,N
	  IT=0
	  H=EPS*(ABS(B(J))+ABS(C(J)))
	  IF (H.GT.D) D=H
	  M=J-1
10	  M=M+1
	  IF (M.LE.N) THEN
	    IF (ABS(C(M)).GT.D) GOTO 10
	  END IF
	  IF (M.NE.J) THEN
15	    IF (IT.EQ.60) THEN
	      L=0
	      WRITE(*,18)
18	      FORMAT(1X,'  FAIL')
	      RETURN
	    END IF
	    IT=IT+1
	    G=B(J)
	    P=(B(J+1)-G)/(2.0*C(J))
	    R=SQRT(P*P+1.0)
	    IF (P.GE.0.0) THEN
	      B(J)=C(J)/(P+R)
	    ELSE
	      B(J)=C(J)/(P-R)
	    END IF
	    H=G-B(J)
	    DO 20 I=J+1,N
20	    B(I)=B(I)-H
	    F=F+H
	    P=B(M)
	    E=1.0
	    S=0.0
	    DO 40 I=M-1,J,-1
	      G=E*C(I)
	      H=E*P
	      IF (ABS(P).GE.ABS(C(I))) THEN
	        E=C(I)/P
	        R=SQRT(E*E+1.0)
	        C(I+1)=S*P*R
	        S=E/R
	        E=1.0/R
	      ELSE
	        E=P/C(I)
	        R=SQRT(E*E+1.0)
	        C(I+1)=S*C(I)*R
	        S=1.0/R
	        E=E/R
	      END IF
	      P=E*B(I)-S*G
	      B(I+1)=H+S*(E*G+S*B(I))
	      DO 30 K=1,N
	        H=Q(K,I+1)
	        Q(K,I+1)=S*Q(K,I)+E*H
	        Q(K,I)=E*Q(K,I)-S*H
30	      CONTINUE
40	    CONTINUE
	    C(J)=S*P
	    B(J)=E*P
	    IF (ABS(C(J)).GT.D) GOTO 15
	  END IF
	  B(J)=B(J)+F
50	CONTINUE
	DO 80 I=1,N
	  K=I
	  P=B(I)
	  IF (I+1.LE.N) THEN
	    J=I
60	    J=J+1
	    IF (J.LE.N) THEN
	      IF (B(J).LE.P) THEN
	        K=J
	        P=B(J)
	        GOTO 60
	      END IF
	    END IF
	  END IF
	  IF (K.NE.I) THEN
	    B(K)=B(I)
	    B(I)=P
	    DO 70 J=1,N
	      P=Q(J,I)
	      Q(J,I)=Q(J,K)
	      Q(J,K)=P
70	    CONTINUE
	  END IF
80	CONTINUE
	L=1
	RETURN
	END

