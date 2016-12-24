# dependency
library(SPARQL)
library(ggplot2)
library(ggrepel)
library(plotly)
library(cluster)
library(ggfortify)

endpoint <- "http://localhost:3030/pi/query"
query <-"[TRUNCATED]"

# query from sparql endpoint
quedata <- SPARQL(endpoint,query)
# parsing result
puskesmas = quedata$results
df=puskesmas
puskesmasMatrix=as.matrix(cbind(df$puskes, df$dokterumum, df$doktergigi, df$perawat, df$bidan, df$pop, df$area),ncol=8)
puskesmasData = data.frame(puskesmasMatrix)
# execute
fit <- kmeans(puskesmasData, 5)

autoplot(fit, data = puskesmasData, label = TRUE)
ggplotly(label = puskesmas$name)

fit
fit$size
fit$withinss

