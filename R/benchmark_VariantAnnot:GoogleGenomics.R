#' @import VariantAnnotation
#' @import VariantTools
#' @import ldblock
#' @import microbenchmark
#' @import GoogleGenomics
#' @author Shweta Gopaulakrishnan <reshg@channing.harvard.edu>
#'Extracting the genotypes for interval ranges between - 16051400,16051500 on chromosome 22 using VariantAnnotation approach.
#'Looking at the time taken to perform this using VariantAnnotation readVcf method.
#'
micro_readVcf <- function(){
  parm = ScanVcfParam(which = GRanges("22", IRanges(16051400,16051500)))
  parmlibrar
  myread_readvcf = readVcf(s3_1kg("22"), param = parm)
  m1 = microbenchmark(readVcf(s3_1kg("22"), param = parm),times = 5)
  m1
}
#'
#' Result :
#' Unit: seconds
#'  expr       min       lq        mean      median    uq        max       neval
#'  myread   1.965495 1.987981  2.345124  2.079625  2.822946  2.869573       5
#'
#'Extracting the genotypes for interval ranges between - 16051400,16051500 on chromosome 22 using GoogleGenomics approach.
#'Looking at the time taken to perform this using the GoogleGenomics approach.
#'
micro_getVariantCalls <- function(){
  myread_getvariantsCalls = getVariantCalls(datasetId = "10473108253681171589", chromosome = "22", start = 16051400, end = 16051500, fields = NULL, converter = c)
  myread_getvariantsCalls
  m2 = microbenchmark(getVariantCalls(datasetId = "10473108253681171589", chromosome = "22", start = 16051400, end = 16051500, fields = NULL, converter = c),times = 5)
  m2
}
#'
#'Result :
#'Unit: milliseconds
#'expr                  min        lq    mean    median         uq       max      neval
#'myread_getvariants  868.4498  870.38  955.5926   916.1046  943.5811  1179.448     5
