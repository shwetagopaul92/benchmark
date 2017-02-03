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
#' benchmark readVcf for select genomic interval, and return the vcf object with timings in a list for a local file.
#' @export
micro_localreadVcf <- function(chr="22", start=16051400, end=16051500, times=5){
  thecall = match.call()
  parm = ScanVcfParam(which = GRanges(chr, IRanges(start,end)))  # should check against chromosome lengths in seqlengths(Homo.sapiens)
  #readVcf(s3_1kg("22"), param = parm)
  m3 = microbenchmark(tmp <- readVcf("/Users/reshg/Documents/My_benchmark_files/ALL.chr22.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz.tbi", param = parm),times = times) # not yet a VRanges so may be cheaper than we deserve
  list(bench=m3, data=tmp, call=thecall)
}
#' @title closure for flexible file handling
#' @describeIn micro_localreadVcf
#' @export
micro_readVcf_clo <- function(vcffile) function(chr="22", start=16051400, end=16051500, times=5){
  thecall = match.call()
  parm = ScanVcfParam(which = GRanges(chr, IRanges(start,end)))  # should check against chromosome lengths in seqlengths(Homo.sapiens)
  #myread_readvcf = readVcf(vcffile, param = parm)
  m1 = microbenchmark(tmp <- readVcf(vcffile, param = parm),times = times) # not yet a VRanges so may be cheaper than we deserve
  #list(bench=m1, data=tmp, call=thecall)
  list(timings = m1, outputSize=object.size(tmp), start=start, end=end, chr=chr )
}
  # instead of returning a list, design a class
  # setOldClass("microbenchmark")
  # setClass("benchOut", representation(timings="microbenchmark", outputSize="numeric", start="numeric", chr="character"))
  # setMethod("..." ..
#
# Result :
# Unit: seconds
#  expr       min       lq        mean      median    uq        max       neval
#  myread   1.965495 1.987981  2.345124  2.079625  2.822946  2.869573       5
