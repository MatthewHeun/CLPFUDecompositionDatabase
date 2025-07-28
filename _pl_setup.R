# For debugging: tar_make(callr_function = NULL, use_crew = FALSE, as_job = FALSE),
# set crew_controller <- FALSE
# and
# (1) insert browser() calls for functions in PFUPipeline2
# (2) set breakpoints in functions from other packages.



# Database version -------------------------------------------------------------
database_version <- "v2.1a2"

# Countries --------------------------------------------------------------------

# Set the countries to be analyzed.
# countries <- c(PFUPipelineTools::canonical_countries, "WRLD") |> as.character()
# countries <- PFUPipelineTools::canonical_countries |> as.character()
# countries <- c("USA", "WMBK")
# countries <- c("USA", "ITA")
# countries <- c("GBR", "USA", "MEX")
# countries <- c("ZWE", "USA", "WRLD")
# countries <- "USA"
# countries <- "WRLD"
# countries <- "CHNM"
# countries <- "GHA"
# countries <- c("GHA", "USA")
countries <- c("USA", "RUS", "IND", "GHA")
# Countries with unique allocation data plus BEL and TUR (for Pierre).
# countries <- c("BRA", "CAN", "CHNM", "DEU", "DNK", "ESP", "FRA", "GBR", "GHA", "GRC",
#                "HKG", "HND", "IDN", "IND", "JOR", "JPN", "KOR", "MEX", "NOR", "PRT",
#                "RUS", "USA", "WABK", "WMBK", "ZAF", "BEL", "TUR")


# Years ------------------------------------------------------------------------

# Set the years to be analyzed.
years <- 1960:2020
# years <- 2002
# years <- 1971:1973
# years <- 1971:1978
# years <- 1971
# years <- 1960:1961
# years <- 2016:2018


# Directories ------------------------------------------------------------------

## Local storage ---------------------------------------------------------------

# Set and create a local storage location.
local_storage <- file.path("~", "Desktop", "Decomposition project")
dir.create(local_storage, recursive = TRUE, showWarnings = FALSE)


# Files ------------------------------------------------------------------------
# Aggregation details
targeted_aggregations_path <- file.path("data",
                                        "aggregation_tables",
                                        "targeted_aggregations.xlsx")
# Data
psut_re_all_path <- file.path(local_storage, "downloaded_data.rds")
