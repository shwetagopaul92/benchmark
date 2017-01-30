# Loading the required libraries and packages.

source("https://bioconductor.org/biocLite.R")
biocLite("microbenchmark")
biocLite("ldblock")
biocLite("VariantAnnotation")
biocLite("VariantTools")
biocLite("GoogleGenomics")

library(microbenchmark)
library(VariantAnnotation)
library(VariantTools)
library(GoogleGenomics)
library(ldblock)

#Extracting the genotypes for interval ranges between - 16051400,16051500 on chromosome 22 using VariantAnnotation approach.
## Looking at the time taken to perform this using VariantAnnotation readVcf method. 

example("readVcfAsVRanges")
parm = ScanVcfParam(which = GRanges("22", IRanges(16051400,16051500)))
parm
readVcf(s3_1kg("22"), param = parm)
myread_readvcf = readVcf(s3_1kg("22"), param = parm)
m1 = microbenchmark(myread_readvcf, times = 5)
m1

### Result : 
### Unit: nanoseconds
### expr    min lq  mean median uq  max  neval
### myread   31 31  307   32    98  1343     5

#Extracting the genotypes for interval ranges between - 16051400,16051500 on chromosome 22 using GoogleGenomics approach.
## Looking at the time taken to perform this using the GoogleGenomics approach.

getVariants(datasetId = "10473108253681171589", chromosome = "22", start = 16051400, end = 16051500, fields = NULL, converter = c)
myread_getvariants = getVariants(datasetId = "10473108253681171589", chromosome = "22", start = 16051400, end = 16051500, fields = NULL, converter = c)
myread_getvariants
m2 = microbenchmark(myread_getvariants, times = 5)
m2

### Result :
### Unit: nanoseconds
### expr                min lq  mean  median uq   max  neval
### myread_getvariants  30  31  457.8   34   166  2028     5

#Comparing the two methods : 
### runs each argument 100 times to get an average look at how long each evaluation takes.
m3 = microbenchmark(
  myread_readvcf,
  myread_getvariants
)
m3

### Result :
### Unit: nanoseconds
### expr                min lq  mean  median uq   max  neval
### myread_readvcf      29  30  40.54   30   31   926   100
### myread_getvariants  28  29  47.07   30   31  1155   100

### runs each argument 5 times to get an average look at how long each evaluation takes.

m4 = microbenchmark(myread_readvcf,myread_getvariants, times = 5)
m4

### Result: 
###Unit: nanoseconds
###expr               min lq  mean  median  uq  max  neval
###myread_readvcf     39  67  284.6   67    119 1131     5
###myread_getvariants 44  50  469.6   60    323 1871     5