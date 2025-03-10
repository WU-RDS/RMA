---
output:
  html_document:
    toc: yes
  theme: united
  html_notebook: default
  pdf_document:
    toc: yes
---


## Basic data handling


### Creating objects

Anything created in R is an object. You can assign values to objects using the assignment operator ``` <-```:


``` r
x <- "hello world" #assigns the words "hello world" to the object x
#this is a comment
```

Note that comments may be included in the code after a ```#```. The text after ```#``` is not evaluated (basically, ignored) when we run the code; comments can be written directly after the code or in a separate line.

To see the value of an object (= what it is, what numeric, character or any other value it has), simply type its name and run the code:


``` r
x #prints the value of x to the console
```

```
## [1] "hello world"
```

You can also explicitly tell R to print the value of an object:


``` r
print(x) #prints the value of x to the console
```

```
## [1] "hello world"
```

Note that because we assign characters in this case (as opposed to e.g., numeric values), we need to wrap the words in quotation marks, which must always come in pairs (i.e., we must close the quotation marks that have been open, eventually). Although RStudio automatically adds a pair of quotation marks (i.e., opening and closing marks) when you enter the opening marks it could be that you end up with a mismatch by accident (e.g., ```x <- "hello``` - notice that the quotation mark is not closed). In this case, R will show you the continuation character “+” down in the console. The same could happen if you did not execute the full command by accident. The "+" means that R is expecting more input. If this happens, either add the missing pair or interrupt the cycle by pressing "control + C" (Mac) or "ctrl + C" (Windows), fix the code, and execute it again.

To change the value of an object, you can simply overwrite (i.e., assign a new value to the existing object - object with the same name) the previous value. For example, you could also assign a numeric value to "x" to perform some basic operations: 


``` r
x <- 2 #assigns the value of 2 to the object x
x
```

```
## [1] 2
```

``` r
x == 2  #checks whether the value of x is equal to 2
```

```
## [1] TRUE
```

``` r
x != 3  #checks whether the value of x is NOT equal to 3
```

```
## [1] TRUE
```

``` r
x < 3   #checks whether the value of x is less than 3
```

```
## [1] TRUE
```

``` r
x > 3   #checks whether the value of x is greater than 3
```

```
## [1] FALSE
```

Note that the name of the object is completely arbitrary. We could also define a second object "y", assign it a different value and use it to perform some basic mathematical operations:


``` r
y <- 5 #assigns the value of 2 to the object x
x == y #checks whether the value of x to the value of y
```

```
## [1] FALSE
```

``` r
x*y #multiplication of x and y
```

```
## [1] 10
```

``` r
x + y #adds the values of x and y together
```

```
## [1] 7
```

``` r
y^2 + 3*x #adds the value of y squared and 3x the value of x together
```

```
## [1] 31
```

<b>Object names</b>

Please note that object names must start with a letter and can only contain letters, numbers, as well as the ```.```, and ```_``` separators. It is important to give your objects descriptive names and to be as consistent as possible with the naming structure. In this tutorial we will be mostly using lower case words separated by underscores (e.g., ```object_name```). There are other naming conventions, such as using a ```.``` as a separator (e.g., ```object.name```), or using upper case letters (```objectName```). It doesn't really matter which one you choose, as long as you are consistent.

### Data types

The most important types of data are:


Data type   | Description	 
-------------   | --------------------------------------------------------------------------
Numeric   | Approximations of the real numbers,  $\normalsize\mathbb{R}$ (e.g., price per kilo: 2.3, 5.56, etc.)
Integer   | Whole numbers,  $\normalsize\mathbb{Z}$ (e.g., number of sales: 7, 0, 120, 63, etc.)
Character   | Text data (strings, e.g., product names). In R, will always be enclosed in quotation marks.
Factor    | Categorical data for classification (e.g., product groups)
Logical   | TRUE, FALSE
Date    | Date variables (e.g., sales dates: 21-06-2015, 06-21-15, 21-Jun-2015, etc.)

Variables can be converted from one type to another using the appropriate functions (e.g., ```as.numeric()```,```as.integer()```,```as.character()```, ```as.factor()```,```as.logical()```, ```as.Date()```). For example, we could convert the object ```y``` to character as follows:


``` r
y <- as.character(y)
print(y)
```

```
## [1] "5"
```

Notice how the value is in quotation marks since it is now of type character. 

Entering a vector of data into R can be done with the ``` c(x1,x2,..,x_n)``` ("concatenate") command. In order to be able to use our vector (or any other variable) later on we want to assign it a name using the assignment operator ``` <-```. You can choose names arbitrarily (but the first character of a name cannot be a number). Just make sure they are descriptive and unique. Assigning the same name to two variables (e.g. vectors) will result in deletion of the first. Instead of converting a variable we can also create a new one and use an existing one as input. In this case we omit the ```as.``` and simply use the name of the type (e.g. ```factor()```). There is a subtle difference between the two: When converting a variable, with e.g. ```as.factor()```, we can only pass the variable we want to convert without additional arguments and R determines the factor levels by the existing unique values in the variable or just returns the variable itself if it is a factor already. When we specifically create a variable (just ```factor()```, ```matrix()```, etc.), we can and should set the options of this type explicitly. For a factor variable these could be the labels and levels, for a matrix the number of rows and columns and so on.  


``` r
#Numeric:
sales <- c(163608, 126687, 120480, 110022, 108630, 95639, 94690, 89011, 87869, 85599) 

#Character:
products <- c("Bio-Kaisersemmel", "Laktosefreie Bio-Vollmilch", "Ottakringer Helles", "Milka Ganze Haselnüsse", "Bio-Toastkäse Scheiben", "Ottakringer Bio Zwickl", "Vienna Coffee House Espresso", "Bio-Mozzarella", "Basmati Reis", "Bananen") # Characters have to be put in ""
```

