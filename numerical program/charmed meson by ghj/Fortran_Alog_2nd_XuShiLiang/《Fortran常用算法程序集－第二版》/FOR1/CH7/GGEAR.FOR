
	SUBROUTINE GGEAR(A,B,H,HMIN,HMAX,EPS,M,N,Y,T,Z,KF,
     *                  F,JACOBI,D,P,S,S02,YM,ER,IIS,JJS)
	DIMENSION T(N),Z(M,N),P(M,M),Y(M,8),D(M),S(M,10)
	DIMENSION YM(M),S02(M),ER(M),AA(7),PP(7,3),IIS(M),JJS(M)
	DOUBLE PRECISION T,Z,D,P,Y,S,YM,S02,ER,AA,PP,A,B,H,
     *        HMIN,HMAX,HW,HD,RM,T0,TD,R,DD,PR1,PR2,PR3,RR
	DATA PP/2.0,4.5,7.333,10.42,13.7,17.15,1.0,
     *          3.0,6.0,9.167,12.5,15.98,1.0,1.0,
     *          1.0,1.0,0.5,0.1667,0.04133,0.008267,1.0/
	AA(2)=-1.0
	JT=0
	NN=0
	KF=1
	T0=A
	NQ=1
	CALL F(T0,Y,M,D)
	DO 10 I=1,M
10	Y(I,2)=D(I)*H
	HW=H
	K=2
	DO 15 I=1,M
15	YM(I)=1.0
20	IRT=1
	KF=1
	NN=NN+1
	T(NN)=T0
	DO 30 I=1,M
30	Z(I,NN)=Y(I,1)
	IF (T0.GE.B) RETURN
	IF (NN.EQ.N) RETURN
	DO 40 I=1,M
	DO 40 J=1,K
40	S(I,J)=Y(I,J)
	HD=HW
	IF (H.NE.HD) THEN
	  RM=H/HD
	  IRT1=1
	  CALL G75(HMIN,HD,RM,HMAX,Y,S,H,IDB,K,M)
	END IF
	NQD=NQ
	TD=T0
	RM=1.0
	IF (JT.GT.0) GOTO 80 


60	IF (NQ.GT.6) THEN
	  KF=-2
	  RETURN
	END IF
	IF (NQ.EQ.1) THEN
	  AA(1)=-1.0
	ELSE IF (NQ.EQ.2) THEN
	  AA(1)=-2.0/3.0
	  AA(3)=-1.0/3.0
	ELSE IF (NQ.EQ.3) THEN
	  AA(1)=-6.0/11.0
	  AA(3)=AA(1)
	  AA(4)=-1.0/11.0
	ELSE IF (NQ.EQ.4) THEN
	  AA(1)=-0.48
	  AA(3)=-0.7
	  AA(4)=-0.2
	  AA(5)=-0.02
	ELSE IF (NQ.EQ.5) THEN
	  AA(1)=-120.0/274.0
	  AA(3)=-225.0/274.0
	  AA(4)=-85.0/274.0
	  AA(5)=-15.0/274.0
	  AA(6)=-1.0/274.0
	ELSE
	  AA(1)=-720.0/1764.0
	  AA(3)=-1624.0/1764.0
	  AA(4)=-735.0/1764.0
	  AA(5)=-175.0/1764.0
	  AA(6)=-21.0/1764.0
	  AA(7)=-1.0/1764.0
	END IF
	K=NQ+1
	IDB=K
	ENQ2=0.5/(NQ+1.0)
	ENQ3=0.5/(NQ+2.0)
	ENQ1=0.5/(NQ+0.0)
	EUP=PP(NQ,2)*EPS
	EUP=EUP*EUP
	E=PP(NQ,1)*EPS
	E=E*E
	EDWN=PP(NQ,3)*EPS
	EDWN=EDWN*EDWN
	IF (EDWN.EQ.0.0) THEN
	  KF=-4
	  CALL G47(M,K,Y,S,H,HD,NQ,NQD,JT)
	  RETURN
	END IF


	BND=EPS*ENQ3/(M+0.0)
	IW=1
	IF (IRT.EQ.2) THEN
	  CALL G68(M,K,R,Y,YM,IDB,NQ,JT)
	  GOTO 20
	END IF
