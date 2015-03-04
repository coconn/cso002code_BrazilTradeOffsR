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
### 4) print one set of figures in which both simulations are overlaid on the same grids
############################################


##### FIRST: DEAL WITH THE DATA

dat <- read.table("~/Documents/GITHUB/cso002code_BrazilTradeOffsR/Fig 3 PNAS version/resultscombotable.txt", header = TRUE)

# # subset only the data that I want to look at
# dat <- subset(dat, dat$SimulationFactor == "AllLand")
attach(dat)


##### second: skip correlation info printed on graphs for now



##### THIRD: MAKE PLOTS, WITH TEXT, COR AND *** VALUES

# ggplot(dat, aes(x=wC, y=-EmittedC, color=SimulationFactor)) + geom_point(shape=1) + geom_smooth(size=0.75)+ ylab("Tg Carbon Emitted") + xlab("Carbon Storage Priority Level") + theme(legend.position="none") + ylim(1.25e10,3.25e10) 

plot1 <- ggplot(dat, aes(x=wC, y=-EmittedC, color=SimulationFactor)) + geom_point(shape=1) + geom_smooth(size=0.75) + ylab("Tg Carbon Emitted") + xlab("Carbon Storage Priority Level") + theme(legend.position="none") + ylim(1.25e10,3.53e10) # + geom_text(aes(label=paste("ρ =", round(cor1t$estimate,4), cor_stars[1])),x=-Inf, y=Inf, hjust=-0.1, vjust=1.5, data = data.frame())

plot2 <- ggplot(dat, aes(x=wC, y=HabAvgImpac, color=SimulationFactor)) + geom_point(shape=1) + geom_smooth(size=0.75) + ylab("Species Ranges Affected") + xlab("Carbon Storage Priority Level") + theme(legend.position="none") + ylim(415,775) # + geom_text(aes(label=paste("ρ =", round(cor2t$estimate,4), cor_stars[2])),x=-Inf, y=Inf, hjust=-0.1, vjust=1.5, data = data.frame())

plot3 <- ggplot(dat, aes(x=wC, y=ClimRegIndexAvgImpac, color=SimulationFactor)) + geom_point(shape=1) + geom_smooth(size=0.75) + ylab("Regional Climate Index") + xlab("Carbon Storage Priority Level") + theme(legend.position="none") + ylim(0.15,0.7) # + geom_text(aes(label=paste("ρ =", round(cor3t$estimate,4), cor_stars[3])),x=-Inf, y=Inf, hjust=-0.1, vjust=1.5, data = data.frame())

plot4 <- ggplot(dat, aes(x=wB, y=-EmittedC, color=SimulationFactor)) + geom_point(shape=1) + geom_smooth(size=0.75) + ylab("Tg Carbon Emitted") + xlab("Habitat Priority Level") + theme(legend.position="none") + ylim(1.25e10,3.53e10) # + geom_text(aes(label=paste("ρ =", round(cor4t$estimate,4), cor_stars[4])),x=-Inf, y=Inf, hjust=-0.1, vjust=1.5, data = data.frame())

plot5 <- ggplot(dat, aes(x=wB, y=HabAvgImpac, color=SimulationFactor)) + geom_point(shape=1) + geom_smooth(size=0.75) + ylab("Species Ranges Affected") + xlab("Habitat Priority Level") + theme(legend.position="none") + ylim(415,775) # + geom_text(aes(label=paste("ρ =", round(cor5t$estimate,4), cor_stars[5])),x=-Inf, y=Inf, hjust=-0.1, vjust=1.5, data = data.frame())

plot6 <- ggplot(dat, aes(x=wB, y=ClimRegIndexAvgImpac, color=SimulationFactor)) + geom_point(shape=1) + geom_smooth(size=0.75) + ylab("Regional Climate Index") + xlab("Habitat Priority Level") + theme(legend.position="none") + ylim(0.15,0.7) # + geom_text(aes(label=paste("ρ =", round(cor6t$estimate,4), cor_stars[6])),x=-Inf, y=Inf, hjust=-0.1, vjust=1.5, data = data.frame())

