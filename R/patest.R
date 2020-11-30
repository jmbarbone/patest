#' PA Test (Package)
#'
#' Pennsylvania school testing results
#'
#' @description
#' The Pennsylvania System of School Assessment, also known as PSSA, measures
#'   how well students have achieved in reading, mathematics, science and
#'   writing according to Pennsylvania's world-class academic standards. By
#'   using these standards, educators, parents and administrators can evaluate
#'   their students' strengths and weaknesses to increase students' achievement
#'   scores.
#'
#' @docType package
#' @name patest
#' @references https://www.education.pa.gov/K-12/Assessment%20and%20Accountability/PSSA/Pages/default.aspx
NULL

#' PSSA Data
#'
#' Data from the Pennsylvania System of School Assessment from 2015-2019.
#'
#' @description
#' Raw data contain multiple iterations of school names.  For simplicity, the
#'   2019 school name is used for all years.
#'
#' @format A data frame with 175,890 rows and 12 variables:
#' \describe{
#'   \item{year}{The school year the PSSA was administered}
#'   \item{county}{County of the school}
#'   \item{district}{School district name}
#'   \item{school_number}{Identification for the school}
#'   \item{school_name}{Name of the school}
#'   \item{grade}{3 through 8}
#'   \item{group}{Student group, "All Students" or "Historically Underperforming"}
#'   \item{subject}{"English Language Arts", "Math", or "Science"}
#'   \item{students}{Number of students who took the assessment}
#'   \item{below_basic}{Proportion of students who scored below basic}
#'   \item{basic}{Proportion of students who scored basic}
#'   \item{proficient}{Proportion of students who scored proficient}
#'   \item{advanced}{Proportion of students who scored advanced}
#' }
#'
#' @name pssa
#' @references https://www.education.pa.gov/DataAndReporting/Assessments/Pages/PSSA-Results.aspx
"pssa"

#' Keystone
#'
#' Data from Pennsyvlania's Keystone assessments
#'
#' @format A data frame with 22,101 rows and 14 variables
#' \describe{
#'   \item{year}{School year (ending) the Keystone was administered}
#'   \item{county}{School district county}
#'   \item{district}{School district name}
#'   \item{school_number}{Identification for the school}
#'   \item{school_name}{Name of the school}
#'   \item{subject}{"Literature", "Algebra I", or "Biology"}
#'   \item{grade}{11 (only admistered in 11th grade)}
#'   \item{group}{Student group, "All Students" or "Historically Underperforming"}
#'   \item{students}{Number of students who took the assessment}
#'   \item{below_basic}{Proportion of students who scored below basic}
#'   \item{basic}{Proportion of students who scored basic}
#'   \item{proficient}{Proportion of students who scored proficient}
#'   \item{advanced}{Proportion of students who scored advanced}
#' }
"keystone"

#' PA SAT
#'
#' SAT results from PA public schools from 2001 to 2019
#'
#' @format A data frame with 5,502 rows and 11 variables
#' \describe{
#'   \item{year}{School year (ending) the Keystone was administered}
#'   \item{district}{School district name}
#'   \item{school_number}{Identification for the school}
#'   \item{school_name}{Name of the school}
#'   \item{students}{Number of students who took the assessment}
#'   \item{verbal}{Average verbal score for school}
#'   \item{math}{Average math score for school}
#'   \item{writing}{Average writing score for school}
#'   \item{reading}{Average reading score for school}
#'   \item{reading_writing}{Average reading and writing composite score for school}
#'   \item{composite}{Average composite score for school}
#' }
"pa_sat"

#' PA ACT
#'
#' ACT results from PA public schools
#'
#' @format A data frame with 5,770 rows and 12 variables
#' \describe{
#'   \item{year}{School year (ending) the Keystone was administered}
#'   \item{district}{School district name}
#'   \item{school_number}{Identification for the school}
#'   \item{school_name}{Name of the school}
#'   \item{students}{Number of students who took the assessment}
#'   \item{english}{Average english score for school}
#'   \item{math}{Average math score for school}
#'   \item{reading}{Average reading score for school}
#'   \item{science}{Average science score for school}
#'   \item{writing}{Average writing score for school}
#'   \item{english_writing}{Average english and writing composite score for school}
#'   \item{composite}{Average composite score for school}
#' }
"pa_act"
