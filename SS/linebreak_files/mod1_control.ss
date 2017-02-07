#V3.30.0.0-trans
#_data_and_control_files: POP_data.SS // POP_control.SS
#_SS-V3.30.0.0-trans;_2016_10_13;_Stock_Synthesis_by_Richard_Methot_(NOAA)_
# using_ADMB_11.2
#_SS-V3.30.0.0-trans;user_support_available_at:NMFS.Stock.Synthesis@noaa.go
# v
#_SS-V3.30.0.0-trans;user_info_available_at:https://vlab.ncep.noaa.gov/grou
# p/stock-synthesis
0  # 0 means do not read wtatage.ss; 1 means read and use wtatage.ss and al
# so read and use growth parameters
1  #_N_Growth_Patterns
1 #_N_platoons_Within_GrowthPattern 
#_Cond 1 #_Morph_between/within_stdev_ratio (no read if N_morphs=1)
#_Cond  1 #vector_Morphdist_(-1_in_first_val_gives_normal_approx)
#
1 # recr_dist_method for parameters:  1=like 3.24; 2=main effects for GP, S
# ettle timing, Area; 3=each Settle entity; 4=none when N_GP*Nsettle*pop==1
1 # Recruitment: 1=global; 2=by area (future option)
1 #  number of recruitment settlement assignments 
0 # year_x_area_x_settlement_event interaction requested (only for recr_dis
# t_method=1)
#GPat month  area age (for each settlement assignment)
 1 1 1 0
#
#_Cond 0 # N_movement_definitions goes here if N_areas > 1
#_Cond 1.0 # first age that moves (real age at begin of season, not integer
# ) also cond on do_migration>0
#_Cond 1 1 1 2 4 10 # example move definition for seas=1, morph=1, source=1
#  dest=2, age1=4, age2=10
#
2 #_Nblock_Patterns
 5 1 #_blocks_per_pattern 
# begin and end years of blocks
 1940 1981 1982 1988 1989 1994 1995 2007 2009 2009
 1939 1939
#
# controls for all timevary parameters 
1 #_env/block/dev_adjust_method for all time-vary parms (1=warn relative to
#  base parm bounds; 3=no bound check)
1 ## 0 means to autogenerate time-varying parameters; 1 means to read each 
# time-varying parameter line
#
# setup for M, growth, maturity, fecundity, recruitment distibution, moveme
# nt 
#
0 #_natM_type:_0=1Parm; 1=N_breakpoints;_2=Lorenzen;_3=agespecific;_4=agesp
# ec_withseasinterpolate
  #_no additional input for selected M option; read 1P per morph
1 # GrowthModel: 1=vonBert with L1&L2; 2=Richards with L1&L2; 3=age_specifi
# c_K; 4=not implemented
3 #_Growth_Age_for_L1
25 #_Growth_Age_for_L2 (999 to use as Linf)
-999 #_exponential decay for growth above maxage (fixed at 0.2 in 3.24; val
# ue should approx initial Z; -999 replicates 3.24)
0  #_placeholder for future growth feature
0 #_SD_add_to_LAA (set to 0.1 for SS2 V1.x compatibility)
0 #_CV_Growth_Pattern:  0 CV=f(LAA); 1 CV=F(A); 2 SD=F(LAA); 3 SD=F(A); 4 l
# ogSD=F(A)
3 #_maturity_option:  1=length logistic; 2=age logistic; 3=read age-maturit
# y matrix by growth_pattern; 4=read age-fecundity; 5=read fec and wt from 
# wtatage.ss
#_Age_Maturity by growth pattern
 0 0 0 0 0 0.24 0.49 0.73 0.89 0.95 0.91 0.85 0.81 0.84 0.89 0.94 0.96 0.95
 0.94 0.94 0.94 0.95 0.95 0.98 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
