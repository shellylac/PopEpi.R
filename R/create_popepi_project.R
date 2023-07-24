#' Utility function to set up a standardised PSB Pop Epi R project
#' with appropriate sub-directories and .gitignore and README.md file template
#' (which should be edited for each project repository)
#'
#' This function harnesses the usethis::create_project() function and adds extra
#' set-up for creating Git infrastructure,an R-flavoured .gitignore file, and
#' (optionally) appropriate sub-directories and a README.md template file.
#'
#' @param path character string specifying the path to the directory where the
#' new project will live.
#' @param folder_structure a logical value (TRUE or FALSE). If TRUE will create
#' sub-directories to hold input, output, and docs.
#' @param create_readme a logical value (TRUE or FALSE). If TRUE will create a
#' README.md template file with the project name as a h1 header in the content.
#' @return Creates a new directory at the path specified initialised, with Rproj
#'  setup and sub-directories, a .gitignore file and README.md file (if TRUE).
#' @note As part of setting up Git infrastructure, the function will prompt the
#' user whether they want to make an initial commit. For some reason, the
#' `usethis` function that handles this part gives three options,
#' two consisting of varieties of "no" and one of "yes," and the exact text
#' options **including their order** are different every time. Please be aware!
#'
#' The "initial commit" also appears to miss some updates to the .Rproj file,
#' so these need to be committed by the user as part of a subsequent commit (or
#' you can just choose not to make an initial commit during setup and make your
#' first commit manually). The script template is not included in the default
#' initial commit, as presumably the user will want to edit and/or rename this.
#' @examples
#' \dontrun{
#' path <- "C:/Users/username/Documents/my_new_project"
#' create_popepi_project(path = path, folder_structure = TRUE,
#' create_readme = TRUE)
#' }
#' @export
#'
create_popepi_project <- function(path,
                                  folder_structure = TRUE,
                                  create_readme = TRUE) {

  ## create project but don't open it yet
  usethis::create_project(path, open = FALSE)

  #Create the .gitignore file
  r_ignore_template <- c("# Misc R files", ".Rhistory", ".Rapp.history",
                         ".RData", ".Ruserdata", ".Rproj.user/", ".Renviron", "",
                         "# OAuth2 token see https://github.com/hadley/httr/releases/tag/v0.3",
                         ".httr-oauth", "",
                         "# knitr and R markdown default cache directories", "*_cache/",
                         "/cache/", "",
                         "# Temporary files created by R markdown",
                         "*.utf8.md", "*.knit.md", "")
  write(r_ignore_template, paste0(path, "/.gitignore"))

  if (folder_structure) {
    dir.create(paste0(path, "/input"), showWarnings = FALSE)
    file.create(paste0(path, "/input", "/.gitkeep"))
    dir.create(paste0(path, "/output"), showWarnings = FALSE)
    file.create(paste0(path, "/output", "/.gitkeep"))
    dir.create(paste0(path, "/docs"), showWarnings = FALSE)
    file.create(paste0(path, "/docs", "/.gitkeep"))

    #Append to the .gitignore file
    ignore_these <- c("#Ignore all objects in subdirectories",
                      "input/*", "output/*", "",
                      "#Exception to the above rules",
                      "!input/.gitkeep",
                      "!output/.gitkeep",
                      "!docs/.gitkeep")
    write(ignore_these, paste0(path, "/.gitignore"), append = TRUE)
  }

  ## add the rest of the local git infrastructure
  usethis::with_project(path, usethis::use_git())

  #Add README.md file
  if (create_readme) {
    cat(paste("#", basename(path)), file = paste0(path, "/README.md"))
    readme_content <- c("\n\n\n## Project Intro/Objective:\n\nThe purpose of this project is to ________...\n* Eliminate world hunger\n* Make The World Great Again\n* Drink gin\n\n## People involved:\n\nList who is involved and who is responsible, etc\n\n#### -- Project Status: [Active, On-Hold, Completed]\n\n## Methods to run analysis / produce output:\n\nHere is where instructions go for whatever is in this repo (how to run scripts, how to produce outputs, what ever is needed so that someone else can replicate your work)\n\n### Key Files Needed\n\nGive details of all inputs needed (e.g. data files) and where to find/source them\n\n### Dependencies / Requirements:\n\nWhich R packages? environment variables? database connections? etc? are needed\n\n### Procedure:\n\nDetail the operating procedures.\n\n## Expected Output:\n\nWhat is produced and where is it saved/stored?\n\n## Issues / Problems / Good to know...\n\nif any ....")
    write(readme_content, paste0(path, "/README.md"), append = TRUE)
  }

  #Create and save an R script in an R folder
  analysis_setup <- c("# load keyring package\nlibrary(keyring)\n\n#load path setting package\nlibrary(here)\n\n#load data wrangling packages\nlibrary(tidyverse)\nlibrary(data.table)")

  cat(analysis_setup, file = paste0(path, "/R/analysis.R"))

  ## open project
  usethis::create_project(path)
}


