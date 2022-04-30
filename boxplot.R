df <- read.csv("violin.csv",header = T)
head(df)
dim(df)
df1 <- mycounts[rowSums(df[,-1]) != 0,]
dim(df1)
library(tidyverse)
library(ggsci)
library(paletteer)
d_palettes <- palettes_d_names
df2 <- pivot_longer(df,col=-gene.id,names_to = 'Tissue',values_to = 'FPKM')
head(df2)
ggplot(df2,aes(x=Tissue, y=log10(FPKM)))+
geom_boxplot(aes(fill=Tissue)) + theme_minimal()+
  theme(axis.text.x = element_text(angle = 45,hjust = 1,colour = 'black'))+
  scale_fill_paletteer_d('ggsci::default_ucscgb')+xlab('') + ylab("log10(FPKM)")
#面积图
ggplot(df2,aes(x=log10(FPKM)))+
  geom_density(aes(fill=Tissue,color=Tissue),alpha=0.5) + theme_minimal()+
  theme(axis.text.x = element_text(colour = 'black'))
