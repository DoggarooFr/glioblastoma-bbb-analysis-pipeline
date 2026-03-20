# -*- coding: utf-8 -*-
"""
Created on Wed Apr 17 20:54:21 2024

@author: Frank
"""

import pandas as pd
import os

def process_files(folder_path):
    with pd.ExcelWriter('Combined & Rename.xlsx', engine='openpyxl') as writer:
        for filename in os.listdir(folder_path):
            if filename.endswith('.csv'):
                file_path = os.path.join(folder_path, filename)
                df = pd.read_csv(file_path)

                df = df.iloc[:, 1:]  # Drop the first column
                headers = df.columns.tolist()  # Get the list of headers

                grouped_data = {}
                for index, group in df.groupby(df.columns[0]):
                    group = group.iloc[:, 1:].reset_index(drop=True)  # Drop the 'ROI index' column and reset index
                    # Create a single-row DataFrame for 'ROI Number'
                    roi_number_df = pd.DataFrame({'ROI': [index]})
                    # Concatenate 'ROI Number' with the group DataFrame horizontally
                    group_with_roi = pd.concat([roi_number_df, group], axis=1)
                    # Adjust the headers to include 'ROI Number'
                    group_with_roi.columns = ['ROI'] + headers[1:]
                    grouped_data[index] = group_with_roi

                startcol = 0
                sheet_name = os.path.splitext(filename)[0]
                for index, data in grouped_data.items():
                    # Write data with headers, starting from the first row
                    data.to_excel(writer, sheet_name=sheet_name, startrow=0, startcol=startcol, index=False)
                    # Move start column to right after the last data column + spacer
                    startcol += len(data.columns) + 2

if __name__ == "__main__":
    import sys
    if len(sys.argv) > 1:
        folder_path = sys.argv[1]  # Folder path from the command line
    else:
        folder_path = input("Enter the folder path: ")
    process_files(folder_path)
