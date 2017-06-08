#####################################################
#     Base R code for POP presentation
#####################################################

Run.Model.Present <- function(create.plots){

rm(list=ls(all=TRUE))
  
spp = 'Pacific ocean perch' 
spp.sci = 'Sebastes alutus'

model.num = "12.0"

# What model file to use
model.file = "model_2017"
model.plots = "plots_mod1" 

requiredPackages = c('xtable', 'ggplot2', 'reshape2', 'scales', 'rmarkdown', 'knitr', 'devtools')
for(p in requiredPackages){
  if(!require(p,character.only = TRUE)) install.packages(p)
  library(p,character.only = TRUE)
}

# Install the latest version of r4ss using devtools
# devtools::install_github("r4ss/r4ss")
library(r4ss)

wd = 'C:/Users/Chantel.Wetzel/Documents/GitHub/POP_2017'


# =============================================================================

# set input and output directories
input.dir = paste0(wd, '/SS')
output.dir = paste0(wd, '/Presentation/figures')

dir.create(output.dir, showWarnings = FALSE)

# ==============================================================================



if (create.plots){
  
# Run r4ss for each model 
mod1 = SS_output(dir = file.path(input.dir, model.file), ncol=1000, printstats = FALSE)
save.image(paste0(wd,'/Presentation/SS_output.RData'))   
  
#fleets = c("Fishery", "At-sea hake", "Foreign", "Pacific ocean perch survey", "Triennial survey", "AFSC slope survey", "NWFSC slope survey", "NWFSC shelf-slope survey")
# Model 1
#SS_plots(mod1,
#         png = TRUE,
#         html = FALSE,
#         datplot = TRUE,
#         fleetnames = fleets,
#         maxrows = 4, 
#         maxcols = 4, 
#         maxrows2 = 4, 
#         maxcols2 = 4, 
#         printfolder = '',
#         bub.scale.dat= 7,
#         dir = output.dir)
  PlotDir = 'C:/Users/Chantel.Wetzel/Documents/GitHub/POP_2017/r4ss/plots_mod1/'
  files = dir(PlotDir)
  dir.create(paste0(wd, "/Presentation/r4ss"))
  for (i in 1:length(files)){
    file.copy(paste0(PlotDir,files[i]),
              paste0(wd, "/Presentation/r4ss"), overwrite = TRUE)
  }
}

if (!create.plots){
  # Save the workspace an image
  load(paste0(wd,'/Presentation/SS_output.RData')) }

# Load in other figures
# =============================================================================
HomeDir = 'C:/Users/Chantel.Wetzel/Documents/GitHub/POP_2017/Figures/'
files = dir(HomeDir)
for (i in 1:length(files)){
  file.copy(paste0(HomeDir,files[i]),
            paste0(wd, "/Presentation/figures"), overwrite = TRUE)
}

figures = c(
            "C:/Assessments/POP2017/Data/Biological/plots/LengthAgeAll.png",
            "C:/Assessments/POP2017/Data/Biological/plots/LengthAgeAll_2.png",
            "C:/Assessments/POP2017/Data/Biological/plots/LengthAgeEach.png",
            "C:/Assessments/POP2017/Data/Biological/plots/weightAtLengthPred.png",
            "C:/Assessments/POP2017/Data/Biological/plots/pop2017_agesbysource.png",
            "C:/Assessments/POP2017/Data/CommercialCatch/Plots/pop2017_2011vs2017catches_states.png",
            "C:/Assessments/POP2017/Models/_Data/compare2_spawnbio_uncertainty.png",
            "C:/Assessments/POP2017/Models/_Data/compare4_Bratio_uncertainty.png",
            "C:/Assessments/POP2017/Models/2011_2017_Bratio.png"
            )

for (i in 1:length(figures)){
  file.copy(figures[i], paste0(wd, "/Presentation/figures"), overwrite = TRUE)
}


#==============================================================================
} # Close function