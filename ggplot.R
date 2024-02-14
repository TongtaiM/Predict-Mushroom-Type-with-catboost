library(ggplot2)


mushroomdata = mushroomdata %>% na.omit(mushroomdata)
str(mushroomdata)

ggplot(data = mushroomdata, aes(x = gill.attachment,fill = class)) +geom_bar() + scale_fill_manual(values=c("#CAA600","#A601CA"))+ theme(text = element_text(size = 10))
ggplot(data = mushroomdata, aes(x = stem.color,fill = class)) +geom_bar() + scale_fill_manual(values=c("#CAA600","#A601CA"))+ theme(text = element_text(size = 10))
ggplot(mushroomdata, aes(x=stem.width,fill = class)) + geom_histogram(bins=50)+scale_fill_manual(values=c("#CAA600","#A601CA"))+ theme(text = element_text(size = 10))

max(mushroomdata$stem.width)
slice_max(mushroomdata$stem.width,order_by = mushroomdata$stem.width)
slice_max(mushroomdata$stem.width)
mushroomdata$stem.width
h = hist(mushroomdata$stem.width)
h$counts
