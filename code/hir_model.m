% Set up parameters
alpha = 0.001;
beta = 0.04;
gamma = 0.01;
delta = 0.01;
epsilon = 0.005;

% Set up time variables
deltaT = 0.1; % Time step
startTime = 0; % Initial time
maxTime = 100; % Maximum time(non inclusive)

% Set up arrays that will hold our values of H, I, & R.
H = ones(1, (maxTime - startTime) / deltaT);
I = ones(1, (maxTime - startTime) / deltaT);
R = ones(1, (maxTime - startTime) / deltaT);

H(1) = 1; % The original person spreading the rumour
I(1) = 199; % Initial population of people not spreading rumour
R(1) = 0;

% Iterate through each time step.  
% We must exclude the last value since we are setting the value at t + 1, 
% so iterating until length(H) would cause us to go out of bounds.
for t = 1:length(H) - 1
    % Calculate the next value of H, I, & R based on the previous values using our difference equations.
    H(t + 1) = deltaT * (epsilon * R(t) + alpha * I(t) * H(t) - (delta + beta) * H(t)) + H(t);
    I(t + 1) = deltaT * (delta * H(t) + gamma * R(t) - alpha * I(t) * H(t)) + I(t);
    R(t + 1) = deltaT * (beta * H(t) - (epsilon + gamma) * R(t)) + R(t);
end

% "Continuous" time, subtract deltaT since we do not want it to be inclusive.
% If we make this inclusive, it will cause errors in the length of our H, I, & R vectors,
% since we are counting from zero.
timeCts = startTime:deltaT:maxTime - deltaT; 

% Plot the model
hold on;
% Plot H, I, & R
plot(timeCts, H, 'DisplayName', 'H, students actively spreading the rumour');
plot(timeCts, I, 'DisplayName', 'I, students ignorant to the rumour');
plot(timeCts, R, 'DisplayName', 'R, students refusing to spread the rumour');
% Label the graph and add a legend
xlabel('Time (t)')
ylabel('Population')
title('Rumour Spread Across OWU Campus and Faculty')
subtitle('')
legend;
hold off;
