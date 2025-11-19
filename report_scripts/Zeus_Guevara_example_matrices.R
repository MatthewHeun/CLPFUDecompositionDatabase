# This script pulls several energy conversion chains (ECCs) and
# writes Excel files with those ECCs.
# These are for Zeus Guevara's work to prepare his decomposition
# code for the data.

data_for_zeus <- targets::tar_read(PSUTReallocated) |>
  dplyr::filter(Country %in% c("MEX", "GHA"), Year %in% 2015:2020) |>
  dplyr::mutate(
    WorksheetNames = paste(Country, Year, sep = "_")
  ) |>
  dplyr::arrange(WorksheetNames)

data_for_zeus |>
  Recca::write_ecc_to_excel(path = "~/Desktop/For Zeus/ReallocatedEECs.xlsx",
                            worksheet_names = "WorksheetNames",
                            overwrite_file = TRUE,
                            overwrite_worksheets = TRUE)

data_for_zeus |>
  saveRDS(file = "~/Desktop/For Zeus/ReallocatedECCs.rds")

# ReallocatedECCs <- readRDS("~/Desktop/For Zeus/ReallocatedECCs.rds")
# ReallocatedECCs$R[[1]] |> as.matrix() |> View()

# Now also gather the allocation matrices and
# efficiency vectors for the same years.

# Write allocation (C) matrices to a file

Cmats <- PFUPipelineTools::pl_filter_collect("Cmats",
                                              Country %in% c("MEX", "GHA"),
                                              Year %in% 2015:2020,
                                              collect = TRUE,
                                              conn = PFUPipelineTools::get_mexerdb_conn(user = "dbcreator")) |>
  tidyr::pivot_longer(cols = c("C_EIOU", "C_Y"), names_to = "matname", values_to = "matrix") |>
  dplyr::mutate(
    matname = factor(matname, levels = c("C_Y", "C_EIOU")),
    rowsums = matsbyname::rowsums_byname(matrix),
    WorksheetNames = paste(matname, Country, EnergyType, Year, sep = "_")
  ) |>
  dplyr::arrange(matname, Country, Year)

Cmats |>
  matsindf::write_mats_to_excel(mat_colname = "matrix",
                                worksheet_names = "WorksheetNames",
                                path = "~/Desktop/For Zeus/Cmats.xlsx")

Cmats |>
  saveRDS(file = "~/Desktop/For Zeus/Cmats.rds")


# Write efficiency (etafu) vectors to a file

etafuvecs <- PFUPipelineTools::pl_filter_collect("Etafuvecs",
                                                 Country %in% c("MEX", "GHA"),
                                                 Year %in% 2015:2020,
                                                 collect = TRUE,
                                                 conn = PFUPipelineTools::get_mexerdb_conn(user = "dbcreator")) |>
  dplyr::mutate(
    WorksheetNames = paste("eta", Country, EnergyType, Year, sep = "_")
  ) |>
  dplyr::arrange(Country, Year)


etafuvecs |>
  matsindf::write_mats_to_excel(mat_colname = "etafu",
                                worksheet_names = "WorksheetNames",
                                path = "~/Desktop/For Zeus/etafuvecs.xlsx")

etafuvecs |>
  saveRDS(file = "~/Desktop/For Zeus/etafuvecs.rds")
