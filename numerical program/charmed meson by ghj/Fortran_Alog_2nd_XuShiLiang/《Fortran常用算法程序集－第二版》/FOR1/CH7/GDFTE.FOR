
	SUBROUTINE GDFTE(A,B,Y0,YN,N,Y,FS,N2,N6,G,D)
	DIMENSION Y(N),G(N6),D(N2)
	DOUBLE PRECISION Y,G,D,A,B,Y0,YN,H,X,U,V,W,F
	H=(B-A)/(N-1.0)
	NN=2*N-1
	G(1)=1.0
	G(2)=0.0
	Y(1)=Y0
	Y(N)=YN
	G(3*N-2)=1.0
	G(3*N-3)=0.0
	DO 10 I=2,N-1
	  X=A+(I-1)*H
	  CALL FS(X,U,V,W,F)
	  K=3*(I-1)-1
	  G(K+1)=U-H*V/2.0
	  G(K+2)=H*H*W-2.0*U
	  G(K+3)=U+H*V/2.0
	  Y(I)=H*H*F
10	CONTINUE
	M1=3*N-2
	CALL ATRDE(G,N,M1,Y,L)
	H=H/2.0
	G(1)=1.0
	G(2)=0.0
	D(1)=Y0
	D(NN)=YN
	G(3*NN-2)=1.0
	G(3*NN-3)=0.0
	DO 20 I=2,NN-1
	  X=A+(I-1)*H
	  CALL FS(X,U,V,W,F)
	  K=3*(I-1)-1
	  G(K+1)=U-H*V/2.0
	  G(K+2)=H*H*W-2.0*U
	  G(K+3)=U+H*V/2.0
	  D(I)=H*H*F
20	CONTINUE
	M1=3*NN-2
	CALL ATRDE(G,NN,M1,D,L)
	DO 30 I=2,N-1
	  K=2*I-1
	  Y(I)=(4.0*D(K)-Y(I))/3.0
30	CONTINUE
	RETURN
	END


