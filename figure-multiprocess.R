works_with_R("3.2.2",
             "tdhock/ggplot2@a8b06ddb680acdcdbd927773b1011c562134e4d2")

load("multiprocess.RData")

multiprocess$cores.fac <-
  factor(multiprocess$cores, c("4", "2", "1"))
multiprocess$fun.fac <-
  factor(multiprocess$fun.name, c("Pool.map", "maxjobs_map", "map"))

p <- ggplot()+
  scale_y_continuous("megabytes used")+
  scale_x_continuous("length of second argument to map")+
  geom_line(aes(size, kilobytes/1024, color=cores.fac,
                linetype=fun.fac),
            pch=1,
            size=1,
            data=multiprocess)+
  theme_bw()+
  scale_color_discrete("cores")+
  scale_linetype_manual("function", values=c(map="dotted",
                          Pool.map="solid", maxjobs_map="dashed"))+
  theme(panel.margin=grid::unit(0, "cm"))+
  facet_grid(pfun.name ~ ., scales="free")

png("figure-multiprocess.png")
print(p)
dev.off()