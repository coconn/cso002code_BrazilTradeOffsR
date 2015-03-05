# AmazonTOs_simulation3Dfrontier_testing.R
# CSO, UMN
# 25/6/2013
# deal with the new scenario experiment results --> make a 3-D efficiency frontier

# this is the .r file where I tried out a bunch of things when I was first trying to make a 3-D figure that was viable

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

dat <- read.table("~/Documents/GITHUB/cso002code_BrazilTradeOffsR/Fig 3 PNAS version/resultscombotable3D.txt", header = TRUE)
attach(dat)



##### SECOND: 3-D FIGURES WHERE TWO PRIORITIES VARY
# from email to Steve: (subj: finally! figure!)
# It kind of feels like you can only do a pairwise comparison in which two services vary and the third one is held equal, then watch how a single impact changes over the "priority space."  i.e. x-axis = habitat priority, y-axis = regional climate priority, z-axis = impact for whatever environmental outcome, and the entire figure is for carbon priority being held steady at 0.35 or whatever number.  I will try that out after lab meeting.

# simple example
# rr <- scatterplot3d(wCl,wC,EmittedC, angle = 24, xlim = c(0, 1.0), ylim = c(0, 1.0))
# kind of hard to tell the third angle

par(mfrow=c(3,3),oma=c(0,0,2,0),mar = c(5.1, 4.1, 2.1, 2.1))

scatterplot3d(wC,wB,EmittedC, angle = 24, xlim = c(0, 1.0), ylim = c(0, 1.0))
scatterplot3d(wC,wB,HabAvgImpac, angle = 24, xlim = c(0, 1.0), ylim = c(0, 1.0))
scatterplot3d(wC,wB,ClimRegIndexAvgImpac, angle = 24, xlim = c(0, 1.0), ylim = c(0, 1.0))

scatterplot3d(wC,wCl,EmittedC, angle = 24, xlim = c(0, 1.0), ylim = c(0, 1.0))
scatterplot3d(wC,wCl,HabAvgImpac, angle = 24, xlim = c(0, 1.0), ylim = c(0, 1.0))
scatterplot3d(wC,wCl,ClimRegIndexAvgImpac, angle = 24, xlim = c(0, 1.0), ylim = c(0, 1.0))

scatterplot3d(wB,wCl,EmittedC, angle = 24, xlim = c(0, 1.0), ylim = c(0, 1.0))
scatterplot3d(wB,wCl,HabAvgImpac, angle = 24, xlim = c(0, 1.0), ylim = c(0, 1.0))
scatterplot3d(wB,wCl,ClimRegIndexAvgImpac, angle = 24, xlim = c(0, 1.0), ylim = c(0, 1.0))

# ug, terrible looking



##### THIRD: 3-D ENVIRONMENTAL EFFICIENCY FRONTIER

# scatterplot3d
rr <- scatterplot3d(EmittedC,HabAvgImpac,ClimRegIndexAvgImpac, angle = 24)

# scatter3D
scatter3D(x = EmittedC, y = HabAvgImpac, z = ClimRegIndexAvgImpac)
# or
rr <- scatter3D(x = EmittedC, y = HabAvgImpac, z = ClimRegIndexAvgImpac, 
                colvar = ClimRegIndexAvgImpac, 
                pch = 16, cex = 0.75, 
                xlab = "EmittedC", ylab = "HabAvgImpac", 
                zlab = "ClimRegIndexAvgImpac", clab = c("ClimRegIndexAvgImpac"),
                ticktype = "detailed", nticks=3,
                main = "3-D Eff Frontier",
                d=35, theta=24,
                colkey = list(length = 0.5, width = 0.5, cex.clab = 0.75))




# making the 3-D graph where the dots get thrown on the walls as well

panelfirst <- function(pmat) {
  zmin <- min(ClimRegIndexAvgImpac)
  XY <- trans3D(EmittedC, HabAvgImpac, 
                z = rep(zmin, nrow(dat)), pmat = pmat)
  scatter2D(XY$x, XY$y, colvar = ClimRegIndexAvgImpac, pch = ".", 
            cex = 3, add = TRUE, colkey = FALSE)
  
  xmin <- min(EmittedC)
  XY <- trans3D(x = rep(xmin, nrow(dat)), y = HabAvgImpac, 
                z = ClimRegIndexAvgImpac, pmat = pmat)
  
  scatter2D(XY$x, XY$y, colvar = ClimRegIndexAvgImpac, pch = ".", 
            cex = 3, add = TRUE, colkey = FALSE)
}

