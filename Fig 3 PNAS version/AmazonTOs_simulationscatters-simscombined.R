# AmazonTOs_simulationscatters-simscombined.R
# CSO, UMN
# 
# deal with the simulation scatterplots (from the scenario experiments)
#
# this script includes: 
# 1) use the .txt made in build_resultscombotable.r
# 4) print one set of figures in which both simulations are overlaid on the same grids
#
# see AmazonTOs_simulationscatters.R for these versions:
# 2) print one set of figures based on the "AllLand" simulation (don't consider protected areas)
# 3) print one set of figures based on the "AvoidProtAreas" simulation (do consider protected areas)
#


# bring in necessary things
library(gridExtra)
library(ggplot2)
library(reshape2)




############################################
### 2) print one set of figures based on the "AllLand" simulation (don't consider protected areas)
############################################


##### FIRST: DEAL WITH THE DATA

dat <- read.table("~/Documents/GITHUB/cso002code_BrazilTradeOffsR/Fig 3 PNAS version/resultscombotable.txt", header = TRUE)

# subset only the data that I want to look at
dat <- subset(dat, dat$SimulationFactor == "AllLand")
attach(dat)


##### SECOND: CORRELATION FOR EACH, TO PRINT ON GRAPH

cor1t <- cor.test(wC, -EmittedC) # default method is "pearson"
cor2t <- cor.test(wC, HabAvgImpac)
cor3t <- cor.test(wC, ClimRegIndexAvgImpac)

cor4t <- cor.test(wB, -EmittedC)
cor5t <- cor.test(wB, HabAvgImpac)
cor6t <- cor.test(wB, ClimRegIndexAvgImpac)

cor7t <- cor.test(wCl, -EmittedC)
cor8t <- cor.test(wCl, HabAvgImpac)
cor9t <- cor.test(wCl, ClimRegIndexAvgImpac)

cor_stars <- numeric(length=9)
# cycle through to set number of stars
for (i in 1:9 ) {
      
      corpval <- paste("cor",i,"t$p.value",sep="")
      
      if(eval(parse(text=corpval)) < 0.001){
            cor_stars[i] <- "***"
      } else if(eval(parse(text=corpval)) < 0.01){
            cor_stars[i] <- "**"
      } else if(eval(parse(text=corpval)) < 0.05){
            cor_stars[i] <- "*"
      } else {
            cor_stars[i] <- " "
      }
      
}


##### THIRD: MAKE PLOTS, WITH TEXT, COR AND *** VALUES

plot1 <- ggplot(dat, aes(x=wC, y=-EmittedC)) + geom_point(colour = "blue", shape=1) + geom_smooth(size = 1.5, fill="#333333", colour="black") + ylab("Tg Carbon Emitted") + xlab("Carbon Storage Priority Level") + theme(legend.position="none") + ylim(1.25e10,3.6e10) + geom_text(aes(label=paste("ρ =", round(cor1t$estimate,4), cor_stars[1])),x=-Inf, y=Inf, hjust=-0.1, vjust=1.5, data = data.frame())

plot2 <- ggplot(dat, aes(x=wC, y=HabAvgImpac)) + geom_point(colour = "black", shape=1) + geom_smooth(size = 1.5, fill="#333333", colour="black") + ylab("Species Ranges Affected") + xlab("Carbon Storage Priority Level") + theme(legend.position="none") + ylim(475,775) + geom_text(aes(label=paste("ρ =", round(cor2t$estimate,4), cor_stars[2])),x=-Inf, y=Inf, hjust=-0.1, vjust=1.5, data = data.frame())

plot3 <- ggplot(dat, aes(x=wC, y=ClimRegIndexAvgImpac)) + geom_point(colour = "black", shape=1) + geom_smooth(size = 1.5, fill="#333333", colour="black") + ylab("Regional Climate Index") + xlab("Carbon Storage Priority Level") + theme(legend.position="none") + ylim(0.15,0.7) + geom_text(aes(label=paste("ρ =", round(cor3t$estimate,4), cor_stars[3])),x=-Inf, y=Inf, hjust=-0.1, vjust=1.5, data = data.frame())

plot4 <- ggplot(dat, aes(x=wB, y=-EmittedC)) + geom_point(colour = "black", shape=1) + geom_smooth(size = 1.5, fill="#333333", colour="black") + ylab("Tg Carbon Emitted") + xlab("Habitat Priority Level") + theme(legend.position="none") + ylim(1.25e10,3.6e10) + geom_text(aes(label=paste("ρ =", round(cor4t$estimate,4), cor_stars[4])),x=-Inf, y=Inf, hjust=-0.1, vjust=1.5, data = data.frame())

plot5 <- ggplot(dat, aes(x=wB, y=HabAvgImpac)) + geom_point(colour = "blue", shape=1) + geom_smooth(size = 1.5, fill="#333333", colour="black") + ylab("Species Ranges Affected") + xlab("Habitat Priority Level") + theme(legend.position="none") + ylim(475,775) + geom_text(aes(label=paste("ρ =", round(cor5t$estimate,4), cor_stars[5])),x=-Inf, y=Inf, hjust=-0.1, vjust=1.5, data = data.frame())

