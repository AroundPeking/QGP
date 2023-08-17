
	SUBROUTINE JLPLQ(A,B,C,X,M,N,MN,S,P,D,L,JS,IIS,JJS)
	DIMENSION A(M,MN),B(M),C(MN),X(MN),P(M,M)
	DIMENSION JS(M),D(M,MN),IIS(M),JJS(M)
	DOUBLE PRECISION A,B,C,D,P,X,S,Z,DD
	DO 10 I=1,M
10	JS(I)=N+I
15	L=1
	DO 20 I=1,M
	DO 20 J=1,M
20	P(I,J)=A(I,JS(J))
	CALL BRINV(P,M,K,IIS,JJS)
	IF (K.EQ.0) THEN
	  L=0
	  RETURN
	END IF
	CALL BRMUL(P,A,M,M,MN,D)
	DO 30 I=1,MN
30	X(I)=0.0
	DO 50 I=1,M
	  S=0.0
	  DO 40 J=1,M
40	  S=S+P(I,J)*B(J)
	  X(JS(I))=S
50	CONTINUE
	K=0
	DD=1.0D-35
	DO 70 J=1,MN
	    Z=0.0
	    DO 60 I=1,M
60	    Z=Z+C(JS(I))*D(I,J)
	    Z=Z-C(J)
	    IF (Z.GT.DD) THEN
	      DD=Z
	      K=J
	    END IF
70	CONTINUE
	IF (K.EQ.0) THEN
	  S=0.0
	  DO 80 J=1,N
80	  S=S+C(J)*X(J)
	  RETURN
	END IF
	J=0
	DD=1.0D+20
	DO 90 I=1,M
	  IF (D(I,K).GE.1.0D-20) THEN
	    Y=X(JS(I))/D(I,K)
	    IF (Y.LT.DD) THEN
	      DD=Y
	      J=I
	    END IF
	  END IF
90	CONTINUE
	IF (J.EQ.0) THEN
	  L=0
	  RETURN
	END IF
	JS(J)=K
	GOTO 15
	END

