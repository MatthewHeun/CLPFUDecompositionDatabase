% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/decomposition_pipelines.R
\name{get_pipeline}
\alias{get_pipeline}
\title{Create a targets workflow for decomposition work}
\usage{
get_pipeline(
  countries = "all",
  years = "all",
  psut_release,
  pipeline_releases_folder,
  pipeline_caches_folder,
  release = FALSE
)
}
\arguments{
\item{countries}{A string vector of 3-letter country codes.
Default is "all", meaning all available countries should be analyzed.}

\item{years}{A numeric vector of years to be analyzed.
Default is "all", meaning all available years should be analyzed.}

\item{psut_release}{The release we'll use from \code{pipeline_releases_folder}.
See details.}

\item{pipeline_releases_folder}{The path to a folder where releases of output targets are pinned.}

\item{pipeline_caches_folder}{The path to a folder where releases of pipeline caches are stored.}

\item{release}{Boolean that tells whether to do a release of the results.
Default is \code{FALSE}.}
}
\value{
A list of \code{tar_target}s to be executed in a workflow.
}
\description{
This is a target factory whose arguments
specify the details of a targets workflow to be constructed
}
