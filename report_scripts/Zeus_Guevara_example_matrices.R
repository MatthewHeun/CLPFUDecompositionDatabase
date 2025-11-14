# This script pulls several energy conversion chains (ECCs) and
# writes Excel files with those ECCs.
# These are for Zeus Guevara's work to prepare his decomposition
# code for the data.

data_for_zeus <- tar_read(PSUTReallocated) |>
  dplyr::filter(Country %in% c("MEX", "GHA"), Year %in% 2015:2020) |>
  dplyr::mutate(
    WorksheetNames = paste(Country, Year, sep = "_")
  ) |>
  dplyr::arrange(WorksheetNames)

data_for_zeus |>
  Recca::write_ecc_to_excel(path = "~/Desktop/For Zeus/ReallocatedEECs.xlsx",
                            worksheet_names = "WorksheetNames")

data_for_zeus |>
  saveRDS(file = "~/Desktop/For Zeus/ReallocatedECCs.rds")

ReallocatedECCs <- readRDS("~/Desktop/For Zeus/ReallocatedECCs.rds")
ReallocatedECCs$R[[1]] |> as.matrix() |> View()

# Now also gather the allocation matrices and
# efficiency vectors for the same years.

Cmats <- PFUPipelineTools::pl_filter_collect("Cmats",
                                              Country %in% c("MEX", "GHA"),
                                              Year %in% 2015:2020,
                                              collect = TRUE,
                                              conn = PFUPipelineTools::get_mexerdb_conn(user = "dbcreator")) |>
  dplyr::mutate(
    rowsumsCY = matsbyname::rowsums_byname(C_Y),
    rowsumsCEIOU = matsbyname::rowsums_byname(C_EIOU),
    WorksheetNames = paste(Country, EnergyType, Year, sep = "_")
  )

etafuvecs <- PFUPipelineTools::pl_filter_collect("Etafuvecs",
                                                 Country %in% c("MEX", "GHA"),
                                                 Year %in% 2015:2020,
                                                 collect = TRUE,
                                                 conn = PFUPipelineTools::get_mexerdb_conn(user = "dbcreator"))


