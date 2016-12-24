# dependency
library(SPARQL)
library(ggplot2)
library(ggrepel)
library(plotly)
library(cluster)
library(ggfortify)
library(ggmap)

endpoint <- "http://localhost:3030/pi/query"
query <-"[TRUNCATED]"

# query from sparql endpoint
quedata <- SPARQL(endpoint,query)
# parsing result
puskesmas = quedata$results
df=puskesmas
puskesmasMatrix=as.matrix(cbind(df$puskes, df$dokterumum, df$doktergigi, df$perawat, df$bidan, df$pop, df$area),ncol=9)
puskesmasData = data.frame(puskesmasMatrix)
# execute
ina_center = as.numeric(geocode("Indonesia"))
INAMap = ggmap(get_googlemap(center=ina_center, scale=2, zoom=4), extent="normal")
circle_scale_amt = 0.030
INAMap + 
  coord_fixed(xlim= c(95, 140), ylim = c(-12, 10)) + 
  geom_point(aes(x=puskesmas$long, y=puskesmas$lat), data=puskesmasData, col="orange", alpha=0.4, size=puskesmas$puskes*circle_scale_amt) +
  scale_size_continuous(range=range(puskesmasData$puskes)) 

