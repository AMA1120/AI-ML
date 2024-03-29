% 1) Load the fisheriris dataset
load fisheriris

% 2) Shuffle the dataset randomly
rng(42); % Set random seed for reproducibility (use any integer value)
n = size(meas, 1);
idx = randperm(n);
data = meas(idx, :);
target = species(idx);

% Split the dataset into training and testing sets
train_ratio = 0.6;
split_point = round(train_ratio * n);

train_data = data(1:split_point, :);
train_target = target(1:split_point);

tst_data = data(split_point+1:end, :);
tst_target = target(split_point+1:end);

% 3) Define the K values to evaluate
K_values = [3, 5];

% Initialize variables to store results
confusion_matrices = cell(length(K_values), 1);
correct_percs = zeros(length(K_values), 1);

% Evaluate different K values using fitcknn
for i = 1:length(K_values)
    K = K_values(i);

    % Train the K-NN classifier
    Mdl = fitcknn(train_data, train_target, 'NumNeighbors', K);

    % Predict on the test data
    predicted_labels = predict(Mdl, tst_data);

    % 4) Create a confusion matrix
    C = confusionmat(tst_target, predicted_labels);
    confusion_matrices{i} = C;

    % Calculate the percentage of correct classifications
    correct_perc = sum(diag(C)) / sum(C(:)) * 100;
    correct_percs(i) = correct_perc;

    % Display results for the current K value
    fprintf('K = %d:\n', K);
    disp(C);
    fprintf('Percentage of correct classifications: %.2f%%\n', correct_perc);
end

% Visualize confusion matrices
figure;
for i = 1:length(K_values)
    subplot(1, length(K_values), i);
    confusionchart(confusion_matrices{i}, ...
        'RowSummary','row-normalized', 'ColumnSummary', 'column-normalized');
    title(['Confusion Matrix (K = ' num2str(K_values(i)) ')']);
end


