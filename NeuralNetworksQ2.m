% Load Iris dataset
load fisheriris.mat

% Get number of rows (objects)
NumRows = size(meas, 1);

% Shuffling dataset
rng(42);  
Data_Indices = randperm(NumRows);
Train_Percentage = 0.6;
Train_Indices = Data_Indices(1:round(Train_Percentage * NumRows));
Test_Indices = Data_Indices(round(Train_Percentage * NumRows) + 1:end);

% Training and testing datasets
train_Data = meas(Train_Indices, :);
test_Data = meas(Test_Indices, :);

% Converting species to numeric indices
[~, ~, Species_Indices] = unique(species);
Train_Targets = Species_Indices(Train_Indices);
Test_Targets = Species_Indices(Test_Indices);

% Define hidden layer sizes to iterate over
Hidden_LayerSizes = [11 16 21];  % Slightly changed hidden layer sizes

for Hidden_layerSize = Hidden_LayerSizes
    fprintf('\nHidden Layer Size: %d\n', Hidden_layerSize);
    
    for iteration = 1:3 % Repeat the experiment 3 times
        fprintf('Iteration: %d\n', iteration);
        
        % Training and evaluating the neural network
        NeuralNetwork = feedforwardnet(Hidden_layerSize);

        % Training the neural network
        NeuralNetwork = train(NeuralNetwork, train_Data', Train_Targets');

        % Testing the trained neural network
        testOutput = NeuralNetwork(test_Data');
        
        accuracy = perform(NeuralNetwork, Test_Targets, testOutput);

        fprintf('Classifier Accuracy: %.2f%%\n\n', accuracy);
    end
end


