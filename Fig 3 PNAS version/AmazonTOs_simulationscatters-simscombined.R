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

# make lists so these will print correctly on the ggplots
l1a <- list(cor = round(cor1ta$estimate,4), star = cor_stars_a[1])
l1b <- list(cor = round(cor1tb$estimate,4), star = cor_stars_b[1])
l2a <- list(cor = round(cor2ta$estimate,4), star = cor_stars_a[2])
l2b <- list(cor = round(cor2tb$estimate,4), star = cor_stars_b[2])
l3a <- list(cor = round(cor3ta$estimate,4), star = cor_stars_a[3])
l3b <- list(cor = round(cor3tb$estimate,4), star = cor_stars_b[3])
l4a <- list(cor = round(cor4ta$estimate,4), star = cor_stars_a[4])
l4b <- list(cor = round(cor4tb$estimate,4), star = cor_stars_b[4])
l5a <- list(cor = round(cor5ta$estimate,4), star = cor_stars_a[5])
l5b <- list(cor = round(cor5tb$estimate,4), star = cor_stars_b[5])
l6a <- list(cor = round(cor6ta$estimate,4), star = cor_stars_a[6])
l6b <- list(cor = round(cor6tb$estimate,4), star = cor_stars_b[6])
l7a <- list(cor = round(cor7ta$estimate,4), star = cor_stars_a[7])
l7b <- list(cor = round(cor7tb$estimate,4), star = cor_stars_b[7])
l8a <- list(cor = round(cor8ta$estimate,4), star = cor_stars_a[8])
l8b <- list(cor = round(cor8tb$estimate,4), star = cor_stars_b[8])
l9a <- list(cor = round(cor9ta$estimate,4), star = cor_stars_a[9])
l9b <- list(cor = round(cor9tb$estimate,4), star = cor_stars_b[9])

# this two lines will be included before each ggplot
#eq_a <- substitute(ρ[all] == cor~star,l4a); eqstr_a <- as.character(as.expression(eq_a))
#eq_b <- substitute(ρ[prot] == cor~star,l4b); eqstr_b <- as.character(as.expression(eq_b))

# add this to the end of each ggplot
# + annotate(geom="text", x = -Inf, y = Inf, hjust=-0.05, vjust=1.2, colour = "black", label = eqstr_a, parse = TRUE) + annotate(geom="text", x = -Inf, y = Inf, hjust=-0.05, vjust=2.4, colour = "black", label = eqstr_b, parse = TRUE)


##### THIRD: MAKE PLOTS, WITH TEXT, COR AND *** VALUES

# applies to all the graphs
factorcolors <- c("black","blue") # c("#1f78b4","#33a02c")
rhosize <- 4

# now begin the plots

eq_a <- substitute(ρ[all] == cor~star,l1a); eqstr_a <- as.character(as.expression(eq_a))
eq_b <- substitute(ρ[prot] == cor~star,l1b); eqstr_b <- as.character(as.expression(eq_b))
plot1 <- ggplot(dat, aes(x=wC, y=-EmittedC, color=SimulationFactor)) + geom_point(shape=1) + geom_smooth(size=0.75) + theme_bw() + ylab("Tg Carbon Emitted") + xlab("Carbon Storage Priority Level") + theme(legend.position="none") + ylim(1.25e10,3.53e10) + annotate(geom="text", x = -Inf, y = Inf, hjust=-0.05, vjust=1.2, colour = factorcolors[1], label = eqstr_a, parse = TRUE, size=rhosize) + annotate(geom="text", x = -Inf, y = Inf, hjust=-0.05, vjust=2.4, colour = factorcolors[2], label = eqstr_b, parse = TRUE, size=rhosize) + scale_colour_manual(values = factorcolors)

