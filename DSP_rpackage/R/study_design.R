####This code comes from http://www.bioconductor.org/packages/release/workflows/vignettes/GeoMxWorkflows/inst/doc/GeomxTools_RNA-NGS_Analysis.html#4_QC__Pre-processing


library(dplyr)
library(ggforce)

# select the annotations we want to show, use `` to surround column names with
# spaces or special symbols
count_mat <- count(pData(demoData), `slide name`, class, region, segment)
# simplify the slide names
count_mat$`slide name` <- gsub("disease", "d",
                               gsub("normal", "n", count_mat$`slide name`))
# gather the data and plot in order: class, slide name, region, segment
test_gr <- gather_set_data(count_mat, 1:4)
test_gr$x <- factor(test_gr$x,
                    levels = c("class", "slide name", "region", "segment"))
# plot Sankey
ggplot(test_gr, aes(x, id = id, split = y, value = n)) +
  geom_parallel_sets(aes(fill = region), alpha = 0.5, axis.width = 0.1) +
  geom_parallel_sets_axes(axis.width = 0.2) +
  geom_parallel_sets_labels(color = "white", size = 5) +
  theme_classic(base_size = 17) + 
  theme(legend.position = "bottom",
        axis.ticks.y = element_blank(),
        axis.line = element_blank(),
        axis.text.y = element_blank()) +
  scale_y_continuous(expand = expansion(0)) + 
  scale_x_discrete(expand = expansion(0)) +
  labs(x = "", y = "") +
  annotate(geom = "segment", x = 4.25, xend = 4.25,
           y = 20, yend = 120, lwd = 2) +
  annotate(geom = "text", x = 4.19, y = 70, angle = 90, size = 5,
           hjust = 0.5, label = "100 segments")