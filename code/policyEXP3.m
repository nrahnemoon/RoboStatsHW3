classdef policyEXP3 < Policy
    %POLICYEXP3 This is a concrete class implementing EXP3.
    
    properties
        nbActions % number of bandit actions
        % Add more member variables as needed
        weights
        timeStep
        lastAction
        lastActionProbability
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
            self.lastActionProbability = p(action);
        end
        
        function getReward(self, reward)
            % Update the weights

            % First we create the loss vector for GWM
            lossScalar = (1 - reward)/self.lastActionProbability; % This is loss of the chosen action
            lossVector = zeros(1,self.nbActions);
            lossVector(self.lastAction) = lossScalar;

            % Do more stuff here using loss Vector
            nu = sqrt(log(self.nbActions)/(self.timeStep * self.nbActions));
            self.weights = self.weights .* exp(-1 * nu * lossVector);
        end
    end
end