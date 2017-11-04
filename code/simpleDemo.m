%% This script applies a random policy on a constant game
clc;
close; 
clear all;

%% Get the constant game
%game = gameConstant();
game = gameGaussian(10, 10000); 

%% Get a set of policies to try out
policies = {policyConstant(), policyRandom(), policyGWM(), policyEXP3(), policyUCB()};
policy_names = {'policyConstant', 'policyRandom', 'policyGWM', 'policyEXP3', 'policyUCB'};

%% Run the policies on the game
figure;
hold on;
for k = 1:length(policies)
    figure(1);
    policy = policies{k};
    game.resetGame();
    [reward, action, regret] = game.play(policy);
    fprintf('Policy: %s Reward: %.2f\n', class(policy), sum(reward));
    subplot(length(policies), 2, 1 + 2*(k - 1));
    plot(regret);
    title(['Regret for Policy ' class(policy)]);

    subplot(length(policies), 2, 2 + 2*(k - 1));
    plot(action);
    title(['Actions for Policy ' class(policy)]);
end
