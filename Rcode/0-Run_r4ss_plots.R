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

model.num = "15.0"

# What model file to use
model.file = "model_2017"
# Cannot change the name below without changing it throughout the Assessment_template file
model.plots = "plots_mod1" #paste0("plot_",model.file)
covar = TRUE

# Give the names of the data and control files, for each model
# Used in the SS_files_linebreaks.R
mod1_dat = "2017pop.dat" #"data.ss"

# Control file names 
mod1_ctrl = "2017pop.ctl" #"control.ss"


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
# r4ss sha # 06b8250
# devtools::install_github("r4ss/r4ss", ref = '1.27.0', force = TRUE)
library(r4ss)

# CHANGE values in this section ===============================================

# number of assessment models - this is run before the R_preamble.R, which also
# contains this value
 n_models = 1
 

# By default, you can only work in the directory containing the project
# Set the directory here if you're getting errors
# setwd('C:/Assessment_template')
if (Sys.info()["user"] == "Chantel.Wetzel") {
  setwd('C:/Users/Chantel.Wetzel/Documents/GitHub/POP_2017')
}


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
do.call(file.remove, list(list.files(file.path(output.dir, model.plots), 
  full.names=TRUE, pattern = "!Thumb")))


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
fleets = c("Fishery", "At-sea hake", "Foreign", "Pacific ocean perch survey", "Triennial shelf survey", "AFSC slope survey", "NWFSC slope survey", "NWFSC shelf-slope survey")

# Model 1
SS_plots(mod1,
         png = TRUE,
         html = FALSE,
         datplot = TRUE,
         uncertainty = covar,
         fleetnames = fleets,
         maxrows = 4, 
         maxcols = 4, 
         maxrows2 = 4, 
         maxcols2 = 4, 
         printfolder = '',
         bub.scale.dat= 6,
         dir = out.dir.mod1)



# Create specialized plots
pngfun <- function(file,w=7,h=7,pt=12){
  file <- file.path(out.dir.mod1, file)
  cat('writing PNG to',file,'\n')
  png(filename=file,
      width=w,height=h,
      units='in',res=300,pointsize=pt)
}

pngfun('POP_unavailable_biomass.png',h=8.5)
SSunavailableSpawningOutput(mod1, plot=TRUE)
dev.off()

pngfun('POP_index_data.png',h=8.5)
par(mfrow=c(2,2),mar=c(2,2,2,1),oma=c(2,2,0,0)+.1)
for(a in 1:4){
  f = c(4,6,7,8)[a]
  SSplotIndices(mod1,fleets=f,subplot=1,datplot=TRUE,fleetnames=fleets)
}
mtext(side=1,line=1,outer=TRUE,'Year')
mtext(side=2,line=1,outer=TRUE,'Index')
dev.off()

# index fits
pngfun('POP_index_fits.png',h=8.5)
par(mfrow=c(2,2),mar=c(2,2,2,1),oma=c(2,2,0,0)+.1)
for(a in 1:4){
  f = c(4,6,7,8)[a]
  SSplotIndices(mod1, fleets=f, subplot=2, fleetnames=fleets)
}
mtext(side=1,line=1,outer=TRUE,'Year')
mtext(side=2,line=1,outer=TRUE,'Index')
dev.off()

# index fits
pngfun('POP_index_fits_alt.png',h=5, w=6)
par(mfrow=c(2,3),mar=c(2,2,2,1),oma=c(2,2,0,0)+.1)
for(a in 1:6){
  f = c(1, 4:8)[a]
  SSplotIndices(mod1, fleets=f, subplot=2, fleetnames=fleets)
}
mtext(side=1,line=1,outer=TRUE,'Year')
mtext(side=2,line=1,outer=TRUE,'Index')
dev.off()

