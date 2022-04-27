# Initialize EM object with initial matrix, number of batches, and desired rank
model = EM(initial_matrix, n_batches, k_dim)

# Set entire matrix to be appended
model.set_append_matrix(E)

# Update over specified number of batches
for i in range(n_batches):
    model.evolve()      # append rows to matrix
    model.update_svd()  # update truncated SVD
    
    # Calculate metrics for pre-selected updates
    if model.phi in phis2plot:
        model.calculate_true_svd()
        model.save_metrics()