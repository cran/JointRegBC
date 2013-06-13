\name{JointRegBC-package}
\alias{JointRegBC-package}
\docType{package}
\title{Joint Modelling of Mixed Correlated Binary and Continuous Responses : A Latent Variable Approach.}
\description{A joint regression model for mixed correlated binary and continuous responses is presented. In this model binary response can be dependent on the continuous response. With this model, the dependence between responses can be taken into account by the correlation between errors in the models for binary and continuous  responses.}
\details{
\tabular{ll}{
Package: \tab JointRegBC\cr
Type: \tab Package\cr
Version: \tab 1.0\cr
Date: \tab 2013-05-31\cr
License: \tab GPL (>=2)\cr
}
}
\author{
Ehsan Bahrami Samani and Zhale Tahmasebinejad 

Maintainer: Bahrami Samani 
<ehsan_bahrami_samani@yahoo.com> 
}
\references{
Bahrami Samani, E. and Tahmasebinejad. Zh.(2011). Joint Modelling of Mixed Correlated Nominal, Ordinal and
Continuous Responses. Journal of Statistical Research. 45(1):37-47. 
}
\examples{
data("Bahrami1")
gender<-Bahrami1$ GENDER
age<-Bahrami1$AGE
duration <-Bahrami1$ DURATION
y<-Bahrami1$ STEATOS
z<-Bahrami1$  BMI
sbp<-Bahrami1$ SBP
X=cbind(gender,age,duration ,sbp)
P<-lm(z~X)[[1]]
names(P)<-paste("Con_",names(P),sep="")
Q<-clogit(y~X)[[1]]
names(Q)<-paste("Binary",names(Q),sep="")
W=c(cor(y,z),var(z))
names(W)=c("Corr","Variance of Continuous Response")
ini=c(P,Q,W)
p=5;
q=4;
JointRegBC(ini,X=X,y=y,z=z,p=p,q=q)
}
\keyword{regression}