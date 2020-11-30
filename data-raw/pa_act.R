
source("data-raw/utils.R")

# 2010 to 2011 in separate sheets (yeah, 2011 is sheet 1; 2010 sheet 2)
pa_act <- list(
  `2010` = read_xlsx(
    "data-raw/act/2010-2011 ACT Scores for Public Schools.xlsx",
    skip = 2,
    sheet = 2,
    # separates ns -- give provide note for three(?) schools that have differences
    col_names = c("aun", "district", "school_number", "school_name",
                  "students_english", "english",
                  "students_math", "math",
                  "students_science", "science",
                  "students_reading", "reading",
                  "students", "composite",
                  "students_english_writing", "english_writing",
                  "students_writing", "writing")
  ) %>%
    select_at(vars(-starts_with("students_"))),
  `2011` = read_xlsx(
    "data-raw/act/2010-2011 ACT Scores for Public Schools.xlsx",
    skip = 3,
    sheet = 1,
    # separates ns -- give provide note for three(?) schools that have differences
    col_names = c("aun", "district", "school_number", "school_name",
                  "students_english", "english",
                  "students_math", "math",
                  "students_science", "science",
                  "students_reading", "reading",
                  "students", "composite",
                  "students_english_writing", "english_writing",
                  "students_writing", "writing")
  ) %>%
    select_at(vars(-starts_with("students_"))),
  `2013` = read_xlsx("data-raw/act/2013 ACT Scores for Public Schools.xlsx", skip = 4) %>%
    select(-`SCHOOL CODE`),
  `2014` = read_xlsx("data-raw/act/2014 ACT Scores for Public Schools.xlsx", skip = 6),
  `2015` = read_xlsx("data-raw/act/2015 ACT Scores for Public Schools.xlsx", skip = 6),
  `2016` = read_xlsx("data-raw/act/2016 ACT Scores Public Schools.xlsx", skip = 6),
  `2017` = read_xlsx("data-raw/act/2017 ACT Scores Public Schools.xlsx", skip = 6),
  `2018` = read_xlsx("data-raw/act/2018 ACT Scores for Public Schools.xlsx", skip = 6),
  `2019` = read_xlsx("data-raw/act/2019 ACT Scores for Public Schools.xlsx", skip = 6)
) %>%
  map_dfr(clean_names_and_types, .id = "year") %>%
  distinct_schools_join() %>%
  arrange(year) %>%
  select(year, district, school_number, school_name, students,
         english, math, reading, science, writing, english_writing, composite,
         everything())

usethis::use_data(pa_act, overwrite = TRUE)
