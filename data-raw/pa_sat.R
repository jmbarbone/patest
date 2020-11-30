
source("data-raw/utils.R")

pa_sat <- list(
  `2012` = read_xlsx("data-raw/sat/2012 SAT Scores for Public Schools.xlsx", skip = 2),
  `2013` = read_xlsx("data-raw/sat/2013 SAT Scores for Public Schools.xlsx", skip = 5),
  `2014` = read_xlsx("data-raw/sat/2014 SAT Scores for Public Schools.xlsx", skip = 7),
  `2015` = read_xlsx("data-raw/sat/2015 SAT Scores for Public Schools.xlsx", skip = 7),
  `2016` = read_xlsx("data-raw/sat/2016 SAT Scores Public Schools.xlsx", skip = 7),
  # Merged cells and difference naming...
  `2017` = read_xlsx(
    "data-raw/sat/2017 SAT Scores Public Schools.xlsx",
    skip = 6,
    col_names = c("school_name", "students", "composite", "reading_writing", "math")),
  `2018` = read_xlsx("data-raw/sat/2018 SAT Scores for Public Schools.xlsx", skip = 5),
  `2019` = read_xlsx("data-raw/sat/2019 SAT Scores for Public Schools.xlsx", skip = 5)
) %>%
  map_dfr(clean_names_and_types, .id = "year") %>%
  distinct_schools_join() %>%
  arrange(year) %>%
  select(year, district, school_number, school_name,
         students, verbal, math, writing, reading, reading_writing, composite,
         everything())

usethis::use_data(pa_sat, overwrite = TRUE)