eq_a <- substitute(ρ[all] == cor~star,l2a); eqstr_a <- as.character(as.expression(eq_a))
eq_b <- substitute(ρ[prot] == cor~star,l2b); eqstr_b <- as.character(as.expression(eq_b))
plot2 <- ggplot(dat, aes(x=wC, y=HabAvgImpac, color=SimulationFactor)) + geom_point(shape=1) + geom_smooth(size=0.75) + theme_bw() + ylab("Species Ranges Affected") + xlab("Carbon Storage Priority Level") + theme(legend.position="none") + ylim(415,775) + annotate(geom="text", x = -Inf, y = Inf, hjust=-0.05, vjust=1.2, colour = "black", label = eqstr_a, parse = TRUE, size=rhosize) + annotate(geom="text", x = -Inf, y = Inf, hjust=-0.05, vjust=2.4, colour = "black", label = eqstr_b, parse = TRUE, size=rhosize) + scale_colour_manual(values = factorcolors)

eq_a <- substitute(ρ[all] == cor~star,l3a); eqstr_a <- as.character(as.expression(eq_a))
eq_b <- substitute(ρ[prot] == cor~star,l3b); eqstr_b <- as.character(as.expression(eq_b))
plot3 <- ggplot(dat, aes(x=wC, y=ClimRegIndexAvgImpac, color=SimulationFactor)) + geom_point(shape=1) + geom_smooth(size=0.75) + theme_bw() + ylab("Regional Climate Index") + xlab("Carbon Storage Priority Level") + theme(legend.position="none") + ylim(0.15,0.7) + annotate(geom="text", x = -Inf, y = Inf, hjust=-0.05, vjust=1.2, colour = "black", label = eqstr_a, parse = TRUE, size=rhosize) + annotate(geom="text", x = -Inf, y = Inf, hjust=-0.05, vjust=2.4, colour = "black", label = eqstr_b, parse = TRUE, size=rhosize) + scale_colour_manual(values = factorcolors)

eq_a <- substitute(ρ[all] == cor~star,l4a); eqstr_a <- as.character(as.expression(eq_a))
eq_b <- substitute(ρ[prot] == cor~star,l4b); eqstr_b <- as.character(as.expression(eq_b))
plot4 <- ggplot(dat, aes(x=wB, y=-EmittedC, color=SimulationFactor)) + geom_point(shape=1) + geom_smooth(size=0.75) + theme_bw() + ylab("Tg Carbon Emitted") + xlab("Habitat Priority Level") + theme(legend.position="none") + ylim(1.25e10,3.53e10) + annotate(geom="text", x = -Inf, y = Inf, hjust=-0.05, vjust=1.2, colour = "black", label = eqstr_a, parse = TRUE, size=rhosize) + annotate(geom="text", x = -Inf, y = Inf, hjust=-0.05, vjust=2.4, colour = "black", label = eqstr_b, parse = TRUE, size=rhosize) + scale_colour_manual(values = factorcolors)

eq_a <- substitute(ρ[all] == cor~star,l5a); eqstr_a <- as.character(as.expression(eq_a))
eq_b <- substitute(ρ[prot] == cor~star,l5b); eqstr_b <- as.character(as.expression(eq_b))
plot5 <- ggplot(dat, aes(x=wB, y=HabAvgImpac, color=SimulationFactor)) + geom_point(shape=1) + geom_smooth(size=0.75) + theme_bw() + ylab("Species Ranges Affected") + xlab("Habitat Priority Level") + theme(legend.position="none") + ylim(415,775) + annotate(geom="text", x = -Inf, y = Inf, hjust=-0.05, vjust=1.2, colour = "black", label = eqstr_a, parse = TRUE, size=rhosize) + annotate(geom="text", x = -Inf, y = Inf, hjust=-0.05, vjust=2.4, colour = "black", label = eqstr_b, parse = TRUE, size=rhosize) + scale_colour_manual(values = factorcolors)

