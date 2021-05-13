% Generate the problem data.
n = 10;
k = 3;
A = randn(n);
A = (A + A.')/2;
 
% Create the problem structure.
manifold = obliquefactory(k, n);
problem.M = manifold;
 
% Define the problem cost function and its derivatives.
problem.cost = @(X) .25*norm(X.'*X-A, 'fro')^2;
egrad = @(X) X*(X.'*X-A);
ehess = @(X, U) X*(U.'*X+X.'*U) + U*(X.'*X-A);
problem.grad = @(X) manifold.egrad2rgrad(X, egrad(X));
problem.hess = @(X, U) manifold.ehess2rhess(X, egrad(X), ehess(X, U), U);
 
% Numerically check the differentials.
checkgradient(problem); pause;
checkhessian(problem); pause;
 
% Solve
X = trustregions(problem);
C = X.'*X;
% C is a rank k (at most) symmetric, positive semidefinite matrix with ones on the diagonal:
disp(C);
disp(eig(C));