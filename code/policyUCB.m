classdef policyUCB < Policy
    %POLICYUCB This is a concrete class implementing UCB.

        
    properties
        % Member variables
        initializationCounter
        nbActions
        banditRewards
        banditCounts
        lastAction
        timeStep
        alpha
        upperConfidences
    end
    
    methods
        function init(self, nbActions)
            % Initialize
            self.initializationCounter = 0;
            self.nbActions = nbActions;
            self.banditRewards = zeros(1, self.nbActions);
            self.banditCounts = zeros(1, self.nbActions);
            self.timeStep = 0;
            self.alpha = 1;
        end
        
        function action = decision(self)
            % Choose action
            if self.initializationCounter < self.nbActions
                self.initializationCounter = self.initializationCounter + 1;
                action = self.initializationCounter;
            else
                self.timeStep = self.timeStep + 1;
                mean = self.banditRewards./self.banditCounts;
                upperLimit = sqrt((ones(1, self.nbActions) * ((self.alpha * log(self.timeStep))/2)) ./ self.banditCounts);
                self.upperConfidences(:, self.timeStep) = (mean + upperLimit)';
                [~, action] = max(mean + upperLimit);
                % Code to plot UCB for Action 1 and Action2
%                 if self.timeStep == 998
%                     figure;
%                     hold on;
%                     plot(1:self.timeStep, self.upperConfidences);
%                     title(['UCB Upper Confidences for Actions 1 and 2']);
%                     legend('Action 1', 'Action 2');
%                     hold off;
%                 end
            end
            self.lastAction = action;
        end
        
        function getReward(self, reward)
            % Update ucb
            self.banditRewards(self.lastAction) = self.banditRewards(self.lastAction) + reward;
            self.banditCounts(self.lastAction) = self.banditCounts(self.lastAction) + 1;
        end
    end

end
