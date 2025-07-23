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

  # PSUT -----------------------------------------------------------------------

  # Read the downloaded file.
  # Source the download.R to get the required data.
  # Pull in the PSUT data frame
  targets::tar_target_raw(
    "PSUTReAllPath",
    psut_re_all_path,
    format = "file"
  ),

  targets::tar_target(
    PSUTReAll,
    readRDS(PSUTReAllPath)
  ),


  # Aggregations ---------------------------------------------------------------

  # Read the aggregation file
  targets::tar_target_raw(
    "TargetedAggregationsPath",
    targeted_aggregations_path,
    format = "file"
  ),

  ## Industry aggregations -----------------------------------------------------
  targets::tar_target(
    IndustryAggregationMap,
    load_agg_map(TargetedAggregationsPath,
                 aggregation_tab = "industry_aggregations")
  ),

  targets::tar_target(
    name = PSUT_Agg_In,
    command = targeted_aggregation(psut_df = PSUTReAll,
                                   aggregation_map = IndustryAggregationMap,
                                   margin = "Industry")),


  ## Product aggregations ------------------------------------------------------
  targets::tar_target(
    ProductAggregationMap,
    load_agg_map(TargetedAggregationsPath,
                 aggregation_tab = "product_aggregations")),

  targets::tar_target(
    name = PSUT_Agg_InPr,
    command = targeted_aggregation(psut_df = PSUT_Agg_In,
                                   aggregation_map = ProductAggregationMap,
                                   margin = "Product")
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



  # Add distribution of statistical differences


  # Calculate and report efficiencies right in the pipeline



)
