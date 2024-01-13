library(forestplot)

workdir <- "."
datafile <- file.path(workdir,"Figure_t2d_yes_medication.csv")

data <- read.csv(datafile, stringsAsFactors=FALSE,row.names=NULL)

## Combine the count and percent column
np <- ifelse(!is.na(data$case_group), paste(data$case_group," (",data$p_val,")",sep=""), NA)

## The rest of the columns in the table. 
tabletext <- cbind(c("Population",data$blah),
                    c("Semaglutide\ngroup\n",data$case_group),
                    c("Non-GLP1R agonist\nanti-diabetic medications group\n",data$control_group),
                    c("        HR (95% CI)",data$CI)
)

pdf(file.path(workdir,"Extended_Figure1b.pdf"),  onefile=FALSE, width=10, height=5.5)

forestplot(labeltext=tabletext, 
           graphwidth = unit(45, 'mm'),
           graph.pos=4,
           is.summary=c(TRUE,rep(FALSE, 150)),
           mean=c(NA,data$AOR), 
           lower=c(NA,data$down), upper=c(NA,data$up),
          title ="Medication prescriptions related to suicidal ideations treatment in patients with T2DM \nwithin 6-month follow-up time window\n(comparison between propensity-score matched groups)", 
        
      
           xticks=log(c(0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1,2,3,4,5,6,7,8,9,10)),
           
           xlog = TRUE,
            xlab="Hazard Ratio (HR)", ##name of x axis

           #### Add horizontal lines on the plot
           hrzl_lines=list("2" = gpar(lwd = 0.9, lty=1, col='black'),
                           "3" = gpar(lwd = 0.9, lty='longdash', col='black'),
                           "5" = gpar(lwd = 0.9, lty='longdash', col='black')
                                      ),
          
           txt_gp=fpTxtGp(label=list(gpar(cex=0.9),gpar(cex=0.9),gpar(cex=0.9),gpar(cex=0.9),gpar(cex=0.9),gpar(cex=0.9)),
                          ticks=gpar(cex=0.7),
                          xlab=gpar(cex=0.7,col='black',fontface='bold'),
                          #xlab=gpar(cex = 1.8),
                          title=gpar(cex = 1.1)),

           col=fpColors(box="black", lines="black", zero = "black"),
           lwd.zero = 001,
           lwd.xaxis = 0.7,
           mar = unit(c(0,0,0,0), "mm"),
           zero=1, cex=0.01, lineheight = unit(4, "mm"), boxsize=0.2, colgap=unit(3,"mm"),
           lwd.ci=0.8, ci.vertices=TRUE, ci.vertices.height = 0.3)

dev.off()