# discard fits
pngfun('POP_discard_fits.png')
par(mfcol=c(1,1),mar=c(2,2,2,1),oma=c(2,2,0,0)+.1)
for(f in 1:1){
  SSplotDiscard(mod1, fleets=f,subplot=2,fleetnames=fleets, datplot = TRUE)
}
mtext(side=1,line=1,outer=TRUE,'Year')
mtext(side=2,line=1,outer=TRUE,'Discard fraction')
dev.off()

# discard without fits
pngfun('POP_discard_data.png')
par(mfcol=c(1,1),mar=c(2,2,2,1),oma=c(2,2,0,0)+.1)
for(f in 1:1){
  SSplotDiscard(mod1, fleets=f,subplot=1,fleetnames=fleets, datplot = TRUE)
}
mtext(side=1,line=1,outer=TRUE,'Year')
mtext(side=2,line=1,outer=TRUE,'Discard fraction')
dev.off()

### biology stuff
# see function maturity/SST_maturity_notes.R
pngfun('POP_weight_vs_fecundity.png',h=5,w=6.5)
par(mar=c(5,4,1,1))
plot(0, type='n', ylim=c(0,2.1),xlim=c(10,50),xaxs='r',axes=FALSE,
     xlab='Length (cm)',ylab="Weight or  Fecundity x Maturity")
abline(h=0,col='grey')
lines(mod1$biology$Mean_Size, mod1$biology$Wt_len_F,
      type='o', lwd=3, pch=16, col=1)
lines(mod1$biology$Mean_Size, mod1$biology$Spawn,
      type='o', lwd=3, pch=16, col=2, lty=2, ylim=c(0,3),xlim=c(0,50))
legend('topleft',lwd=3,pch=16,col=1:2,c("Weight","Fecundity x Maturity"),lty=1:2, bty = 'n')
axis(1)
axis(2)
box()
dev.off()

#test <- SSplotSelex(mod1, fleets=1:2, fleetnames=fleets, subplot=1, year = c(1999, 2016))
#test$infotable$longname = c("Fishery & Foreign 1981-1999", "Fishery 2000-2016", "At-sea hake")
#test$infotable = rbind(test$infotable[1,], test$infotable[3,], test$infotable[2,])
#test$infotable$col <- rich.colors.short(5)[c(1:3)]
#test1 <- SSplotSelex(mod1, fleets=1, fleetnames=fleets[1], subplot=1, year = 1999)
#test1$infotable$col <- rich.colors.short(5)[c(1)]
#test2 <- SSplotSelex(mod1, fleets=4:8, fleetnames=fleets, subplot=1)
#
#pngfun("POP_selectivity.png")
#par(mfrow=c(2,1),mar=c(2,4,3,1))
#SSplotSelex(mod1, fleets=1:3, infotable=test$infotable, subplot=1, legendloc='topleft', showmain=FALSE, fleetlty = c(1,2,1))
#grid()
#par(mar=c(4,4,1,1))
#SSplotSelex(mod1,fleets=4:8,infotable=test2$infotable,subplot=1,legendloc='topleft',showmain=FALSE)
#grid()
#dev.off()

test <- SSplotSelex(mod1, fleets=1, fleetnames=fleets, subplot=1, year = c(1999, 2016))
test$infotable$longname = c("Fishery & Foreign 1981-1999", "Fishery 2000-2016")
test$infotable$col <- rich.colors.short(8)[c(1,1)]
test1 <- SSplotSelex(mod1, fleets=2, fleetnames=fleets, subplot=1)
test1$infotable$col <- "red"
test2 <- SSplotSelex(mod1, fleets=c(4:6), fleetnames=fleets, subplot=1)
test2$infotable$col <- c("blue", "grey", "green")#rich.colors.short(8)[c(4,6)]
test3 <- SSplotSelex(mod1, fleets=7:8, fleetnames=fleets, subplot=1)
test3$infotable$col <- c("red", "orange")#rich.colors.short(8)[c(7:8)]