plot6 <- ggplot(dat, aes(x=wB, y=ClimRegIndexAvgImpac)) + geom_point(colour = "black", shape=1) + geom_smooth(size = 1.5, fill="#333333", colour="black") + ylab("Regional Climate Index") + xlab("Habitat Priority Level") + theme(legend.position="none") + ylim(0.15,0.7) + geom_text(aes(label=paste("ρ =", round(cor6t$estimate,4), cor_stars[6])),x=-Inf, y=Inf, hjust=-0.1, vjust=1.5, data = data.frame())

plot7 <- ggplot(dat, aes(x=wCl, y=-EmittedC)) + geom_point(colour = "black", shape=1) + geom_smooth(size = 1.5, fill="#333333", colour="black") + ylab("Tg Carbon Emitted") + xlab("Regional Climate Priority Level") + theme(legend.position="none") + ylim(1.25e10,3.6e10) + geom_text(aes(label=paste("ρ =", round(cor7t$estimate,4), cor_stars[7])),x=-Inf, y=Inf, hjust=-0.1, vjust=1.5, data = data.frame())

plot8 <- ggplot(dat, aes(x=wCl, y=HabAvgImpac)) + geom_point(colour = "black", shape=1) + geom_smooth(size = 1.5, fill="#333333", colour="black") + ylab("Species Ranges Affected") + xlab("Regional Climate Priority Level") + theme(legend.position="none") + ylim(475,775) + geom_text(aes(label=paste("ρ =", round(cor8t$estimate,4), cor_stars[8])),x=-Inf, y=Inf, hjust=-0.1, vjust=1.5, data = data.frame())

plot9 <- ggplot(dat, aes(x=wCl, y=ClimRegIndexAvgImpac)) + geom_point(colour = "blue", shape=1) + geom_smooth(size = 1.5, fill="#333333", colour="black") + ylab("Regional Climate Index") + xlab("Regional Climate Priority Level") + theme(legend.position="none") + ylim(0.15,0.7) + geom_text(aes(label=paste("ρ =", round(cor9t$estimate,4), cor_stars[9])),x=-Inf, y=Inf, hjust=-0.1, vjust=1.5, data = data.frame())


grid.arrange(plot1, plot2, plot3, plot4, plot5, plot6, plot7, plot8, plot9, ncol=3, main=textGrob("Impacts when you vary how services are prioritized",gp=gpar(fontsize=20,font=1),just="top"))


##### FINALLY: SAVE FIGURE

# where to save in this loop
dirbegin="~/Documents/GITHUB/cso002code_BrazilTradeOffsR/Fig 3 PNAS version/SimulationScatters/"
dirloopname <- paste(dirbegin, "AllLand", "/", sep = "")
setwd(dirloopname)

# must save this way, because ggsave only works with ggplot items and it doesn't understand that gB, etc. are based on ggplot items (since they are currently grobs, the units of grid.arrange)
png(file = "AmazonTOs_simulationscatters.png",width=10,height=10,units="in",res=300) # tiff(file=...) also an option
grid.arrange(plot1, plot2, plot3, plot4, plot5, plot6, plot7, plot8, plot9, ncol=3)
dev.off()

# high res copy
png(file = "AmazonTOs_simulationscatters_hires.png",width=10,height=10,units="in",res=600) # tiff(file=...) also an option
grid.arrange(plot1, plot2, plot3, plot4, plot5, plot6, plot7, plot8, plot9, ncol=3)
dev.off()

# detach
detach(dat2)
# zen
zen()





############################################
### 3) print one set of figures based on the "AvoidProtAreas" simulation (do consider protected areas)
############################################


##### FIRST: DEAL WITH THE DATA

dat <- read.table("~/Documents/GITHUB/cso002code_BrazilTradeOffsR/Fig 3 PNAS version/resultscombotable.txt", header = TRUE)

# subset only the data that I want to look at
dat <- subset(dat, dat$SimulationFactor == "AvoidProtAreas")
attach(dat)


##### SECOND: CORRELATION FOR EACH, TO PRINT ON GRAPH

cor1t <- cor.test(wC, -EmittedC) # default method is "pearson"
cor2t <- cor.test(wC, HabAvgImpac)
cor3t <- cor.test(wC, ClimRegIndexAvgImpac)

cor4t <- cor.test(wB, -EmittedC)
cor5t <- cor.test(wB, HabAvgImpac)
cor6t <- cor.test(wB, ClimRegIndexAvgImpac)

cor7t <- cor.test(wCl, -EmittedC)
cor8t <- cor.test(wCl, HabAvgImpac)
cor9t <- cor.test(wCl, ClimRegIndexAvgImpac)

cor_stars <- numeric(length=9)
# cycle through to set number of stars
for (i in 1:9 ) {
      
      corpval <- paste("cor",i,"t$p.value",sep="")
      
      if(eval(parse(text=corpval)) < 0.001){
            cor_stars[i] <- "***"
      } else if(eval(parse(text=corpval)) < 0.01){
            cor_stars[i] <- "**"
      } else if(eval(parse(text=corpval)) < 0.05){
            cor_stars[i] <- "*"
      } else {
            cor_stars[i] <- " "
      }
      
}