5 #_First_Mature_Age
3 #_fecundity option:(1)eggs=Wt*(a+b*Wt);(2)eggs=a*L^b;(3)eggs=a*Wt^b; (4)e
# ggs=a+b*L; (5)eggs=a+b*W
0 #_hermaphroditism option:  0=none; 1=female-to-male age-specific fxn; -1=
# male-to-female age-specific fxn
2 #_parameter_offset_approach (1=none, 2= M, G, CV_G as offset from female-
# GP1, 3=like SS2 V1.x)
#
#_growth_parms
#_ LO HI INIT PRIOR PR_SD PR_type PHASE env_var&link dev_link dev_minyr dev
# _maxyr dev_PH Block Block_Fxn
 0.02 0.1 0.05 -2.81 0.31 0 -2 0 0 0 0 0 0 0 # NatM_p_1_Fem_GP_1
 15 25 21.211 22.2214 99 0 -3 0 0 0 0 0 0 0 # L_at_Amin_Fem_GP_1
 35 45 41.983 39.986 99 0 -2 0 0 0 0 0 0 0 # L_at_Amax_Fem_GP_1
 0.1 0.4 0.159 0.193718 99 0 -3 0 0 0 0 0 0 0 # VonBert_K_Fem_GP_1
 0.03 0.16 0.072 0.1 99 0 -5 0 0 0 0 0 0 0 # CV_young_Fem_GP_1
 0.03 0.16 0.064 0.1 99 0 -5 0 0 0 0 0 0 0 # CV_old_Fem_GP_1
 0 3 1.065e-005 1e-005 99 0 -50 0 0 0 0 0 0 0 # Wtlen_1_Fem
 2 4 3.08 3.05 99 0 -50 0 0 0 0 0 0 0 # Wtlen_2_Fem
 2 12 8 8 99 0 -50 0 0 0 0 0 0 0 # Mat50%_Fem
 -2 4 -2 -2 99 0 -50 0 0 0 0 0 0 0 # Mat_slope_Fem
 0 6 1.08643 1 99 0 -50 0 0 0 0 0 0 0 # Eggs_scalar_Fem
 -3 3 1.44 1 99 0 -50 0 0 0 0 0 0 0 # Eggs_exp_wt_Fem
 -1 1 0 0.05 0.1 6 2 0 0 0 0 0 0 0 # NatM_p_1_Mal_GP_1
 -1 1 0 0 99 0 -2 0 0 0 0 0 0 0 # L_at_Amin_Mal_GP_1
 -1 1 -0.059 0 99 0 -2 0 0 0 0 0 0 0 # L_at_Amax_Mal_GP_1
 -1 1 0.195 0 99 0 -2 0 0 0 0 0 0 0 # VonBert_K_Mal_GP_1
 -1 1 0.049 0 99 0 -2 0 0 0 0 0 0 0 # CV_young_Mal_GP_1
 -1 1 -0.189 0 99 0 -2 0 0 0 0 0 0 0 # CV_old_Mal_GP_1
 0 3 1.395e-005 1e-005 99 0 -50 0 0 0 0 0 0 0 # Wtlen_1_Mal
 2 4 3 3.05 99 0 -50 0 0 0 0 0 0 0 # Wtlen_2_Mal
 0 2 1 1 99 0 -50 0 0 0 0 0 0 0 # RecrDist_GP_1
 0 2 1 1 99 0 -50 0 0 0 0 0 0 0 # RecrDist_Area_1
 0 2 1 1 99 0 -50 0 0 0 0 0 0 0 # RecrDist_Bseas_1
 0 2 1 1 99 0 -50 0 0 0 0 0 0 0 # CohortGrowDev
 0.000001 0.999999 0.5 0.5  0.5 0 -99 0 0 0 0 0 0 0 # FracFemale_GP_1
#
#_no timevary MG parameters
#
#_seasonal_effects_on_biology_parms
 0 0 0 0 0 0 0 0 0 0 #_femwtlen1,femwtlen2,mat1,mat2,fec1,fec2,Malewtlen1,m
