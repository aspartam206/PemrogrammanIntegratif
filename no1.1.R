# dependency
library(SPARQL)
library(ggplot2)
library(ggrepel)
library(plotly)

endpoint <- "http://localhost:3030/pi/query"
query <-"[TRUNCATED]"

# query from sparql endpoint
quedata <- SPARQL(endpoint,query)
# parsing result
puskesmas = quedata$results
df=puskesmas
puskesmasMatrix=as.matrix(cbind(df$puskes, df$pop),ncol=2)

# execute
fit <- kmeans(puskesmasMatrix, 5)
pus <- ggplot(data=df, aes(x=pop, y=puskes, color = factor(fit$cluster), label= puskesmas$name)) + geom_point() 
pus + geom_segment(aes(x = 0, y = 0, xend = 3600000, yend = 1200, colour = "segment"))
ggplotly(label= puskesmas$name)