##### THIRD: MAKE PLOTS, WITH TEXT, COR AND *** VALUES

plot1 <- ggplot(dat, aes(x=wC, y=-EmittedC)) + geom_point(colour = "blue", shape=1) + geom_smooth(size = 1.5, fill="#333333", colour="black") + ylab("Tg Carbon Emitted") + xlab("Carbon Storage Priority Level") + theme(legend.position="none") + ylim(1.25e10,3.6e10) + geom_text(aes(label=paste("ρ =", round(cor1t$estimate,4), cor_stars[1])),x=-Inf, y=Inf, hjust=-0.1, vjust=1.5, data = data.frame())

plot2 <- ggplot(dat, aes(x=wC, y=HabAvgImpac)) + geom_point(colour = "black", shape=1) + geom_smooth(size = 1.5, fill="#333333", colour="black") + ylab("Species Ranges Affected") + xlab("Carbon Storage Priority Level") + theme(legend.position="none") + ylim(475,775) + geom_text(aes(label=paste("ρ =", round(cor2t$estimate,4), cor_stars[2])),x=-Inf, y=Inf, hjust=-0.1, vjust=1.5, data = data.frame())

plot3 <- ggplot(dat, aes(x=wC, y=ClimRegIndexAvgImpac)) + geom_point(colour = "black", shape=1) + geom_smooth(size = 1.5, fill="#333333", colour="black") + ylab("Regional Climate Index") + xlab("Carbon Storage Priority Level") + theme(legend.position="none") + ylim(0.15,0.7) + geom_text(aes(label=paste("ρ =", round(cor3t$estimate,4), cor_stars[3])),x=-Inf, y=Inf, hjust=-0.1, vjust=1.5, data = data.frame())

plot4 <- ggplot(dat, aes(x=wB, y=-EmittedC)) + geom_point(colour = "black", shape=1) + geom_smooth(size = 1.5, fill="#333333", colour="black") + ylab("Tg Carbon Emitted") + xlab("Habitat Priority Level") + theme(legend.position="none") + ylim(1.25e10,3.6e10) + geom_text(aes(label=paste("ρ =", round(cor4t$estimate,4), cor_stars[4])),x=-Inf, y=Inf, hjust=-0.1, vjust=1.5, data = data.frame())

plot5 <- ggplot(dat, aes(x=wB, y=HabAvgImpac)) + geom_point(colour = "blue", shape=1) + geom_smooth(size = 1.5, fill="#333333", colour="black") + ylab("Species Ranges Affected") + xlab("Habitat Priority Level") + theme(legend.position="none") + ylim(475,775) + geom_text(aes(label=paste("ρ =", round(cor5t$estimate,4), cor_stars[5])),x=-Inf, y=Inf, hjust=-0.1, vjust=1.5, data = data.frame())

plot6 <- ggplot(dat, aes(x=wB, y=ClimRegIndexAvgImpac)) + geom_point(colour = "black", shape=1) + geom_smooth(size = 1.5, fill="#333333", colour="black") + ylab("Regional Climate Index") + xlab("Habitat Priority Level") + theme(legend.position="none") + ylim(0.15,0.7) + geom_text(aes(label=paste("ρ =", round(cor6t$estimate,4), cor_stars[6])),x=-Inf, y=Inf, hjust=-0.1, vjust=1.5, data = data.frame())

plot7 <- ggplot(dat, aes(x=wCl, y=-EmittedC)) + geom_point(colour = "black", shape=1) + geom_smooth(size = 1.5, fill="#333333", colour="black") + ylab("Tg Carbon Emitted") + xlab("Regional Climate Priority Level") + theme(legend.position="none") + ylim(1.25e10,3.6e10) + geom_text(aes(label=paste("ρ =", round(cor7t$estimate,4), cor_stars[7])),x=-Inf, y=Inf, hjust=-0.1, vjust=1.5, data = data.frame())

plot8 <- ggplot(dat, aes(x=wCl, y=HabAvgImpac)) + geom_point(colour = "black", shape=1) + geom_smooth(size = 1.5, fill="#333333", colour="black") + ylab("Species Ranges Affected") + xlab("Regional Climate Priority Level") + theme(legend.position="none") + ylim(475,775) + geom_text(aes(label=paste("ρ =", round(cor8t$estimate,4), cor_stars[8])),x=-Inf, y=Inf, hjust=-0.1, vjust=1.5, data = data.frame())

plot9 <- ggplot(dat, aes(x=wCl, y=ClimRegIndexAvgImpac)) + geom_point(colour = "blue", shape=1) + geom_smooth(size = 1.5, fill="#333333", colour="black") + ylab("Regional Climate Index") + xlab("Regional Climate Priority Level") + theme(legend.position="none") + ylim(0.15,0.7) + geom_text(aes(label=paste("ρ =", round(cor9t$estimate,4), cor_stars[9])),x=-Inf, y=Inf, hjust=-0.1, vjust=1.5, data = data.frame())


grid.arrange(plot1, plot2, plot3, plot4, plot5, plot6, plot7, plot8, plot9, ncol=3, main=textGrob("Impacts when you vary how services are prioritized",gp=gpar(fontsize=20,font=1),just="top"))