# alewtlen2,L1,K
#_ LO HI INIT PRIOR PR_SD PR_type PHASE
#_Cond -2 2 0 0 -1 99 -2 #_placeholder when no seasonal MG parameters
#
#_Spawner-Recruitment
3 #_SR_function: 2=Ricker; 3=std_B-H; 4=SCAA; 5=Hockey; 6=B-H_flattop; 7=su
# rvival_3Parm; 8=Shepard_3Parm
0  # 0/1 to use steepness in initial equ recruitment calculation
0  #  future feature:  0/1 to make realized sigmaR a function of SR curvatu
# re
#_      LO        HI      INIT     PRIOR   PR_SD   PR_type        PHASE env
# -var use_dev dev_mnyr dev_mxyr dev_PH   Block Blk_Fxn  #  parm_name
          5         20       10.2         10          5          0       1 
      0       0       0       0       0       0       0 # SR_LN(R0)
        0.2          1        0.4       0.78      0.165          0      -3 
      0       0       0       0       0       0       0 # SR_BH_steep
        0.5        1.2        0.7       0.76         99          0      -6 
      0       0       0       0       0       0       0 # SR_sigmaR
         -5          5          0          0         99          0     -50 
      0       0       0       0       0       0       0 # SR_regime
          0          2          0          1         99          0     -50 
      0       0       0       0       0       0       0 # SR_autocorr
1 #do_recdev:  0=none; 1=devvector; 2=simple deviations
1952 # first year of main recr_devs; early devs can preceed this era
2008 # last year of main recr_devs; forecast devs start in following year
1 #_recdev phase 
1 # (0/1) to read 13 advanced options
 1932 #_recdev_early_start (0=none; neg value makes relative to recdev_star
# t)
 3 #_recdev_early_phase
 5 #_forecast_recruitment phase (incl. late recr) (0 value resets to maxpha
# se+1)
 1 #_lambda for Fcast_recr_like occurring before endyr+1
 1954 #_last_early_yr_nobias_adj_in_MPD
 1970 #_first_yr_fullbias_adj_in_MPD
 2006 #_last_yr_fullbias_adj_in_MPD
 2009 #_first_recent_yr_nobias_adj_in_MPD
 0.875 #_max_bias_adj_in_MPD (-1 to override ramp and set biasadj=1.0 for a
# ll estimated recdevs)
 0 #_period of cycles in recruitment (N parms read below)
 -6 #min rec_dev
 6 #max rec_dev
 0 #_read_recdevs