pp <- with(dat, scatter3D(x = EmittedC, y = HabAvgImpac, z = ClimRegIndexAvgImpac, 
                       colvar = ClimRegIndexAvgImpac, 
                       pch = 16, cex = 1.2, xlab = "EmittedC", ylab = "HabAvgImpac", 
                       zlab = "ClimRegIndexAvgImpac", clab = c("ClimReg"),
                       main = "3-D Eff Frontier", ticktype = "detailed", 
                       panel.first = panelfirst, theta = 30, phi=15, d = 2, 
                       colkey = list(length = 0.5, width = 0.5, cex.clab = 0.75)))


## all three shadows are present

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




panelfirst <- function(pmat) {
  zmin <- 0
  XY <- trans3D(ClimRegIndexAvgImpac, HabAvgImpac, 
                z = rep(zmin, nrow(dat)), pmat = pmat)
  scatter2D(XY$x, XY$y, pch = ".", 
            cex = 5, col="#999999", add = TRUE, colkey = FALSE)
  
  xmin <- max(HabAvgImpac)
  XY <- trans3D(x = rep(xmin, nrow(dat)), y = ClimRegIndexAvgImpac, 
                z = -EmittedC, pmat = pmat)
  
  scatter2D(XY$x, XY$y, colvar = -EmittedC, pch = ".", 
            cex = 3, add = TRUE, colkey = FALSE)
}

pp <- with(dat, scatter3D(x = ClimRegIndexAvgImpac, y = HabAvgImpac, z = -EmittedC, 
                          colvar = -EmittedC, 
                          xlim = c(0.15,0.7), ylim = c(500,1600), zlim = c(0,4e10),
                          pch = 16, cex = 1.2, xlab = "ClimRegIndexAvgImpac", ylab = "HabAvgImpac", 
                          zlab = "-EmittedC", clab = c("EmC"),
                          main = "3-D Eff Frontier", ticktype = "detailed", 
                          panel.first = panelfirst, theta = 20, phi=0, d = 2, 
                          colkey = list(length = 0.5, width = 0.5, cex.clab = 0.75)))






## double check the clouds by making sure that the pairwise scatters make sense
dir="~/Dropbox/MANUSCRIPT/First attempt - Nature submission/AmazonTOs MS - Figures and tables/Figures and Tables/Figure 3/R Bargraph/PNAS version/"
setwd(dir)
getwd()
# set save situation
png(file = "AmazonTOs_simulation3Dfrontier_pairwisescatters.png",width=10,height=10,units="in",res=300)
# make plot
par(mfrow=c(2,3))
plot(ClimRegIndexAvgImpac,EmittedC)
plot(HabAvgImpac,EmittedC)
plot(ClimRegIndexAvgImpac,HabAvgImpac)
# switch order so easy to imagine along the walls of the 3-D plot
plot(EmittedC,ClimRegIndexAvgImpac)
plot(EmittedC,HabAvgImpac)
plot(HabAvgImpac,ClimRegIndexAvgImpac)
dev.off()



# based on this plot3D example
# 
# panelfirst <- function(pmat) {
#   zmin <- min(-quakes$depth)
#   XY <- trans3D(quakes$long, quakes$lat, 
#                 z = rep(zmin, nrow(quakes)), pmat = pmat)
#   scatter2D(XY$x, XY$y, colvar = quakes$mag, pch = ".", 
#             cex = 2, add = TRUE, colkey = FALSE)
#   
#   xmin <- min(quakes$long)
#   XY <- trans3D(x = rep(xmin, nrow(quakes)), y = quakes$lat, 
#                 z = -quakes$depth, pmat = pmat)
#   
#   scatter2D(XY$x, XY$y, colvar = quakes$mag, pch = ".", 
#             cex = 2, add = TRUE, colkey = FALSE)
# }
# 
# with(quakes, scatter3D(x = long, y = lat, z = -depth, colvar = mag, 
#                        pch = 16, cex = 1.5, xlab = "longitude", ylab = "latitude", 
#                        zlab = "depth, km", clab = c("Richter","Magnitude"),
#                        main = "Earthquakes off Fiji", ticktype = "detailed", 
#                        panel.first = panelfirst, theta = 10, d = 2, 
#                        colkey = list(length = 0.5, width = 0.5, cex.clab = 0.75)))
# 



##### FINALLY: SAVE FIGURE
# This is the one to save!

