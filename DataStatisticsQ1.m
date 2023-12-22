% Load the Iris dataset
load fisheriris.mat;

% Report A - the total number of rows.
A = size(meas, 1);
fprintf('B. Total number of rows (objects, cases): %d\n', A);

% From 1- 4, for each column; report= Mean, Standard Deviation, Maximum, Minimum, Root Mean Square
Featuresdata_stat = ["Sepal Length", "Sepal Width", "Petal Length", "Petal Width"];

for i = 1:4
    % To Extract the current feature column
    Cur_Feature = meas(:, i);

    stats = [mean(Cur_Feature), std(Cur_Feature), max(Cur_Feature), min(Cur_Feature), rms(Cur_Feature)];

    fprintf('\nC. %s (Column %d) Statistics:\n', Featuresdata_stat(i), i);
    % To display the results of Mean Value, Standard Deviation, Max, Min, Root Mean Square
    fprintf(['  Mean: %.4f\n   ' ...
             'Standard Deviation: %.4f\n   ' ...
             'Maximum: %.4f\n   ' ...
             'Minimum: %.4f\n   ' ...
             'Root Mean Square: %.4f\n'], stats);
end