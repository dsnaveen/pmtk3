function logp = studentLogprob(model, X)
% Multivariate student T distribution, log pdf
%
% -  model is a structure containing fields mu, Sigma, dof
% -  logp(i) = logp(X(i, :) | model)
%
% For the scalar case, Sigma is the variance not the standard deviation

mu = model.mu; Sigma = model.Sigma; nu = model.dof;
d = size(Sigma, 1);
X = reshape(X, [], d);
%XX = X;
X = bsxfun(@minus, X, rowvec(mu));
mahal = sum((X/Sigma).*X,2);
logc = gammaln(nu/2 + d/2) - gammaln(nu/2) - 0.5*logdet(Sigma) ...
    - (d/2)*log(nu) - (d/2)*log(pi);
logp = logc  -(nu+d)/2*log1p(mahal/nu);

%%
%     if length(mu)==1
%         x = XX(:);
%         s = sqrt(Sigma); s2 = Sigma;
%         logZ =  gammaln(nu/2) - gammaln(nu/2 + 0.5)  + 0.5*log(nu*pi*s2);
%         logp2 =  -(nu+1)/2*log1p((1/nu)*((x-mu)/s).^2) -logZ;
%         assert(approxeq(logp, logp2))
%     end
%%

%%
%     % compare to stats toolbox
%     if length(mu)==1
%         logp2 = log(tpdf(( x-mu)./sqrt(Sigma), nu));
%     else
%         % this check only works if Sigma is a correlation matrix
%         logp2 = log(mvtpdf(XX, Sigma, nu));
%     end
%     assert(approxeq(logp, logp2))
%%


end