dir="~/Dropbox/MANUSCRIPT/First attempt - Nature submission/AmazonTOs MS - Figures and tables/Figures and Tables/Figure 3/R Bargraph/PNAS version/"
setwd(dir)
getwd()

# must save this way, because ggsave only works with ggplot items and it doesn't understand that gB, etc. are based on ggplot items (since they are currently grobs, the units of grid.arrange)
png(file = "AmazonTOs_simulation3Dfrontier.png",width=10,height=10,units="in",res=300) # tiff(file=...) also an option
# put the final fig code here
dev.off()

























##### THINGS THAT WORK

### try creating loess 3-D surface
surf.df = data.frame(x = dat$ClimRegIndexAvgImpac, y = dat$HabAvgImpac, z = dat$EmittedC)

surf.loess = loess(z~x*y, data=surf.df,degree=2,span=0.25)

surf.fit = expand.grid(list(x=seq(0.0,1,0.05),y=seq(550,1300,25)))
z = predict(surf.loess, newdata = surf.fit)
surf.fit$Height = as.numeric(z)

require(lattice)
wireframe(Height~x*y, data = surf.fit, xlab = "ClimRegIndexAvgImpac", ylab = "HabAvgImpac", zlab="EmittedC", main = "Surface fit", drape = TRUE, colorkey = TRUE, scales=list(arrows=FALSE,cex=.5,tick.number="10"))






### droplines till the fitted surface

# make easier dataframe to read in the code below
surf.df = data.frame(x = dat$ClimRegIndexAvgImpac, y = dat$HabAvgImpac, z = dat$EmittedC)

with (surf.df, {
  
  # linear regression
  fit <- lm(z ~ x + y, data=surf.df)
  
  # predict values on regular xy grid
  x.pred <- seq(0.0,1, length.out = 25)
  y.pred <- seq(550,1300, length.out = 25)
  xy <- expand.grid(x = x.pred, 
                    y = y.pred)
  
  fit.pred <- matrix (nrow = 25, ncol = 25, 
                      data = predict(fit, newdata = data.frame(xy), 
                                     interval = "prediction"))
  
  # fitted points for droplines to surface
  fitpoints <- predict(fit) 
  
  scatter3D(z = surf.df$z, x = surf.df$x, y = surf.df$y, pch = 16, cex = 0.8, 
            theta = 20, phi = 30, ticktype = "detailed",
            xlab = "xlab", ylab = "ylab", zlab = "zlab",  
            surf = list(x = x.pred, y = y.pred, z = fit.pred,  
                        border = "black", facets = NA, fit = fitpoints),
            main = "fit???") # fit = fitpoints makes the droplines
  
})




### droplines till the fitted surface, poly response surf

# make easier dataframe to read in the code below
surf.df = data.frame(x = dat$ClimRegIndexAvgImpac, y = dat$HabAvgImpac, z = dat$EmittedC)

with (surf.df, {
  
  # linear regression
  fit2 <- lm(z ~ poly(x, y, degree = 2), data=surf.df)  
  
  # predict values on regular xy grid
  x.pred <- seq(0.0,1, length.out = 25)
  y.pred <- seq(550,1300, length.out = 25)
  xy <- expand.grid(x = x.pred, 
                    y = y.pred)
  
  fit.pred <- matrix (nrow = 25, ncol = 25, 
                      data = predict(fit2, newdata = data.frame(xy), 
                                     interval = "prediction"))
  
  # fitted points for droplines to surface
  fitpoints <- predict(fit2) 
  
  scatter3D(z = surf.df$z, x = surf.df$x, y = surf.df$y, pch = 16, cex = 0.8, 
            theta = 20, phi = 30, ticktype = "detailed",
            xlab = "xlab", ylab = "ylab", zlab = "zlab",  
            surf = list(x = x.pred, y = y.pred, z = fit.pred,  
                        border = "black", facets = NA, fit2 = fitpoints),
            main = "fit???") # fit = fitpoints makes the droplines
  
})




### using rgl

tmp.lm <- lm(EmittedC ~ ClimRegIndexAvgImpac + HabAvgImpac, data = dat)
tmp2.lm <- lm(EmittedC ~ poly(ClimRegIndexAvgImpac, HabAvgImpac, degree = 2), data = dat)
summary.lm(tmp.lm)
summary.lm(tmp2.lm)

newdat <- expand.grid(ClimRegIndexAvgImpac=seq(0,1,by=0.1),
                      HabAvgImpac=seq(0,1500,by=100))
