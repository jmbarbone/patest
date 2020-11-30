# Some extra functions for cleaning the data sets

# TODO combine all data to find county, district, school number etc
# (may only need from a single report?)

options(tidyverse.quiet = TRUE)
library(tidyverse)
library(readxl)

rename_schools <- function(x) {
  # Attempt to standardized some of the names
  x <- sub("EL(EM)? S(CH)?$|EL(EM)?$", "ELS", x)
  x <- sub("CHARTER?(\\sSCHOOL)?$", "CS", x)
  x <- sub("CHARTER\\sS$", "CS", x)
  x <- sub("INTRM(D SCH)?$|INTERMEDIATE\\sS(CH)?$", "IS", x)
  x <- sub("PRIMARY SCH(OO)?L?$", "PS", x)
  x <- sub("INTERMEDIATE CE?N?TE?R%", "ICTR", x)
  x <- sub("\\s SCH$", "", x)
  x
}

clean_names_and_types <- function(x) {
  x <- janitor::clean_names(x)
  cn <- colnames(x)

  ind <- grep("^pct_", cn)
  if (length(ind)) {
    colnames(x)[ind] <- paste0("percent", substr(cn[ind], 4, 20))
    cn <- colnames(x)
  }

  # differences across reports and years
  new_cols <- list(
    school_name = "school",
    school_number = c("schl", "school_code", "school_nbr"),
    district = c("district_name", "lea"),
    students = c("n_scored", "number_scored", "n_count", "n_tested",
                 "number_tested", "number_students_tested"),
    group = "student_group_name",
    verbal = c("verbal_average", "verbal_average_score"),
    math = c("mathematics_average", "math_average", "math_average_score"),
    writing = c("writing_average", "writing_average_score"),
    reading = c("reading_average", "reading_average_score"),
    english = "english_average",
    science = "science_average",
    reading_writing = "evidence_based_reading_and_writing_average",
    composite = c("composite_average", "compostie_average",
                  "composite_score_average")
  )

  x <- rename_cols(x, new_cols)

  ind <- cn %in% c("growth", "year", "highschcode", "aun", "aicode")
  if (any(ind)) {
    x <- x[, !ind]
  }

  x <- if_found_then(x, "grade", as.character)
  x <- if_found_then(x, "percent_advanced", as.double)
  x <- if_found_then(x, "percent_proficient", as.double)
  x <- if_found_then(x, "percent_basic", as.double)
  x <- if_found_then(x, "percent_below_basic", as.double)
  x <- if_found_then(x, "verbal", as.double)
  x <- if_found_then(x, "math", as.double)
  x <- if_found_then(x, "writing", as.double)
  x <- if_found_then(x, "reading", as.double)
  x <- if_found_then(x, "reading_writing", as.double)
  x <- if_found_then(x, "english", as.double)
  x <- if_found_then(x, "english_writing", as.double)
  x <- if_found_then(x, "science", as.double)
  x <- if_found_then(x, "composite", as.double)
  x <- if_found_then(x, "students", as.integer)
  x <- if_found_then(x, "school_number", school_format)
  x
}

if_found_then <- function(x, col, FUN, ...) {
  if (!is.null(x[[col]])) {
    x[[col]] <- silently(FUN)(x[[col]], ...)
  }

  x
}

silently <- function(FUN) {
  function(...) {
    suppressWarnings(FUN(...))
  }
}

school_format <- function(x) {
  formatC(as.integer(x), width = 9, flag = 0)
}

distinct_schools <- function(x) {
  x <- dplyr::arrange(x, dplyr::desc(year))
  x <- dplyr::distinct(x, school_number, school_name)
  dplyr::distinct(x, school_number, .keep_all = TRUE)
}

rename_cols <- function(x, cols) {
  # like dplyr::rename() except can take multiple matches
  # And I'm not accounting for too much
  cn <- colnames(x)
  nm <- names(cols)

  for (i in seq_along(cols)) {
    ind <- cn %in% cols[[i]]
    if (any(ind)) {
      stopifnot(sum(ind) == 1)
      colnames(x)[ind] <- nm[i]
    }
  }

  x
}

percents_to_props <- function(x) {
  dplyr::mutate_at(
    x,
    dplyr::vars(tidyselect::starts_with("percent_")),
    magrittr::divide_by, 100
  )
}

remove_percent_names <- function(x) {
  dplyr::rename_at(
    x,
    dplyr::vars(tidyselect::starts_with("percent_")),
    stringr::str_remove,
    "percent_")
}

distinct_schools_join <- function(data) {
  schools <- distinct_schools(data)
  data <- dplyr::select(data, -school_name)
  data <- dplyr::left_join(data, schools, by = "school_number")
  dplyr::relocate(data, school_name, .after = school_number)
}