##### FINALLY: SAVE FIGURE

# where to save in this loop
dirbegin="~/Documents/GITHUB/cso002code_BrazilTradeOffsR/Fig 3 PNAS version/SimulationScatters/"
dirloopname <- paste(dirbegin, "AvoidProtAreas", "/", sep = "")
setwd(dirloopname)

# must save this way, because ggsave only works with ggplot items and it doesn't understand that gB, etc. are based on ggplot items (since they are currently grobs, the units of grid.arrange)
png(file = "AmazonTOs_simulationscatters.png",width=10,height=10,units="in",res=300) # tiff(file=...) also an option
grid.arrange(plot1, plot2, plot3, plot4, plot5, plot6, plot7, plot8, plot9, ncol=3)
dev.off()

# high res copy
png(file = "AmazonTOs_simulationscatters_hires.png",width=10,height=10,units="in",res=600) # tiff(file=...) also an option
grid.arrange(plot1, plot2, plot3, plot4, plot5, plot6, plot7, plot8, plot9, ncol=3)
dev.off()

# detach
detach(dat2)
# zen
zen()




############################################
### 4) print one set of figures in which both simulations are overlaid on the same grids
############################################


##### FIRST: DEAL WITH THE DATA

dat <- read.table("~/Documents/GITHUB/cso002code_BrazilTradeOffsR/Fig 3 PNAS version/resultscombotable.txt", header = TRUE)

# subset only the data that I want to look at
dat <- subset(dat, dat$SimulationFactor == "AllLand")
attach(dat)









############################################
### THIS IS THE CODE I USED FOR A LONG TIME - uncomment if want to use again at any point
############################################


