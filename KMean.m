clear all;
clc;
close all;

% Load your dataset
load kmeansdata.mat; 

% Define the range of cluster numbers to test
cluster_numbers = [3, 4, 5];
mean_silh_values = zeros(1, length(cluster_numbers));
cluster_assignments = cell(1, length(cluster_numbers));

for i = 1:length(cluster_numbers)
    k = cluster_numbers(i);
    
    % Perform K-means clustering
    [idx, C] = kmeans(X, k); 
    
    % Calculate Silhouette score
    silhouette_scores = silhouette(X, idx);
    
    % Store mean Silhouette score
    mean_silh_values(i) = mean(silhouette_scores);
    
    % Store cluster assignments
    cluster_assignments{i} = idx;
    
    % Plot Silhouette for each cluster
    figure;
    silhouette(X, idx);
    title(['Silhouette Plot for K = ' num2str(k)]);
    
    % Plot clusters and centroids
    figure;
    gscatter(X(:, 1), X(:, 2), idx);
    hold on;
    plot(C(:, 1), C(:, 2), 'kx', 'MarkerSize', 12, 'LineWidth', 2);
    title(['Cluster Assignments and Centroids for K = ' num2str(k)]);
    legend('Cluster 1', 'Cluster 2', 'Cluster 3', 'Cluster 4', 'Location', 'NW');
    hold off;
end
