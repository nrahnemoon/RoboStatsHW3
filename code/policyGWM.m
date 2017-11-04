classdef policyGWM < Policy
    %POLICYGWM This policy implementes GWM for the bandit setting.
    
    properties
        nbActions % number of bandit actions
        % Add more member variables as needed
        weights
        timeStep
        lastAction
    end
    
    methods
        
        function init(self, nbActions)
            % Initialize any member variables
            self.nbActions = nbActions;
            
            % Initialize other variables as needed
            self.weights = ones(1, nbActions);
            self.timeStep = 0;

        end
        
        function action = decision(self)
            % Choose an action according to multinomial distribution
            self.timeStep = self.timeStep + 1;
            p = self.weights/sum(self.weights);
            [~, action] = max(mnrnd(1,p));
            self.lastAction = action;
        end
        
        function getReward(self, reward)
            % Update the weights
            
            % First we create the loss vector for GWM
            lossScalar = 1 - reward; % This is loss of the chosen action
            lossVector = zeros(1,self.nbActions);
            lossVector(self.lastAction) = lossScalar;
            
            % Do more stuff here using loss Vector
            nu = sqrt(log(self.nbActions)/self.timeStep);
            self.weights = self.weights .* exp(-1 * nu * lossVector);
        end        
    end
end

