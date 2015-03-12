# AmazonTOs_simulation3Dfrontier.R
# CSO, UMN
# feb-2015
# deal with the new scenario experiment results --> make a 3-D efficiency frontier

# this is the .r file where I try to get a working figure up and running


# bring in necessary things
library(gridExtra)
library(ggplot2)
library(reshape2)

# install.packages("plot3D")
# install.packages("rgl")
# install.packages("scatterplot3d")
library(plot3D)
library(rgl)
library(scatterplot3d)
#example(persp3D)
#example(surf3D) 
#example(scatter3D)


##### FIRST: DEAL WITH THE DATA

dat <- read.table("~/Documents/GITHUB/cso002code_BrazilTradeOffsR/Fig 3 PNAS version/resultscombotable.txt", header = TRUE)

# subset only the data that I want to look at
dat <- subset(dat, dat$SimulationFactor == "AllLand")
# attach(dat)

# where to save things
dirsave="~/Documents/GITHUB/cso002code_BrazilTradeOffsR/3D-frontier-figures/EfficiencyFrontiers/"
setwd(dirsave)


##### SECOND: Scatter with third dim as color

## carbon and biodiv on the axes

# efficiency frontier, no limit on third variable
png(file = "eff-frontier-1.png",width=10,height=10,units="in",res=150)
# make plot
ggplot(dat, aes(x = -EmittedC, y = HabAvgImpac, colour=ClimRegIndexAvgImpac)) + geom_point() + scale_colour_gradient(low = "blue", high="red")
dev.off()

# reverse axes so shape is concave
png(file = "eff-frontier-2.png",width=10,height=10,units="in",res=150)
# make plot
ggplot(dat, aes(x = -EmittedC, y = HabAvgImpac, colour=ClimRegIndexAvgImpac)) + geom_point() + scale_colour_gradient(low = "blue", high="red") + scale_y_reverse() + scale_x_reverse()
dev.off()

## carbon and regclim on the axes

# efficiency frontier, no limit on third variable
png(file = "eff-frontier-3.png",width=10,height=10,units="in",res=150)
# make plot
ggplot(dat, aes(x = -EmittedC, y = ClimRegIndexAvgImpac, colour=HabAvgImpac)) + geom_point() + scale_colour_gradient(low = "blue", high="red")
dev.off()

# reverse axes so shape is concave
png(file = "eff-frontier-4.png",width=10,height=10,units="in",res=150)
# make plot
ggplot(dat, aes(x = -EmittedC, y = ClimRegIndexAvgImpac, colour=HabAvgImpac)) + geom_point() + scale_colour_gradient(low = "blue", high="red") + scale_y_reverse() + scale_x_reverse()
dev.off()


## biodiv and regclim on the axes

# efficiency frontier, no limit on third variable
png(file = "eff-frontier-5.png",width=10,height=10,units="in",res=150)
# make plot
ggplot(dat, aes(x = HabAvgImpac, y = ClimRegIndexAvgImpac, colour=-EmittedC)) + geom_point() + scale_colour_gradient(low = "blue", high="red")
dev.off()

# reverse axes so shape is concave
png(file = "eff-frontier-6.png",width=10,height=10,units="in",res=150)
# make plot
ggplot(dat, aes(x = HabAvgImpac, y = ClimRegIndexAvgImpac, colour=-EmittedC)) + geom_point() + scale_colour_gradient(low = "blue", high="red") + scale_y_reverse() + scale_x_reverse()
dev.off()


## all on one plot

effa <- ggplot(dat, aes(x = -EmittedC, y = HabAvgImpac, colour=ClimRegIndexAvgImpac)) + geom_point() + scale_colour_gradient(low = "blue", high="red") + scale_y_reverse() + scale_x_reverse()

effb <- ggplot(dat, aes(x = -EmittedC, y = ClimRegIndexAvgImpac, colour=HabAvgImpac)) + geom_point() + scale_colour_gradient(low = "blue", high="red") + scale_y_reverse() + scale_x_reverse()

effc <- ggplot(dat, aes(x = HabAvgImpac, y = ClimRegIndexAvgImpac, colour=-EmittedC)) + geom_point() + scale_colour_gradient(low = "blue", high="red") + scale_y_reverse() + scale_x_reverse()

png(file = "eff-frontier-7.png",width=20,height=6,units="in",res=150) # tiff(file=...) also an option
grid.arrange(effa, effb, effc, ncol=3)
dev.off()



##### THIRD: True efficiency frontier with bin of impact for third dim

# define the impact levels for the third dim


# subset the data
datsub <- subset(dat, dat$HabAvgImpac < 600 & dat$HabAvgImpac >= 550)

# plot 2-d scatter

png(file = "eff-frontier-8.png",width=10,height=10,units="in",res=150) # tiff(file=...) also an option
datsub <- subset(dat, dat$ClimRegIndexAvgImpac < 1.0 & dat$ClimRegIndexAvgImpac >= 0.58)
ggplot(datsub, aes(x = -EmittedC, y = HabAvgImpac, colour=ClimRegIndexAvgImpac)) + geom_point() + scale_colour_gradient(low = "blue", high="red") + scale_y_reverse() + scale_x_reverse()
dev.off()