In order to "return" a vector we can now simply enter its name:


``` r
sales
```

```
##  [1] 163608 126687 120480 110022 108630  95639  94690  89011  87869  85599
```

However, generally, you don't need to print the whole object. Objects that we typically work with are huge data sets, and printing the whole set neither gives the reader any information nor is a good ("polite") reporting practice in general.

In order to check the type of a variable the ```class()``` function is used.


``` r
class(sales)
```

```
## [1] "numeric"
```

### Data structures

Now let's work with a table that contains the variables in columns and each observation in a row (like in SPSS or Excel). There are different data structures in R (e.g., Matrix, Vector, List, Array). In this course, we will mainly use <b>data frames</b>. 

<p style="text-align:center;"><img src="https://github.com/IMSMWU/Teaching/raw/master/MRDA2017/Graphics/dataframe.JPG" alt="data types" height="320"></p>

Data frames are similar to matrices but are more flexible in the sense that they may contain different data types (e.g., numeric, character, etc.), while all values of vectors and matrices have to be of the same type (e.g. character). It is often more convenient to use characters instead of numbers (e.g. when indicating a persons sex: "F", "M" instead of 1 for female, 2 for male). Thus we would like to combine both numeric and character values while retaining the respective desired features. This is where "data frames" come into play. Data frames can have different types of data in each column. For example, we can combine the vectors created above in one data frame using ```data.frame()```. This creates a separate column for each vector, which is usually what we want (similar to SPSS or Excel).


``` r
sales_data <- read.csv("https://raw.githubusercontent.com/WU-RDS/RMA2024/refs/heads/main/data/Sales_Data.csv", 
                      sep = ",", 
                      header = TRUE)
```

#### Accessing data in data frames

When entering the name of a data frame, R returns the entire data frame: 


``` r
sales_data # Returns the entire data frame
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["top10_sales"],"name":[1],"type":["int"],"align":["right"]},{"label":["top10_product_names"],"name":[2],"type":["chr"],"align":["left"]},{"label":["private_label"],"name":[3],"type":["chr"],"align":["left"]},{"label":["top10_brand"],"name":[4],"type":["chr"],"align":["left"]},{"label":["date_most_sold"],"name":[5],"type":["chr"],"align":["left"]},{"label":["private_label_logical"],"name":[6],"type":["lgl"],"align":["right"]}],"data":[{"1":"163608","2":"Bio-Kaisersemmel","3":"private label","4":"Ja! Natürlich","5":"2023-05-24","6":"TRUE"},{"1":"126687","2":"Laktosefreie Bio-Vollmilch","3":"private label","4":"Ja! Natürlich","5":"2023-06-23","6":"TRUE"},{"1":"120480","2":"Ottakringer Helles","3":"national brand","4":"Ottakringer","5":"2023-09-01","6":"FALSE"},{"1":"110022","2":"Milka Ganze Haselnüsse","3":"national brand","4":"Milka","5":"2023-06-30","6":"FALSE"},{"1":"108630","2":"Bio-Toastkäse Scheiben","3":"private label","4":"Ja! Natürlich","5":"2023-05-05","6":"TRUE"},{"1":"95639","2":"Ottakringer Bio Zwickl","3":"national brand","4":"Ottakringer","5":"2023-06-09","6":"FALSE"},{"1":"94690","2":"Vienna Coffee House Espresso","3":"national brand","4":"Julius Meinl","5":"2023-07-14","6":"FALSE"},{"1":"89011","2":"Bio-Mozzarella","3":"private label","4":"Ja! Natürlich","5":"2023-06-16","6":"TRUE"},{"1":"87869","2":"Basmati Reis","3":"private label","4":"Billa Bio","5":"2023-05-18","6":"TRUE"},{"1":"85599","2":"Bananen","3":"private label","4":"Clever","5":"2023-05-19","6":"TRUE"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

Please remember that this is not a good idea to do it this way because, if the data set contains millions of rows, the reader will have hard times reading through the report; this as well does not contribute to the analysis part. we only use this "approach" now for the purpose of showing how the data frame looks.

Hint: You may also use the ```View()```-function to view the data in a table format (like in SPSS or Excel), i.e. enter the command ```View(data)```. Note that you can achieve the same by clicking on the small table icon next to the data frame in the "Environment"-window on the right in RStudio. 

It is much more convenient to return only specific values instead of the entire data frame. There are a variety of ways to identify the elements of a data frame. One easy way is to "request" the "head" of the data frame, i.e., some rows at the top of the data frame:


``` r
head(sales_data) # 6 rows by default
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":[""],"name":["_rn_"],"type":[""],"align":["left"]},{"label":["top10_sales"],"name":[1],"type":["int"],"align":["right"]},{"label":["top10_product_names"],"name":[2],"type":["chr"],"align":["left"]},{"label":["private_label"],"name":[3],"type":["chr"],"align":["left"]},{"label":["top10_brand"],"name":[4],"type":["chr"],"align":["left"]},{"label":["date_most_sold"],"name":[5],"type":["chr"],"align":["left"]},{"label":["private_label_logical"],"name":[6],"type":["lgl"],"align":["right"]}],"data":[{"1":"163608","2":"Bio-Kaisersemmel","3":"private label","4":"Ja! Natürlich","5":"2023-05-24","6":"TRUE","_rn_":"1"},{"1":"126687","2":"Laktosefreie Bio-Vollmilch","3":"private label","4":"Ja! Natürlich","5":"2023-06-23","6":"TRUE","_rn_":"2"},{"1":"120480","2":"Ottakringer Helles","3":"national brand","4":"Ottakringer","5":"2023-09-01","6":"FALSE","_rn_":"3"},{"1":"110022","2":"Milka Ganze Haselnüsse","3":"national brand","4":"Milka","5":"2023-06-30","6":"FALSE","_rn_":"4"},{"1":"108630","2":"Bio-Toastkäse Scheiben","3":"private label","4":"Ja! Natürlich","5":"2023-05-05","6":"TRUE","_rn_":"5"},{"1":"95639","2":"Ottakringer Bio Zwickl","3":"national brand","4":"Ottakringer","5":"2023-06-09","6":"FALSE","_rn_":"6"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

