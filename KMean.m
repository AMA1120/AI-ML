clc;
close all;

% Load the dataset
load kmeansdata.mat; 

% Define the range of cluster numbers
cluster_numbers = [2, 3, 4];
mean_silhouette_val = zeros(1, length(cluster_numbers));
cluster_assign = cell(1, length(cluster_numbers));

for i = 1:length(cluster_numbers)
    k = cluster_numbers(i);
    
    % Perform K-means clustering
    [idx, C] = kmeans(X, k); 
    
    % Calculate Silhouette score
    silhouette_scores = silhouette(X, idx);
    
    % Store mean Silhouette score
    mean_silhouette = mean(silhouette_scores);
    mean_silhouette_val(i) = mean_silhouette;
    
    % Display mean Silhouette score for each K
    disp(['Mean Silhouette score for K = ' num2str(k) ': ' num2str(mean_silhouette)]);
    
    % Store cluster assignments
    cluster_assign{i} = idx;
    
    % Plot Silhouette for each cluster
    figure;
    silhouette(X, idx);
    title(['Silhouette Plot for K = ' num2str(k)]);
    
    % Plot clusters and centroids
    figure;
    gscatter(X(:, 1), X(:, 2), idx);
    hold on;
    plot(C(:, 1), C(:, 2), 'kx', 'MarkerSize', 13, 'LineWidth', 3);
    title(['Cluster Assignments and Centroids for K = ' num2str(k)]);
    legend_entries = cellstr(num2str((1:k)', 'Cluster %d'));
    legend(legend_entries, 'Location', 'NW');

    hold off;
end

% Find the optimal number of clusters that achieves the best performance
[task2_silh, task2_idx] = max(mean_silhouette_val);
optimal_k = cluster_numbers(task2_idx);
disp(['The optimal number of clusters is ' num2str(optimal_k) ' based on Silhouette score']);



