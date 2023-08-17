
	SUBROUTINE CSTRQ(A,N,Q,B,C)
	DIMENSION A(N,N),Q(N,N),B(N),C(N)
	DOUBLE PRECISION A,Q,B,C,F,H,G,H2
	DO 10 I=1,N
	DO 10 J=1,N
10	Q(I,J)=A(I,J)
	DO 80 I=N,2,-1
	  H=0.0
	  IF (I.GT.2) THEN
	    DO 20 K=1,I-1
20	    H=H+Q(I,K)*Q(I,K)
	  END IF
	  IF (H+1.0.EQ.1.0) THEN
	    C(I)=0.0
	    IF (I.EQ.2) C(I)=Q(I,I-1)
	    B(I)=0.0
	  ELSE
	    C(I)=SQRT(H)
	    IF (Q(I,I-1).GT.0.0) C(I)=-C(I)
	    H=H-Q(I,I-1)*C(I)
	    Q(I,I-1)=Q(I,I-1)-C(I)
	    F=0.0
	    DO 50 J=1,I-1
	      Q(J,I)=Q(I,J)/H
	      G=0.0
	      DO 30 K=1,J
30	      G=G+Q(J,K)*Q(I,K)
	      IF (J+1.LE.I-1) THEN
	        DO 40 K=J+1,I-1
40	        G=G+Q(K,J)*Q(I,K)
	      END IF
	      C(J)=G/H
	      F=F+G*Q(J,I)
50	    CONTINUE
	    H2=F/(H+H)
	    DO 70 J=1,I-1
	      F=Q(I,J)
	      G=C(J)-H2*F
	      C(J)=G
	      DO 60 K=1,J
60	      Q(J,K)=Q(J,K)-F*C(K)-G*Q(I,K)
70	    CONTINUE
	    B(I)=H
	  END IF
80	CONTINUE
	DO 85 I=1,N-1
85	C(I)=C(I+1)
	C(N)=0.0
	B(1)=0.0
	DO 130 I=1,N
	  IF ((B(I).NE.0.0).AND.(I-1.GE.1)) THEN
	    DO 110 J=1,I-1
	      G=0.0
	      DO 90 K=1,I-1
90	      G=G+Q(I,K)*Q(K,J)
	      DO 100 K=1,I-1
100	      Q(K,J)=Q(K,J)-G*Q(K,I)
110	    CONTINUE
	  END IF
	  B(I)=Q(I,I)
	  Q(I,I)=1.0
	  IF (I-1.GE.1) THEN
	    DO 120 J=1,I-1
	      Q(I,J)=0.0
	      Q(J,I)=0.0
120	    CONTINUE
	  END IF
130	CONTINUE
	RETURN
	END



	
