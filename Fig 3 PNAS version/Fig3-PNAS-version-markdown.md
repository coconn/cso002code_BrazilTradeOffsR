# Markdown Cheat Sheet: code for Figure 3

## Introduction

This is a markdown file where I explain how all the code fits together for the simulation scatterplot figure for the PNAS version of the Amazon tradeoffs paper.

This set of analyses use the output from the land allocation simulation (completed in Matlab) and do the figure creation.

Here are the .r files to think about:


## build_resultscombotable.R

<ul>

<li>automate building resultscombotable.txt (which Christine previously built by hand after running simulations in excel)</li>

<li>resultscombotable.txt then feeds into AmazonTOs_simulationscatters.R</li>

<li>in matlab, see GESexperiment_longfile_whittled.m and GESexperiment_longfile_whittled_parks.m (where the simulations get run and the AmazonTOs_simulationresults.csv files get made)</li>

</ul>


## AmazonTOs_simulationscatters.R

<ul>

<li>deal with the simulation scatterplots (from the scenario experiments)</li>

<li>this script also updated to </li>

<ul>

<li>1) use the .txt made in build_resultscombotable.r</li>

<li>2) print one set of figures based on the "AllLand" simulation (don't consider protected areas)</li>

<li>3) print one set of figures based on the "AvoidProtAreas" simulation (do consider protected areas)</li>

</ul>

<li>these figures save to the "SimulationScatters" folder</li>

<li>see AmazonTOs_simulationscatters-simscombined.R for this version:</li>

<ul>

<li>4) print one set of figures in which both simulations are overlaid on the same grids</li>

</ul>

</ul>



## AmazonTOs_simulationscatters-simscombined.R

<ul>

<li>deal with the simulation scatterplots (from the scenario experiments)</li>

<li>this script includes: </li>

<ul>

<li>1) use the .txt made in build_resultscombotable.r</li>

<li>4) print one set of figures in which both simulations are overlaid on the same grids</li>

</ul>

<li>see AmazonTOs_simulationscatters.R for these versions:</li>

<ul>
<li>2) print one set of figures based on the "AllLand" simulation (don't consider protected areas)</li>

<li>3) print one set of figures based on the "AvoidProtAreas" simulation (do consider protected areas)</li>

</ul>

</ul>


## images

![practice relative path](/Fig 3 PNAS version/SimulationScatters/AllLand/AmazonTOs_simulationscatters.png)