pngfun("POP_selectivity_with_Tri.png")
par(mfrow=c(2,2),mar=c(2,4,3,1))
#SSplotSelex(mod1, fleets = 1:3, infotable = test$infotable, subplot = 1, showmain = FALSE, legendloc= 'topleft')
SSplotSelex(mod1, fleets=1,  infotable=test$infotable, subplot=1, legendloc='topleft', showmain=FALSE, year = c(1999, 2016))
grid()
SSplotSelex(mod1, fleets=2, infotable=test1$infotable, subplot=1, legendloc='topleft',showmain=FALSE)
legend("topleft", legend = "At-sea hake", col = "red", lwd =2, lty = 1, pch = 16, bty = 'n')
grid()
SSplotSelex(mod1, fleets=c(4,5,6), infotable=test2$infotable,subplot=1, legendloc='topleft',showmain=FALSE)
grid()
#par(mar=c(4,4,1,1))
SSplotSelex(mod1,fleets=7:8,infotable=test3$infotable,subplot=1,legendloc='topleft',showmain=FALSE)
grid()
dev.off()


ret = mod1$sizeselex[mod1$sizeselex$Fleet == 1, ]
ret = ret[ret$Factor == "Ret", ]
col.vec = c("red", "blue", "orange2", "green", "purple", "darkgrey")

pngfun("POP_retention.png")
plot(5.5:50.5, ret[1, 6:dim(ret)[2]], col = col.vec[1], type = 'l', ylab = "Retention", xlab = "Length (cm)", lwd = 2)
points(5.5:50.5, ret[1, 6:dim(ret)[2]], pch = 1, col = col.vec[1])
lines(5.5:50.5, ret[5, 6:dim(ret)[2]], col = col.vec[2], lty = 1, lwd = 2)
points(5.5:50.5, ret[5, 6:dim(ret)[2]], pch = 2, col = col.vec[2])
lines(5.5:50.5, ret[14, 6:dim(ret)[2]], col = col.vec[3], lty = 1, lwd = 2)
points(5.5:50.5, ret[14, 6:dim(ret)[2]], pch = 3, col = col.vec[3])
lines(5.5:50.5, ret[18, 6:dim(ret)[2]], col = col.vec[4], lty = 1, lwd = 2)
points(5.5:50.5, ret[18, 6:dim(ret)[2]], pch = 4, col = col.vec[4])
lines(5.5:50.5, ret[19, 6:dim(ret)[2]], col = col.vec[5], lty = 1, lwd = 2)
points(5.5:50.5, ret[19, 6:dim(ret)[2]], pch = 5, col = col.vec[5])
lines(5.5:50.5, ret[24, 6:dim(ret)[2]], col = col.vec[6], lty = 1, lwd = 2)
points(5.5:50.5, ret[24, 6:dim(ret)[2]], pch = 6, col = col.vec[6])
legend ("topleft", legend = c("1918-1991", "1992-2001", "2002-2007", "2008", "2009-2010", "2011-2017"),
        col = col.vec, pch = 1:6,lty = 1, lwd = 2, bty = 'n')
grid()
dev.off()

# Fit bias ramp
SS_fitbiasramp (mod1,  method="BFGS", twoplots=FALSE,
           transform=FALSE, print=TRUE, plotdir=out.dir.mod1 ,shownew=FALSE,
           pwidth=6.5, pheight=5.0, punits="in", ptsize=10, res=300, cex.main=1)


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