``` r
head(sales_data, 10) # first 10 rows
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":[""],"name":["_rn_"],"type":[""],"align":["left"]},{"label":["top10_sales"],"name":[1],"type":["int"],"align":["right"]},{"label":["top10_product_names"],"name":[2],"type":["chr"],"align":["left"]},{"label":["private_label"],"name":[3],"type":["chr"],"align":["left"]},{"label":["top10_brand"],"name":[4],"type":["chr"],"align":["left"]},{"label":["date_most_sold"],"name":[5],"type":["chr"],"align":["left"]},{"label":["private_label_logical"],"name":[6],"type":["lgl"],"align":["right"]}],"data":[{"1":"163608","2":"Bio-Kaisersemmel","3":"private label","4":"Ja! Natürlich","5":"2023-05-24","6":"TRUE","_rn_":"1"},{"1":"126687","2":"Laktosefreie Bio-Vollmilch","3":"private label","4":"Ja! Natürlich","5":"2023-06-23","6":"TRUE","_rn_":"2"},{"1":"120480","2":"Ottakringer Helles","3":"national brand","4":"Ottakringer","5":"2023-09-01","6":"FALSE","_rn_":"3"},{"1":"110022","2":"Milka Ganze Haselnüsse","3":"national brand","4":"Milka","5":"2023-06-30","6":"FALSE","_rn_":"4"},{"1":"108630","2":"Bio-Toastkäse Scheiben","3":"private label","4":"Ja! Natürlich","5":"2023-05-05","6":"TRUE","_rn_":"5"},{"1":"95639","2":"Ottakringer Bio Zwickl","3":"national brand","4":"Ottakringer","5":"2023-06-09","6":"FALSE","_rn_":"6"},{"1":"94690","2":"Vienna Coffee House Espresso","3":"national brand","4":"Julius Meinl","5":"2023-07-14","6":"FALSE","_rn_":"7"},{"1":"89011","2":"Bio-Mozzarella","3":"private label","4":"Ja! Natürlich","5":"2023-06-16","6":"TRUE","_rn_":"8"},{"1":"87869","2":"Basmati Reis","3":"private label","4":"Billa Bio","5":"2023-05-18","6":"TRUE","_rn_":"9"},{"1":"85599","2":"Bananen","3":"private label","4":"Clever","5":"2023-05-19","6":"TRUE","_rn_":"10"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

The ```tail()``` function is similar, except it displays the last elements/rows.


``` r
tail(sales_data, 3) # returns the last X rows (here, the last 3 rows)
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":[""],"name":["_rn_"],"type":[""],"align":["left"]},{"label":["top10_sales"],"name":[1],"type":["int"],"align":["right"]},{"label":["top10_product_names"],"name":[2],"type":["chr"],"align":["left"]},{"label":["private_label"],"name":[3],"type":["chr"],"align":["left"]},{"label":["top10_brand"],"name":[4],"type":["chr"],"align":["left"]},{"label":["date_most_sold"],"name":[5],"type":["chr"],"align":["left"]},{"label":["private_label_logical"],"name":[6],"type":["lgl"],"align":["right"]}],"data":[{"1":"89011","2":"Bio-Mozzarella","3":"private label","4":"Ja! Natürlich","5":"2023-06-16","6":"TRUE","_rn_":"8"},{"1":"87869","2":"Basmati Reis","3":"private label","4":"Billa Bio","5":"2023-05-18","6":"TRUE","_rn_":"9"},{"1":"85599","2":"Bananen","3":"private label","4":"Clever","5":"2023-05-19","6":"TRUE","_rn_":"10"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

It is a good idea to check the structure of the data set:


``` r
str(sales_data) # returns the structure of the data frame
```

```
## 'data.frame':	10 obs. of  6 variables:
##  $ top10_sales          : int  163608 126687 120480 110022 108630 95639 94690 89011 87869 85599
##  $ top10_product_names  : chr  "Bio-Kaisersemmel" "Laktosefreie Bio-Vollmilch" "Ottakringer Helles" "Milka Ganze Haselnüsse" ...
##  $ private_label        : chr  "private label" "private label" "national brand" "national brand" ...
##  $ top10_brand          : chr  "Ja! Natürlich" "Ja! Natürlich" "Ottakringer" "Milka" ...
##  $ date_most_sold       : chr  "2023-05-24" "2023-06-23" "2023-09-01" "2023-06-30" ...
##  $ private_label_logical: logi  TRUE TRUE FALSE FALSE TRUE FALSE ...
```

Your to-dos when inspecting the structure of the data frame:  
1. Check if the data is read in correctly (e.g., if the columns are split correctly)
2. Check how the columns are called and what the spelling is. You must refer to columns exactly how they are called in the data frame.
3. Check data types: what columns (variables) should be numeric but are currently character? Are there any dates that are not in the date format?
4. If something is wrong, change the data types, targeting specific columns.

We can also have a look not at the whole data frame, but at specific column. The code below does exactly that. But more importantly, this is how we explicitly call a specific column that we need to work with. This code cal be read as "column 'top10_sales' from data frame 'sales_data'":


``` r
sales_data$top10_sales
```

```
##  [1] 163608 126687 120480 110022 108630  95639  94690  89011  87869  85599
```


