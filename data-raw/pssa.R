
source("data-raw/utils.R")

source("data-raw/utils.R")

pssa <- list(
  `2015` = read_xlsx("data-raw/pssa/2015 PSSA School Level Data.xlsx", skip = 6),
  `2016` = read_xlsx("data-raw/pssa/2016 PSSA School Level Data.xlsx", skip = 4),
  `2017` = read_xlsx("data-raw/pssa/2017 PSSA School Level Data.xlsx", skip = 4),
  `2018` = read_xlsx("data-raw/pssa/2018 PSSA School Level Data.xlsx", skip = 4),
  `2019` = read_xlsx("data-raw/pssa/2019 PSSA School Level Data.xlsx", skip = 4)
) %>%
  map_dfr(clean_names_and_types, .id = "year") %>%
  filter(!grade %in% c("Total", "School Total")) %>%
  percents_to_props() %>%
  remove_percent_names() %>%
  mutate_at(c("year", "grade", "students"), as.integer) %>%
  mutate(school_name = rename_schools(school_name)) %>%
  distinct_schools_join() %>%
  arrange(year) %>%
  select(year, county, district, school_number, school_name,
         grade, group, subject, students,
         below_basic, basic, proficient, advanced,
         everything())

usethis::use_data(pssa, overwrite = TRUE)
