# This script prepares machine efficiency data for Zeus Guevara.
# --- MKH, 11 Sept 2025

tar_read(Etai) |>
  dplyr::select(-dplyr::all_of(c("r_EIOU", "S_units", "R", "U_feed", "U_EIOU", "U", "V", "Y"))) |>
  dplyr::mutate(
    matnames = "eta_i"
  ) |>
  dplyr::rename(matvals = eta_i) |>
  matsindf::group_by_everything_except("matvals") |>
  matsindf::expand_to_tidy() |>
  dplyr::rename(machine = rownames, eta_i = matvals) |>
  dplyr::mutate(
    colnames = NULL
  ) |>
  write.csv("~/Desktop/etai.csv")
