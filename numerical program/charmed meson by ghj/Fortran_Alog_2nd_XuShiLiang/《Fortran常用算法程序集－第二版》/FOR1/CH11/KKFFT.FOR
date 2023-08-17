

	SUBROUTINE KKFFT(PR,PI,N,K,FR,FI,L,IL)
	DIMENSION PR(N),PI(N),FR(N),FI(N)
	DOUBLE PRECISION PR,PI,FR,FI,P,Q,S,VR,VI,PODDR,PODDI
	DO 20 IT=0,N-1
	  M=IT
	  IS=0
	  DO 10 I=0,K-1
	    J=M/2
	    IS=2*IS+(M-2*J)
	    M=J
10	  CONTINUE
	  FR(IT+1)=PR(IS+1)
	  FI(IT+1)=PI(IS+1)
20	CONTINUE
	PR(1)=1.0
	PI(1)=0.0
	PR(2)=COS(6.283185306/N)
	PI(2)=-SIN(6.283185306/N)
	IF (L.NE.0) PI(2)=-PI(2)
	DO 30 I=3,N
	  P=PR(I-1)*PR(2)
	  Q=PI(I-1)*PI(2)
	  S=(PR(I-1)+PI(I-1))*(PR(2)+PI(2))
	  PR(I)=P-Q
	  PI(I)=S-P-Q
30	CONTINUE
	DO 40 IT=0,N-2,2
	  VR=FR(IT+1)
	  VI=FI(IT+1)
	  FR(IT+1)=VR+FR(IT+2)
	  FI(IT+1)=VI+FI(IT+2)
	  FR(IT+2)=VR-FR(IT+2)
	  FI(IT+2)=VI-FI(IT+2)
40	CONTINUE
	M=N/2
	NV=2
	DO 70 L0=K-2,0,-1
	  M=M/2
	  NV=2*NV
	  DO 60 IT=0,(M-1)*NV,NV
	  DO 60 J=0,(NV/2)-1
	    P=PR(M*J+1)*FR(IT+J+1+NV/2)
	    Q=PI(M*J+1)*FI(IT+J+1+NV/2)
	    S=PR(M*J+1)+PI(M*J+1)
	    S=S*(FR(IT+J+1+NV/2)+FI(IT+J+1+NV/2))
	    PODDR=P-Q
	    PODDI=S-P-Q
	    FR(IT+J+1+NV/2)=FR(IT+J+1)-PODDR
	    FI(IT+J+1+NV/2)=FI(IT+J+1)-PODDI
	    FR(IT+J+1)=FR(IT+J+1)+PODDR
	    FI(IT+J+1)=FI(IT+J+1)+PODDI
60	  CONTINUE
70	CONTINUE


	IF (L.NE.0) THEN
	  DO 80 I=1,N
	    FR(I)=FR(I)/N
	    FI(I)=FI(I)/N
80	  CONTINUE
	END IF
	IF (IL.NE.0) THEN
	  DO 90 I=1,N
	    PR(I)=SQRT(FR(I)*FR(I)+FI(I)*FI(I))
	    PI(I)=ATAN(FI(I)/FR(I))*360.0/6.283185306
90	  CONTINUE
	END IF
	RETURN
	END