plot7 <- ggplot(dat, aes(x=wCl, y=-EmittedC, color=SimulationFactor)) + geom_point(shape=1) + geom_smooth(size=0.75) + ylab("Tg Carbon Emitted") + xlab("Regional Climate Priority Level") + theme(legend.position="none") + ylim(1.25e10,3.53e10) # + geom_text(aes(label=paste("ρ =", round(cor7t$estimate,4), cor_stars[7])),x=-Inf, y=Inf, hjust=-0.1, vjust=1.5, data = data.frame())

plot8 <- ggplot(dat, aes(x=wCl, y=HabAvgImpac, color=SimulationFactor)) + geom_point(shape=1) + geom_smooth(size=0.75) + ylab("Species Ranges Affected") + xlab("Regional Climate Priority Level") + theme(legend.position="none") + ylim(415,775) # + geom_text(aes(label=paste("ρ =", round(cor8t$estimate,4), cor_stars[8])),x=-Inf, y=Inf, hjust=-0.1, vjust=1.5, data = data.frame())

plot9 <- ggplot(dat, aes(x=wCl, y=ClimRegIndexAvgImpac, color=SimulationFactor)) + geom_point(shape=1) + geom_smooth(size=0.75) + ylab("Regional Climate Index") + xlab("Regional Climate Priority Level") + theme(legend.position="none") + ylim(0.15,0.7) # + geom_text(aes(label=paste("ρ =", round(cor9t$estimate,4), cor_stars[9])),x=-Inf, y=Inf, hjust=-0.1, vjust=1.5, data = data.frame())


grid.arrange(plot1, plot2, plot3, plot4, plot5, plot6, plot7, plot8, plot9, ncol=3, main=textGrob("Impacts when you vary how services are prioritized",gp=gpar(fontsize=20,font=1),just="top"))


##### FINALLY: SAVE FIGURE

# where to save in this loop
dirbegin="~/Documents/GITHUB/cso002code_BrazilTradeOffsR/Fig 3 PNAS version/SimulationScatters/"
dirloopname <- paste(dirbegin, "SimsCombined", "/", sep = "")
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
detach(dat)
# zen
zen()





























##### SECOND: CORRELATION FOR EACH, TO PRINT ON GRAPH

# subset for cor and p-values
dat_all <- subset(dat, dat$SimulationFactor == "AllLand")
dat_prot <- subset(dat, dat$SimulationFactor == "AvoidProtAreas")

# AllLand
cor1ta <- cor.test(dat_all$wC, -dat_all$EmittedC) # default method is "pearson"
cor2ta <- cor.test(dat_all$wC, dat_all$HabAvgImpac)
cor3ta <- cor.test(dat_all$wC, dat_all$ClimRegIndexAvgImpac)

cor4ta <- cor.test(dat_all$wB, -dat_all$EmittedC)
cor5ta <- cor.test(dat_all$wB, dat_all$HabAvgImpac)
cor6ta <- cor.test(dat_all$wB, dat_all$ClimRegIndexAvgImpac)

cor7ta <- cor.test(dat_all$wCl, -dat_all$EmittedC)
cor8ta <- cor.test(dat_all$wCl, dat_all$HabAvgImpac)
cor9ta <- cor.test(dat_all$wCl, dat_all$ClimRegIndexAvgImpac)

# AvoidProtAreas
cor1tb <- cor.test(dat_prot$wC, -dat_prot$EmittedC) # default method is "pearson"
cor2tb <- cor.test(dat_prot$wC, dat_prot$HabAvgImpac)
cor3tb <- cor.test(dat_prot$wC, dat_prot$ClimRegIndexAvgImpac)

cor4tb <- cor.test(dat_prot$wB, -dat_prot$EmittedC)
cor5tb <- cor.test(dat_prot$wB, dat_prot$HabAvgImpac)
cor6tb <- cor.test(dat_prot$wB, dat_prot$ClimRegIndexAvgImpac)

cor7tb <- cor.test(dat_prot$wCl, -dat_prot$EmittedC)
cor8tb <- cor.test(dat_prot$wCl, dat_prot$HabAvgImpac)
cor9tb <- cor.test(dat_prot$wCl, dat_prot$ClimRegIndexAvgImpac)

