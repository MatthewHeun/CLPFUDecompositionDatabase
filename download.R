# This script downloads relevant data from the Mexer database
# and stores locally for later processing.



# Countries and years ----------------------------------------------------------

# Source the setup file from which we obtain
# countries and years of interest.
source("_pl_setup.R")


# Database connection ----------------------------------------------------------

conn <- PFUPipelineTools::get_scratchmdb_conn()

# Download data ----------------------------------------------------------------

# Download from the Mexer website
psut_re_all <- PFUPipelineTools::pl_filter_collect(db_table_name = "PSUTReAll",
                                                   version_string = database_version,
                                                   Dataset == "CL-PFU IEA",
                                                   EnergyType == "E",
                                                   LastStage == "Final",
                                                   IncludesNEU,
                                                   Country %in% countries,
                                                   Year %in% years,
                                                   conn = conn,
                                                   collect = TRUE)

DBI::dbDisconnect(conn)

# Save to local_storage --------------------------------------------------------
psut_re_all |>
  saveRDS(file = psut_re_all_path)

