
	SUBROUTINE HPIR3(X,Y,Z,N,M,L,R,A,P,Q,DT1,DT2,DT3,V)
	INTEGER P,Q,L(M),R(M)
	DIMENSION X(N),Y(M),Z(N,M),A(P,Q)
	DIMENSION APX(20),APY(20),BX(20),BY(20),U(20,20),V(20,M)
	DIMENSION T(20),T1(20),T2(20)
	DOUBLE PRECISION X,Y,Z,A,APX,APY,BX,BY,U,V,T,T1,T2,DT1,DT2,
     *                   DT3,XX,YY,D1,D2,G,G1,G2,X1,X2,Y1,DD,DT
        DO 1 I=1,P
        DO 1 J=1,Q
1	A(I,J)=0.0
        K=P
        DO 2 J=1,M
          IF ((R(J)-L(J)+1).LT.K) K=R(J)-L(J)+1
2	CONTINUE
        IF (P.GT.K) P=K
        IF (P.GT.20) P=20
        IF (Q.GT.M) Q=M
        IF (Q.GT.20) Q=20
	XX=0.0
	DO 10 I=1,N
10	XX=XX+X(I)/N
	YY=0.0
	DO 20 I=1,M
20	YY=YY+Y(I)/M
        DO 50 J=1,M
	  D1=R(J)-L(J)+1.0
	  APX(1)=0.0
	  DO 30 I=L(J),R(J)
30	  APX(1)=APX(1)+X(I)-XX
	  APX(1)=APX(1)/D1
	  V(1,J)=0.0
	  DO 40 I=L(J),R(J)
40	  V(1,J)=V(1,J)+Z(I,J)
	  V(1,J)=V(1,J)/D1
	  IF (P.GT.1) THEN
	    D2=0.0
	    APX(2)=0.0
	    DO 60 I=L(J),R(J)
	      G=X(I)-XX-APX(1)
	      D2=D2+G*G
	      APX(2)=APX(2)+(X(I)-XX)*G*G
60	    CONTINUE
	    APX(2)=APX(2)/D2
	    BX(2)=D2/D1
	    V(2,J)=0.0
	    DO 70 I=L(J),R(J)
	      G=X(I)-XX-APX(1)
	      V(2,J)=V(2,J)+Z(I,J)*G
70	    CONTINUE
	    V(2,J)=V(2,J)/D2
	    D1=D2
	  END IF
	  DO 140 K=3,P
	    D2=0.0
	    APX(K)=0.0
	    V(K,J)=0.0
	    DO 120 I=L(J),R(J)
	      G1=1.0
	      G2=X(I)-XX-APX(1)
	      DO 100 JJ=3,K
	        G=(X(I)-XX-APX(JJ-1))*G2-BX(JJ-1)*G1
	        G1=G2
	        G2=G
100	      CONTINUE
	      D2=D2+G*G
	      APX(K)=APX(K)+(X(I)-XX)*G*G
	      V(K,J)=V(K,J)+Z(I,J)*G
120	    CONTINUE
	    V(K,J)=V(K,J)/D2
	    APX(K)=APX(K)/D2
	    BX(K)=D2/D1
	    D1=D2
140	  CONTINUE
50	CONTINUE
	D1=M
	APY(1)=0.0
	DO 150 I=1,M
150	APY(1)=APY(1)+Y(I)-YY
	APY(1)=APY(1)/D1
	DO 170 J=1,P
	  U(J,1)=0.0
	  DO 160 I=1,M
160	  U(J,1)=U(J,1)+V(J,I)
	  U(J,1)=U(J,1)/D1
170	CONTINUE
	IF (Q.GT.1) THEN
	  D2=0.0
	  APY(2)=0.0
	  DO 180 I=1,M
	    G=Y(I)-YY-APY(1)
	    D2=D2+G*G
	    APY(2)=APY(2)+(Y(I)-YY)*G*G
