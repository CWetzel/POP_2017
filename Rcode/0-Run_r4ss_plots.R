### Run r4ss and notes for making model comparison plots and editing plots
### Originally developed for the 2015 China Rockfish assessment document, 
### which had three independent assessment models (South of 40-10, 
### 40-10 through OR, and WA). Written for up to 3 assessment models
### Even if you only have 1 assessment model, it will be called mod1 throughout
### 
### Section 1: run r4ss and create plots
###
### Section 2: save the entire myreplist and mod_structure files from r4ss as csv's
###
### Section 3: Copy csv files from working assessment folder into the txt folder 
### within the github directory
# =============================================================================

# start fresh here - this script is separate from the script for the assessment
# document
rm(list=ls(all=TRUE))

# What model file to use
model.file = "Model_2017"
# Cannot change the name below without changing it throughout the Assessment_template file
model.plots = "plots_mod1" #paste0("plot_",model.file)
covar = TRUE

# Give the names of the data and control files, for each model
# Used in the SS_files_linebreaks.R
mod1_dat = "data.ss"

# Control file names 
mod1_ctrl = "control.ss"


#=====================================================================================
# SECTION1: Run r4ss, parse plotInfoTable.csv file, & add linebreaks to SS files
#=====================================================================================

#stop("\n  This file should not be sourced!") # note to stop from accidental sourcing

# Here we're going to make sure you have all the required packages for the template
# Check for installtion and make sure all R libraries can be loaded
# xtable for creating tables, ggplot2 for plotting, reshape2 for melting
# dataframes, scales for printing percents
# You may have to manually install knitr - reason unknown!

requiredPackages = c('xtable', 'ggplot2', 'reshape2', 'scales', 'rmarkdown', 'knitr', 'devtools')
for(p in requiredPackages){
  if(!require(p,character.only = TRUE)) install.packages(p)
  library(p,character.only = TRUE)
}

# Install the latest version of r4ss using devtools
# devtools::install_github("r4ss/r4ss")
library(r4ss)

# CHANGE values in this section ===============================================

# number of assessment models - this is run before the R_preamble.R, which also
# contains this value
 n_models = 1
 

# By default, you can only work in the directory containing the project
# Set the directory here if you're getting errors
# setwd('C:/Assessment_template')
setwd('C:/Users/Chantel.Wetzel/Documents/GitHub/POP_2017')


# =============================================================================

# set input and output directories
input.dir = file.path(getwd(), 'SS')
output.dir = file.path(getwd(), 'r4ss')

# IF the r4SS subdirectories don't exist, create them
# Once you have your own SS files and want to save these plots
# Uncomment the /r4SS/ in the .gitignore file
#dir.create(file.path(output.dir,'plots_mod1'), showWarnings = FALSE)
dir.create(file.path(output.dir,model.plots), showWarnings = FALSE)


# BEGIN r4ss===================================================================
# REMOVE OLD r4SS OUTPUT!!!!! -------------------------------------------------
# Run this deliberately - it deletes the r4SS output plots files
do.call(file.remove, list(list.files(file.path(output.dir, model.plots), full.names=TRUE)))


# Run r4ss for each model - **CHANGE DIRECTORY if necessary**
mod1 = SS_output(dir = file.path(input.dir,model.file), forecast=T, covar=covar, ncol=1000, printstats = FALSE)


# Save the workspace an image
save.image('./r4ss/SS_output.RData')



#=====================================================================================
# SECTION 2: RUN r4ss plots for each model & save files
#=====================================================================================
# output directories
#out.dir.mod1 = file.path(output.dir,'plots_mod1')
out.dir.mod1 = file.path(output.dir,model.plots)

# Model 1
SS_plots(mod1,
         png = TRUE,
         html = FALSE,
         datplot = TRUE,
         uncertainty = covar,
         maxrows = 6, 
         maxcols = 6, 
         maxrows2 = 4, 
         maxcols2 = 4, 
         printfolder = '', 
         dir = out.dir.mod1)


# -----------------------------------------------------------------------------

# Run the code to parse the plotInfoTable files
source('./Rcode/Parse_r4ss_plotInfoTable.R')

# -----------------------------------------------------------------------------

# Create the SS files for the appendices
source('./Rcode/SS_files_linebreaks.R')

#=====================================================================================
# SECTION 3: Move CSV files from working directory to github directory
#=====================================================================================

HomeDir = "C:/Assessments/POP2017/WriteUp/Tables/"
files = dir(HomeDir)
for (i in 1:length(files)){
  file.copy(paste0(HomeDir,files[i]),
            paste0(getwd(), "/txt_files"), overwrite = TRUE)
}

# Copy and move files from other locations
file.copy("C:/Assessments/POP2017/Data/CommercialCatch/POP2017_PacFIN_catch_forExpansion.csv", 
          paste0(getwd(), "/txt_files"), overwrite = TRUE)