#_end of advanced SR options
#
#_placeholder for full parameter lines for recruitment cycles
# read specified recr devs
#_Yr Input_value
#
# all recruitment deviations
#  1932E 1933E 1934E 1935E 1936E 1937E 1938E 1939E 1940E 1941E 1942E 1943E 
# 1944E 1945E 1946E 1947E 1948E 1949E 1950E 1951E 1952R 1953R 1954R 1955R 1
# 956R 1957R 1958R 1959R 1960R 1961R 1962R 1963R 1964R 1965R 1966R 1967R 19
# 68R 1969R 1970R 1971R 1972R 1973R 1974R 1975R 1976R 1977R 1978R 1979R 198
# 0R 1981R 1982R 1983R 1984R 1985R 1986R 1987R 1988R 1989R 1990R 1991R 1992
# R 1993R 1994R 1995R 1996R 1997R 1998R 1999R 2000R 2001R 2002R 2003R 2004R
#  2005R 2006R 2007R 2008R 2009F 2010F 2011F 2012F 2013F 2014F 2015F 2016F 
# 2017F 2018F 2019F 2020F 2021F 2022F
#  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 
# 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
#  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
# implementation error by year in forecast:  0 0 0 0 0 0 0 0 0 0 0 0
#
#Fishing Mortality info 
0.03 # F ballpark
1999 # F ballpark year (neg value to disable)
1 # F_Method:  1=Pope; 2=instan. F; 3=hybrid (hybrid is recommended)
0.95 # max F or harvest rate, depends on F_Method
# no additional F input needed for Fmethod 1
# if Fmethod=2; read overall start F value; overall phase; N detailed input
# s to read
# if Fmethod=3; read N iterations for tuning for Fmethod 3
#
#_initial_F_parms; count = 0
#_ LO HI INIT PRIOR PR_SD  PR_type  PHASE
#
# F rates by fleet
# Yr:  1940 1941 1942 1943 1944 1945 1946 1947 1948 1949 1950 1951 1952 195
# 3 1954 1955 1956 1957 1958 1959 1960 1961 1962 1963 1964 1965 1966 1967 1
# 968 1969 1970 1971 1972 1973 1974 1975 1976 1977 1978 1979 1980 1981 1982
#  1983 1984 1985 1986 1987 1988 1989 1990 1991 1992 1993 1994 1995 1996 19
# 97 1998 1999 2000 2001 2002 2003 2004 2005 2006 2007 2008 2009 2010 2011 
# 2012 2013 2014 2015 2016 2017 2018 2019 2020 2021 2022
# seas:  1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 
# 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
#  1 1 1 1 1 1 1 1 1 1 1 1 1
# Fishery 4.84199e-005 7.26323e-005 0.000129131 0.000460071 0.000807408 0.0
# 0122393 0.000966241 0.000821235 0.000878334 0.00230841 0.00336667 0.00411
# 439 0.009532 0.00701014 0.0101644 0.00788411 0.0128718 0.0111001 0.008745
# 29 0.00559562 0.00955652 0.0136026 0.0182034 0.0244749 0.0264725 0.034096
# 4 0.0875499 0.0719935 0.0478387 0.0105492 0.0127463 0.0113997 0.0111646 0
# .0158346 0.0137824 0.00789603 0.0101124 0.00976451 0.0134247 0.0109695 0.
# 0123827 0.0082166 0.00655471 0.00988296 0.0100495 0.00911351 0.00884385 0
# .00694901 0.00877564 0.00981575 0.00747975 0.00982887 0.00964857 0.008753
# 83 0.0073189 0.00666793 0.00617269 0.0050693 0.00505369 0.00405104 0.0010
# 5944 0.00210022 0.00119273 0.00106433 0.000967921 0.000507182 0.000569765
#
#_Q_setup
#_  fleet     link link_info extra_se  biasadj   float  #  fleetname
        1        1        0        0        0        1  #  Fishery
        2        1        0        0        0        1  #  POP
        3        1        0        0        0        1  #  EarlyTriennial
        4        1        0        0        0        1  #  LateTriennial
        5        1        0        0        0        1  #  AFSCSlope
        6        1        0        0        0        1  #  NWFSCSlope
        7        1        0        0        0        1  #  NWFSCcombo
-9999 0 0 0 0 0
#
#_Q_parms(if_any);Qunits_are_ln(q)
#_      LO        HI      INIT     PRIOR   PR_SD  PR_type      PHASE env-va
# r use_dev dev_mnyr dev_mxyr dev_PH   Block Blk_Fxn  #  parm_name
        -15         15   -13.5598          0          1          0      -1 
      0       0       0       0       0       0       0  #  LnQ_base_Fisher
# y(1)
        -15         15   -2.31978          0          1          0      -1 
      0       0       0       0       0       0       0  #  LnQ_base_POP(2)
        -15         15   -3.56038          0          1          0      -1 
      0       0       0       0       0       0       0  #  LnQ_base_EarlyT
# riennial(3)
        -15         15   -4.09537          0          1          0      -1 
      0       0       0       0       0       0       0  #  LnQ_base_LateTr
# iennial(4)
        -15         15    -3.7565          0          1          0      -1 
      0       0       0       0       0       0       0  #  LnQ_base_AFSCSl
# ope(5)
        -15         15   -4.19759          0          1          0      -1 
      0       0       0       0       0       0       0  #  LnQ_base_NWFSCS
