
	SUBROUTINE ESPL1(X,Y,N,DY1,DYN,XX,M,DY,DDY,S,DS,DDS,T,H)
	DIMENSION X(N),Y(N),XX(M),DY(N),DDY(N)
        DIMENSION S(M),DS(M),DDS(M),H(N)
	DOUBLE PRECISION X,Y,XX,DY,DDY,S,DS,DDS,H,DY1,DYN,
     *                   T,H0,H1,BETA,ALPHA
	DY(1)=0.0
	H(1)=DY1
	H0=X(2)-X(1)
	DO 10 J=2,N-1
	  H1=X(J+1)-X(J)
	  ALPHA=H0/(H0+H1)
	  BETA=(1.0-ALPHA)*(Y(J)-Y(J-1))/H0
	  BETA=3.0*(BETA+ALPHA*(Y(J+1)-Y(J))/H1)
	  DY(J)=-ALPHA/(2.0+(1.0-ALPHA)*DY(J-1))
	  H(J)=(BETA-(1.0-ALPHA)*H(J-1))
	  H(J)=H(J)/(2.0+(1.0-ALPHA)*DY(J-1))
	  H0=H1
10	CONTINUE
	DY(N)=DYN
	DO 20 J=N-1,1,-1
20	DY(J)=DY(J)*DY(J+1)+H(J)
	DO 30 J=1,N-1
30	H(J)=X(J+1)-X(J)
	DO 40 J=1,N-1
	  H1=H(J)*H(J)
	  DDY(J)=6.0*(Y(J+1)-Y(J))/H1-
     *           2.0*(2.0*DY(J)+DY(J+1))/H(J)
40	CONTINUE
	H1=H(N-1)*H(N-1)
	DDY(N)=6.0*(Y(N-1)-Y(N))/H1+
     *            2.0*(2.0*DY(N)+DY(N-1))/H(N-1)
	T=0.0
	DO 50 I=1,N-1
	  H1=0.5*H(I)*(Y(I)+Y(I+1))
	  H1=H1-H(I)*H(I)*H(I)*(DDY(I)+DDY(I+1))/24.0
	  T=T+H1
50	CONTINUE
	DO 70 J=1,M
	  IF (XX(J).GE.X(N)) THEN
	    I=N-1
	  ELSE
	    I=1
60	    IF (XX(J).GT.X(I+1)) THEN
	      I=I+1
	      GOTO 60
	    END IF
	  END IF
	  H1=(X(I+1)-XX(J))/H(I)
	  S(J)=(3.0*H1*H1-2.0*H1*H1*H1)*Y(I)
	  S(J)=S(J)+H(I)*(H1*H1-H1*H1*H1)*DY(I)
	  DS(J)=6.0*(H1*H1-H1)*Y(I)/H(I)
	  DS(J)=DS(J)+(3.0*H1*H1-2.0*H1)*DY(I)
	  DDS(J)=(6.0-12.0*H1)*Y(I)/(H(I)*H(I))
	  DDS(J)=DDS(J)+(2.0-6.0*H1)*DY(I)/H(I)
	  H1=(XX(J)-X(I))/H(I)
	  S(J)=S(J)+(3.0*H1*H1-2.0*H1*H1*H1)*Y(I+1)
	  S(J)=S(J)-H(I)*(H1*H1-H1*H1*H1)*DY(I+1)
	  DS(J)=DS(J)-6.0*(H1*H1-H1)*Y(I+1)/H(I)
	  DS(J)=DS(J)+(3.0*H1*H1-2.0*H1)*DY(I+1)
	  DDS(J)=DDS(J)+(6.0-12.0*H1)*Y(I+1)/(H(I)*H(I))
	  DDS(J)=DDS(J)-(2.0-6.0*H1)*DY(I+1)/H(I)
70	CONTINUE
	RETURN
	END