eq_a <- substitute(ρ[all] == cor~star,l6a); eqstr_a <- as.character(as.expression(eq_a))
eq_b <- substitute(ρ[prot] == cor~star,l6b); eqstr_b <- as.character(as.expression(eq_b))
plot6 <- ggplot(dat, aes(x=wB, y=ClimRegIndexAvgImpac, color=SimulationFactor)) + geom_point(shape=1) + geom_smooth(size=0.75) + theme_bw() + ylab("Regional Climate Index") + xlab("Habitat Priority Level") + theme(legend.position="none") + ylim(0.15,0.7) + annotate(geom="text", x = -Inf, y = Inf, hjust=-0.05, vjust=1.2, colour = "black", label = eqstr_a, parse = TRUE, size=rhosize) + annotate(geom="text", x = -Inf, y = Inf, hjust=-0.05, vjust=2.4, colour = "black", label = eqstr_b, parse = TRUE, size=rhosize) + scale_colour_manual(values = factorcolors)

eq_a <- substitute(ρ[all] == cor~star,l7a); eqstr_a <- as.character(as.expression(eq_a))
eq_b <- substitute(ρ[prot] == cor~star,l7b); eqstr_b <- as.character(as.expression(eq_b))
plot7 <- ggplot(dat, aes(x=wCl, y=-EmittedC, color=SimulationFactor)) + geom_point(shape=1) + geom_smooth(size=0.75) + theme_bw() + ylab("Tg Carbon Emitted") + xlab("Regional Climate Priority Level") + theme(legend.position="none") + ylim(1.25e10,3.53e10) + annotate(geom="text", x = -Inf, y = Inf, hjust=-0.05, vjust=1.2, colour = "black", label = eqstr_a, parse = TRUE, size=rhosize) + annotate(geom="text", x = -Inf, y = Inf, hjust=-0.05, vjust=2.4, colour = "black", label = eqstr_b, parse = TRUE, size=rhosize) + scale_colour_manual(values = factorcolors)

eq_a <- substitute(ρ[all] == cor~star,l8a); eqstr_a <- as.character(as.expression(eq_a))
eq_b <- substitute(ρ[prot] == cor~star,l8b); eqstr_b <- as.character(as.expression(eq_b))
plot8 <- ggplot(dat, aes(x=wCl, y=HabAvgImpac, color=SimulationFactor)) + geom_point(shape=1) + geom_smooth(size=0.75) + theme_bw() + ylab("Species Ranges Affected") + xlab("Regional Climate Priority Level") + theme(legend.position="none") + ylim(415,775) + annotate(geom="text", x = -Inf, y = Inf, hjust=-0.05, vjust=1.2, colour = "black", label = eqstr_a, parse = TRUE, size=rhosize) + annotate(geom="text", x = -Inf, y = Inf, hjust=-0.05, vjust=2.4, colour = "black", label = eqstr_b, parse = TRUE, size=rhosize) + scale_colour_manual(values = factorcolors)

eq_a <- substitute(ρ[all] == cor~star,l9a); eqstr_a <- as.character(as.expression(eq_a))
eq_b <- substitute(ρ[prot] == cor~star,l9b); eqstr_b <- as.character(as.expression(eq_b))
plot9 <- ggplot(dat, aes(x=wCl, y=ClimRegIndexAvgImpac, color=SimulationFactor)) + geom_point(shape=1) + geom_smooth(size=0.75) + theme_bw() + ylab("Regional Climate Index") + xlab("Regional Climate Priority Level") + theme(legend.position="none") + ylim(0.15,0.7) + annotate(geom="text", x = -Inf, y = Inf, hjust=-0.05, vjust=1.2, colour = "black", label = eqstr_a, parse = TRUE, size=rhosize) + annotate(geom="text", x = -Inf, y = Inf, hjust=-0.05, vjust=2.4, colour = "black", label = eqstr_b, parse = TRUE, size=rhosize) + scale_colour_manual(values = factorcolors)


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
#detach(dat)
# zen
#zen()