# lope(6)
        -15         15   -3.11695          0          1          0      -1 
      0       0       0       0       0       0       0  #  LnQ_base_NWFSCc
# ombo(7)
#_no timevary Q parameters
#
#_size_selex_types
#discard_options:_0=none;_1=define_retention;_2=retention&mortality;_3=all_
# discarded_dead
#_Pattern Discard Male Special
 24 1 0 0 # 1 Fishery
 1 0 0 0 # 2 POP
 1 0 0 0 # 3 EarlyTriennial
 15 0 0 3 # 4 LateTriennial
 15 0 0 2 # 5 AFSCSlope
 15 0 0 2 # 6 NWFSCSlope
 1 0 0 0 # 7 NWFSCcombo
#
#_age_selex_types
#_Pattern Discard Male Special
 10 0 0 0 # 1 Fishery
 10 0 0 0 # 2 POP
 10 0 0 0 # 3 EarlyTriennial
 10 0 0 0 # 4 LateTriennial
 10 0 0 0 # 5 AFSCSlope
 10 0 0 0 # 6 NWFSCSlope
 10 0 0 0 # 7 NWFSCcombo
#
#_      LO        HI      INIT     PRIOR      PR_SD    PR_type  PHASE env-v
# ar use_dev dev_mnyr dev_mxyr dev_PH   Block Blk_Fxn  #  parm_name
         20         45         31         28         50          0       2 
      0       0       0       0       0       0       0  #  SizeSel_P1_Fish
# ery(1)
         -6          4         -5         -1         50          0      -2 
      0       0       0       0       0       0       0  #  SizeSel_P2_Fish
# ery(1)
         -1          9          2          4         50          0       3 
      0       0       0       0       0       0       0  #  SizeSel_P3_Fish
# ery(1)
         -1          9          0          4         50          0       3 
      0       0       0       0       0       0       0  #  SizeSel_P4_Fish
# ery(1)
         -5          9      -4.99         -4         50          0       4 
      0       0       0       0       0       0       0  #  SizeSel_P5_Fish
# ery(1)
         -5          9          1         -2         50          0       2 
      0       0       0       0       0       0       0  #  SizeSel_P6_Fish
# ery(1)
         15         45         27         35         99          0       1 
      0       0       0       0     0.5       0       0  #  Retain_P1_Fishe
# ry(1)
        0.1         10          2          1         99          0       1 
      0       0       0       0     0.5       0       0  #  Retain_P2_Fishe
# ry(1)
      0.001          1        0.7        0.6         99          0       1 
      0       0       0       0     0.5       1       2  #  Retain_P3_Fishe
# ry(1)
          0          0          0          0         99          0      -3 
      0       0       0       0     0.5       0       0  #  Retain_P4_Fishe
# ry(1)
         20         70         25         30         99          0       2 
      0       0       0       0       0       0       0  #  SizeSel_P1_POP(
# 2)
      0.001         50         11         15         99          0       3 
      0       0       0       0       0       0       0  #  SizeSel_P2_POP(
# 2)
         18         70         25         30         99          0       2 
      0       0       0       0       0       0       0  #  SizeSel_P1_Earl
# yTriennial(3)
      0.001         50         11         15         99          0       3 
      0       0       0       0       0       0       0  #  SizeSel_P2_Earl
# yTriennial(3)
         20         70         25         30         99          0       2 
      0       0       0       0       0       0       0  #  SizeSel_P1_NWFS
# Ccombo(7)
      0.001         50         11         15         99          0       3 
      0       0       0       0       0       0       0  #  SizeSel_P2_NWFS
# Ccombo(7)
# timevary selex parameters 
#_      LO        HI      INIT     PRIOR   PR_SD  PR_type       PHASE
      0.001          1      0.999        0.9         99          6      -1 
 # Retain_P3_Fishery(1)_BLK1repl_1940
      0.001          1       0.98        0.9         99          6      -1 
 # Retain_P3_Fishery(1)_BLK1repl_1982
      0.001          1        0.9       0.88         99          6      1  
