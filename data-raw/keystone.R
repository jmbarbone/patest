
source("data-raw/utils.R")

keystone <- list(
  `2015` = read_xlsx("data-raw/keystone/2015 Keystone Exam School Level Data.xlsx", skip = 7),
  `2016` = read_xlsx("data-raw/keystone/2016 Keystone Exams School Level Data.xlsx", skip = 4),
  `2017` = read_xlsx("data-raw/keystone/2017 Keystone Exams School Level Data.xlsx", skip = 4),
  `2018` = read_xlsx("data-raw/keystone/2018 Keystone Exams School Level Data.xlsx", skip = 4),
  `2019` = read_xlsx("data-raw/keystone/2019 Keystone Exams School Level Data.xlsx", skip = 3)
) %>%
  map_dfr(clean_names_and_types, .id = "year") %>%
  filter(grade != "Total") %>%
  percents_to_props() %>%
  remove_percent_names() %>%
  mutate_at(c("year", "grade"), as.integer) %>%
  # 2015 data uses EMS for English Math Science
  mutate(subject = recode(subject, "E" = "Literature", "M" = "Algebra I", "S" = "Biology")) %>%
  distinct_schools_join() %>%
  arrange(year) %>%
  select(year, county, district, school_number, school_name,
         grade, subject, group, students,
         below_basic, basic, proficient, advanced,
         everything())

usethis::use_data(keystone, overwrite = TRUE)
