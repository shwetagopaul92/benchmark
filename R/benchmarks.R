#' @import VariantAnnotation
#' @import VariantTools
#' @import ldblock
#' @import microbenchmark
#' @import GoogleGenomics
#' @author Shweta Gopaulakrishnan <reshg@channing.harvard.edu>
# Extracting the genotypes for interval ranges between - 16051400,16051500 on chromosome 22 using VariantAnnotation approach.
# Looking at the time taken to perform this using VariantAnnotation readVcf method.
#' @param chr character encoding chromosome in the vcf
#' @param start starting location for interval to search for variants
#' @param end end location of interval
#' @param times passed to \code{\link[microbenchmark]{microbenchmark}}
#' @return a list with components \code{bench} giving timings, \code{data} giving variants, and \code{call} describing call
#' @title
#' benchmark readVcf for select genomic interval, and return the vcf object with timings in a list
#' @export
micro_readVcf <- function(chr="22", start=16051400, end=16051500, times=5){
  thecall = match.call()
  parm = ScanVcfParam(which = GRanges(chr, IRanges(start,end)))  # should check against chromosome lengths in seqlengths(Homo.sapiens)
  #myread_readvcf = readVcf(s3_1kg(chr), param = parm)
  m1 = microbenchmark(tmp <- readVcf(s3_1kg(chr), param = parm),times = times) # not yet a VRanges so may be cheaper than we deserve
  #list(bench=m1, data=tmp, call=thecall)
  list(timings = m1, outputSize=object.size(tmp), start=start, end=end, chr=chr )
}
#
# Result :
# Unit: seconds
#  expr       min       lq        mean      median    uq        max       neval
#  myread   1.965495 1.987981  2.345124  2.079625  2.822946  2.869573       5
#'
# Extracting the genotypes for interval ranges between - 16051400,16051500 on chromosome 22 using GoogleGenomics approach.
# Looking at the time taken to perform this using the GoogleGenomics approach.
#' @param chr character encoding chromosome in the vcf
#' @param start starting location for interval to search for variants
#' @param end end location of interval
#' @param times passed to \code{\link[microbenchmark]{microbenchmark}}
#' @return a list with components \code{bench} giving timings, \code{data} giving variants, and \code{call} describing call
#' @title
#' benchmark GG getVariantCalls for select genomic interval, and return the vcf object with timings in a list
#' @author Shweta Gopaulakrishnan <reshg@channing.harvard.edu>
#'@export
micro_getVariantCalls <- function(datasetId="10473108253681171589", chr="22", start=16051400, end=16051500, times=5,
                                  fields=NULL, converter=c){
  thecall = match.call()
  m2 = microbenchmark(tmp <- getVariantCalls(datasetId = datasetId, chromosome = chr, start = start,
                                            end = end, fields = fields, converter = converter), times=times )
  list(bench=m2, data=tmp, call=thecall)
}
#
#Result :
#Unit: milliseconds
#expr                  min        lq    mean    median         uq       max      neval
#myread_getvariants  868.4498  870.38  955.5926   916.1046  943.5811  1179.448     5
