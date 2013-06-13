\name{JointRegBC.default}
\alias{JointRegBC.default}
\title{Joint Modelling of Mixed Correlated Binary and
Continuous Responses : A Latent Variable Approach.}
\description{
A joint regression model for mixed correlated binary and continuous responses is presented. In this model binary response can be dependent on the continuous response. With this model, the dependence between responses can be taken into account by the correlation between errors in the models for binary and continuous  responses.}
\usage{
\method{JointRegBC}{default}(ini = NA, X, y, z, p, q, ...)}
\arguments{
  \item{ini}{Initial values}
  \item{X}{Design matrix}
  \item{z}{Continuous responses}
  \item{y}{Binary responses}
  \item{p}{Order of dimension of Binary responses}
  \item{q}{Order of dimension of continuous responses}
  \item{\dots}{Other arguments}}
\details{Models for JointRegBC are specified symbolically. A typical model has the form response1 ~ terms and response2 ~ terms  where response1and response2 are the (numeric) binary and 
continuous responses vector and  terms is a series of terms which specifies a linear predictor for responses. A terms specification of the form first + second indicates all the terms in first together with all the terms in second with duplicates removed. A specification of the form first:second indicates the set of terms obtained by taking the interactions of all terms in first with all terms in second. The specification first*second indicates the cross of first and second. This is the same as first + second + first:second.}
\value{
 \item{Binary response}{Coefficient of ordinal response}
\item{Continuous Response}{Coefficient of continuous response}
 \item{Variance of Countinuous Response}{Variance of continuous response}
 \item{Correlation}{Coefficient of continuous response}
 \item{Hessian}{Hessian matrix}
 \item{convergence}{An integer code. 0 indicates successful convergence.}
\item{objective}{-loglikelihood.}
}
\references{
Bahrami Samani, E. and Tahmasebinejad. Zh.(2011). Joint Modelling of Mixed Correlated Nominal, Ordinal and
Continuous Responses. Journal of Statistical Research. 45(1):37-47. 
}
\author{
Ehsan Bahrami Samani and Zhale Tahmasebinejad
}
\note{
Supportted by Shahid Beheshti University
}
\seealso{
\code{\link{nlminb}},\code{\link{fdHess},\link{clogit}}
}
\examples{
function (ini = NA, X, y, z, p, q, ...) 
{
    options(warn = -1)
     f <- function(ini, X, y, z, p, q) {
        X = cbind(1, X)
        y <- as.vector(y)
        z <- as.vector(z)
        ini <- as.vector(ini)
        X <- as.matrix(X)
        n = nrow(X)
        muz = muy = muygivenzx = q2 = q1 = l1 = l2 = l3 = muygivenzx = as.vector(0)
        sez <- ini[p + q + 2]
        seygivenzx <- (1 - (ini[p + q + 1])^2)
mz=matrix(0,n,p)
my=matrix(0,n,q)

for(i in 1:n){
for(j in 1:p){
mz[i,j]=ini[1:p][[j]]*X[i, ][[j]]
}}
for(i in 1:n){
for(k in 1:q){
my[i,k]=ini[(p + 1):(p + q)][[k]]*X[i, -1][[k]]
}}
        for (i in 1:n) {
            muz[i] <- sum(mz[i,])
            muy[i] <- sum(my[i,])
            muygivenzx[i] <- muy[i] + (ini[p + q + 1] * (z[i] - 
                muz[i]))/sez
            q1[i] <- ( - muygivenzx[i])/sqrt(seygivenzx)
            
            l1[i] <- log(pnorm(q1[i])) + log(dnorm(z[i], muz[i], 
                sez))
             l2[i] <- log(1 - pnorm(q1[i])) + log(dnorm(z[i], 
             muz[i], sez))
        }
        data0 <- cbind(y, l1)
        data1 <- cbind(y, l2)
        data0[data0[, 1] == 1, 2] <- 0
        data1[data1[, 1] == 0, 2] <- 0
        t0 <- sum(data0[, 2])
        t1 <- sum(data1[, 2])
        t <- c(t0, t1)
        Tfinal <- sum(t)
        return(-Tfinal)
    }
    n = nlminb(ini, f, X = X, y = y, z = z, p = p, q = q, lower = c(rep(-Inf, 
        p+q), -0.999, 0), upper = c(rep(Inf, 
        p+q), 0.999, Inf), hessian = T)
    h = fdHess(n$par, f, z = z, y = y, X, p, q)
    h1 = h$Hessian
    ih = ginv(h1)
    se = sqrt(abs(diag(ih)))
    n$Hessian <- h1
    n$p <- p
    n$q <- q
    n$se <- as.vector(se)
    n$call <- match.call()
    class(n) <- "JointRegBC"
    object = n
    Co.Re <- data.frame(Parameter = object$par[1:p], S.E = object$se[1:p], 
        `Confidence Interval` = paste("(", round(object$par[1:p] - 
            2 * object$se[1:p], 3), ",", round(object$par[1:p] + 
            2 * object$se[1:p], 3), ")", sep = ""))
    Binary.Re <- data.frame(Parameter = object$par[(p + 1):(p + q)], 
        S.E = object$se[(p + 1):(p + q)], `Confidence Interval` = paste("(", 
            round(object$par[(p + 1):(p + q)] - 2 * object$se[(p + 
                1):(p + q)], 3), ",", round(object$par[(p + 1):(p + 
                q)] + 2 * object$se[(p + 1):(p + q)], 3), ")", 
            sep = ""))
        Cor <- data.frame(Parameter = object$par[p + q + 1], S.E = object$se[p + 
        q + 1], `Confidence Interval` = paste("(", round(object$par[p + 
        q + 1] - 2 * object$se[p + q + 1], 3), ",", round(object$par[p + 
        q + 1] + 2 * object$se[p + q + 1], 3), ")", sep = ""))
    Var <- data.frame(Parameter = object$par[p + q + 2], S.E = object$se[p + 
        q + 2], `Confidence Interval` = paste("(", round(object$par[p + 
        q + 2] - 2 * object$se[p + q + 2], 3), ",", round(object$par[p + 
        q + 2] + 2 * object$se[p + q + 2], 3), ")", sep = ""))
       res <- list(call = object$call, `Continuos Response` = Co.Re, 
        `Variance Of Countinous Response` = Var, `Binary Response` = Binary.Re, 
         Correlation = Cor)
    res$Hessian <- h1
    res$convergence <- n$convergence
res$objective<-  n$objective
    res$call <- match.call()
    class(res) <- "JointRegBC"
    res
  }
}
\keyword{regression}