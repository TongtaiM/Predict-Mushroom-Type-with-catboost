mushroomdata = read.csv("C:/Users/matages/Desktop/MushroomDataset/secondary_data.csv",sep=";")
library(dplyr)
View(mushroomdata)

sum(is.na(mushroomdata))
sum(mushroomdata %>% duplicated())
mushroomdata = mushroomdata %>% distinct()
nrow(mushroomdata)

#cap-surface
table(mushroomdata$cap.surface)
mushroomdata = mushroomdata %>% select(-cap.surface)
str(mushroomdata)

#gill.attachment
table(mushroomdata$gill.attachment)
mushroomdata$gill.attachment[mushroomdata$gill.attachment == ""] = NA
table(mushroomdata$gill.attachment)

#stemroot
table(mushroomdata$stem.root)
mushroomdata = mushroomdata %>% select(-stem.root)
str(mushroomdata)

#stem-surface
table(mushroomdata$stem.surface)
mushroomdata = mushroomdata %>% select(-stem.surface)
str(mushroomdata)

table(mushroomdata$stem.color)

#veil-type
table(mushroomdata$veil.type)
mushroomdata = mushroomdata %>% select(-veil.type)
str(mushroomdata)

#veil-color
table(mushroomdata$veil.color)
mushroomdata = mushroomdata %>% select(-veil.color)
str(mushroomdata)

#ring-type
table(mushroomdata$ring.type)
mushroomdata$ring.type[mushroomdata$ring.type == ""] = NA
table(mushroomdata$ring.type)

#spore-print-color
table(mushroomdata$spore.print.color)
mushroomdata = mushroomdata %>% select(-spore.print.color)
str(mushroomdata)

write.csv(mushroomdata,"C:/Users/matages/Desktop/MushroomDataset/mushroomdata_clean.csv")