cor_stars_a <- numeric(length=9)
# cycle through to set number of stars
for (i in 1:9 ) {
      
      corpval <- paste("cor",i,"ta$p.value",sep="")
      
      if(eval(parse(text=corpval)) < 0.001){
            cor_stars_a[i] <- "***"
      } else if(eval(parse(text=corpval)) < 0.01){
            cor_stars_a[i] <- "**"
      } else if(eval(parse(text=corpval)) < 0.05){
            cor_stars_a[i] <- "*"
      } else {
            cor_stars_a[i] <- " "
      }
      
}

cor_stars_b <- numeric(length=9)
# cycle through to set number of stars
for (i in 1:9 ) {
      
      corpval <- paste("cor",i,"tb$p.value",sep="")
      
      if(eval(parse(text=corpval)) < 0.001){
            cor_stars_b[i] <- "***"
      } else if(eval(parse(text=corpval)) < 0.01){
            cor_stars_b[i] <- "**"
      } else if(eval(parse(text=corpval)) < 0.05){
            cor_stars_b[i] <- "*"
      } else {
            cor_stars_b[i] <- " "
      }
      
}




data2.labels <- data.frame(
      time = c(7, 15), 
      value = c(.9, .6), 
      label = c("correct color", "another correct color!"), 
      type = c("NA*", "MVH")
)

ggplot(data2, aes(x=time, y=value, group=type, col=type))+
      geom_line()+
      geom_point()+
      theme_bw() +
      geom_text(data = data2.labels, aes(x = time, y = value, label = label))


ggplot(dat, aes(x=wCl, y=ClimRegIndexAvgImpac, color=SimulationFactor)) + geom_point(shape=1) + geom_smooth(size=0.75) + ylab("Regional Climate Index") + xlab("Regional Climate Priority Level") + theme(legend.position="none") + ylim(0.15,0.7) + geom_text(aes(label=paste("ρ =", round(cor9ta$estimate,4), cor_stars_a[9])),x=-Inf, y=Inf, hjust=-0.1, vjust=1.5, data = data.frame(label="geom_text"))






# no p-value
# corlist <- by(dat[,unlist(lapply(dat, is.numeric))],factor(SimulationFactor),cor) 
# # p-value
# library(psych)
# corlist2 <- by(dat[,unlist(lapply(dat, is.numeric))],factor(SimulationFactor),corr.test) 







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










ggplot(dat, aes(x=wC, y=-EmittedC)) 
+ geom_point(colour = "blue", shape=1) 
+ geom_smooth(size = 1.5, fill="#333333", colour="black") 
+ ylab("Tg Carbon Emitted") 
+ xlab("Carbon Storage Priority Level") 
+ theme(legend.position="none") 
+ ylim(1.25e10,3.6e10) 
+ geom_text(aes(label=paste("ρ =", round(cor1t$estimate,4), cor_stars[1])),x=-Inf, y=Inf, hjust=-0.1, vjust=1.5, data = data.frame())


ggplot(dat, aes(x=wC, y=-EmittedC, color=SimulationFactor)) + geom_point(shape=1) + geom_smooth(size=0.75)+ ylab("Tg Carbon Emitted") + xlab("Carbon Storage Priority Level") + theme(legend.position="none") + ylim(1.25e10,3.25e10) 

# + geom_text(aes(label=paste("ρ =", round(cor1t$estimate,4), cor_stars[1])),x=-Inf, y=Inf, hjust=-0.1, vjust=1.5, data = data.frame())





##### THIRD: MAKE PLOTS, WITH TEXT, COR AND *** VALUES

plot1 <- ggplot(dat, aes(x=wC, y=-EmittedC)) + geom_point(colour = "blue", shape=1) + geom_smooth(size = 1.5, fill="#333333", colour="black") + ylab("Tg Carbon Emitted") + xlab("Carbon Storage Priority Level") + theme(legend.position="none") + ylim(1.25e10,3.6e10) + geom_text(aes(label=paste("ρ =", round(cor1ta$estimate,4), cor_stars_a[1])),x=-Inf, y=Inf, hjust=-0.1, vjust=1.5, data = data.frame(label="geom_text"))

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






