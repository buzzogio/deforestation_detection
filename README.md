# osapiens terra interview challenge

## Introduction
At osapiens terra, you will be working at the cutting edge of research involving computer vision, satellite data, and algorithms. A key focus is on our deforestation detection algorithm, which employs an explainable, interpretable method that reliably identifies deforestation events in forests. In this challenge, you will develop a prototype of a pixel-wise anomaly detection algorithm, a statistical method that will significantly contribute to our efforts in monitoring and preventing deforestation.

## Expected outcome
- A Jupyter notebook (including any `utils.py` scripts) used for data loading and implementing the method.
- A set of plots illustrating your analysis results.
- A detailed description of the challenges you faced and what you learned during the challenge.

## Process
1. Review the README.md and skim through the additional material to clearly understand our expectations.
2. Inform us about the amount of time you can dedicate to this challenge.
3. We will then set a deadline to ensure timely progress and results.
4. Discuss your findings and have your code evaluated by our team.
5. Receive feedback on your submission.
6. Collaboratively, we will make a decision regarding the job offer.

## Background
Deforestation, particularly for agricultural expansion, presents significant environmental challenges. The conversion of rainforests into agricultural lands, such as soy fields, contributes to biodiversity loss, carbon emissions, and the disruption of water cycles. Recognizing these changes early is crucial for taking action against unsustainable land use practices.

Satellite imagery offers a powerful tool for monitoring deforestation. With over 40 years of data capturing every plot of land on Earth every few days, these images provide an invaluable long-term perspective. Automated detection of deforestation through satellite data is essential for timely intervention and conservation efforts.

You will use satellite data from Sentinel 2, employing tools such as the Normalized Burn Ratio, which indicates the amount of tree cover on a given pixel, to detect changes over time.

# Challenge
1. Prepare a timeseries of pixel values from the satellite imagery.
2. Implement a version of the Breaks For Additive Season and Trend (BFAST) method: http://bfast.r-forge.r-project.org/Verbesselt+Zeileis+Herold-2012.pdf
3. Visualize the results, highlighting areas of potential deforestation.

# Expectations
- You clearly understand the algorithm in the `Verbesselt et al.` paper
- You demonstrate the quantitative finesse to implement a prototype version, making simplifications of the method along the way
- You know how to communicate in discussions on design choices for algorithms and are able to visualize your results. You can formulate the next steps and hypothesis you might have
- You get up to speed to handle the basic data formats when working with geospatial data (use ChatGPT for help!): .tifs, polygons, geodataframes, etc.
- You can articulate your learnings and challenges when working on the implementation

## Helpful material
- **geopandas**: A Python library for working with geospatial data.
- **shapely**: A Python package for manipulation and analysis of planar geometric objects.
- **the .tif format**: A common file format for high-quality raster data.
- **satellite data basics**: Understanding the fundamentals of satellite imagery and its applications.
- **BFAST paper**: Provides in-depth information on the BFAST method for detecting changes in the time series.
- **Background reading paper on why this problem is important**: Offers insight into the environmental impacts of deforestation and the role of satellite imagery in combating it.