180	  CONTINUE
	  APY(2)=APY(2)/D2
	  BY(2)=D2/D1

	  DO 200 J=1,P
	    U(J,2)=0.0
	    DO 190 I=1,M
	      G=Y(I)-YY-APY(1)
	      U(J,2)=U(J,2)+V(J,I)*G
190	    CONTINUE
	    U(J,2)=U(J,2)/D2
200	  CONTINUE
	  D1=D2
	END IF
	DO 260 K=3,Q
	  D2=0.0
	  APY(K)=0.0
	  DO 210 J=1,P
210	  U(J,K)=0.0
	  DO 240 I=1,M
	    G1=1.0
	    G2=Y(I)-YY-APY(1)
	    DO 220 J=3,K
	      G=(Y(I)-YY-APY(J-1))*G2-BY(J-1)*G1
	      G1=G2
	      G2=G
220	    CONTINUE
	    D2=D2+G*G
	    APY(K)=APY(K)+(Y(I)-YY)*G*G
	    DO 230 J=1,P
230	    U(J,K)=U(J,K)+V(J,I)*G
240	  CONTINUE
	  DO 250 J=1,P
250	  U(J,K)=U(J,K)/D2
	  APY(K)=APY(K)/D2
	  BY(K)=D2/D1
	  D1=D2
260	CONTINUE
	V(1,1)=1.0
	V(2,1)=-APY(1)
	V(2,2)=1.0
	DO 265 I=1,P
	DO 265 J=1,Q
265	A(I,J)=0.0

	DO 280 I=3,Q
	  V(I,I)=V(I-1,I-1)
	  V(I,I-1)=-APY(I-1)*V(I-1,I-1)+V(I-1,I-2)
	  IF (I.GE.4) THEN
	    DO 270 K=I-2,2,-1
270	    V(I,K)=-APY(I-1)*V(I-1,K)+V(I-1,K-1)-BY(I-1)*V(I-2,K)
	  END IF
	  V(I,1)=-APY(I-1)*V(I-1,1)-BY(I-1)*V(I-2,1)
280	CONTINUE
	DO 320 I=1,P
	  IF (I.EQ.1) THEN
	    T(1)=1.0
	    T1(1)=1.0
	  ELSE IF (I.EQ.2) THEN
	    T(1)=-APX(1)
	    T(2)=1.0
	    T2(1)=T(1)
	    T2(2)=T(2)
	  ELSE
	    T(I)=T2(I-1)
	    T(I-1)=-APX(I-1)*T2(I-1)+T2(I-2)
	    IF (I.GE.4) THEN
	      DO 290 K=I-2,2,-1
290	      T(K)=-APX(I-1)*T2(K)+T2(K-1)-BX(I-1)*T1(K)
	    END IF
	    T(1)=-APX(I-1)*T2(1)-BX(I-1)*T1(1)
	    T2(I)=T(I)
	    DO 310 K=I-1,1,-1
	      T1(K)=T2(K)
	      T2(K)=T(K)
310	    CONTINUE
	  END IF
	  DO 300 J=1,Q
	  DO 300 K=I,1,-1
	  DO 300 LL=J,1,-1
300	  A(K,LL)=A(K,LL)+U(I,J)*T(K)*V(J,LL)
320	CONTINUE
	DT1=0.0
	DT2=0.0
	DT3=0.0

	DO 400 J=1,M
	  Y1=Y(J)-YY
	  DO 350 I=L(J),R(J)
	    X1=X(I)-XX
	    X2=1.0
	    DD=0.0
	    DO 340 K=1,P
	      G=A(K,Q)
	      DO 330 KK=Q-1,1,-1
330	      G=G*Y1+A(K,KK)
	      G=G*X2
	      DD=DD+G
	      X2=X2*X1
340	    CONTINUE
	    DT=DD-Z(I,J)
	    IF (ABS(DT).GT.DT3) DT3=ABS(DT)
	    DT1=DT1+DT*DT
	    DT2=DT2+ABS(DT)
350	  CONTINUE
400	CONTINUE
	RETURN
	END
	
