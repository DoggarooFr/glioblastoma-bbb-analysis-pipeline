// CHANGE THE IMAGE NAME
// CHANGE THE IMAGE NAME 
// CHANGE THE IMAGE NAME
Z_Stack_Image_name = "AVG_20240401.oir";
desktopPath = "C:/Users/Frank/Desktop/";
csvFilePath = desktopPath + "NAME_ME_!!.csv";

run("Clear Results");


rowCounter = 0;

greenImage = "C1-" + Z_Stack_Image_name;
redImage = "C2-" + Z_Stack_Image_name;
greenImageExists = isOpen(greenImage);
redImageExists = isOpen(redImage);
var measurementsPerROI = 0;


function processChannel(channelImage, channelColor) {
    selectWindow(channelImage);
    roiManager("Select", i);
    run("Plot Profile");


    plotWindowName = "Plot of " + channelImage.substring(0, channelImage.lastIndexOf("."));

    if (isOpen(plotWindowName)) {
        selectWindow(plotWindowName);
        print("Processing: " + plotWindowName); 


        x = newArray();
        y = newArray();
        Plot.getValues(x, y);


        if (channelColor == "Green") {
            measurementsPerROI = x.length;
            for (j = 0; j < y.length; j++) {
                setResult("ROI Index", rowCounter, i);
                setResult("Distance", rowCounter, x[j]);
                setResult("Green", rowCounter, y[j]);
                rowCounter++;
            }
        }

        else if (channelColor == "Red") {
            var baseRow = i * measurementsPerROI;
            for (j = 0; j < y.length; j++) {
                setResult("Red", baseRow + j, y[j]);
            }
        }

        updateResults(); 
        close(plotWindowName); 
    } else {
        print("Plot window not found for ROI: " + i + " in " + channelImage);
    }
}


for (i = 0; i < roiManager("count"); i++) {
    if (greenImageExists) {
        processChannel(greenImage, "Green");
    }
    if (redImageExists) {
        processChannel(redImage, "Red");
    }
}


saveAs("Results", csvFilePath);

if (isOpen("Results")) {
    selectWindow("Results"); 
    run("Close");
}


wait(500); 

if (isOpen("Log")) {
    selectWindow("Log"); 
    run("Close");
}
