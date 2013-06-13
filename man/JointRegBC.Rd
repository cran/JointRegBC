\name{JointRegBC}
\alias{JointRegBC}
\title{
Joint Modelling of Mixed Correlated Binary and
Continuous Responses : A Latent Variable Approach.
}
\description{
A joint regression model for mixed correlated binary and continuous responses is presented. In this model binary response can be dependent on the continuous response. With this model, the dependence between responses can be taken into account by the correlation between errors in the models for binary and continuous  responses.
}
\usage{
JointRegBC(ini = NA, X, y, z, p, q, ...)
}
\arguments{
\item{ini}{Initial values}
\item{X}{Design matrix}
\item{z}{Continuous responses}
\item{y}{Binary responses }
\item{p}{Order of dimension of Binary responses}
\item{q}{Order of dimension of continuous responses}
\item{\dots}{Other arguments}}
\details{
Models for JointRegBC are specified symbolically. A typical model has the form response1 ~ terms and response2 ~ terms  where response1and response2 are the (numeric) binary and 
continuous responses vector and  terms is a series of terms which specifies a linear predictor for responses. A terms specification of the form first + second indicates all the terms in first together with all the terms in second with duplicates removed. A specification of the form first:second indicates the set of terms obtained by taking the interactions of all terms in first with all terms in second. The specification first*second indicates the cross of first and second. This is the same as first + second + first:second.
}
\value{
   \item{Binary response}{Coefficient of ordinal response}
\item{Continuous Response}{Coefficient of continuous response}
 \item{Variance of Countinuous Response}{Variance of continuous response}
 \item{Correlation}{Coefficient of continuous response}
 \item{Hessian}{Hessian matrix}
 \item{convergence}{An integer code. 0 indicates successful convergence.}
}
\references{
Bahrami Samani, E. and Tahmasebinejad. Zh.(2011). Joint Modelling of Mixed Correlated Nominal, Ordinal and
Continuous Responses. Journal of Statistical Research. 45(1):37-47. 
}
\author{
Bahrami Samani and Zhale Tahmasebinejad
}
\note{
Supportted by Shahid Beheshti University
}
\seealso{
\code{\link{nlminb}},\code{\link{fdHess},\link{clogit}}
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
names(W)=c("Corr","Variance of Continous Response")
ini=c(P,Q,W)
p=5;
q=4;
JointRegBC(ini,X=X,y=y,z=z,p=p,q=q)
## The function is currently defined as
structure(function (x, ...) 
UseMethod("JointRegBC"), class = "JointRegBC")
}
\keyword{regression}