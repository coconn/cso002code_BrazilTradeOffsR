# Markdown Cheat Sheet: code for Figure 3

## Introduction

This is a markdown file where I explain how all the code fits together for the simulation scatterplot figure for the PNAS version of the Amazon tradeoffs paper.

This set of analyses use the output from the land allocation simulation (completed in Matlab) and do the figure creation.

Here are the .r files to think about:


## build_resultscombotable.R


* automate building resultscombotable.txt (which Christine previously built by hand after running simulations in excel)
* resultscombotable.txt then feeds into AmazonTOs_simulationscatters.R
* in matlab, see GESexperiment_longfile_whittled.m and GESexperiment_longfile_whittled_parks.m (where the simulations get run and the AmazonTOs_simulationresults.csv files get made)


## AmazonTOs_simulationscatters.R

* deal with the simulation scatterplots (from the scenario experiments) 
* this script also updated to 
      * 1) use the .txt made in build_resultscombotable.r
      * 2) print one set of figures based on the "AllLand" simulation (don't consider protected areas)
      * 3) print one set of figures based on the "AvoidProtAreas" simulation (do consider protected areas)
* these figures save to the "SimulationScatters" folder
* see AmazonTOs_simulationscatters-simscombined.R for this version:
      * 4) print one set of figures in which both simulations are overlaid on the same grids


## AmazonTOs_simulationscatters-simscombined.R

* deal with the simulation scatterplots (from the scenario experiments)
* this script includes: 
      * 1) use the .txt made in build_resultscombotable.r
      * 4) print one set of figures in which both simulations are overlaid on the same grids
* see AmazonTOs_simulationscatters.R for these versions:
      * 2) print one set of figures based on the "AllLand" simulation (don't consider protected areas)
      * 3) print one set of figures based on the "AvoidProtAreas" simulation (do consider protected areas)

## images

![practice relative path](/Fig 3 PNAS version/SimulationScatters/AllLand/AmazonTOs_simulationscatters.png)