In order to make data handling easier we will add more functions to R by installing a package (sometimes also referred to as "library") called ```tidyverse```. We only have to install it once (per computer) and subsequently we can add the functions the package provides by calling ```library(tidyverse)```. Typically `library(PACKAGENAME)` has to be called again whenever you restart R/RStudio. If you see the error message `could not find function ...` make sure you have loaded all the required packages. The `tidyverse` provides us with convenient tools to manipulate data. 

You may create subsets of the data frame, e.g., using mathematical expressions using the `filter` function:


``` r
library(tidyverse)
filter(sales_data, private_label == "private label") # show only products that belong to private labels
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["top10_sales"],"name":[1],"type":["int"],"align":["right"]},{"label":["top10_product_names"],"name":[2],"type":["chr"],"align":["left"]},{"label":["private_label"],"name":[3],"type":["chr"],"align":["left"]},{"label":["top10_brand"],"name":[4],"type":["chr"],"align":["left"]},{"label":["date_most_sold"],"name":[5],"type":["chr"],"align":["left"]},{"label":["private_label_logical"],"name":[6],"type":["lgl"],"align":["right"]}],"data":[{"1":"163608","2":"Bio-Kaisersemmel","3":"private label","4":"Ja! Natürlich","5":"2023-05-24","6":"TRUE"},{"1":"126687","2":"Laktosefreie Bio-Vollmilch","3":"private label","4":"Ja! Natürlich","5":"2023-06-23","6":"TRUE"},{"1":"108630","2":"Bio-Toastkäse Scheiben","3":"private label","4":"Ja! Natürlich","5":"2023-05-05","6":"TRUE"},{"1":"89011","2":"Bio-Mozzarella","3":"private label","4":"Ja! Natürlich","5":"2023-06-16","6":"TRUE"},{"1":"87869","2":"Basmati Reis","3":"private label","4":"Billa Bio","5":"2023-05-18","6":"TRUE"},{"1":"85599","2":"Bananen","3":"private label","4":"Clever","5":"2023-05-19","6":"TRUE"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

``` r
sales_data %>% filter(private_label == "private label") # this is another way to do the same using the "pipe" (operator %>%, pronounced as "then": take "sales_data", then filter [it] by "private_label")
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["top10_sales"],"name":[1],"type":["int"],"align":["right"]},{"label":["top10_product_names"],"name":[2],"type":["chr"],"align":["left"]},{"label":["private_label"],"name":[3],"type":["chr"],"align":["left"]},{"label":["top10_brand"],"name":[4],"type":["chr"],"align":["left"]},{"label":["date_most_sold"],"name":[5],"type":["chr"],"align":["left"]},{"label":["private_label_logical"],"name":[6],"type":["lgl"],"align":["right"]}],"data":[{"1":"163608","2":"Bio-Kaisersemmel","3":"private label","4":"Ja! Natürlich","5":"2023-05-24","6":"TRUE"},{"1":"126687","2":"Laktosefreie Bio-Vollmilch","3":"private label","4":"Ja! Natürlich","5":"2023-06-23","6":"TRUE"},{"1":"108630","2":"Bio-Toastkäse Scheiben","3":"private label","4":"Ja! Natürlich","5":"2023-05-05","6":"TRUE"},{"1":"89011","2":"Bio-Mozzarella","3":"private label","4":"Ja! Natürlich","5":"2023-06-16","6":"TRUE"},{"1":"87869","2":"Basmati Reis","3":"private label","4":"Billa Bio","5":"2023-05-18","6":"TRUE"},{"1":"85599","2":"Bananen","3":"private label","4":"Clever","5":"2023-05-19","6":"TRUE"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

``` r
sales_data %>% filter(top10_sales > 100000) # show only products that sold more than 100,000 units  
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["top10_sales"],"name":[1],"type":["int"],"align":["right"]},{"label":["top10_product_names"],"name":[2],"type":["chr"],"align":["left"]},{"label":["private_label"],"name":[3],"type":["chr"],"align":["left"]},{"label":["top10_brand"],"name":[4],"type":["chr"],"align":["left"]},{"label":["date_most_sold"],"name":[5],"type":["chr"],"align":["left"]},{"label":["private_label_logical"],"name":[6],"type":["lgl"],"align":["right"]}],"data":[{"1":"163608","2":"Bio-Kaisersemmel","3":"private label","4":"Ja! Natürlich","5":"2023-05-24","6":"TRUE"},{"1":"126687","2":"Laktosefreie Bio-Vollmilch","3":"private label","4":"Ja! Natürlich","5":"2023-06-23","6":"TRUE"},{"1":"120480","2":"Ottakringer Helles","3":"national brand","4":"Ottakringer","5":"2023-09-01","6":"FALSE"},{"1":"110022","2":"Milka Ganze Haselnüsse","3":"national brand","4":"Milka","5":"2023-06-30","6":"FALSE"},{"1":"108630","2":"Bio-Toastkäse Scheiben","3":"private label","4":"Ja! Natürlich","5":"2023-05-05","6":"TRUE"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

``` r
sales_data %>% filter(top10_product_names == 'Bio-Kaisersemmel') # returns all observations from product "Bio-Kaisersemmel"
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["top10_sales"],"name":[1],"type":["int"],"align":["right"]},{"label":["top10_product_names"],"name":[2],"type":["chr"],"align":["left"]},{"label":["private_label"],"name":[3],"type":["chr"],"align":["left"]},{"label":["top10_brand"],"name":[4],"type":["chr"],"align":["left"]},{"label":["date_most_sold"],"name":[5],"type":["chr"],"align":["left"]},{"label":["private_label_logical"],"name":[6],"type":["lgl"],"align":["right"]}],"data":[{"1":"163608","2":"Bio-Kaisersemmel","3":"private label","4":"Ja! Natürlich","5":"2023-05-24","6":"TRUE"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

We can create an object based on our manipulations, i.e., the filtered piece of the initial data set.


``` r
private_labels <- sales_data %>% filter(private_label == "private label")
```


Next, we can also change the order of the rows by using the ```arrange()```-function. 


``` r
# Arrange by sales (descending: most - least) 
sales_data %>% arrange(desc(top10_sales)) 
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["top10_sales"],"name":[1],"type":["int"],"align":["right"]},{"label":["top10_product_names"],"name":[2],"type":["chr"],"align":["left"]},{"label":["private_label"],"name":[3],"type":["chr"],"align":["left"]},{"label":["top10_brand"],"name":[4],"type":["chr"],"align":["left"]},{"label":["date_most_sold"],"name":[5],"type":["chr"],"align":["left"]},{"label":["private_label_logical"],"name":[6],"type":["lgl"],"align":["right"]}],"data":[{"1":"163608","2":"Bio-Kaisersemmel","3":"private label","4":"Ja! Natürlich","5":"2023-05-24","6":"TRUE"},{"1":"126687","2":"Laktosefreie Bio-Vollmilch","3":"private label","4":"Ja! Natürlich","5":"2023-06-23","6":"TRUE"},{"1":"120480","2":"Ottakringer Helles","3":"national brand","4":"Ottakringer","5":"2023-09-01","6":"FALSE"},{"1":"110022","2":"Milka Ganze Haselnüsse","3":"national brand","4":"Milka","5":"2023-06-30","6":"FALSE"},{"1":"108630","2":"Bio-Toastkäse Scheiben","3":"private label","4":"Ja! Natürlich","5":"2023-05-05","6":"TRUE"},{"1":"95639","2":"Ottakringer Bio Zwickl","3":"national brand","4":"Ottakringer","5":"2023-06-09","6":"FALSE"},{"1":"94690","2":"Vienna Coffee House Espresso","3":"national brand","4":"Julius Meinl","5":"2023-07-14","6":"FALSE"},{"1":"89011","2":"Bio-Mozzarella","3":"private label","4":"Ja! Natürlich","5":"2023-06-16","6":"TRUE"},{"1":"87869","2":"Basmati Reis","3":"private label","4":"Billa Bio","5":"2023-05-18","6":"TRUE"},{"1":"85599","2":"Bananen","3":"private label","4":"Clever","5":"2023-05-19","6":"TRUE"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

``` r
# function desc() is applied directly to column "top10_sales", but it is also correct to write sales_data %>% arrange(desc(sales_data$top10_sales)) 
```

You can order observations by several characteristics. Please note that the order of variables in the ```arrange()```-function specifies the order of arranging the data set. For example, here we first arrange the observations by the brand of the product, and only then require ordering by sales amounts:


``` r
# Arrange by brand (ascending by default) and by sales (descending: most - least) by simply listng the columns in the order that you need
sales_data %>% arrange(top10_brand, desc(top10_sales))
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["top10_sales"],"name":[1],"type":["int"],"align":["right"]},{"label":["top10_product_names"],"name":[2],"type":["chr"],"align":["left"]},{"label":["private_label"],"name":[3],"type":["chr"],"align":["left"]},{"label":["top10_brand"],"name":[4],"type":["chr"],"align":["left"]},{"label":["date_most_sold"],"name":[5],"type":["chr"],"align":["left"]},{"label":["private_label_logical"],"name":[6],"type":["lgl"],"align":["right"]}],"data":[{"1":"87869","2":"Basmati Reis","3":"private label","4":"Billa Bio","5":"2023-05-18","6":"TRUE"},{"1":"85599","2":"Bananen","3":"private label","4":"Clever","5":"2023-05-19","6":"TRUE"},{"1":"163608","2":"Bio-Kaisersemmel","3":"private label","4":"Ja! Natürlich","5":"2023-05-24","6":"TRUE"},{"1":"126687","2":"Laktosefreie Bio-Vollmilch","3":"private label","4":"Ja! Natürlich","5":"2023-06-23","6":"TRUE"},{"1":"108630","2":"Bio-Toastkäse Scheiben","3":"private label","4":"Ja! Natürlich","5":"2023-05-05","6":"TRUE"},{"1":"89011","2":"Bio-Mozzarella","3":"private label","4":"Ja! Natürlich","5":"2023-06-16","6":"TRUE"},{"1":"94690","2":"Vienna Coffee House Espresso","3":"national brand","4":"Julius Meinl","5":"2023-07-14","6":"FALSE"},{"1":"110022","2":"Milka Ganze Haselnüsse","3":"national brand","4":"Milka","5":"2023-06-30","6":"FALSE"},{"1":"120480","2":"Ottakringer Helles","3":"national brand","4":"Ottakringer","5":"2023-09-01","6":"FALSE"},{"1":"95639","2":"Ottakringer Bio Zwickl","3":"national brand","4":"Ottakringer","5":"2023-06-09","6":"FALSE"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>


#### Select, group, append and delete variables to/from data frames

If you want to select more than one variable you can use the `select` function. It takes the data frame containing the data as its first argument and the variables that you need after it in the `select()` function:


``` r
sales_data %>% select(top10_product_names, top10_sales, private_label)
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["top10_product_names"],"name":[1],"type":["chr"],"align":["left"]},{"label":["top10_sales"],"name":[2],"type":["int"],"align":["right"]},{"label":["private_label"],"name":[3],"type":["chr"],"align":["left"]}],"data":[{"1":"Bio-Kaisersemmel","2":"163608","3":"private label"},{"1":"Laktosefreie Bio-Vollmilch","2":"126687","3":"private label"},{"1":"Ottakringer Helles","2":"120480","3":"national brand"},{"1":"Milka Ganze Haselnüsse","2":"110022","3":"national brand"},{"1":"Bio-Toastkäse Scheiben","2":"108630","3":"private label"},{"1":"Ottakringer Bio Zwickl","2":"95639","3":"national brand"},{"1":"Vienna Coffee House Espresso","2":"94690","3":"national brand"},{"1":"Bio-Mozzarella","2":"89011","3":"private label"},{"1":"Basmati Reis","2":"87869","3":"private label"},{"1":"Bananen","2":"85599","3":"private label"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

`select` can also be used to remove columns by prepending a `-` to their name:


``` r
sales_data %>% select(-date_most_sold, -private_label_logical)
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["top10_sales"],"name":[1],"type":["int"],"align":["right"]},{"label":["top10_product_names"],"name":[2],"type":["chr"],"align":["left"]},{"label":["private_label"],"name":[3],"type":["chr"],"align":["left"]},{"label":["top10_brand"],"name":[4],"type":["chr"],"align":["left"]}],"data":[{"1":"163608","2":"Bio-Kaisersemmel","3":"private label","4":"Ja! Natürlich"},{"1":"126687","2":"Laktosefreie Bio-Vollmilch","3":"private label","4":"Ja! Natürlich"},{"1":"120480","2":"Ottakringer Helles","3":"national brand","4":"Ottakringer"},{"1":"110022","2":"Milka Ganze Haselnüsse","3":"national brand","4":"Milka"},{"1":"108630","2":"Bio-Toastkäse Scheiben","3":"private label","4":"Ja! Natürlich"},{"1":"95639","2":"Ottakringer Bio Zwickl","3":"national brand","4":"Ottakringer"},{"1":"94690","2":"Vienna Coffee House Espresso","3":"national brand","4":"Julius Meinl"},{"1":"89011","2":"Bio-Mozzarella","3":"private label","4":"Ja! Natürlich"},{"1":"87869","2":"Basmati Reis","3":"private label","4":"Billa Bio"},{"1":"85599","2":"Bananen","3":"private label","4":"Clever"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>


Assume that you wanted to add an additional variable to the data frame. You may use the ```$``` notation to achieve this:


``` r
# Create new variable as the log of sales
sales_data$log_sales <- log(sales_data$top10_sales)
head(sales_data)
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":[""],"name":["_rn_"],"type":[""],"align":["left"]},{"label":["top10_sales"],"name":[1],"type":["int"],"align":["right"]},{"label":["top10_product_names"],"name":[2],"type":["chr"],"align":["left"]},{"label":["private_label"],"name":[3],"type":["chr"],"align":["left"]},{"label":["top10_brand"],"name":[4],"type":["chr"],"align":["left"]},{"label":["date_most_sold"],"name":[5],"type":["chr"],"align":["left"]},{"label":["private_label_logical"],"name":[6],"type":["lgl"],"align":["right"]},{"label":["log_sales"],"name":[7],"type":["dbl"],"align":["right"]}],"data":[{"1":"163608","2":"Bio-Kaisersemmel","3":"private label","4":"Ja! Natürlich","5":"2023-05-24","6":"TRUE","7":"12.00523","_rn_":"1"},{"1":"126687","2":"Laktosefreie Bio-Vollmilch","3":"private label","4":"Ja! Natürlich","5":"2023-06-23","6":"TRUE","7":"11.74947","_rn_":"2"},{"1":"120480","2":"Ottakringer Helles","3":"national brand","4":"Ottakringer","5":"2023-09-01","6":"FALSE","7":"11.69924","_rn_":"3"},{"1":"110022","2":"Milka Ganze Haselnüsse","3":"national brand","4":"Milka","5":"2023-06-30","6":"FALSE","7":"11.60844","_rn_":"4"},{"1":"108630","2":"Bio-Toastkäse Scheiben","3":"private label","4":"Ja! Natürlich","5":"2023-05-05","6":"TRUE","7":"11.59570","_rn_":"5"},{"1":"95639","2":"Ottakringer Bio Zwickl","3":"national brand","4":"Ottakringer","5":"2023-06-09","6":"FALSE","7":"11.46834","_rn_":"6"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

``` r
# Create an ascending count variable which might serve as an ID
sales_data$obs_number <- 1:nrow(sales_data)
head(sales_data)
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":[""],"name":["_rn_"],"type":[""],"align":["left"]},{"label":["top10_sales"],"name":[1],"type":["int"],"align":["right"]},{"label":["top10_product_names"],"name":[2],"type":["chr"],"align":["left"]},{"label":["private_label"],"name":[3],"type":["chr"],"align":["left"]},{"label":["top10_brand"],"name":[4],"type":["chr"],"align":["left"]},{"label":["date_most_sold"],"name":[5],"type":["chr"],"align":["left"]},{"label":["private_label_logical"],"name":[6],"type":["lgl"],"align":["right"]},{"label":["log_sales"],"name":[7],"type":["dbl"],"align":["right"]},{"label":["obs_number"],"name":[8],"type":["int"],"align":["right"]}],"data":[{"1":"163608","2":"Bio-Kaisersemmel","3":"private label","4":"Ja! Natürlich","5":"2023-05-24","6":"TRUE","7":"12.00523","8":"1","_rn_":"1"},{"1":"126687","2":"Laktosefreie Bio-Vollmilch","3":"private label","4":"Ja! Natürlich","5":"2023-06-23","6":"TRUE","7":"11.74947","8":"2","_rn_":"2"},{"1":"120480","2":"Ottakringer Helles","3":"national brand","4":"Ottakringer","5":"2023-09-01","6":"FALSE","7":"11.69924","8":"3","_rn_":"3"},{"1":"110022","2":"Milka Ganze Haselnüsse","3":"national brand","4":"Milka","5":"2023-06-30","6":"FALSE","7":"11.60844","8":"4","_rn_":"4"},{"1":"108630","2":"Bio-Toastkäse Scheiben","3":"private label","4":"Ja! Natürlich","5":"2023-05-05","6":"TRUE","7":"11.59570","8":"5","_rn_":"5"},{"1":"95639","2":"Ottakringer Bio Zwickl","3":"national brand","4":"Ottakringer","5":"2023-06-09","6":"FALSE","7":"11.46834","8":"6","_rn_":"6"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

In order to add a function (e.g., `log`) of multiple existing variables to the `data.frame` use `mutate`. Multiple commands can be chained using pipes - operators that can be read as "then". 


``` r
sales_data %>% mutate(sqrt_sales = sqrt(top10_sales)) %>%
  select(top10_product_names, sqrt_sales)
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["top10_product_names"],"name":[1],"type":["chr"],"align":["left"]},{"label":["sqrt_sales"],"name":[2],"type":["dbl"],"align":["right"]}],"data":[{"1":"Bio-Kaisersemmel","2":"404.4849"},{"1":"Laktosefreie Bio-Vollmilch","2":"355.9312"},{"1":"Ottakringer Helles","2":"347.1023"},{"1":"Milka Ganze Haselnüsse","2":"331.6956"},{"1":"Bio-Toastkäse Scheiben","2":"329.5907"},{"1":"Ottakringer Bio Zwickl","2":"309.2556"},{"1":"Vienna Coffee House Espresso","2":"307.7174"},{"1":"Bio-Mozzarella","2":"298.3471"},{"1":"Basmati Reis","2":"296.4271"},{"1":"Bananen","2":"292.5731"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

Two other important functions of `tidyverse` help calculating important summary statistics, such as totals, averages, etc. By using `group_by` function, we can ask R to pay attention to group-specific observations (e.g., by brand, label, date, ...) to then obtain values of interest by calling `summarize`:


``` r
sales_data %>% group_by(top10_brand) %>% summarize(total_sales = sum(top10_sales), avg_sales = mean(top10_sales))
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["top10_brand"],"name":[1],"type":["chr"],"align":["left"]},{"label":["total_sales"],"name":[2],"type":["int"],"align":["right"]},{"label":["avg_sales"],"name":[3],"type":["dbl"],"align":["right"]}],"data":[{"1":"Billa Bio","2":"87869","3":"87869.0"},{"1":"Clever","2":"85599","3":"85599.0"},{"1":"Ja! Natürlich","2":"487936","3":"121984.0"},{"1":"Julius Meinl","2":"94690","3":"94690.0"},{"1":"Milka","2":"110022","3":"110022.0"},{"1":"Ottakringer","2":"216119","3":"108059.5"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

In many cases, it makes sense to save the results of our summary as a new object (then we can reuse it in some analyses or export from R as Excel file):


``` r
summary <- sales_data %>% 
  group_by(top10_brand) %>% 
  summarize(total_sales = sum(top10_sales), avg_sales = mean(top10_sales))
# Again, there is no "presentable" output in the console unless we call it directly:
summary
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["top10_brand"],"name":[1],"type":["chr"],"align":["left"]},{"label":["total_sales"],"name":[2],"type":["int"],"align":["right"]},{"label":["avg_sales"],"name":[3],"type":["dbl"],"align":["right"]}],"data":[{"1":"Billa Bio","2":"87869","3":"87869.0"},{"1":"Clever","2":"85599","3":"85599.0"},{"1":"Ja! Natürlich","2":"487936","3":"121984.0"},{"1":"Julius Meinl","2":"94690","3":"94690.0"},{"1":"Milka","2":"110022","3":"110022.0"},{"1":"Ottakringer","2":"216119","3":"108059.5"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

Important: `summarize()` keeps **only** the grouping columns and the columns that you create to get the desired summary; it drops all other unused (not mentioned) columns. If you need to keep more columns, e.g., private_label, they should be also included in the group_by():


``` r
summary_new <- sales_data %>% 
  group_by(top10_brand, private_label) %>% 
  summarize(total_sales = sum(top10_sales), avg_sales = mean(top10_sales))
summary_new
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["top10_brand"],"name":[1],"type":["chr"],"align":["left"]},{"label":["private_label"],"name":[2],"type":["chr"],"align":["left"]},{"label":["total_sales"],"name":[3],"type":["int"],"align":["right"]},{"label":["avg_sales"],"name":[4],"type":["dbl"],"align":["right"]}],"data":[{"1":"Billa Bio","2":"private label","3":"87869","4":"87869.0"},{"1":"Clever","2":"private label","3":"85599","4":"85599.0"},{"1":"Ja! Natürlich","2":"private label","3":"487936","4":"121984.0"},{"1":"Julius Meinl","2":"national brand","3":"94690","4":"94690.0"},{"1":"Milka","2":"national brand","3":"110022","4":"110022.0"},{"1":"Ottakringer","2":"national brand","3":"216119","4":"108059.5"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

You can also rename variables in a data frame, e.g., using the ```rename()```-function. In the following code "::" signifies that the function "rename" should be taken from the package "dplyr" (note: this package is part of the `tidyverse`). This can be useful if multiple packages have a function with the same name. Calling a function this way also means that you can access a function without loading the entire package via ```library()```.


``` r
sales_data <- dplyr::rename(sales_data, brand = top10_brand)
head(sales_data)
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":[""],"name":["_rn_"],"type":[""],"align":["left"]},{"label":["top10_sales"],"name":[1],"type":["int"],"align":["right"]},{"label":["top10_product_names"],"name":[2],"type":["chr"],"align":["left"]},{"label":["private_label"],"name":[3],"type":["chr"],"align":["left"]},{"label":["brand"],"name":[4],"type":["chr"],"align":["left"]},{"label":["date_most_sold"],"name":[5],"type":["chr"],"align":["left"]},{"label":["private_label_logical"],"name":[6],"type":["lgl"],"align":["right"]},{"label":["log_sales"],"name":[7],"type":["dbl"],"align":["right"]},{"label":["obs_number"],"name":[8],"type":["int"],"align":["right"]}],"data":[{"1":"163608","2":"Bio-Kaisersemmel","3":"private label","4":"Ja! Natürlich","5":"2023-05-24","6":"TRUE","7":"12.00523","8":"1","_rn_":"1"},{"1":"126687","2":"Laktosefreie Bio-Vollmilch","3":"private label","4":"Ja! Natürlich","5":"2023-06-23","6":"TRUE","7":"11.74947","8":"2","_rn_":"2"},{"1":"120480","2":"Ottakringer Helles","3":"national brand","4":"Ottakringer","5":"2023-09-01","6":"FALSE","7":"11.69924","8":"3","_rn_":"3"},{"1":"110022","2":"Milka Ganze Haselnüsse","3":"national brand","4":"Milka","5":"2023-06-30","6":"FALSE","7":"11.60844","8":"4","_rn_":"4"},{"1":"108630","2":"Bio-Toastkäse Scheiben","3":"private label","4":"Ja! Natürlich","5":"2023-05-05","6":"TRUE","7":"11.59570","8":"5","_rn_":"5"},{"1":"95639","2":"Ottakringer Bio Zwickl","3":"national brand","4":"Ottakringer","5":"2023-06-09","6":"FALSE","7":"11.46834","8":"6","_rn_":"6"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>


## Learning check {-}

**(LC3.1) Which of the following are data types are recognized by R?**

- [X] Factor
- [X] Date
- [ ] Decimal
- [ ] Vector
- [ ] None of the above 	

**(LC3.2) What function should you use to check if an object is a data frame?**

- [ ] `type()`
- [ ] `str()`
- [X] `class()`
- [ ] `object.type()`
- [ ] None of the above 	

**(LC3.3) You would like to combine three vectors (student, grade, date) in a data frame. What would happen when executing the following code?** 


``` r
student <- c('Max','Jonas','Saskia','Victoria')
grade <- c(3,2,1,2)
date <- as.Date(c('2020-10-06','2020-10-08','2020-10-09'))
df <- data.frame(student,grade,date)
```

- [ ] Error because a data frame can not have different data types
- [ ] Error because you should use `as.data.frame()` instead of `data.frame()`
- [X] Error because all vectors need to have the same length
- [ ] Error because the column names are not specified
- [ ] This code should not report an error	

**You would like to analyze the following data frame**

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["student"],"name":[1],"type":["chr"],"align":["left"]},{"label":["grade"],"name":[2],"type":["dbl"],"align":["right"]},{"label":["country"],"name":[3],"type":["chr"],"align":["left"]}],"data":[{"1":"Christian","2":"1","3":"AT"},{"1":"Matthias","2":"1","3":"AT"},{"1":"Max","2":"NA","3":"AT"},{"1":"Christina","2":"3","3":"AT"},{"1":"Ines","2":"2","3":"DE"},{"1":"Eddie","2":"1","3":"DE"},{"1":"Janine","2":"2","3":"DE"},{"1":"Victoria","2":"3","3":"SK"},{"1":"Pia","2":"1","3":"US"},{"1":"Julia","2":"2","3":"CA"},{"1":"Lena","2":"3","3":"AT"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

**(LC3.4) How can you obtain Christina's grade from the data frame?**

- [X] `df[4,2]`
- [ ] `df[2,4]`
- [ ] `filter(df, student = Christina) %>% select(grade)`
- [X] `filter(df, student == "Christina") %>% select(grade)`
- [ ] None of the above 	

**(LC3.5) How can you add a new variable 'student_id' to the data frame that assigns numbers to students in an ascending order?**

- [X] `df$student_id <- 1:nrow(df)`
- [ ] `df&student_id <- 1:nrow(df)`
- [X] `mutate(df, student_id = 1:nrow(df))`
- [ ] `mutate(df, student_id = 1:length(df))`
- [ ] None of the above 	

**(LC3.6) How could you obtain all rows with students who obtained a 1?**

- [X] `filter(df, grade == 1)`
- [X] `filter(df, grade == min(df$grade, na.rm = TRUE))`
- [ ] `select(df, grade == 1)`
- [ ] `filter(df, grade == min(df$grade))`
- [ ] None of the above 	

**(LC3.7) How could you create a subset of observations where the grade is not missing (NA) **

- [X] `df_subset <- filter(df, !is.na(grade))`
- [ ] `df_subset <- filter(df, isnot.na(grade))`
- [ ] `df_subset <- filter(df, grade != NA)`
- [ ] `df_subset <- filter(df, grade != "NA")`
- [ ] None of the above 

**(LC3.8) What is the share of students with a grade better than 3?**

- [ ] `filter(df, grade < 3)/nrow(df)`
- [ ] `nrow(filter(df, grade < 3))/length(df)`
- [X] `nrow(filter(df, grade < 3))/nrow(df)`
- [ ] `filter(df, grade < 3)/length(df)`
- [ ] None of the above

**(LC3.9) You would like to load a .csv file from your working directory. What function would you use do it?**

- [ ] `read.table(file_name.csv)`
- [ ] `load.csv("file.csv")`
- [X] `read.table("file.csv")`
- [ ] `get.table(file_name.csv)`
- [ ] None of the above

**(LC3.10) After you loaded the file, you would like to inspect the types of data contained in it. How would you do it?**

- [ ] `ncol(df)`
- [ ] `nrow(df)`
- [ ] `dim(df)`
- [X] `str(df)`
- [ ] None of the above