# Copy and move figures from assessment folder
figures = c(
            paste0("C:/Assessments/POP2017/Models/_Sensitivities/", model.num, "/depl_sens1.png"),
            paste0("C:/Assessments/POP2017/Models/_Sensitivities/", model.num, "/depl_sens2.png"),
            paste0("C:/Assessments/POP2017/Models/_Sensitivities/", model.num, "/ssb_sens1.png"),
            paste0("C:/Assessments/POP2017/Models/_Sensitivities/", model.num, "/ssb_sens2.png"),
            paste0("C:/Assessments/POP2017/Models/_Retro/", model.num, "/compare2_spawnbio_uncertainty.png"),
            paste0("C:/Assessments/POP2017/Models/_Retro/", model.num, "/compare4_Bratio_uncertainty.png"),
            paste0("C:/Assessments/POP2017/Models/_Retro/", model.num, "/compare10_recdevs_uncertainty.png"),
            "C:/Assessments/POP2017/Models/_bridging/bridging.png",
            "C:/Assessments/POP2017/Data/Biological/plots/allSexRatios.png",
            "C:/Assessments/POP2017/Data/Biological/plots/allSexRatiosAge.png",
            "C:/Assessments/POP2017/Data/Biological/plots/weightAtLengthBySource.png",
            "C:/Assessments/POP2017/Data/Biological/plots/weightAtLengthPred.png",
            "C:/Assessments/POP2017/Data/Biological/plots/LengthAgeAll.png",
            "C:/Assessments/POP2017/Data/Maturity_Fecundity/Functional_Maturity.png",
            "C:/Assessments/POP2017/Data/Maturity_Fecundity/Maturity_Comparison.png", 
            "C:/Assessments/POP2017/Data/AgeingError/Ageing_Error.png",
            "C:/Assessments/POP2017/Models/_bridging/bridging.png",
            "C:/Assessments/POP2017/Data/SurveyIndices/Index_Comparison.png",
            "C:/Assessments/POP2017/Data/Maturity_Fecundity/Fecundity_Comparison.png",
            "C:/Assessments/POP2017/Data/SurveyIndices/Index_Data.png",
            "C:/Assessments/POP2017/Data/CommercialCatch/Catch_Comparison.png",
            paste0("C:/Assessments/POP2017/Models/_Profiles/h_profiles/", model.num, "_pop_base/piner_panel_h.png"),
            paste0("C:/Assessments/POP2017/Models/_Profiles/h_profiles/", model.num, "_pop_base/h_trajectories.png"),
            paste0("C:/Assessments/POP2017/Models/_Profiles/m_profiles/", model.num, "_pop_base/piner_panel_m.png"),
            paste0("C:/Assessments/POP2017/Models/_Profiles/m_profiles/", model.num, "_pop_base/m_trajectories.png"),
            paste0("C:/Assessments/POP2017/Models/_Profiles/R0_profiles/", model.num, "_pop_base/piner_panel_R0.png")
            )

for (i in 1:length(figures)){
  file.copy(figures[i], paste0(getwd(), "/Figures"), overwrite = TRUE)
}

#=====================================================================================
# SECTION 4: Create Numbers at Age Table
#=====================================================================================
base      <- readLines( paste0(getwd(),"/SS/", model.file, "/Report.sso"))

# First and last years of model model 1
startyr = mod1$startyr # year model 1 data starts 
endyr   = mod1$endyr   # year model 1 data ends

maxAge = length(strsplit(base[grep(paste("1 1 1 1 1 1 1", startyr,sep=" "),base)]," ")[[1]]) - 14


temp = mapply(function(x) temp = as.numeric(strsplit(base[grep(paste("1 1 1 1 1 1 1", x,sep=" "),base)]," ")[[1]][14:(14+maxAge)]), x = startyr:endyr)
natage.f = t(temp) 
temp = mapply(function(x) temp = as.numeric(strsplit(base[grep(paste("1 1 2 1 1 1 2", x,sep=" "),base)]," ")[[1]][14:(14+maxAge)]), x = startyr:endyr)
natage.m = t(temp) 

colnames(natage.f) = 0:maxAge; colnames(natage.m) = 0:maxAge		
rownames(natage.f) <- startyr:endyr ; rownames(natage.m) <- startyr:endyr

write.csv(natage.f, paste0(getwd(), "/txt_files/POP_natage_f.csv"))
write.csv(natage.m, paste0(getwd(), "/txt_files/POP_natage_m.csv"))	


#=====================================================================================
# SECTION 5: Functions
#=====================================================================================

print.numeric<-function(x, digits) { formatC(x, digits = digits, format = "f") }
comma <- function(x, digits=0) { formatC(x, big.mark=",", digits, format = "f") }