# # bring in necessary things
# library(gridExtra)
# library(ggplot2)
# library(reshape2)
# 
# 
# ##### FIRST: DEAL WITH THE DATA
# 
# dat <- read.table("~/Documents/GITHUB/cso002code_BrazilTradeOffsR/Fig 3 PNAS version/resultscombotable.txt", header = TRUE)
# attach(dat)
# 
# # subset only the data that I want to look at
# dat <- subset(dat, dat$SimulationFactor == "AllLand")
# 
# ##### SECOND: CHECK OUT RESULTS ON GROUPS OF GRAPHS BY SERVICE
# 
# # look at carbon results
# par(mfrow=c(2,2),oma=c(0,0,2,0),mar = c(5.1, 4.1, 2.1, 2.1))
# plot(wC,EmittedC,ylim = rev(range(EmittedC)),xlab="Carbon Storage Priority Level", ylab="Tg Carbon Emitted", col="blue")
# plot(wC,HabAvgImpac,xlab="Carbon Storage Priority Level", ylab="Species Ranges Affected")
# plot(wC,DelHAvgImpac,xlab="Carbon Storage Priority Level", ylab=expression(Delta~degree*Celcius))
# plot(wC,DelQAvgImpac,ylim = rev(range(DelQAvgImpac)),xlab="Carbon Storage Priority Level", ylab=expression(Delta~mm~H[2]*O/Day))
# title("Impacts when you vary carbon prioritization", outer=TRUE)
# 
# # look at habitat results
# par(mfrow=c(2,2),oma=c(0,0,2,0),mar = c(5.1, 4.1, 2.1, 2.1))
# plot(wB,EmittedC,ylim = rev(range(EmittedC)),xlab="Habitat Priority Level", ylab="Tg Carbon Emitted")
# plot(wB,HabAvgImpac,xlab="Habitat Priority Level", ylab="Species Ranges Affected", col="blue")
# plot(wB,DelHAvgImpac,xlab="Habitat Priority Level", ylab=expression(Delta~degree*Celcius))
# plot(wB,DelQAvgImpac,ylim = rev(range(DelQAvgImpac)),xlab="Habitat Priority Level", ylab=expression(Delta~mm~H[2]*O/Day))
# title("Impacts when you vary Habitat prioritization", outer=TRUE)
# 
# # look at regclim results
# par(mfrow=c(2,2),oma=c(0,0,2,0),mar = c(5.1, 4.1, 2.1, 2.1))
# plot(wCl,EmittedC,ylim = rev(range(EmittedC)),xlab="Regional Climate Priority Level", ylab="Tg Carbon Emitted")
# plot(wCl,HabAvgImpac,xlab="Regional Climate Priority Level", ylab="Species Ranges Affected")
# plot(wCl,DelHAvgImpac,xlab="Regional Climate Priority Level", ylab=expression(Delta~degree*Celcius), col="blue")
# plot(wCl,DelQAvgImpac,ylim = rev(range(DelQAvgImpac)),xlab="Regional Climate Priority Level", ylab=expression(Delta~mm~H[2]*O/Day), col="blue")
# title("Impacts when you vary regional climate prioritization", outer=TRUE)
# 
# 
# 
# 
# ##### THIRD: CHECK OUT RESULTS IN ONE BIG FIGURE
# 
# par(mfrow=c(3,4),oma=c(0,0,2,0),mar = c(5.1, 4.1, 2.1, 2.1))
# 
# plot(wC,EmittedC,ylim = rev(range(EmittedC)),xlab="Carbon Storage Priority Level", ylab="Tg Carbon Emitted", col="blue")
# plot(wC,HabAvgImpac,xlab="Carbon Storage Priority Level", ylab="Species Ranges Affected")
# plot(wC,DelHAvgImpac,xlab="Carbon Storage Priority Level", ylab=expression(Delta~degree*Celcius))
# plot(wC,DelQAvgImpac,ylim = rev(range(DelQAvgImpac)),xlab="Carbon Storage Priority Level", ylab=expression(Delta~mm~H[2]*O/Day))
# 
# plot(wB,EmittedC,ylim = rev(range(EmittedC)),xlab="Habitat Priority Level", ylab="Tg Carbon Emitted")
# plot(wB,HabAvgImpac,xlab="Habitat Priority Level", ylab="Species Ranges Affected", col="blue")
# plot(wB,DelHAvgImpac,xlab="Habitat Priority Level", ylab=expression(Delta~degree*Celcius))
# plot(wB,DelQAvgImpac,ylim = rev(range(DelQAvgImpac)),xlab="Habitat Priority Level", ylab=expression(Delta~mm~H[2]*O/Day))
# 
# plot(wCl,EmittedC,ylim = rev(range(EmittedC)),xlab="Regional Climate Priority Level", ylab="Tg Carbon Emitted")
# plot(wCl,HabAvgImpac,xlab="Regional Climate Priority Level", ylab="Species Ranges Affected")
# plot(wCl,DelHAvgImpac,xlab="Regional Climate Priority Level", ylab=expression(Delta~degree*Celcius), col="blue")
# plot(wCl,DelQAvgImpac,ylim = rev(range(DelQAvgImpac)),xlab="Regional Climate Priority Level", ylab=expression(Delta~mm~H[2]*O/Day), col="blue")
# 
# title("Impacts when you vary how services are prioritized", outer=TRUE)
# 
# 
# 
# 
# ##### FOURTH: CHECK OUT RESULTS IN ONE BIG FIGURE, ONLY ONE REGCLIM COLUMN
# 
# par(mfrow=c(3,3),oma=c(0,0,2,0),mar = c(5.1, 4.1, 2.1, 2.1))
# 
# plot(wC,EmittedC,ylim = rev(range(EmittedC)),xlab="Carbon Storage Priority Level", ylab="Tg Carbon Emitted", col="blue")
# plot(wC,HabAvgImpac,xlab="Carbon Storage Priority Level", ylab="Species Ranges Affected")
# plot(wC,ClimRegIndexAvgImpac  ,xlab="Carbon Storage Priority Level", ylab="Regional Climate Impacts Index")
# 
# plot(wB,EmittedC,ylim = rev(range(EmittedC)),xlab="Habitat Priority Level", ylab="Tg Carbon Emitted")
# plot(wB,HabAvgImpac,xlab="Habitat Priority Level", ylab="Species Ranges Affected", col="blue")
# plot(wB,ClimRegIndexAvgImpac  ,xlab="Habitat Priority Level", ylab="Regional Climate Impacts Index")
# 
# plot(wCl,EmittedC,ylim = rev(range(EmittedC)),xlab="Regional Climate Priority Level", ylab="Tg Carbon Emitted")
# plot(wCl,HabAvgImpac,xlab="Regional Climate Priority Level", ylab="Species Ranges Affected")
# plot(wCl,ClimRegIndexAvgImpac  ,xlab="Regional Climate Priority Level", ylab="Regional Climate Impacts Index", col="blue")
# 
# title("Impacts when you vary how services are prioritized", outer=TRUE)
# 
# 
# 
# ##### FOURTH PART B: CHECK OUT RESULTS IN ONE BIG FIGURE, ONLY ONE REGCLIM COLUMN, ADD LOESS, GGPLOT
# 
# # can use linear regression and not loess
# # https://sites.google.com/site/davidsstatistics/using-r/smoothing-curves
# # ggplot(dat, aes(x=wC, y=EmittedC)) +
# #   geom_point(shape=1) +    # Use hollow circles
# #   geom_smooth(method=lm) # linear regression
# 
# plot1 <- ggplot(dat, aes(x=wC, y=EmittedC)) + geom_point(colour = "blue", shape=1) + geom_smooth(size = 1.5, fill="#333333", colour="black") + ylab("Tg Carbon Emitted") + xlab("Carbon Storage Priority Level") + theme(legend.position="none") + scale_y_reverse()
# plot2 <- ggplot(dat, aes(x=wC, y=HabAvgImpac)) + geom_point(colour = "black", shape=1) + geom_smooth(size = 1.5, fill="#333333", colour="black") + ylab("Species Ranges Affected") + xlab("Carbon Storage Priority Level") + theme(legend.position="none")
# plot3 <- ggplot(dat, aes(x=wC, y=ClimRegIndexAvgImpac)) + geom_point(colour = "black", shape=1) + geom_smooth(size = 1.5, fill="#333333", colour="black") + ylab("Regional Climate Impacts Index") + xlab("Carbon Storage Priority Level") + theme(legend.position="none")
# 
# plot4 <- ggplot(dat, aes(x=wB, y=EmittedC)) + geom_point(colour = "black", shape=1) + geom_smooth(size = 1.5, fill="#333333", colour="black") + ylab("Tg Carbon Emitted") + xlab("Habitat Priority Level") + theme(legend.position="none") + scale_y_reverse()
# plot5 <- ggplot(dat, aes(x=wB, y=HabAvgImpac)) + geom_point(colour = "blue", shape=1) + geom_smooth(size = 1.5, fill="#333333", colour="black") + ylab("Species Ranges Affected") + xlab("Habitat Priority Level") + theme(legend.position="none")
# plot6 <- ggplot(dat, aes(x=wB, y=ClimRegIndexAvgImpac)) + geom_point(colour = "black", shape=1) + geom_smooth(size = 1.5, fill="#333333", colour="black") + ylab("Regional Climate Impacts Index") + xlab("Habitat Priority Level") + theme(legend.position="none")
# 
# plot7 <- ggplot(dat, aes(x=wCl, y=EmittedC)) + geom_point(colour = "black", shape=1) + geom_smooth(size = 1.5, fill="#333333", colour="black") + ylab("Tg Carbon Emitted") + xlab("Regional Climate Priority Level") + theme(legend.position="none") + scale_y_reverse()
# plot8 <- ggplot(dat, aes(x=wCl, y=HabAvgImpac)) + geom_point(colour = "black", shape=1) + geom_smooth(size = 1.5, fill="#333333", colour="black") + ylab("Species Ranges Affected") + xlab("Regional Climate Priority Level") + theme(legend.position="none")
# plot9 <- ggplot(dat, aes(x=wCl, y=ClimRegIndexAvgImpac)) + geom_point(colour = "blue", shape=1) + geom_smooth(size = 1.5, fill="#333333", colour="black") + ylab("Regional Climate Impacts Index") + xlab("Regional Climate Priority Level") + theme(legend.position="none")
# 
# grid.arrange(plot1, plot2, plot3, plot4, plot5, plot6, plot7, plot8, plot9, ncol=3, main=textGrob("Impacts when you vary how services are prioritized",gp=gpar(fontsize=20,font=1),just="top"))
# 
# 
# 
# ##### FOURTH PART C: CORRELATION FOR EACH, PRINT ON GRAPH
# 
# cor1t <- cor.test(wC, -EmittedC) # default method is "pearson"
# cor2t <- cor.test(wC, HabAvgImpac)
# cor3t <- cor.test(wC, ClimRegIndexAvgImpac)
# 
# cor4t <- cor.test(wB, -EmittedC)
# cor5t <- cor.test(wB, HabAvgImpac)
# cor6t <- cor.test(wB, ClimRegIndexAvgImpac)
# 
# cor7t <- cor.test(wCl, -EmittedC)
# cor8t <- cor.test(wCl, HabAvgImpac)
# cor9t <- cor.test(wCl, ClimRegIndexAvgImpac)
# 
# cor_stars <- numeric(length=9)
# # cycle through to set number of stars
# for (i in 1:9 ) {
#   
#   corpval <- paste("cor",i,"t$p.value",sep="")
#   
#   if(eval(parse(text=corpval)) < 0.001){
#     cor_stars[i] <- "***"
#   } else if(eval(parse(text=corpval)) < 0.01){
#     cor_stars[i] <- "**"
#   } else if(eval(parse(text=corpval)) < 0.05){
#     cor_stars[i] <- "*"
#   } else {
#     cor_stars[i] <- " "
#   }
#   
# }
# 
# 
# ## now plot, but add text with the cor and *** values
# 
# plot1 <- ggplot(dat, aes(x=wC, y=-EmittedC)) + geom_point(colour = "blue", shape=1) + geom_smooth(size = 1.5, fill="#333333", colour="black") + ylab("Tg Carbon Emitted") + xlab("Carbon Storage Priority Level") + theme(legend.position="none") + ylim(1.25e10,3.6e10) + geom_text(aes(label=paste("ρ =", round(cor1t$estimate,4), cor_stars[1])),x=-Inf, y=Inf, hjust=-0.1, vjust=1.5, data = data.frame())
# 
# plot2 <- ggplot(dat, aes(x=wC, y=HabAvgImpac)) + geom_point(colour = "black", shape=1) + geom_smooth(size = 1.5, fill="#333333", colour="black") + ylab("Species Ranges Affected") + xlab("Carbon Storage Priority Level") + theme(legend.position="none") + ylim(475,775) + geom_text(aes(label=paste("ρ =", round(cor2t$estimate,4), cor_stars[2])),x=-Inf, y=Inf, hjust=-0.1, vjust=1.5, data = data.frame())
# 
# plot3 <- ggplot(dat, aes(x=wC, y=ClimRegIndexAvgImpac)) + geom_point(colour = "black", shape=1) + geom_smooth(size = 1.5, fill="#333333", colour="black") + ylab("Regional Climate Index") + xlab("Carbon Storage Priority Level") + theme(legend.position="none") + ylim(0.15,0.7) + geom_text(aes(label=paste("ρ =", round(cor3t$estimate,4), cor_stars[3])),x=-Inf, y=Inf, hjust=-0.1, vjust=1.5, data = data.frame())
# 
# plot4 <- ggplot(dat, aes(x=wB, y=-EmittedC)) + geom_point(colour = "black", shape=1) + geom_smooth(size = 1.5, fill="#333333", colour="black") + ylab("Tg Carbon Emitted") + xlab("Habitat Priority Level") + theme(legend.position="none") + ylim(1.25e10,3.6e10) + geom_text(aes(label=paste("ρ =", round(cor4t$estimate,4), cor_stars[4])),x=-Inf, y=Inf, hjust=-0.1, vjust=1.5, data = data.frame())
# 
# plot5 <- ggplot(dat, aes(x=wB, y=HabAvgImpac)) + geom_point(colour = "blue", shape=1) + geom_smooth(size = 1.5, fill="#333333", colour="black") + ylab("Species Ranges Affected") + xlab("Habitat Priority Level") + theme(legend.position="none") + ylim(475,775) + geom_text(aes(label=paste("ρ =", round(cor5t$estimate,4), cor_stars[5])),x=-Inf, y=Inf, hjust=-0.1, vjust=1.5, data = data.frame())
# 
# plot6 <- ggplot(dat, aes(x=wB, y=ClimRegIndexAvgImpac)) + geom_point(colour = "black", shape=1) + geom_smooth(size = 1.5, fill="#333333", colour="black") + ylab("Regional Climate Index") + xlab("Habitat Priority Level") + theme(legend.position="none") + ylim(0.15,0.7) + geom_text(aes(label=paste("ρ =", round(cor6t$estimate,4), cor_stars[6])),x=-Inf, y=Inf, hjust=-0.1, vjust=1.5, data = data.frame())
# 
# plot7 <- ggplot(dat, aes(x=wCl, y=-EmittedC)) + geom_point(colour = "black", shape=1) + geom_smooth(size = 1.5, fill="#333333", colour="black") + ylab("Tg Carbon Emitted") + xlab("Regional Climate Priority Level") + theme(legend.position="none") + ylim(1.25e10,3.6e10) + geom_text(aes(label=paste("ρ =", round(cor7t$estimate,4), cor_stars[7])),x=-Inf, y=Inf, hjust=-0.1, vjust=1.5, data = data.frame())
# 
# plot8 <- ggplot(dat, aes(x=wCl, y=HabAvgImpac)) + geom_point(colour = "black", shape=1) + geom_smooth(size = 1.5, fill="#333333", colour="black") + ylab("Species Ranges Affected") + xlab("Regional Climate Priority Level") + theme(legend.position="none") + ylim(475,775) + geom_text(aes(label=paste("ρ =", round(cor8t$estimate,4), cor_stars[8])),x=-Inf, y=Inf, hjust=-0.1, vjust=1.5, data = data.frame())
# 
# plot9 <- ggplot(dat, aes(x=wCl, y=ClimRegIndexAvgImpac)) + geom_point(colour = "blue", shape=1) + geom_smooth(size = 1.5, fill="#333333", colour="black") + ylab("Regional Climate Index") + xlab("Regional Climate Priority Level") + theme(legend.position="none") + ylim(0.15,0.7) + geom_text(aes(label=paste("ρ =", round(cor9t$estimate,4), cor_stars[9])),x=-Inf, y=Inf, hjust=-0.1, vjust=1.5, data = data.frame())
# 
# grid.arrange(plot1, plot2, plot3, plot4, plot5, plot6, plot7, plot8, plot9, ncol=3, main=textGrob("Impacts when you vary how services are prioritized",gp=gpar(fontsize=20,font=1),just="top"))
# 
# 
# ##### FINALLY: SAVE FIGURE
# # This is the one to save!
# 
# dir="~/Dropbox/MANUSCRIPT/First attempt - Nature submission/AmazonTOs MS - Figures and tables/Figures and Tables/Figure 3/R Bargraph/PNAS version/"
# setwd(dir)
# getwd()
# 
# # must save this way, because ggsave only works with ggplot items and it doesn't understand that gB, etc. are based on ggplot items (since they are currently grobs, the units of grid.arrange)
# png(file = "AmazonTOs_simulationscatters.png",width=10,height=10,units="in",res=300) # tiff(file=...) also an option
# grid.arrange(plot1, plot2, plot3, plot4, plot5, plot6, plot7, plot8, plot9, ncol=3)
# dev.off()
# 
# # high res copy
# png(file = "AmazonTOs_simulationscatters_hires.png",width=10,height=10,units="in",res=600) # tiff(file=...) also an option
# grid.arrange(plot1, plot2, plot3, plot4, plot5, plot6, plot7, plot8, plot9, ncol=3)
# dev.off()







