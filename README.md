# glioblastoma-vascular-analysis
Computational pipeline for analyzing glioblastoma-associated capillary dynamics and blood-brain barrier (BBB) dysfunction from microscopy data. The pipeline integrates MATLAB, ImageJ, Python, and VBA-based scripts for data compilation, ROI intensity extraction, capillary feature analysis, and permeability-surface area (PS) quantification.

## Study objective
This project supports analysis of longitudinal imaging data from mouse glioblastoma model. The goal is to quantify tumor-associated vascular changes, including capillary signal dynamics, structural alterations, and blood-brain barrier permeability over time. Imaging data were collected using in vivo two-photon microscopy and immunohistochemistry imaging.

## Workflow overview

The analysis pipeline is organized into four stages:

1. **ImageJ analysis**  
   Extracts Green and Red channel intensity profiles from user-drawn ROIs in Z-stacked microscopy images and exports the data as CSV files.

2. **Macro analysis**  
   Processes compiled ROI datasets in Excel/VBA to detect peaks, estimate capillary-related signal width, identify left/right minima, and generate grouped datasets     and summary plots.

3. **PS analysis**  
   Normalizes and aligns signal curves, identifies threshold crossings, computes diameter-related metrics, and estimates permeability-surface area (PS) product over    time.
