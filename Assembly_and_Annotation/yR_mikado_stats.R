# what are se introns
# September 2020
# anna.duenser@gmail.com
install.packages("tidyverse", repos = 'https://cran.wu.ac.at/')
install.packages("rtracklayer", repos = 'https://cran.wu.ac.at/')

library("tidyverse")
library("rtracklayer")
library("dplyr")

FILE.DIR = "/cl_tmp/singh_duenser/Ehsan/gffread" #!change this
setwd(FILE.DIR) 

DATE <- format(Sys.time(), "%m%d%Y")

all.files <- list.files(FILE.DIR, full.names = FALSE)
gffcmp_files <- as.vector(grep("final.*annotated.gtf", all.files, value = TRUE))

# select desired file:
test_file <- gffcmp_files

# import file as tibble
raw <- import(test_file) %>% as_tibble()

# split by transcript id to calculate introns:
a <- raw[raw$type != "transcript",] %>% group_split(transcript_id)
resl <- lapply(a, function(current){
  print(current$transcript_id[1])
  if(length(current$start) > 1){
    
  exon_start <<- current$start
  exon_end   <<- current$end
  
  intron_start <<- exon_end[-length(exon_end)] + 1
  intron_end <<- exon_start[-1] - 1
  res <- tibble(
    seqnames = current$seqnames[-1],
    start    = intron_start,
    end      = intron_end,
    width    = intron_end - intron_start,
    strand = NA,
    source = NA,
    type = "intron",
    score = NA, phase = NA,
    transcript_id = current$transcript_id[-1],
    gene_id = current$gene_id[-1],
    xloc = NA, class_code = NA, tss_id = NA, exon_number = NA, gene_name = NA, cmp_ref = NA
  )  
  return(res)
  }
})

# generate tibble from list
result <- bind_rows(resl)
# remove list
rm(resl)

# combine imported list and intron list
raw <- raw %>% add_row(result)

# summarize statistics per gene
gene_sum <- raw[raw$type == "transcript",] %>% group_by(gene_id, gene_name, type) %>% summarise(
  n = n(),
  mean = mean(width),
  median = median(width),
  max = max(width),
  min = min(width)
)


# find instances where different MSTRG.IDs are assigned to one ENSEMBL.ID
list_of_duplicates <- gene_sum %>% group_by(gene_name) %>% filter(n() >=2) %>% na.omit()


# summarize statistics per transcript
transcript_sum <- raw %>% group_by(transcript_id, type) %>% summarise(
  n = n(),
  mean = mean(width),
  median = median(width),
  max = max(width),
  min = min(width),
  gene_id = unique(gene_id),
  gene_name = unique(gene_name),
  class_code = unique(class_code)
)


# mikado in ugly
nr_genes <- nrow(gene_sum)
transcripts_per_gene <- nrow(transcript_sum[(transcript_sum$type == "transcript"),]) 
transcript_per_gene <- summary(gene_sum$n)
monoexonic_transcripts <- nrow(transcript_sum[(transcript_sum$type == "exon" & transcript_sum$n == 1),])
exons_per_transcript <- summary(transcript_sum[(transcript_sum$type == "exon"),])
introns <- raw[raw$type == "intron",]
intron_length <- summary(introns$width)
exons <- raw[raw$type == "exon",]
exon_length <- summary(exons$width)
transcripts <- raw[raw$type == "transcript",]
transcript_length <- summary(transcripts$width)

# print log file
my_log <- file(paste("gtf_stats_", DATE, ".txt", sep = ""))
sink(my_log, append = TRUE, type = "output", split = TRUE)

print("Summary of ugly mikado.2")
print("nr_genes")
print(nr_genes)
print("transcript_per_gene")
print(transcripts_per_gene)
print("monoexonic_transcripts")
print(monoexonic_transcripts)
print("exons_per_transcript")
print(exons_per_transcript)
print("intron_length")
print(intron_length)
print("exon_length")
print(exon_length)
print("transcript_length")
print(transcript_length)

sink()

# make histograms
hist(gene_sum$median)
hist(gene_sum$n[gene_sum$n])
hist(raw$width[raw$type == "transcript"])
hist(raw$width[raw$type == "exon"])
hist(raw$width[raw$type == "intron"])
hist(log10(raw$width[raw$type == "transcript"]))
hist(log10(raw$width[raw$type == "exon"]))
hist(log10(raw$width[raw$type == "intron"]))
hist(transcript_sum$n[transcript_sum$type == "exon"], main = "Number of exons per transcript")
hist(gene_sum$n, main = "Number of transcripts per gene_id")

nr_duplicates <- list_of_duplicates %>% group_by(gene_name) %>% summarise(n = n())
hist(nr_duplicates$n)
