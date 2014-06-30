function [C, sigma] = dataset3Params(X, y, Xval, yval)
%EX6PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = EX6PARAMS(X, y, Xval, yval) returns your choice of C and 
%   sigma. You should complete this function to return the optimal C and 
%   sigma based on a cross-validation set.
%

% You need to return the following variables correctly.
C = 1;
sigma = 0.1;

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return the optimal C and sigma
%               learning parameters found using the cross validation set.
%               You can use svmPredict to predict the labels on the cross
%               validation set. For example, 
%                   predictions = svmPredict(model, Xval);
%               will return the predictions on the cross validation set.
%
%  Note: You can compute the prediction error using 
%        mean(double(predictions ~= yval))
%
%{
tryValues = [0.01, 0.03, 0.1, 0.3, 1, 3 , 10, 30];
optimalCombo = zeros(3, 1); % to store the values related to the lowest error

for cValue = tryValues
	for sigmaValue = tryValues
		fprintf(['\nTrying C value = %f and sigma value = %f \t\n'], cValue, sigmaValue);
		model = svmTrain(X, y, cValue, @(x1, x2)  gaussianKernel(x1, x2, sigmaValue));
		predictions = svmPredict(model, Xval);
		prediction_error = mean(double(predictions ~= yval));
		if optimalCombo(1) == 0
			optimalCombo = [prediction_error, cValue, sigmaValue];
		elseif prediction_error < optimalCombo(1)
			optimalCombo = [prediction_error, cValue, sigmaValue];
			fprintf(['The best combo currently is %f\n'], optimalCombo);
			
		end
	end
end
fprintf(['The best C and sigma values are: %f and %f\n'], optimalCombo(2), optimalCombo(3));
C = optimalCombo(2);
sigma = optimalCombo(3);	
%}


% =========================================================================

end
