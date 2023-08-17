

	SUBROUTINE JJSIM(N,M,D,U,V,X,Z,EPS,K,FS,XX,F,XT,XF)
	DIMENSION X(N),F(M),XX(N,M),XT(N),XF(N)
	DOUBLE PRECISION X,Z,F,XX,XT,XF,FR,FL,FG,FT,FF,FS
	INTEGER R,G
	K=1
	FR=SQRT(1.0D0*M)
	FL=D*(FR-1.0)/(1.414*N)
	FG=D*(FR+N-1.0)/(1.414*N)
	DO 10 I=2,M
	DO 10 J=1,N
10	XX(J,I)=FL
	DO 20 I=2,M
20	XX(I-1,I)=FG
	DO 40 I=1,M
	  DO 30 J=1,N
30	  X(J)=XX(J,I)
	  F(I)=FS(N,X)
40	CONTINUE
50	FR=F(1)
	FL=F(1)
	R=1
	L=1
	DO 60 I=2,M
	  IF (F(I).GT.FR) THEN
	    R=I
	    FR=F(I)
	  END IF
	  IF (F(I).LT.FL) THEN
	    L=I
	    FL=F(I)
	  END IF
60	CONTINUE

	G=1
	FG=F(1)
	J=1
	IF (R.EQ.1) THEN
	  G=2
	  FG=F(2)
	  J=2
	END IF
	DO 70 I=J+1,M
	  IF ((I.NE.R).AND.(F(I).GT.FG)) THEN
	    G=I
	    FG=F(I)
	  END IF
70	CONTINUE
	DO 90 J=1,N
	  XF(J)=0.0
	  DO 80 I=1,M
	    IF (I.NE.R) XF(J)=XF(J)+XX(J,I)/N
80	  CONTINUE
	  XT(J)=2.0*XF(J)-XX(J,R)
90	CONTINUE
	FT=FS(N,XT)
	IF (FT.LT.F(L)) THEN
	  DO 100 J=1,N
100	  XF(J)=(1.0+U)*XT(J)-U*XF(J)
	  FF=FS(N,XF)
	  IF (FF.LT.F(L)) THEN
	    DO 110 J=1,N
110	    XX(J,R)=XF(J)
	    F(R)=FF
	  ELSE
	    DO 120 J=1,N
120	    XX(J,R)=XT(J)
	    F(R)=FT
	  END IF
	ELSE IF (FT.LE.F(G)) THEN
	  DO 130 J=1,N
130	  XX(J,R)=XT(J)
	  F(R)=FT
	ELSE
	  IF (FT.LE.F(R)) THEN
	    DO 140 J=1,N
140	    XX(J,R)=XT(J)
	    F(R)=FT
	  END IF
	  DO 150 J=1,N
150	  XF(J)=V*XX(J,R)+(1.0-V)*XF(J)
	  FF=FS(N,XF)

	  IF (FF.GT.F(R)) THEN
	    DO 170 I=1,M
	      DO 160 J=1,N
	        XX(J,I)=(XX(J,I)+XX(J,L))/2.0
	        X(J)=XX(J,I)
160	      CONTINUE
	      F(I)=FS(N,X)
170	    CONTINUE
	  ELSE
	    DO 180 J=1,N
180	    XX(J,R)=XF(J)
	    F(R)=FF
	  END IF
	END IF
	FF=0.0
	FT=0.0
	DO 190 I=1,M
	  FF=FF+F(I)/M
	  FT=FT+F(I)*F(I)
190	CONTINUE
	FT=(FT-M*FF*FF)/N
	IF (FT.GE.EPS) THEN
	  K=K+1
	  IF (K.LT.201) GOTO 50
	END IF
	DO 210 J=1,N
	  X(J)=0.0
	  DO 200 I=1,M
200	  X(J)=X(J)+XX(J,I)/M
210	CONTINUE
	Z=FS(N,X)
	RETURN
	END