# Retain_P3_Fishery(1)_BLK1repl_1989
      0.001          1        0.8       0.82         99          6      1  
# Retain_P3_Fishery(1)_BLK1repl_1995
      0.001          1        0.6       0.65         99          6      1  
# Retain_P3_Fishery(1)_BLK1repl_2009
# info on dev vectors created for selex parms are reported with other devs 
# after tag parameter section 
#
# Tag loss and Tag reporting parameters go next
0  # TG_custom:  0=no read; 1=read if tags exist
#_Cond -6 6 1 1 2 0.01 -4 0 0 0 0 0 0 0  #_placeholder if no parameters
#
# deviation vectors for timevary parameters
#  base   base first block   block  env  env   dev   dev   dev   dev   dev
#  type  index  parm trend pattern link  var  vectr link _mnyr  mxyr phase 
#  dev_vector
#      5     9     1     1     2     2     0     0     0     0     0     0
     #
# Input variance adjustments factors: 
 #_1=add_to_survey_CV
 #_2=add_to_discard_stddev
 #_3=add_to_bodywt_CV
 #_4=mult_by_lencomp_N
 #_5=mult_by_agecomp_N
 #_6=mult_by_size-at-age_N
 #_7=mult_by_generalized_sizecomp
#_Factor  Fleet  Value
      1      2      0.11
      5      2       0.4
      5      3       0.7
      1      4      0.27
      5      4      0.84
      4      5      0.85
      1      6      0.47
      1      7      0.29
 -9999   1    0  # terminator
#
1 #_maxlambdaphase
1 #_sd_offset
# read 0 changes to default Lambdas (default value is 1.0)
# Like_comp codes:  1=surv; 2=disc; 3=mnwt; 4=length; 5=age; 6=SizeFreq; 7=
# sizeage; 8=catch; 9=init_equ_catch; 
# 10=recrdev; 11=parm_prior; 12=parm_dev; 13=CrashPen; 14=Morphcomp; 15=Tag
# -comp; 16=Tag-negbin; 17=F_ballpark
#like_comp fleet  phase  value  sizefreq_method
-9999  1  1  1  1  #  terminator
#
# lambdas (for info only; columns are phases)
#  1 #_CPUE/survey:_1
#  1 #_CPUE/survey:_2
#  1 #_CPUE/survey:_3
#  1 #_CPUE/survey:_4
#  1 #_CPUE/survey:_5
#  1 #_CPUE/survey:_6
#  1 #_CPUE/survey:_7
#  1 #_discard:_1
#  0 #_discard:_2
#  0 #_discard:_3
#  0 #_discard:_4
#  0 #_discard:_5
#  0 #_discard:_6
#  0 #_discard:_7
#  1 #_lencomp:_1
#  1 #_lencomp:_2
#  1 #_lencomp:_3
#  0 #_lencomp:_4
#  1 #_lencomp:_5
#  0 #_lencomp:_6
#  0 #_lencomp:_7
#  1 #_agecomp:_1
#  1 #_agecomp:_2
#  1 #_agecomp:_3
#  1 #_agecomp:_4
#  0 #_agecomp:_5
#  1 #_agecomp:_6
#  1 #_agecomp:_7
#  1 #_init_equ_catch
#  1 #_recruitments
#  1 #_parameter-priors
#  1 #_parameter-dev-vectors
#  1 #_crashPenLambda
#  1 # F_ballpark_lambda
0 # (0/1) read specs for more stddev reporting 
 # 0 1 -1 5 1 5 1 -1 5 # placeholder for selex type, len/age, year, N selex
#  bins, Growth pattern, N growth ages, NatAge_area(-1 for all), NatAge_yr,
#  N Natages
 # placeholder for vector of selex bins to be reported
 # placeholder for vector of growth ages to be reported
 # placeholder for vector of NatAges ages to be reported
999

