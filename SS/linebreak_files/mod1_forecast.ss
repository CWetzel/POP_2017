#V3.30.0.0-trans
# for all year entries except rebuilder; enter either: actual year, -999 fo
# r styr, 0 for endyr, neg number for rel. endyr
1 # Benchmarks: 0=skip; 1=calc F_spr,F_btgt,F_msy 
2 # MSY: 1= set to F(SPR); 2=calc F(MSY); 3=set to F(Btgt); 4=set to F(endy
# r) 
0.5 # SPR target (e.g. 0.40)
0.4 # Biomass target (e.g. 0.40)
#_Bmark_years: beg_bio, end_bio, beg_selex, end_selex, beg_relF, end_relF, 
# beg_recr_dist, end_recr_dist, beg_SRparm, end_SRparm (enter actual year, 
# or values of 0 or -integer to be rel. endyr)
 2005 2008 2005 2008 2005 2008 1940 2010 1940 2010
2 #Bmark_relF_Basis: 1 = use year range; 2 = set relF same as forecast belo
# w
#
1 # Forecast: 0=none; 1=F(SPR); 2=F(MSY) 3=F(Btgt); 4=Ave F (uses first-las
# t relF yrs); 5=input annual F scalar
12 # N forecast years 
1 # F scalar (only used for Do_Forecast==5)
#_Fcast_years:  beg_selex, end_selex, beg_relF, end_relF, beg_recruits, end
# _recruits  (enter actual year, or values of 0 or -integer to be rel. endy
# r)
 2005 2008 2005 2008 -999 0
#  2005 2008 2005 2008 1940 2010 # after processing 
1 # Control rule method (1=catch=f(SSB) west coast; 2=F=f(SSB) ) 
0.4 # Control rule Biomass level for constant F (as frac of Bzero, e.g. 0.4
# 0); (Must be > the no F level below) 
0.1 # Control rule Biomass level for no F (as frac of Bzero, e.g. 0.10) 
1 # Control rule target as fraction of Flimit (e.g. 0.75) 
3 #_N forecast loops (1=OFL only; 2=ABC; 3=get F from forecast ABC catch wi
# th allocations applied)
3 #_First forecast loop with stochastic recruitment
-1 #_Forecast loop control #3 (reserved for future bells&whistles) 
0 #_Forecast loop control #4 (reserved for future bells&whistles) 
0 #_Forecast loop control #5 (reserved for future bells&whistles) 
2013  #FirstYear for caps and allocations (should be after years with fixed
#  inputs) 
0 # stddev of log(realized catch/target catch) in forecast (set value>0.0 t
# o cause active impl_error)
0 # Do West Coast gfish rebuilder output (0/1) 
2001 # Rebuilder:  first year catch could have been set to zero (Ydecl)(-1 
# to set to 1999)
2011 # Rebuilder:  year for current age structure (Yinit) (-1 to set to end
# year+1)
1 # fleet relative F:  1=use first-last alloc year; 2=read seas(row) x flee
# t(col) below
# Note that fleet allocation is used directly as average F if Do_Forecast=4
#  
2 # basis for fcast catch tuning and for fcast catch caps and allocation  (
# 2=deadbio; 3=retainbio; 5=deadnum; 6=retainnum)
# Conditional input if relative F choice = 2
# Fleet relative F:  rows are seasons, columns are fleets
#_Fleet:  Fishery POP EarlyTriennial LateTriennial AFSCSlope NWFSCSlope NWF
# SCcombo
#  1 0 0 0 0 0 0
# enter list of fleet number and max for fleets with max annual catch; term
# inate with fleet=-9999
-9999 -1
# enter list of area ID and max annual catch; terminate with area=-9999
-9999 -1
# enter list of fleet number and allocation group assignment, if any; termi
# nate with fleet=-9999
1 1
-9999 -1
#_if N allocation groups >0, list year, allocation fraction for each group 
# list sequentially because read values fill to end of N forecast
# terminate with -9999 in year field 
2011  1
 -9999  1 
2 # basis for input Fcast catch: -1=read basis with each obs; 2=dead catch;
#  3=retained catch; 99=input Hrate(F)
#enter list of Fcast catches; terminate with line having year=-9999
#_Year Seas Fleet Catch(or_F)
 2011 1 1 180
 2012 1 1 183
-9999 1 1 0 
#
999 # verify end of input 