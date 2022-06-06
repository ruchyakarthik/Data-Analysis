data {
  int<lower=1> N;                                      // number of data points
  vector[N] xobs;                                      // observed velocity dispersion
  vector[N] xerr;                                      // uncertainty on observed velocity scatter
  vector[N] yobs;                                      // observed black hole mass
  vector[N] yerr;                                      // uncertainty on black hole mass
}

parameters {
  real intercept;                                      
  real slope;                                          
  real<lower=0> zeta;                                  // scatter of ytrue around the linear relation
  vector[N] xtrue;                                     // true but unknown velocity dispersion
  vector[N] ytrue;                                     // true but unknown black hole mass 
}

model {
  intercept ~ normal(0, 100);
  slope     ~ normal(0, 100);
  zeta      ~ student_t(1, 0, 4);
  xtrue     ~ normal(0, 20);                           // hyper-prior
  xobs      ~ normal(xtrue, xerr);
  ytrue     ~ normal(intercept + slope * xtrue, zeta);
  yobs      ~ normal(ytrue, yerr);
}