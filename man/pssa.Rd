% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/patest.R
\docType{data}
\name{pssa}
\alias{pssa}
\title{PSSA Data}
\format{
A data frame with 175,890 rows and 12 variables:
\describe{
  \item{year}{The school year the PSSA was administered}
  \item{county}{County of the school}
  \item{district}{School district name}
  \item{school_number}{Identification for the school}
  \item{school_name}{Name of the school}
  \item{grade}{3 through 8}
  \item{group}{Student group, "All Students" or "Historically Underperforming"}
  \item{subject}{"English Language Arts", "Math", or "Science"}
  \item{students}{Number of students who took the assessment}
  \item{below_basic}{Proportion of students who scored below basic}
  \item{basic}{Proportion of students who scored basic}
  \item{proficient}{Proportion of students who scored proficient}
  \item{advanced}{Proportion of students who scored advanced}
}
}
\usage{
pssa
}
\description{
Raw data contain multiple iterations of school names.  For simplicity, the
  2019 school name is used for all years.
}
\details{
Data from the Pennsylvania System of School Assessment from 2015-2019.
}
\references{
https://www.education.pa.gov/DataAndReporting/Assessments/Pages/PSSA-Results.aspx
}
\keyword{datasets}