80	T0=T0+H
	DO 110 J=2,K
	  DO 100 J1=J,K
	    J2=K-J1+J-1
	    DO 90 I=1,M
90	    Y(I,J2)=Y(I,J2)+Y(I,J2+1)
100	  CONTINUE
110	CONTINUE
	DO 120 I=1,M
120	ER(I)=0.0
	J1=1
	NT=1
	DO 190 L=1,3
	  IF ((J1.NE.0).AND.(NT.NE.0)) THEN
	    CALL F(T0,Y,M,D)
	    IF (IW.GE.1) THEN
	      CALL JACOBI(T0,Y,P,M)
	      R=AA(1)*H
	      DO 130 I=1,M
	      DO 130 J=1,M
130	      P(I,J)=P(I,J)*R
	      DO 140 I=1,M
140	      P(I,I)=1.0+P(I,I)
	      IW=-1
	      CALL BRINV(P,M,J1,IIS,JJS)
	    END IF
	    IF (J1.GT.0) THEN
	      DO 150 I=1,M
150	      S02(I)=Y(I,2)-D(I)*H
	      DO 170 I=1,M
	        DD=0.0
	        DO 160 J=1,M
160	        DD=DD+S02(J)*P(I,J)
	        S(I,9)=DD
170	      CONTINUE
	      NT=M
	      DO 180 I=1,M
	        Y(I,1)=Y(I,1)+AA(1)*S(I,9)
	        Y(I,2)=Y(I,2)-S(I,9)
	        ER(I)=ER(I)+S(I,9)
	        IF (ABS(S(I,9)).LE.(BND*YM(I))) NT=NT-1
180	      CONTINUE
	    END IF
	  END IF
190	CONTINUE


	IF (NT.GT.0) THEN
	  T0=TD
	  IF ((H.GT.(HMIN*1.00001)).OR.(IW.GE.0)) THEN
	    IF (IW.NE.0) RM=0.25*RM
	    IW=1
	    IRT1=2
	    CALL G75(HMIN,HD,RM,HMAX,Y,S,H,IDB,K,M)
	    GOTO 80
	  END IF
	  KF=-3
	  CALL G47(M,K,Y,S,H,HD,NQ,NQD,JT)
	  RETURN
	END IF
	DD=0.0
	DO 200 I=1,M
200	DD=DD+(ER(I)/YM(I))*(ER(I)/YM(I))
	IW=0
	IF (DD.LE.E) THEN
	  IF (K.GE.3) THEN
	    DO 210 J=3,K
	    DO 210 I=1,M
210	    Y(I,J)=Y(I,J)+AA(J)*ER(I)
	  END IF
	  KF=1
	  HW=H
	  IF (IDB.GT.1) THEN
	    IDB=IDB-1
	    IF (IDB.LE.1) THEN
	      DO 220 I=1,M
220	      S(I,10)=ER(I)
	    END IF
	    DO 230 I=1,M
	      IF (YM(I).LT.ABS(Y(I,1))) YM(I)=ABS(Y(I,1))
230	    CONTINUE
	    JT=NQ
	    GOTO 20
	  END IF
	END IF
	IF (DD.GT.E) THEN
	  KF=KF-2
	  IF (H.LE.(HMIN*1.00001)) THEN
	    KF=-1
	    HW=H
	    JT=NQ
	    RETURN
	  END IF
	  T0=TD


	  IF (KF.LE.-5) THEN
	    IF (NQ.EQ.1) THEN
	      KF=-4
	      CALL G47(M,K,Y,S,H,HD,NQ,NQD,JT)
	      RETURN
	    END IF
	    CALL F(T0,Y,M,D)
	    R=H/HD
	    DO 240 I=1,M
	      Y(I,1)=S(I,1)
	      S(I,2)=HD*D(I)
	      Y(I,2)=S(I,2)*R
240	    CONTINUE
	    NQ=1
	    KF=1
	    GOTO 60
	  END IF
	END IF
	PR2=((DD/E)**ENQ2)*1.2
	PR3=1.0E+20
	IF (NQ.LT.7) THEN
	  IF (KF.GT.-1) THEN
	    DD=0.0
	    DO 250 I=1,M
	      PR3=(ER(I)-S(I,10))/YM(I)
	      DD=DD+PR3*PR3
