### Comparing for 1k interval gap

parm = ScanVcfParam(which = GRanges("22", IRanges(16051400,16051500)))
m1 = microbenchmark(readVcf(s3_1kg("22"), param = parm),times = 5)

m2 = microbenchmark(getVariantCalls(datasetId = "10473108253681171589", chromosome = "22", start = 16051400,
                                           end = 16051500, fields = NULL, converter = c), times=5 )

### Comparing for 10k interval gap

parm = ScanVcfParam(which = GRanges("22", IRanges(16051400,16061400)))
m1_a = microbenchmark(readVcf(s3_1kg("22"), param = parm),times = 5)

m2_a = microbenchmark(getVariantCalls(datasetId = "10473108253681171589", chromosome = "22", start = 16051400,
                                    end = 16061400, fields = NULL, converter = c), times=5 )

### Comparing the 50k interval gap

parm = ScanVcfParam(which = GRanges("22", IRanges(16051400,16101400)))
m1_b = microbenchmark(readVcf(s3_1kg("22"), param = parm),times = 5)

m2_b = microbenchmark(getVariantCalls(datasetId = "10473108253681171589", chromosome = "22", start = 16051400,
                                      end = 16101400, fields = NULL, converter = c), times=5 )

#getVariantCalls(datasetId="11027761582969783635", chr="22", start=16.005e6, end=16.052e6)
