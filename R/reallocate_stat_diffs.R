reallocate <- function(PSUT) {
  PSUT |>
    Recca::reallocate_statistical_differences() |>
    dplyr::mutate(
      # Get rid of old columns
      R = NULL,
      U = NULL,
      V = NULL,
      Y = NULL,
      U_feed = NULL,
      U_EIOU = NULL
    ) |>
    dplyr::rename(
      # Rename new columns
      R = R_prime,
      U = U_prime,
      V = V_prime,
      Y = Y_prime,
      U_feed = U_feed_prime,
      U_EIOU = U_EIOU_prime
    )
}
