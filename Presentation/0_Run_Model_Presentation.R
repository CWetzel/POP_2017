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

pngfun <- function(file,w=7,h=7,pt=12){
  file <- file.path(output.dir, file)
  cat('writing PNG to',file,'\n')
  png(filename=file,
      width=w,height=h,
      units='in',res=300,pointsize=pt)
}

pngfun('POP_Landings_Discards.png',h=8.5)
fishery = mod1$catch[mod1$catch$Fleet==1, ]
plot(fishery$Yr, fishery$Obs, lwd = 2, type = 'l', col= 1, ylab = "Fishery Landings (mt)", xlab = "Year")
lines(fishery$Yr, (fishery$kill_bio-fishery$ret_bio), lwd = 2, lty = 2, col = 'red')
legend("topright", legend = c("Landings", "Discards"), col = c(1, 'red'), lwd = 2, lty = c(1,2), bty = 'n')
dev.off()

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
            "C:/Assessments/POP2017/Models/_Data/Data_spawnbio_uncertainty.png",
            "C:/Assessments/POP2017/Models/_Data/Data_Bratio_uncertainty.png",
            "C:/Assessments/POP2017/Models/2011_2017_Bratio.png",
            "C:/Assessments/POP2017/Models/_Sensitivities/12.0/present_plots/Bratio_sensitivites_1.png",
            "C:/Assessments/POP2017/Models/_Sensitivities/12.0/present_plots/SSB_sensitivities_1.png",
            "C:/Assessments/POP2017/Models/_Sensitivities/12.0/present_plots/Bratio_indices.png",
            "C:/Assessments/POP2017/Models/_Sensitivities/12.0/present_plots/SSB_indices.png",
            "C:/Assessments/POP2017/Data/SurveyIndices/Index_Comparison.png",
            "C:/Assessments/POP2017/Data/SurveyIndices/Index_DesignBased_Comparison.png",
            "C:/Assessments/POP2017/Data/SurveyIndices/NWFSC_shelf_slope_2011_2017.png"
            )

for (i in 1:length(figures)){
  file.copy(figures[i], paste0(wd, "/Presentation/figures"), overwrite = TRUE)
}

# Rename figures
#=====================================================================================================
PresDir = 'C:/Users/Chantel.Wetzel/Documents/GitHub/POP_2017/Presentation/r4ss'

figures = c("comp_lenfit_data_weighting_TA1.8_NWFSC slope survey.png",
            "comp_lenfit_data_weighting_TA1.8_NWFSC shelf-slope survey.png",
            "comp_lenfit_data_weighting_TA1.8_AFSC slope survey.png",
            "comp_lenfit_data_weighting_TA1.8_Pacific ocean perch survey.png",
            "comp_lenfit_data_weighting_TA1.8_Triennial shelf survey.png",
            "comp_lenfit_data_weighting_TA1.8_Fishery.png",
            "comp_lenfit_data_weighting_TA1.8_At-sea hake.png",
            "comp_agefit_data_weighting_TA1.8_NWFSC slope survey.png",
            "comp_condAALfit_data_weighting_TA1.8_condAgeNWFSC shelf-slope survey.png",
            "comp_agefit_data_weighting_TA1.8_Pacific ocean perch survey.png",
            "comp_agefit_data_weighting_TA1.8_Triennial shelf survey.png",
            "comp_agefit_data_weighting_TA1.8_Fishery.png",
            "comp_agefit_data_weighting_TA1.8_At-sea hake.png",
            "index1_cpuedata_Triennial shelf survey.png",
            "index1_cpuedata_Pacific ocean perch survey.png",
            "index1_cpuedata_NWFSC slope survey.png",
            "index1_cpuedata_AFSC slope survey.png",
            "index1_cpuedata_NWFSC shelf-slope survey.png")

new.name = c("comp_lenfit_data_weighting_TA18_NWFSC_slope_survey.png",
            "comp_lenfit_data_weighting_TA18_NWFSC_shelf-slope_survey.png",
            "comp_lenfit_data_weighting_TA18_AFSC_slope_survey.png",
            "comp_lenfit_data_weighting_TA18_Pacific_ocean_perch_survey.png",
            "comp_lenfit_data_weighting_TA18_Triennial_shelf_survey.png",
            "comp_lenfit_data_weighting_TA18_Fishery.png",
            "comp_lenfit_data_weighting_TA18_At-sea_hake.png",
            "comp_agefit_data_weighting_TA18_NWFSC_slope_survey.png",
            "comp_condAALfit_data_weighting_TA18_condAgeNWFSC_shelf-slope_survey.png",
            "comp_agefit_data_weighting_TA18_Pacific_ocean_perch_survey.png",
            "comp_agefit_data_weighting_TA18_Triennial_shelf_survey.png",
            "comp_agefit_data_weighting_TA18_Fishery.png",
            "comp_agefit_data_weighting_TA18_At-sea_hake.png",
            "index1_cpuedata_Triennial_shelf_survey.png",
            "index1_cpuedata_Pacific_ocean_perch_survey.png",
            "index1_cpuedata_NWFSC_slope_survey.png",
            "index1_cpuedata_AFSC_slope_survey.png",
            "index1_cpuedata_NWFSC_shelf-slope_survey.png")



setwd(PresDir)
for(i in 1:length(figures)){
  file.rename(figures[i], new.name[i])
}
            


#======================================================================================================
} # Close function