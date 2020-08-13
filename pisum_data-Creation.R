library(tidyverse)
library(brms)
library(cowplot)
library(tidybayes)

# Add a column to the data which species the species:
# The wild species is Pisum fulvum, the domesticated speceis is Pisum sativum var. sativum.
#dat <- read.table("~/Dropbox/stress_review/results/lit_search/manual_search/scraped/Naim-Feil_2017/naim_feil.txt",T,'\t')

# Read in the data and the metadata to join them
naim <- read_csv("~/Dropbox/stress_review/results/lit_search/manual_search/scraped/Naim-Feil_2017/data.csv", T, comment="#")
meta <- read_csv("~/Dropbox/stress_review/results/lit_search/manual_search/scraped/Naim-Feil_2017/metadata1", T, comment="#")

# Join the two by geno
dat <- full_join(meta, naim, by = c("geno" = "geno")) %>%
  mutate(variety = paste(genus, species, subspecies, sep="_"))

# Take a look at the data to see what's going on for a few traits.
datw <- filter(dat, treatment=="W")
datd <- filter(dat, treatment=="D")

p0 <- ggplot(data = datw, aes(y=vegetative_dry_Matter, x=dom_extent)) + 
  geom_boxplot() + ggtitle("Well watered") + ylim(c(0,800))
p1 <- ggplot(data = datd, aes(y=vegetative_dry_Matter, x=dom_extent)) + 
  geom_boxplot() + ggtitle("Drought") + ylim(c(0,800))
p2 <- ggplot(data = datw, aes(y=total_dry_matter, x=dom_extent)) + 
  geom_boxplot() + ggtitle("Well watered") + ylim(c(0,1500))
p3 <- ggplot(data = datd, aes(y=total_dry_matter, x=dom_extent)) + 
  geom_boxplot() + ggtitle("Drought") + ylim(c(0,1500))

plot_grid(p0, p1, p2, p3, ncol = 2)
