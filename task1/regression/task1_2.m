%% Clear all
clear all;
close all;

%% Load data

load('data/Fonts_n_to_m.mat');

n_train = size(trainingIndices, 1);
n_test = size(testIndices, 1);

X_train = [ones(1, n_train); X(trainingIndices, :)'];
X_test = [ones(1, n_test); X(testIndices, :)'];

colors = ['b','g','r','c','m','y','k', 'b','g','r','c','m','y','k'];

w = Y(trainingIndices,:);

nu = 0.0005;

kernel = @(x_i, x_j) kernel_gauss (x_i, x_j, 2);

%% Fit model

do_profile = 0;

if do_profile
    profile on;
end

[mu_test, var_test, relevant] = fit_rvr (X_train, w, nu, X_test, kernel);

if do_profile
    profile off;
    profile viewer;
end

%% Check predictions

Y_test = Y(testIndices, :);

for i=1:n_test
    figure;
    plotCharacter(Y(testIndices(i), :), 'b-');
    plotCharacter(mu_test(i, :), 'r-');
end

% figure;
% for i=1:size(X, 1)
%     plotCharacter(X(i, :), strcat(colors(i),'-'));
% end
% 
% figure;
% for i=1:size(X, 1)
%     plotCharacter(Y(i, :), strcat(colors(i),'-'));
% end