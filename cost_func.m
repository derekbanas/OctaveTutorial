% Read data from file
data = load('ex1data1.txt');
% Assign column 1 to X
X = data(:, 1);
% Assign column 2 to y
y = data(:, 2);
% Get number of elements in columns
m = length(y);

% Plot values for X & y
% r* : Plots * in red 
% Markerstyles : + o * . x s (Square) d (Diamond)
% ^ v > < p (Pentagram) h (Hexagram)
% Colors : k r g b m c w
% You can define markersize, linestyle, linewidth,
% color, marker, markeredgecolor, markerfacecolor,
% baseline and basevalue with a key value pair

% linestyle : - -- : -.
% linewidth : Width of line
% marker : Symbol to use at the top of the stem
% markeredgecolor : Changes the edge color of the marker
% markerfacecolor : Changes the fill color of marker

%plot(X, y, 'rs', 'markersize', 5, 
%'markeredgecolor', 'b', 'markerfacecolor', 'r');
ylabel('Profit in $10,000s');
xlabel('Population of City in 10,000s');

% Add a column of ones to X
X = [ones(m, 1), data(:,1)];

% Values of theta set to 2 rows and 1 column of zeros
theta = zeros(2, 1);

iterations = 1500;

alpha = 0.01;

% ----- CALCULATE ERROR WITH FOR LOOP -----

% Our guess at the values
X = 0.5:0.5:1.5;
% Actual values
y = 1:1:3;
% Points on x axis for both
x = 1:1:3;

% J(1) = 1/6*((1-.5)^2 + (2-1)^2 + (3-1.5)^2)
% J(1) = 1/6*(.25 + 1 + 2.25) = 3.5/6 = .5833

% J is the return value and X, y are arguments
function J = cost_func(X, y)
  % Stores accumulating errors
  total = 0;
  % Number of values
  m = length(y);
  % Cycle through values while calculating errors
  for i = 1:m
    % Difference between actual value and guess squared
    fprintf("X(i) : %f\n", X(i));
    fprintf("y(i) : %f\n", y(i));
    sqr_err = (y(i) - X(i)) ** 2;
    % Accumulate errors
    total += sqr_err;
    fprintf("Total : %f\n", total);
  end
  % Return accumulated errors divided by 2 * number of values
  J = total * (1/(2*m));
end

% Creates window labeled figure 1 with plot
figure(1)
plot(x, y, 'g+:','LineWidth',2)
hold on
% Draw black stars on points
plot(x, X, 'k+:','LineWidth',2)

% Get error based on data supplied
cost_func(X, y, 1)

% ----- CALCULATE ERROR WITH LINEAR ALGEBRA -----

% X - y = [.5 1 1.5] - [1 2 3] = [-0.5 -1, -1.5]
% 1/(2*3) * (X - y)T * (X - y)
% 1/6 * |-0.5| * |-0.5 -1 -1.5| = |0.25 / 6| = .0416
%       | -1 |                    |  1  / 6| = .1667
%       |-1.5|                    |2.25 / 6| = .375
% = .5833

# This time we also use theta and linear algebra
function J = cost_mat_func(X, y, theta)
  m = length(y);
  J = (1/(2*m))*(X*theta - y)'*(X*theta - y);
end

% You have to turn them into row vectors with transpose
X = X'
y = y'

% Add a column of ones to X
X = [ones(3, 1), X]
disp("MATRIX ERROR FUNCTION WITH THETA");
cost_mat_func(X, y, theta)

% ----- FIND COST USING ORIGINAL DATA -----

% Get original data
% Assign column 1 to X
X = data(:, 1);
% Assign column 2 to y
y = data(:, 2);
% Add a column of ones to X
X = [ones(m, 1), data(:,1)];
% Values of theta set to 2 rows and 1 column of zeros
theta = zeros(2, 1);

cost_mat_func(X, y, theta)