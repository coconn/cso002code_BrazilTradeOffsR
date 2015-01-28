# AmazonTOs_resultscombotable_20sims.R
# CSO, UMN
# 25/6/2013
# deal with the new scenario experiment results


# bring in necessary things
library(gridExtra)
library(ggplot2)
library(reshape2)


##### FIRST: DEAL WITH THE DATA

dat <- read.table("~/Documents/GITHUB/cso002code_BrazilTradeOffsR/Fig 3 PNAS version/resultscombotable.txt", header = TRUE)
attach(dat)



##### SECOND: CHECK OUT RESULTS ON GROUPS OF GRAPHS BY SERVICE
# good!!!  this works!

# look at carbon results
par(mfrow=c(2,2),oma=c(0,0,2,0),mar = c(5.1, 4.1, 2.1, 2.1))
plot(wC[WhichServ=="C"],EmittedC[WhichServ=="C"], ylim = rev(range(EmittedC[WhichServ=="C"])),xlab="Carbon Storage Priority Level", ylab="Tg Carbon Emitted", col="blue")
plot(wC[WhichServ=="C"],HabAvgImpac[WhichServ=="C"],xlab="Carbon Storage Priority Level", ylab="Species Ranges Affected")
plot(wC[WhichServ=="C"],DelHAvgImpac[WhichServ=="C"],xlab="Carbon Storage Priority Level", ylab=expression(Delta~degree*Celcius))
plot(wC[WhichServ=="C"],DelQAvgImpac[WhichServ=="C"],ylim = rev(range(DelQAvgImpac[WhichServ=="C"])),xlab="Carbon Storage Priority Level", ylab=expression(Delta~mm~H[2]*O/Day))
title("Impacts when you vary carbon prioritization", outer=TRUE)


# habitat results
par(mfrow=c(2,2),oma=c(0,0,2,0),mar = c(5.1, 4.1, 2.1, 2.1))
plot(wB[WhichServ=="B"],EmittedC[WhichServ=="B"], ylim = rev(range(EmittedC[WhichServ=="B"])),xlab="Habitat Priority Level", ylab="Tg Carbon Emitted")
plot(wB[WhichServ=="B"],HabAvgImpac[WhichServ=="B"],xlab="Habitat Priority Level", ylab="Species Ranges Affected", col="blue")
plot(wB[WhichServ=="B"],DelHAvgImpac[WhichServ=="B"],xlab="Habitat Priority Level", ylab=expression(Delta~degree*Celcius))
plot(wB[WhichServ=="B"],DelQAvgImpac[WhichServ=="B"],ylim = rev(range(DelQAvgImpac[WhichServ=="B"])),xlab="Habitat Priority Level", ylab=expression(Delta~mm~H[2]*O/Day))
title("Impacts when you vary habitat prioritization", outer=TRUE)


# regclim results
par(mfrow=c(2,2),oma=c(0,0,2,0),mar = c(5.1, 4.1, 2.1, 2.1))
plot(wCl[WhichServ=="Cl"],EmittedC[WhichServ=="Cl"], ylim = rev(range(EmittedC[WhichServ=="Cl"])),xlab="Regional Climate Priority Level", ylab=)
plot(wCl[WhichServ=="Cl"],HabAvgImpac[WhichServ=="Cl"],xlab="Regional Climate Priority Level", ylab="Species Ranges Affected")
plot(wCl[WhichServ=="Cl"],DelHAvgImpac[WhichServ=="Cl"],xlab="Regional Climate Priority Level", ylab=expression(Delta~degree*Celcius), col="blue")
plot(wCl[WhichServ=="Cl"],DelQAvgImpac[WhichServ=="Cl"],ylim = rev(range(DelQAvgImpac[WhichServ=="Cl"])),xlab="Regional Climate Priority Level", ylab=expression(Delta~mm~H[2]*O/Day), col="blue")
title("Impacts when you vary regional climate prioritization", outer=TRUE)



##### THIRD: CHECK OUT RESULTS IN ONE BIG FIGURE

par(mfrow=c(3,4),oma=c(0,0,2,0),mar = c(5.1, 4.1, 2.1, 2.1))

plot(wC[WhichServ=="C"],EmittedC[WhichServ=="C"], ylim = rev(range(EmittedC[WhichServ=="C"])),xlab="Carbon Storage Priority Level", ylab="Tg Carbon Emitted", col="blue")
plot(wC[WhichServ=="C"],HabAvgImpac[WhichServ=="C"],xlab="Carbon Storage Priority Level", ylab="Species Ranges Affected")
plot(wC[WhichServ=="C"],DelHAvgImpac[WhichServ=="C"],xlab="Carbon Storage Priority Level", ylab=expression(Delta~degree*Celcius))
plot(wC[WhichServ=="C"],DelQAvgImpac[WhichServ=="C"],ylim = rev(range(DelQAvgImpac[WhichServ=="C"])),xlab="Carbon Storage Priority Level", ylab=expression(Delta~mm~H[2]*O/Day))

plot(wB[WhichServ=="B"],EmittedC[WhichServ=="B"], ylim = rev(range(EmittedC[WhichServ=="B"])),xlab="Habitat Priority Level", ylab="Tg Carbon Emitted")
plot(wB[WhichServ=="B"],HabAvgImpac[WhichServ=="B"],xlab="Habitat Priority Level", ylab="Species Ranges Affected", col="blue")
plot(wB[WhichServ=="B"],DelHAvgImpac[WhichServ=="B"],xlab="Habitat Priority Level", ylab=expression(Delta~degree*Celcius))
plot(wB[WhichServ=="B"],DelQAvgImpac[WhichServ=="B"],ylim = rev(range(DelQAvgImpac[WhichServ=="B"])),xlab="Habitat Priority Level", ylab=expression(Delta~mm~H[2]*O/Day))

plot(wCl[WhichServ=="Cl"],EmittedC[WhichServ=="Cl"], ylim = rev(range(EmittedC[WhichServ=="Cl"])),xlab="Regional Climate Priority Level", ylab=)
plot(wCl[WhichServ=="Cl"],HabAvgImpac[WhichServ=="Cl"],xlab="Regional Climate Priority Level", ylab="Species Ranges Affected")
plot(wCl[WhichServ=="Cl"],DelHAvgImpac[WhichServ=="Cl"],xlab="Regional Climate Priority Level", ylab=expression(Delta~degree*Celcius), col="blue")
plot(wCl[WhichServ=="Cl"],DelQAvgImpac[WhichServ=="Cl"],ylim = rev(range(DelQAvgImpac[WhichServ=="Cl"])),xlab="Regional Climate Priority Level", ylab=expression(Delta~mm~H[2]*O/Day), col="blue")

title("Impacts when you vary how services are prioritized", outer=TRUE)