newdat$pp <- predict(tmp.lm,newdata=newdat)
newdat$pp2 <- predict(tmp2.lm,newdata=newdat)

library(rgl)
with(dat,plot3d(ClimRegIndexAvgImpac,HabAvgImpac,EmittedC))
with(newdat,surface3d(unique(ClimRegIndexAvgImpac),unique(HabAvgImpac),pp,
                      alpha=0.3,front="line"))
#rgl.snapshot("swiss.png")





### all three shadows are present
### flexible so can easily switch around variables

xlimset = c(-3.5e10,-1e10)
ylimset = c(500,1600)
zlimset = c(0.15,0.7)

xvarset = EmittedC
yvarset = HabAvgImpac
zvarset = ClimRegIndexAvgImpac

xlabset = "EmittedC"
ylabset = "HabAvgImpac"
zlabset = "ClimRegIndexAvgImpac"



panelfirst <- function(pmat) {
  zmin <- zlimset[1]
  XY <- trans3D(xvarset, yvarset, 
                z = rep(zmin, nrow(dat)), pmat = pmat)
  scatter2D(XY$x, XY$y, pch = ".", 
            cex = 5, col="#999999", add = TRUE, colkey = FALSE)
  
  xmin <- xlimset[1]
  XY <- trans3D(x = rep(xmin, nrow(dat)), y = yvarset, 
                z = zvarset, pmat = pmat)
  
  scatter2D(XY$x, XY$y, pch = ".", 
            cex = 5, col="#999999", add = TRUE, colkey = FALSE)
  
  ymax <- ylimset[2]
  XY <- trans3D(xvarset, y = rep(ymax, nrow(dat)),
                z = zvarset, pmat = pmat)
  scatter2D(XY$x, XY$y, pch = ".", 
            cex = 5, col="#999999", add = TRUE, colkey = FALSE)
  
}

pp <- with(dat, scatter3D(x = xvarset, y = yvarset, z = zvarset, 
                          colvar = zvarset, 
                          zlim = zlimset, ylim = ylimset, xlim = xlimset,
                          pch = 16, cex = 1.2, xlab = xlabset, ylab = ylabset, 
                          zlab = zlabset, clab = zlabset,
                          main = "3-D Eff Frontier", ticktype = "detailed", 
                          panel.first = panelfirst, theta = 20, phi=15, d = 2, 
                          colkey = list(length = 0.5, width = 0.5, cex.clab = 0.75)))





### all three shadows are present

zlimset = c(-3.5e10,-1e10)
ylimset = c(500,1600)
xlimset = c(0.15,0.7)

zvarset = EmittedC
yvarset = HabAvgImpac
xvarset = ClimRegIndexAvgImpac

zlabset = "EmittedC"
ylabset = "HabAvgImpac"
xlabset = "ClimRegIndexAvgImpac"



panelfirst <- function(pmat) {
  zmin <- zlimset[1]
  XY <- trans3D(xvarset, yvarset, 
                z = rep(zmin, nrow(dat)), pmat = pmat)
  scatter2D(XY$x, XY$y, pch = ".", 
            cex = 5, col="#999999", add = TRUE, colkey = FALSE)
  
  xmin <- xlimset[1]
  XY <- trans3D(x = rep(xmin, nrow(dat)), y = yvarset, 
                z = zvarset, pmat = pmat)
  
  scatter2D(XY$x, XY$y, pch = ".", 
            cex = 5, col="#999999", add = TRUE, colkey = FALSE)
  
  ymax <- ylimset[2]
  XY <- trans3D(xvarset, y = rep(ymax, nrow(dat)),
                z = zvarset, pmat = pmat)
  scatter2D(XY$x, XY$y, pch = ".", 
            cex = 5, col="#999999", add = TRUE, colkey = FALSE)
  
}

pp <- with(dat, scatter3D(x = xvarset, y = yvarset, z = zvarset, 
                          colvar = zvarset, 
                          zlim = zlimset, ylim = ylimset, xlim = xlimset,
                          pch = 16, cex = 1.2, xlab = xlabset, ylab = ylabset, 
                          zlab = zlabset, clab = zlabset,
                          main = "3-D Eff Frontier", ticktype = "detailed", 
                          panel.first = panelfirst, theta = 15, phi=15, d = 2,
                          colkey = list(length = 0.5, width = 0.5, cex.clab = 0.75)))



