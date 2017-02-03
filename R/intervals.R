
### Testing for different interval widths for readVCF approach.
# ignore the class stuff - i created one so that i could access the values later easily.
test_readVCF <- function(chr, start, end){
  ###thecall = match.call()
  width_interval = list(end-start)
  print(width_interval)
  parm = ScanVcfParam(which = GRanges(chr, IRanges(start,end)))  ### should check against chromosome lengths in seqlengths(Homo.sapiens)
  m8 = list(microbenchmark(tmp <- readVcf(s3_1kg(chr), param = parm),times = 5)) # not yet a VRanges so may be cheaper than we deserve
  print(m8)
  return(list(width_interval,m8))
}
### To generate different width of intervals.
atest = list()
for(i in seq(16051500,16051502,1)){
  x = i
  print(x)
  atest = c(atest,test_readVCF("22", 16051400,x))
}

### To draw a plot for mean of time taken for microbenchmarking against a range of intervals.
time_int = list()
width_int =  list()
for(i in seq(1,6,1)){
  if((i %% 2) == 0){
    time_int = c(time_int, mean(atest[[i]][[1]][[2]]))
  }
  else{
    width_int = c(width_int, mean(atest[[i]][[1]]))
  }
}


