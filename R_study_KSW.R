getwd()

iris

dd <- iris
head(dd)

aa <- read.delim("AWS_sample.txt",
                 sep = "#",
                 stringsAsFactors = FALSE)
head(aa)
tail(aa)

str(aa)
summary(aa)

nrow(aa)
ncol(aa)
dim(aa)
colnames(aa)

aa$TA

aa[2,]

aa[,"Wind"]
aa[,c("AWS_ID", "TA")]
aa[,c("TA", "AWS_ID")]

aa[1,3]
aa["1", "TA"]
aa[2:5, c("TA", "Wind")]

head(aa)

aaa = aa[1:3 , 2:4]
bbb = aa[9:11, 2:4]

cbind(aaa, bbb)
rbind(aaa, bbb)

aaa
bbb

table(aa$AWS_ID)
table(aa$AWS_ID, aa$X.)

aa[2500:3100,"X."] = "kkk"
table(aa$AWS_ID, aa$X.)
paste0(prop.table(table(aa$AWS_ID)) *100, "%")

table(aa[,c("AWS_ID", "X.")])