png(file = "eff-frontier-9.png",width=10,height=10,units="in",res=150) # tiff(file=...) also an option
datsub <- subset(dat, dat$ClimRegIndexAvgImpac < 1.0 & dat$ClimRegIndexAvgImpac >= 0.50)
ggplot(datsub, aes(x = -EmittedC, y = HabAvgImpac, colour=ClimRegIndexAvgImpac)) + geom_point() + scale_colour_gradient(low = "blue", high="red") + scale_y_reverse() + scale_x_reverse()
dev.off()

datsub <- subset(dat, dat$HabAvgImpac < 620 & dat$HabAvgImpac >= 600)
ggplot(datsub, aes(x = -EmittedC, y = ClimRegIndexAvgImpac, colour=HabAvgImpac)) + geom_point() + scale_colour_gradient(low = "blue", high="red") + scale_y_reverse() + scale_x_reverse()

datsub <- subset(dat, dat$EmittedC < 750 & dat$EmittedC >= 620)
ggplot(dat, aes(x = HabAvgImpac, y = ClimRegIndexAvgImpac, colour=-EmittedC)) + geom_point() + scale_colour_gradient(low = "blue", high="red") + scale_y_reverse() + scale_x_reverse()




##### FOURTH: 3-D examples that look ok

## all three shadows are present

attach(dat)

png(file = "3D-frontier-1.png",width=10,height=10,units="in",res=150) # tiff(file=...) also an option

panelfirst <- function(pmat) {
      zmin <- min(ClimRegIndexAvgImpac)
      XY <- trans3D(EmittedC, HabAvgImpac, 
                    z = rep(zmin, nrow(dat)), pmat = pmat)
      scatter2D(XY$x, XY$y, pch = ".", 
                cex = 5, col="#999999", add = TRUE, colkey = FALSE)
      
      xmin <- min(EmittedC)
      XY <- trans3D(x = rep(xmin, nrow(dat)), y = HabAvgImpac, 
                    z = ClimRegIndexAvgImpac, pmat = pmat)
      
      scatter2D(XY$x, XY$y, pch = ".", 
                cex = 5, col="#999999", add = TRUE, colkey = FALSE)
      
      ymax <- max(HabAvgImpac)
      XY <- trans3D(EmittedC, y = rep(ymax, nrow(dat)),
                    z = ClimRegIndexAvgImpac, pmat = pmat)
      scatter2D(XY$x, XY$y, pch = ".", 
                cex = 5, col="#999999", add = TRUE, colkey = FALSE)
      
}

pp <- with(dat, scatter3D(x = EmittedC, y = HabAvgImpac, z = ClimRegIndexAvgImpac, 
                          colvar = ClimRegIndexAvgImpac, 
                          pch = 16, cex = 1.2, xlab = "EmittedC", ylab = "HabAvgImpac", 
                          zlab = "ClimRegIndexAvgImpac", clab = c("ClimReg"),
                          main = "3-D Eff Frontier", ticktype = "detailed", 
                          panel.first = panelfirst, theta = 30, phi=15, d = 2, 
                          colkey = list(length = 0.5, width = 0.5, cex.clab = 0.75)))

dev.off()



##### loess 3-D surface
require(lattice)

# figure model stuff
surf.df = data.frame(x = dat$ClimRegIndexAvgImpac, y = dat$HabAvgImpac, z = dat$EmittedC)
surf.loess = loess(z~x*y, data=surf.df,degree=2,span=0.25)
surf.fit = expand.grid(list(x=seq(0.0,1,0.05),y=seq(550,1300,25)))
g = predict(surf.loess, newdata = surf.fit)
surf.fit$Height = as.numeric(g)

# figure
png(file = "3D-frontier-2.png",width=10,height=10,units="in",res=150) # tiff(file=...) also an option
wireframe(Height~x*y, data = surf.fit, xlab = "ClimRegIndexAvgImpac", ylab = "HabAvgImpac", zlab="EmittedC", main = "Surface fit", drape = TRUE, colorkey = TRUE, scales=list(arrows=FALSE, cex=.5, tick.number=10))
dev.off()


### can manipulate on screen using rgl

tmp.lm <- lm(EmittedC ~ ClimRegIndexAvgImpac + HabAvgImpac, data = dat)
tmp2.lm <- lm(EmittedC ~ poly(ClimRegIndexAvgImpac, HabAvgImpac, degree = 2), data = dat)
summary.lm(tmp.lm)
summary.lm(tmp2.lm)

newdat <- expand.grid(ClimRegIndexAvgImpac=seq(0.1,0.7,by=0.1),
                      HabAvgImpac=seq(400,750,by=25))
newdat$pp <- predict(tmp.lm,newdata=newdat)
newdat$pp2 <- predict(tmp2.lm,newdata=newdat)

library(rgl)
with(dat,plot3d(ClimRegIndexAvgImpac,HabAvgImpac,EmittedC))
with(newdat,surface3d(unique(ClimRegIndexAvgImpac),unique(HabAvgImpac),pp,alpha=0.3,front="line"))

rgl.postscript("persp3dd.pdf","pdf")








