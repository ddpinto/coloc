% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/pcs.R
\name{pcs.prepare}
\alias{pcs.prepare}
\title{Functions to prepare principle component models for colocalisation testing}
\usage{
pcs.prepare(X1, X2, impute = TRUE)
}
\arguments{
\item{X1}{Either a SnpMatrix or numeric matrix of genetic data.
Columns index SNPs, rows index samples.}

\item{X2}{as X1}

\item{impute}{if TRUE (default), impute missing genotypes}
}
\value{
a \code{colocPCs} object.
}
\description{
Prepares principal components of two datasets for
colocalisation testing.
}
\details{
If \code{X1} and \code{X2} are \code{SnpMatrix} objects, they are checked for
missing data, and any missing values imputed by repeated use of
\code{impute.snps} from the \code{snpStats} package.

Columns with common names are \code{rbind}ed together and principal
components calculated using \code{prcomp}.

\code{pcs.model} can then be invoked to create \code{glm} objects.
}
\examples{

 ## simulate covariate matrix (X) and continuous response vector (Y)
 ## for two populations/triats Y1 and Y2 depend equally on f1 and f2
 ## within each population, although their distributions differ between
 ## populations.  They are compatible with a null hypothesis that they
 ## share a common causal variant, with the effect twice as strong for
 ## Y2 as Y1
set.seed(1)
 X1 <- matrix(rbinom(5000,1,0.4),ncol=10)
 Y1 <- rnorm(500,apply(X1[,1:2],1,sum),2)
 X2 <- matrix(rbinom(5000,1,0.6),ncol=10)
 Y2 <- rnorm(500,2*apply(X2[,1:2],1,sum),5)
 
 ## generate principal components object
 colnames(X1) <- colnames(X2) <- make.names(1:ncol(X1))
 pcs <- pcs.prepare(X1,X2)

 ## generate glm objects
 m1 <- pcs.model(pcs, group=1, Y=Y1)
 m2 <- pcs.model(pcs, group=2, Y=Y2)

 ## test colocalisation using PCs
 coloc.test(m1,m2,plot.coeff=FALSE,bayes=FALSE)

}
\author{
Chris Wallace
}
\references{
Wallace et al (2012).  Statistical colocalisation of monocyte
gene expression and genetic risk variants for type 1 diabetes.  Hum Mol Genet
21:2815-2824.  \url{http://europepmc.org/abstract/MED/22403184}

Plagnol et al (2009).  Statistical independence of the colocalized
association signals for type 1 diabetes and RPS26 gene expression on
chromosome 12q13. Biostatistics 10:327-34.
\url{http://www.ncbi.nlm.nih.gov/pubmed/19039033}
}

