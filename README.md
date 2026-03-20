# glioblastoma-vascular-analysis

A computational pipeline for analyzing glioblastoma-associated capillary dynamics and blood-brain barrier (BBB) dysfunction from microscopy data. This workflow integrates MATLAB, ImageJ, Python, and VBA-based scripts for data compilation, ROI intensity extraction, capillary feature analysis, and permeability–surface area (PS) quantification.

## Study objective

This project supports the analysis of longitudinal imaging data collected from a mouse glioblastoma model. The goal is to quantify tumor-associated vascular changes over time, including capillary signal dynamics, structural alterations, and blood-brain barrier permeability. Imaging data were acquired using in vivo two-photon microscopy and immunohistochemistry.

## Workflow overview

The analysis pipeline is organized into three major stages:

1. **ImageJ analysis**  
   Extracts green and red channel intensity profiles from user-drawn ROIs in Z-stacked microscopy images and exports the results as CSV files.

2. **Macro analysis**  
   Processes compiled ROI datasets in Excel/VBA to detect peaks, estimate capillary-related signal widths, identify left and right minima, and generate grouped datasets and summary plots.

3. **PS analysis**  
   Normalizes and aligns signal curves, identifies threshold crossings, computes diameter-related metrics, and estimates permeability–surface area (PS) values over time.

## Script descriptions

Detailed descriptions for individual scripts are provided in the corresponding folders.

## Typical inputs

- CSV files exported from microscopy or prior analysis software
- Excel workbooks containing compiled ROI- or region-based data in the required format
- Z-stacked image files processed in ImageJ

## Software requirements

- MATLAB
- ImageJ / Fiji
- Python 3
  - pandas
  - openpyxl
- Microsoft Excel with VBA enabled

## Usage notes

Most scripts require user-specific file paths, worksheet formats, or column layouts to be adjusted before execution. Because these workflows were developed for a laboratory-specific data organization system, users should review file naming conventions, sheet structures, and expected column headers before running the scripts.

## Limitations

These scripts were developed for a specific experimental workflow and data structure. Some scripts assume fixed worksheet layouts, channel naming conventions, or manually prepared ROIs. Minor modifications may be required to adapt the pipeline for other datasets.

## Contribution

This repository contains analysis scripts developed as part of imaging-based vascular and blood-brain barrier analysis for glioblastoma research under the mentorship of Dr. Jiandi Wan and Dr. Brianna Urbina.
