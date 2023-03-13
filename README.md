# Digital-Spatial-Profiling-Workflow

This workflow was built to address the need for streamlining the analysis of Spatial Transcriptomics data produced from Digital Spatial Profiling Technology (NanoString) and is based mostly on the [vignette on Bioconductor] (http://bioconductor.org/packages/release/workflows/vignettes/GeoMxWorkflows/inst/doc/GeomxTools_RNA-NGS_Analysis.html).  It has been tested on several GeoMx Whole Transcriptome Atlas (WTA) datasets for [human](https://nanostring.com/products/geomx-digital-spatial-profiler/geomx-rna-assays/geomx-whole-transcriptome-atlas/) and [mouse](https://nanostring.com/products/geomx-digital-spatial-profiler/geomx-rna-assays/geomx-mouse-whole-transcriptome-atlas/). The workflow    



The development environment is provided in the Dockerfile/ directory, there are two sets of files:
  1. Conda_container/ : The container includes a conda environment: DSPWorkflow_NDIAP.
  2. Plain_R_container/ : Then container includes a plain R environment.