250	    CONTINUE
	    PR3=((DD/EUP)**ENQ3)*1.4
	  END IF
	END IF
	PR1=1.0E+20
	IF (NQ.GT.1) THEN
	  DD=0.0
	  DO 260 I=1,M
	    PR1=Y(I,K)/YM(I)
	    DD=DD+PR1*PR1
260	  CONTINUE
	  PR1=((DD/EDWN)**ENQ1)*1.3
	END IF


	IF (PR2.LE.PR3) THEN
	  IF (PR2.GT.PR1) THEN
	    R=1.0E+4
	    IF (PR1.GT.1.0E-4) R=1.0/PR1
	    NQW=NQ-1
	  ELSE
	    NQW=NQ
	    R=1.0E+4
	    IF (PR2.GT.1.0E-4) R=1.0/PR2
	  END IF
	ELSE IF (PR3.LT.PR1) THEN
	  R=1.0E+4
	  IF (PR3.GT.1.0E-4) R=1.0/PR3
	  NQW=NQ+1
	ELSE
	  R=1.0E+4
	  IF (PR1.GT.1.0E-4) R=1.0/PR1
	  NQW=NQ-1
	END IF
	IDB=10
	IF (KF.EQ.1) THEN
	  IF (R.LT.1.1) THEN
	    DO 270 I=1,M
	      IF (YM(I).LT.ABS(Y(I,1))) YM(I)=ABS(Y(I,1))
270	    CONTINUE
	    JT=NQ
	    GOTO 20
	  END IF
	END IF
	IF (NQW.GT.NQ) THEN
	  DO 280 I=1,M
280	  Y(I,NQW+1)=ER(I)*AA(K)/(K+0.0)
	END IF
	K=NQW+1
	IF (KF.EQ.1) THEN
	  IRT=2
	  RR=HMAX/ABS(H)
	  IF (R.GT.RR) R=RR
	  H=H*R
	  HW=H
	  IF (NQ.EQ.NQW) THEN
	    CALL G68(M,K,R,Y,YM,IDB,NQ,JT)
	    GOTO 20
	  END IF
	  NQ=NQW
	  GOTO 60
	END IF
	RM=RM*R
	IRT1=3
	CALL G75(HMIN,HD,RM,HMAX,Y,S,H,IDB,K,M)
	IF (NQW.EQ.NQ) GOTO 80
	NQ=NQW
	GOTO 60
	END

	SUBROUTINE G75(HMIN,HD,RM,HMAX,Y,S,H,IDB,K,M)
	DIMENSION Y(M,8),S(M,10)
	DOUBLE PRECISION HMIN,HMAX,H,RM,Y,S,HD,R,RR
	RR=ABS(HMIN/HD)
	IF (RM.LT.RR) RM=RR
	RR=ABS(HMAX/HD)
	IF (RM.GT.RR) RM=RR
	R=1.0
	DO 20 J=2,K
	  R=R*RM
	  DO 10 I=1,M
10	  Y(I,J)=S(I,J)*R
20	CONTINUE
	H=HD*RM
	DO 30 I=1,M
30	Y(I,1)=S(I,1)
	IDB=K
	RETURN
	END

	SUBROUTINE G47(M,K,Y,S,H,HD,NQ,NQD,JT)
	DIMENSION Y(M,8),S(M,10)
	DOUBLE PRECISION Y,S,H,HD
	DO 10 I=1,M
	DO 10 J=1,K
10	Y(I,J)=S(I,J)
	H=HD
	NQ=NQD
	JT=NQ
	RETURN
	END

	SUBROUTINE G68(M,K,R,Y,YM,IDB,NQ,JT)
	DIMENSION Y(M,8),YM(M)
	DOUBLE PRECISION Y,YM,R,R1
	R1=1.0
	DO 20 J=2,K
	  R1=R1*R
	  DO 10 I=1,M
10	  Y(I,J)=Y(I,J)*R1
20	CONTINUE
	IDB=K
	DO 30 I=1,M
	  IF (YM(I).LT.ABS(Y(I,1))) YM(I)=ABS(Y(I,1))
30	CONTINUE
	JT=NQ
	RETURN
	END

