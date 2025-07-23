# targets::tar_make() to run the pipeline in a single thread.
# targets::tar_make_future(workers = 8) to execute across multiple cores.
# targets::tar_make(callr_function = NULL) to debug.
# targets::tar_read(<<target_name>>) to view the results.
# targets::tar_invalidate(<<target_name>>) to re-compute <<target_name>> and its dependents.
# targets::tar_destroy() to start over with everything,

# Get local machine setup information ------------------------------------------
# Duplicate file _pl_setup_template.R and
# rename as _pl_setup.R.
# Modify details for your setup, as needed.
source("_pl_setup.R")

# Load packages required to define the pipeline:
library(tarchetypes)
library(targets)



# Set aggregation files
aggregation_tables_dir <- "aggregation_tables"
targeted_aggregations_file <- system.file(aggregation_tables_dir, "targeted_aggregations.xlsx",
                                          package = "CLPFUDecompositionDatabase")


# End user-adjustable parameters.





#
# Set up some machine-specific parameters,
# mostly for input and output locations.
#

# sys_info <- Sys.info()
# if (startsWith(sys_info[["nodename"]], "Mac")) {
#   setup <- PFUSetup::get_abs_paths()
# } else if (endsWith(sys_info[["nodename"]], "arc4.leeds.ac.uk")) {
#   uname <- sys_info[["user"]]
#   setup <- PFUSetup::get_abs_paths(home_path <- "/nobackup",
#                                    dropbox_path = uname)
#   # Set the location for the _targets folder.
#   targets::tar_config_set(store = file.path(setup[["output_data_path"]], "_targets/"))
# } else {
#   stop("Unknown system in _targets.R for PFUAggDatabase. Can't set input and output locations.")
# }

# Set up for multithreaded work on the local machine.
# future::plan(future.callr::callr)

# Set options for all targets.
targets::tar_option_set(
  packages = NULL,
  # Indicate that storage and retrieval of subtargets
  # should be done by the worker thread,
  # not the main thread.
  # These options set defaults for all targets.
  # Individual targets can override.
  storage = "worker",
  retrieval = "worker",
  # Tell targets to NOT keep everything in memory ...
  memory = "transient",
  # ... and to garbage-collect the memory when done.
  garbage_collection = TRUE
)

# Source scripts ---------------------------------------------------------------
tar_source()


# Source the pipeline ----------------------------------------------------------
source("pipeline.R")




