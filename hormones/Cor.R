df <- read.csv('hormones.levels.csv',header = T,row.names = 1,check.names = F)
head(df)
df1 <- log2(df+1)
df2 <- cor(df1,method = 'spearman')
head(df1)
library(pheatmap)
color=colorRampPalette(c("navy", "white", "firebrick3"))(10)
col <- read.csv('hormones_col.csv',header = T,row.names = 1,check.names = F)
pheatmap(df2,display_numbers = T,show_rownames = T,annotation_col = col,
         cutree_rows = 3,cutree_cols = 3,border_color = 'white',color=color)
library(tidyverse)
df3 <- read.csv('boxplot.csv',header = T,check.names = F)
head(df3)
df3 <- pivot_longer(df3,cols = -Class,names_to = 'Group',values_to = 'Content' )
ggplot(data = df3,aes(x=Group,y=log2(Content+1)))+geom_boxplot(aes(fill=Group))

library(ComplexHeatmap)
library(dendextend)
row_dend = as.dendrogram(hclust(dist(df2)))
column_dend=as.dendrogram(hclust(dist(df2)))
column_dend = color_branches(column_dend, k = 3)
row_dend = color_branches(row_dend, k = 3)
column_ha = HeatmapAnnotation(df=col,
                              gp = gpar(col=NA))
Heatmap(df2,name = 'Cor',
               cluster_rows = row_dend,cluster_columns = column_dend,
               top_annotation = column_ha,row_split = 3,column_split=3,row_title = NULL,
        column_title=NULL,border = T,
               cell_fun = function(j, i,x,y,w,h,fill)
               {grid.text(sprintf("%.2f", pindex(df2, i, j)),x,y,gp = gpar(fontsize = 8))})
