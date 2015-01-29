# build_resultscombotable.r
# CSO, UMN
# 28/1/2015
#
# automate building resultscombotable.txt (which Christine previously built by hand after running simulations in excel)
# resultscombotable.txt then feeds into AmazonTOs_simulationscatters.R
#
# in matlab, see GESexperiment_longfile_whittled.m and GESexperiment_longfile_whittled_parks.m (where the simulations get run and the AmazonTOs_simulationresults.csv files get made)
# 


##### FIRST: BRING IN SIMULATION RESULTS

dat1 <- read.table("~/Documents/MATLAB/aa O'Connell PROJECTS/cso002_BrazilTradeOffs/SERVICES/OVERLAP/Objective Function Experiment/Version2_HectareControlled/GESmaps_hacontrolled/GES3Dfig/AmazonTOs_simulationresults.csv", sep = ",", header = FALSE)

dat2prot <- read.table("~/Documents/MATLAB/aa O'Connell PROJECTS/cso002_BrazilTradeOffs/SERVICES/OVERLAP/Objective Function Experiment/Version2_HectareControlled/GESmaps_hacontrolled/GES3DfigProtArea/AmazonTOs_simulationresults.csv", sep = ",", header = FALSE)



##### SECOND: ADD SIMULATION FACTOR

# add factor
dat1$V17 <- 'AllLand'
dat2prot$V17 <- 'AvoidProtAreas'



##### THIRD: ELIMINATE (1,0,0) REPEAT PRIORITY ROWS

# what are the duplicates?
dat1_dup <- dat1[duplicated(dat1[1:3]) | duplicated(dat1[1:3], fromLast=TRUE),]
dat2prot_dup <- dat2prot[duplicated(dat2prot[1:3]) | duplicated(dat2prot[1:3], fromLast=TRUE),]

# ditch duplicates
dat1 <- dat1[!duplicated(dat1[1:3]),]
dat2prot <- dat2prot[!duplicated(dat2prot[1:3]),]

# # get rid of row.names (got added during duplicated step)
# tmp <- dat1
# tmp$row.names <- NULL
# 
# don't need this since I just made sure they didn't get written in the write.table command below



##### FOURTH: COMBINE, ADD HEADER

# taken from GESexperiment_longfile_whittled.m
headerstrings <- c('wC' , 'wCl' , 'wB' , 'NewHA' , 'Cropkcal' ,'Pastkcal' , 'EmittedC' ,  'HabAvgImpac' , 'HabStdImpac' , 'DelHAvgImpac' , 'DelHStdImpac' ,  'DelQAvgImpac' , 'DelQStdImpac' , 'ClimRegIndexAvgImpac', 'ClimRegIndexStdImpac', 'Combokcal', 'SimulationFactor')

# combine
resultscombotable <- rbind(headerstrings, dat1, dat2prot)



##### SAVE

# right place
setwd("~/Documents/GITHUB/cso002code_BrazilTradeOffsR/Fig 3 PNAS version/")

# save without incorrect V1-style header, bring in with nice header subsequently
write.table(resultscombotable,file="resultscombotable.txt",sep="\t", col.names = F, row.names = F)