############################################
### THIS IS RANDO EXTRA CODE - larger fonts experiment, looked ugly
############################################



# 
# 
# # larger fonts
# 
# 
# plotf1 <- ggplot(dat, aes(x=wC, y=-EmittedC)) + geom_point(colour = "blue", shape=1) + geom_smooth(size = 1.5, fill="#333333", colour="black") + ylab("Tg Carbon Emitted") + xlab("Carbon Storage Priority Level") + theme(legend.position="none") + ylim(1.25e10,3.6e10) + geom_text(aes(label=paste("ρ =", round(cor1t$estimate,4), cor_stars[1])),x=-Inf, y=Inf, hjust=-0.1, vjust=1.5, data = data.frame()) + theme(axis.text=element_text(size=18),axis.title=element_text(size=24))
# 
# plotf2 <- ggplot(dat, aes(x=wC, y=HabAvgImpac)) + geom_point(colour = "black", shape=1) + geom_smooth(size = 1.5, fill="#333333", colour="black") + ylab("Species Ranges Affected") + xlab("Carbon Storage Priority Level") + theme(legend.position="none") + ylim(475,775) + geom_text(aes(label=paste("ρ =", round(cor2t$estimate,4), cor_stars[2])),x=-Inf, y=Inf, hjust=-0.1, vjust=1.5, data = data.frame()) + theme(axis.text=element_text(size=18),axis.title=element_text(size=24))
# 
# plotf3 <- ggplot(dat, aes(x=wC, y=ClimRegIndexAvgImpac)) + geom_point(colour = "black", shape=1) + geom_smooth(size = 1.5, fill="#333333", colour="black") + ylab("Regional Climate Index") + xlab("Carbon Storage Priority Level") + theme(legend.position="none") + ylim(0.15,0.7) + geom_text(aes(label=paste("ρ =", round(cor3t$estimate,4), cor_stars[3])),x=-Inf, y=Inf, hjust=-0.1, vjust=1.5, data = data.frame()) + theme(axis.text=element_text(size=18),axis.title=element_text(size=24))
# 
# plotf4 <- ggplot(dat, aes(x=wB, y=-EmittedC)) + geom_point(colour = "black", shape=1) + geom_smooth(size = 1.5, fill="#333333", colour="black") + ylab("Tg Carbon Emitted") + xlab("Habitat Priority Level") + theme(legend.position="none") + ylim(1.25e10,3.6e10) + geom_text(aes(label=paste("ρ =", round(cor4t$estimate,4), cor_stars[4])),x=-Inf, y=Inf, hjust=-0.1, vjust=1.5, data = data.frame()) + theme(axis.text=element_text(size=18),axis.title=element_text(size=24))
# 
# plotf5 <- ggplot(dat, aes(x=wB, y=HabAvgImpac)) + geom_point(colour = "blue", shape=1) + geom_smooth(size = 1.5, fill="#333333", colour="black") + ylab("Species Ranges Affected") + xlab("Habitat Priority Level") + theme(legend.position="none") + ylim(475,775) + geom_text(aes(label=paste("ρ =", round(cor5t$estimate,4), cor_stars[5])),x=-Inf, y=Inf, hjust=-0.1, vjust=1.5, data = data.frame()) + theme(axis.text=element_text(size=18),axis.title=element_text(size=24))
# 
# plotf6 <- ggplot(dat, aes(x=wB, y=ClimRegIndexAvgImpac)) + geom_point(colour = "black", shape=1) + geom_smooth(size = 1.5, fill="#333333", colour="black") + ylab("Regional Climate Index") + xlab("Habitat Priority Level") + theme(legend.position="none") + ylim(0.15,0.7) + geom_text(aes(label=paste("ρ =", round(cor6t$estimate,4), cor_stars[6])),x=-Inf, y=Inf, hjust=-0.1, vjust=1.5, data = data.frame()) + theme(axis.text=element_text(size=18),axis.title=element_text(size=24))
# 
# plotf7 <- ggplot(dat, aes(x=wCl, y=-EmittedC)) + geom_point(colour = "black", shape=1) + geom_smooth(size = 1.5, fill="#333333", colour="black") + ylab("Tg Carbon Emitted") + xlab("Regional Climate Priority Level") + theme(legend.position="none") + ylim(1.25e10,3.6e10) + geom_text(aes(label=paste("ρ =", round(cor7t$estimate,4), cor_stars[7])),x=-Inf, y=Inf, hjust=-0.1, vjust=1.5, data = data.frame()) + theme(axis.text=element_text(size=18),axis.title=element_text(size=24))
# 
# plotf8 <- ggplot(dat, aes(x=wCl, y=HabAvgImpac)) + geom_point(colour = "black", shape=1) + geom_smooth(size = 1.5, fill="#333333", colour="black") + ylab("Species Ranges Affected") + xlab("Regional Climate Priority Level") + theme(legend.position="none") + ylim(475,775) + geom_text(aes(label=paste("ρ =", round(cor8t$estimate,4), cor_stars[8])),x=-Inf, y=Inf, hjust=-0.1, vjust=1.5, data = data.frame()) + theme(axis.text=element_text(size=18),axis.title=element_text(size=24))
# 
# plotf9 <- ggplot(dat, aes(x=wCl, y=ClimRegIndexAvgImpac)) + geom_point(colour = "blue", shape=1) + geom_smooth(size = 1.5, fill="#333333", colour="black") + ylab("Regional Climate Index") + xlab("Regional Climate Priority Level") + theme(legend.position="none") + ylim(0.15,0.7) + geom_text(aes(label=paste("ρ =", round(cor9t$estimate,4), cor_stars[9])),x=-Inf, y=Inf, hjust=-0.1, vjust=1.5, data = data.frame()) + theme(axis.text=element_text(size=18),axis.title=element_text(size=24))
# 
# 
