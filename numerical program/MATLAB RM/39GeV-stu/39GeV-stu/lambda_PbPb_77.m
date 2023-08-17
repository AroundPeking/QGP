% show the significant digits
    currentPrecision = digits
    
    load lambda_PbPb_cent0005_77_yabs05.txt
    load lambda_PbPb_cent2040_77_yabs05.txt
    load lambda_PbPb_cent6080_77_yabs05.txt
    load lambda_PbPb_cent1020_77_yabs05.txt
    load lambda_PbPb_cent4060_77_yabs05.txt
% Generate X vectors for both data sets
		x1 = lambda_PbPb_cent0005_77_yabs05(:,2);
        y1 = lambda_PbPb_cent0005_77_yabs05(:,4);
        x2 = lambda_PbPb_cent1020_77_yabs05(:,2);
        y2 = lambda_PbPb_cent1020_77_yabs05(:,4);
		x3 = lambda_PbPb_cent2040_77_yabs05(:,2);
        y3 = lambda_PbPb_cent2040_77_yabs05(:,4);
        x4 = lambda_PbPb_cent4060_77_yabs05(:,2);
        y4 = lambda_PbPb_cent4060_77_yabs05(:,4);
        x5 = lambda_PbPb_cent6080_77_yabs05(:,2);
        y5 = lambda_PbPb_cent6080_77_yabs05(:,4);
        
        mass = 1.116;
        
        y1f = (mass*mass+x1.*x1).^0.5./(x1.*x1).*y1;
         y2f = (mass*mass+x2.*x2).^0.5./(x2.*x2).*y2;
        y3f = (mass*mass+x3.*x3).^0.5./(x3.*x3).*y3;
         y4f = (mass*mass+x4.*x4).^0.5./(x4.*x4).*y4;
        y5f = (mass*mass+x5.*x5).^0.5./(x5.*x5).*y5;
        

		% Generate Y data with some noise
	%	y1 = cos(2*pi*0.5*x1).*exp(-x1/5) + 0.1*randn(size(x1));
	%	y2 = 0.5 + 2*exp(-(x2/5)) + 0.1*randn(size(x2));

		% Define fitting functions and parameters, with identical
		% exponential decay for both data sets
		mdl1 = @(beta,x) beta(1)*exp(-x/beta(6));
        mdl2 = @(beta,x) beta(2)*exp(-x/beta(6));
		mdl3 = @(beta,x) beta(3)*exp(-x/beta(6));
        mdl4 = @(beta,x) beta(4)*exp(-x/beta(6));
        mdl5 = @(beta,x )beta(5)*exp(-x/beta(6));

		% Prepare input for NLINMULTIFIT and perform fitting
		x_cell = {x1,x2, x3,x4, x5};
		y_cell = {y1f,y2f, y3f,y4f, y5f};
		mdl_cell = {mdl1,mdl2,mdl3,mdl4,mdl5};
		beta0 = [40.7774   22.4220    13.5527    2.1404    0.3781    0.1802];
		[beta,r,J,Sigma,mse,errorparam,robustw] = ...
					nlinmultifit(x_cell, y_cell, mdl_cell, beta0);

		% Calculate model predictions and confidence intervals
		[ypred1,delta1] = nlpredci(mdl1,x1,beta,r,'covar',Sigma);
        [ypred2,delta2] = nlpredci(mdl2,x2,beta,r,'covar',Sigma);
		[ypred3,delta3] = nlpredci(mdl3,x3,beta,r,'covar',Sigma);
        [ypred4,delta4] = nlpredci(mdl4,x4,beta,r,'covar',Sigma);
        [ypred5,delta5] = nlpredci(mdl5,x5,beta,r,'covar',Sigma);
  
        % taking into account the weight
        % weights1 = ypred1./y1f;
        % weights3 = ypred3./y3f;
        % weights5 = ypred5./y5f;
        % w_cell = {weights1, weights3, weights5};
        % beta0 = beta;
        % [beta,r,J,Sigma,mse,errorparam,robustw] = ...
		%			nlinmultifit(x_cell, y_cell, mdl_cell, beta0, 'Weights', w_cell);
        beta
        
     beta=[  212.2219  135.9665   92.8734   28.1928    3.2855    0.2043]
        % Calculate model predictions and confidence intervals
		[ypred1,delta1] = nlpredci(mdl1,x1,beta,r,'covar',Sigma);
        [ypred2,delta2] = nlpredci(mdl2,x2,beta,r,'covar',Sigma);
		[ypred3,delta3] = nlpredci(mdl3,x3,beta,r,'covar',Sigma);
        [ypred4,delta4] = nlpredci(mdl4,x4,beta,r,'covar',Sigma);
        [ypred5,delta5] = nlpredci(mdl5,x5,beta,r,'covar',Sigma);
		% Calculate parameter confidence intervals
		ci = nlparci(beta,r,'Jacobian',J)

        L1=(ci(1,2)+ci(1,1))/2;
        dL1=(ci(1,2)-ci(1,1))/2;
		% Plot results
		figure;
		%hold all;
		box on;
		semilogy(x1,y1f, '>','MarkerFaceColor','black');
        hold on;
        semilogy(x2,y2f/5^1, 's','MarkerFaceColor','black');
		semilogy(x3,y3f/5^2, 'p','MarkerFaceColor','black');
        semilogy(x4,y4f/5^3, 'O','MarkerFaceColor','black');
        semilogy(x5,y5f/5^4, '<','MarkerFaceColor','black');
		semilogy(x1,ypred1,'--k');
        semilogy(x2,ypred2/5^1,'--k');
		semilogy(x3,ypred3/5^2,'--k');
        semilogy(x4,ypred4/5^3,'--k');
        semilogy(x5,ypred5/5^4,'--k');
        xlabel('Tp');
        ylabel('Bh');
        legend('0-10%','10-20%/5','20-40%/5^2','40-60%/5^3','60-80%/5^4');
        title('Lambda  AuAu@7.7GeV');
        hold off;