#ACCURACY

p_hat <- posterior_epred(fit1) 
p_mean <- colMeans(p_hat)
y_pred <- ifelse(p_mean > 0.5, 1, 0)
y_true <- vlbw_model$dead
accuracy <- mean(y_pred == y_true)
accuracy
