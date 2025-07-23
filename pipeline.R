# This is the targets pipeline

list(

  # Preliminary setup --------------------------------------------------------

  # Store some incoming data as targets
  # These targets are invariant across incoming psut_releases
  targets::tar_target_raw("Countries", list(countries)),
  targets::tar_target_raw("Years", list(years)),
  targets::tar_target_raw("DatabaseVersion", database_version),
  targets::tar_target_raw("LocalStorage", local_storage),
  # targets::tar_target_raw("Release", release),

  # PSUT ---------------------------------------------------------------------

  # Read the downloaded file.
  # Source the download.R to get the required data.
  # Pull in the PSUT data frame
  targets::tar_target_raw(
    "PSUTReAllFilePath",
    psut_re_all_path,
    format = "file"
  ),

  targets::tar_target(
    PSUTReAll,
    readRDS(PSUTReAllFilePath)
  )

  # # Etai ---------------------------------------------------------------------
  #
  # # Pull in the Etai data frame
  # targets::tar_target_raw(
  #   "Etai",
  #   quote(PFUPipelineTools::read_pin_version(pin_name = "eta_i",
  #                                            database_version = database_version,
  #                                            pipeline_releases_folder = PinboardFolder) |>
  #           PFUPipelineTools::filter_countries_years(countries = Countries, years = Years))
  # ),
  #
  #
  # # Aggregation file ---------------------------------------------------------
  #
  # targets::tar_target_raw(
  #   "TargetedAggregationsFile",
  #   targeted_aggregations_file
  # ),
  #
  #
  # # Industry aggregations ----------------------------------------------------
  #
  # targets::tar_target_raw(
  #   "IndustryAggregationMaps",
  #   quote(load_agg_map(TargetedAggregationsFile, aggregation_tab = "industry_aggregations"))
  # ),
  # targets::tar_target_raw(
  #   name = "PSUT_Agg_In",
  #   command = quote(targeted_aggregation(psut_df = PSUTByCountry,
  #                                        aggregation_map = IndustryAggregationMaps,
  #                                        margin = "Industry")),
  #   pattern = quote(map(PSUTByCountry))
  # ),
  #
  #
  # # Product aggregations -----------------------------------------------------
  #
  # targets::tar_target_raw(
  #   "ProductAggregationMaps",
  #   quote(load_agg_map(TargetedAggregationsFile, aggregation_tab = "product_aggregations"))
  # ),
  # targets::tar_target_raw(
  #   name = "PSUT_Agg_InPr",
  #   command = quote(targeted_aggregation(psut_df = PSUT_Agg_In,
  #                                        aggregation_map = ProductAggregationMaps,
  #                                        margin = "Product")),
  #   pattern = quote(map(PSUT_Agg_In))
  # ),


  # Technology shares --------------------------------------------------------

  # targets::tar_target_raw(
  #   "IndustryShares",
  #   quote(calc_iea_industry_shares(psut_df = PSUTByCountry)),
  #   pattern = quote(map(PSUTByCountry))
  # ),
  # targets::tar_target_raw(
  #   "IndustrySharesExpanded",
  #   quote(expand_tech_shares(IndustryShares)),
  #   pattern = quote(map(IndustryShares))
  # )




)
