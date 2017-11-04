classdef gameGaussian < Game
    %GAMEGAUSSIAN This is a concrete class defining a game where rewards a
    %   are drawn from a gaussian distribution.
    
    methods
        
        function self = gameGaussian(nbActions, totalRounds) 
            % Input
            %   nbActions - number of actions
            %   totalRounds - number of rounds of the game
            
            self.nbActions = nbActions;
            self.totalRounds = totalRounds;
            mu = repmat(unifrnd(0, 1, 1, nbActions)', 1, totalRounds);
            sigma = repmat(unifrnd(0, 1, 1, nbActions)', 1, totalRounds);
            
            self.tabR = normrnd(mu, sigma); % table of rewards
            self.tabR = self.tabR - repmat(min(self.tabR)', 1, nbActions)';
            self.tabR = self.tabR ./ repmat(max(self.tabR)', 1, nbActions)';
            self.N = 0; % the current round counter is initialized to 0
        end
        
    end    
end

