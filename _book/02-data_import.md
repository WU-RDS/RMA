---
output:
  html_document:
    toc: yes
  html_notebook: default
  pdf_document:
    toc: yes
---

# Data handling

This chapter covers the basics of data handling in R.

## Data import and export 






Before you can start your analysis in R, you first need to import the data you wish to perform the analysis on. You will often be faced with different types of data formats (usually produced by some other statistical software like SPSS or Excel or a text editor). Fortunately, R is fairly flexible with respect to the sources from which data may be imported and you can import the most common data formats into R with the help of a few packages. R can, among others, handle data from the following sources: 

![](https://github.com/IMSMWU/Teaching/raw/master/MRDA2017/Graphics/data_import.JPG)

In the previous chapter, we saw how we may use the keyboard to input data in R. In the following sections, we will learn how to import data from text files and other statistical software packages. 

### Getting data for this course

Most of the data sets we will be working with in this course will be stored in text files (i.e., .dat, .txt, .csv). All data sets we will be working with are stored in a repository on GitHub (similar to other cloud storage services such as Dropbox). You can directly import these data sets from GitHub without having to copy data sets from one place to another. If you know the location, where the files are stored, you may conveniently load the data directly from GitHub into R using the ```read.csv()``` function. To figure out the structure of the data you can read the first couple of lines of a file using the `readLines` function. The ```header=TRUE``` argument in the `read.csv` function indicates that the first line of data represents the header, i.e., it contains the names of the columns. The ```sep=";"```-argument specifies the delimiter (the character used to separate the columns), which is a ";" in this case. 


``` r
readLines("https://raw.githubusercontent.com/WU-RDS/RMA2024/refs/heads/main/data/Sales_Data.csv",
    n = 3)
```

```
## [1] "\"top10_sales\",\"top10_product_names\",\"private_label\",\"top10_brand\",\"date_most_sold\",\"private_label_logical\""
## [2] "163608,\"Bio-Kaisersemmel\",\"private label\",\"Ja! Natürlich\",2023-05-24,TRUE"                                       
## [3] "126687,\"Laktosefreie Bio-Vollmilch\",\"private label\",\"Ja! Natürlich\",2023-06-23,TRUE"
```

``` r
test_data <- read.csv("https://raw.githubusercontent.com/WU-RDS/RMA2024/refs/heads/main/data/Sales_Data.csv",
    sep = ",", header = TRUE)
head(test_data)
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["top10_sales"],"name":[1],"type":["int"],"align":["right"]},{"label":["top10_product_names"],"name":[2],"type":["chr"],"align":["left"]},{"label":["private_label"],"name":[3],"type":["chr"],"align":["left"]},{"label":["top10_brand"],"name":[4],"type":["chr"],"align":["left"]},{"label":["date_most_sold"],"name":[5],"type":["chr"],"align":["left"]},{"label":["private_label_logical"],"name":[6],"type":["lgl"],"align":["right"]}],"data":[{"1":"163608","2":"Bio-Kaisersemmel","3":"private label","4":"Ja! Natürlich","5":"2023-05-24","6":"TRUE"},{"1":"126687","2":"Laktosefreie Bio-Vollmilch","3":"private label","4":"Ja! Natürlich","5":"2023-06-23","6":"TRUE"},{"1":"120480","2":"Ottakringer Helles","3":"national brand","4":"Ottakringer","5":"2023-09-01","6":"FALSE"},{"1":"110022","2":"Milka Ganze Haselnüsse","3":"national brand","4":"Milka","5":"2023-06-30","6":"FALSE"},{"1":"108630","2":"Bio-Toastkäse Scheiben","3":"private label","4":"Ja! Natürlich","5":"2023-05-05","6":"TRUE"},{"1":"95639","2":"Ottakringer Bio Zwickl","3":"national brand","4":"Ottakringer","5":"2023-06-09","6":"FALSE"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

Note that it is also possible to download the data, placing it in the working directory and importing it from there. However, this requires an additional step to download the file manually first. If you chose this option, please **remember to put the data file in the working directory first**. If the import is not working, check your working directory setting using ```getwd()```. Once you placed the file in the working directory, you can import it using the same command as above. Note that the file must be given as a character string (i.e., in quotation marks) and has to end with the file extension (e.g., .csv, .tsv, etc.).


``` r
test_data <- read.csv("data/Sales_Data.csv", header = TRUE,
    sep = ",")
head(test_data)
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["top10_sales"],"name":[1],"type":["int"],"align":["right"]},{"label":["top10_product_names"],"name":[2],"type":["chr"],"align":["left"]},{"label":["private_label"],"name":[3],"type":["chr"],"align":["left"]},{"label":["top10_brand"],"name":[4],"type":["chr"],"align":["left"]},{"label":["date_most_sold"],"name":[5],"type":["chr"],"align":["left"]},{"label":["private_label_logical"],"name":[6],"type":["lgl"],"align":["right"]}],"data":[{"1":"163608","2":"Bio-Kaisersemmel","3":"private label","4":"Ja! Natürlich","5":"2023-05-24","6":"TRUE"},{"1":"126687","2":"Laktosefreie Bio-Vollmilch","3":"private label","4":"Ja! Natürlich","5":"2023-06-23","6":"TRUE"},{"1":"120480","2":"Ottakringer Helles","3":"national brand","4":"Ottakringer","5":"2023-09-01","6":"FALSE"},{"1":"110022","2":"Milka Ganze Haselnüsse","3":"national brand","4":"Milka","5":"2023-06-30","6":"FALSE"},{"1":"108630","2":"Bio-Toastkäse Scheiben","3":"private label","4":"Ja! Natürlich","5":"2023-05-05","6":"TRUE"},{"1":"95639","2":"Ottakringer Bio Zwickl","3":"national brand","4":"Ottakringer","5":"2023-06-09","6":"FALSE"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>


### Export data

Exporting to different formats is also easy, as you can just replace "read" with "write" in many of the previously discussed functions (e.g. ```write.csv(object, "file_name")```). This will save the data file to the working directory. To check what the current working directory is you can use ```getwd()```. By default, the ```write.csv(object, "file_name")```function includes the row number as the first variable. By specifying ```row.names = FALSE```, you may exclude this variable since it doesn't contain any useful information.  


``` r
write.csv(sales_data, "Sales_Data.csv", row.names = FALSE)  # writes to a comma-separated value file

# To save as Excel file:
library(xlsx)
write.xlsx(sales_data, "Sales_Data.xlsx", sheetName = "Data",
    row.names = FALSE)
```

