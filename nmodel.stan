data {
  int<lower=1> N;                                      
  vector[N] xobs;                                     
  vector[N] xerr;                                     
  vector[N] yobs;                                      
  vector[N] yerr;                                      
}

parameters {
  real beta0;                                      
  real beta1;                                          
  real<lower=0> zeta;                                  
  vector[N] xtrue;                                     
  vector[N] ytrue;                                     
}

model {
  beta0     ~ normal(0, 100);
  beta1     ~ normal(0, 100);
  zeta      ~ normal(0, 100);
  xtrue     ~ normal(0, 20);                           
  xobs      ~ normal(xtrue, xerr);
  ytrue     ~ normal(beta0 + beta1 * xtrue, zeta);
  yobs      ~ normal(ytrue,yerr);
}
