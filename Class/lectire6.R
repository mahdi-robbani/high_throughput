#devtools::install_github("kvittingseerup/IsoformSwitchAnalyzeR", build_vignettes = TRUE)
#install.packages('ellipsis')

library(tidyverse)
library('IsoformSwitchAnalyzeR')
#vignette("IsoformSwitchAnalyzeR")
packageVersion('IsoformSwitchAnalyzeR')


salmonQuant <- importIsoformExpression(
  parentDir = system.file("extdata/",package="IsoformSwitchAnalyzeR")
)
head(salmonQuant$abundance, 2)
head(salmonQuant$counts, 2)
myDesign <- data.frame(
  sampleID = colnames(salmonQuant$abundance)[-1],
  condition = gsub('_.*', '', colnames(salmonQuant$abundance)[-1])
)
myDesign

### Create switchAnalyzeRlist
aSwitchList <- importRdata(
  isoformCountMatrix   = salmonQuant$counts,
  isoformRepExpression = salmonQuant$abundance,
  designMatrix         = myDesign,
  isoformExonAnnoation = system.file("extdata/example.gtf.gz"             , package="IsoformSwitchAnalyzeR"),
  isoformNtFasta       = system.file("extdata/example_isoform_nt.fasta.gz", package="IsoformSwitchAnalyzeR"),
  showProgress = FALSE
)

data("exampleSwitchList")

exampleSwitchList <- isoformSwitchAnalysisPart1(
  switchAnalyzeRlist   = exampleSwitchList,
  # pathToOutput = 'path/to/where/output/should/be/'
  outputSequences      = FALSE, # change to TRUE whan analyzing your own data 
  prepareForWebServers = FALSE  # change to TRUE if you will use webservers for external sequence analysis
)

extractSwitchSummary( exampleSwitchList )

exampleSwitchList <- isoformSwitchAnalysisPart2(
  switchAnalyzeRlist        = exampleSwitchList, 
  dIFcutoff                 = 0.3,   # Cutoff for defining switch size - set high for short runtime in example data
  n                         = 10,    # if plotting was enabled, it would only output the top 10 switches
  removeNoncodinORFs        = TRUE,  # Because ORF was predicted de novo
  pathToCPC2resultFile      = system.file("extdata/cpc2_result.txt"         , package = "IsoformSwitchAnalyzeR"),
  pathToPFAMresultFile      = system.file("extdata/pfam_results.txt"        , package = "IsoformSwitchAnalyzeR"),
  pathToIUPred2AresultFile  = system.file("extdata/iupred2a_result.txt.gz"  , package = "IsoformSwitchAnalyzeR"),
  pathToSignalPresultFile   = system.file("extdata/signalP_results.txt"     , package = "IsoformSwitchAnalyzeR"),
  outputPlots               = FALSE  # keeps the function from outputting the plots from this example
)


switchPlot(
  exampleSwitchListAnalyzed,
  gene='ZAK',
  condition1 = 'COAD_ctrl',
  condition2 = 'COAD_cancer',
  localTheme = theme_bw(base_size = 13) # making text sightly larger for vignette
)


switchPlot(
  exampleSwitchList,
  gene='LDLRAD2',
  condition1 = 'COAD_ctrl',
  condition2 = 'COAD_cancer',
  localTheme = theme_bw(base_size = 13) # making text sightly larger for vignette
)

extractTopSwitches(exampleSwitchList, filterForConsequences = TRUE, n=10)

data("exampleSwitchListAnalyzed")

extractSwitchSummary(
  exampleSwitchListAnalyzed,
  filterForConsequences = TRUE
) 

subset(
  extractTopSwitches(
    exampleSwitchListAnalyzed,
    filterForConsequences = TRUE,
    n=10,
    inEachComparison = TRUE
  )[,c('gene_name','condition_2','gene_switch_q_value','Rank')],
  gene_name == 'LDLRAD2'
)

switchPlot(
  exampleSwitchListAnalyzed,
  gene='ZAK',
  condition1 = 'COAD_ctrl',
  condition2 = 'COAD_cancer',
  localTheme = theme_bw(base_size = 13) # making text sightly larger for vignette
)
