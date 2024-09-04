---
output:
  html_document:
    toc: yes
  theme: united
  html_notebook: default
  pdf_document:
    toc: yes
---

# Data handling

This chapter covers the basics of data handling in R.

## Basic data handling


### Creating objects

Anything created in R is an object. You can assign values to objects using the assignment operator ``` <-```:


``` r
x <- "hello world" #assigns the words "hello world" to the object x
#this is a comment
```

Note that comments may be included in the code after a ```#```. The text after ```#``` is not evaluated when the code is run; they can be written directly after the code or in a separate line.

To see the value of an object, simply type its name into the console and hit enter:


``` r
x #print the value of x to the console
```

```
## [1] "hello world"
```

You can also explicitly tell R to print the value of an object:


``` r
print(x) #print the value of x to the console
```

```
## [1] "hello world"
```

Note that because we assign characters in this case (as opposed to e.g., numeric values), we need to wrap the words in quotation marks, which must always come in pairs. Although RStudio automatically adds a pair of quotation marks (i.e., opening and closing marks) when you enter the opening marks it could be that you end up with a mismatch by accident (e.g., ```x <- "hello```). In this case, R will show you the continuation character “+”. The same could happen if you did not execute the full command by accident. The "+" means that R is expecting more input. If this happens, either add the missing pair, or press ESCAPE to abort the expression and try again.

To change the value of an object, you can simply overwrite the previous value. For example, you could also assign a numeric value to "x" to perform some basic operations: 


``` r
x <- 2 #assigns the value of 2 to the object x
print(x)
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

Please note that object names must start with a letter and can only contain letters, numbers, as well as the ```.```, and ```_``` separators. It is important to give your objects descriptive names and to be as consistent as possible with the naming structure. In this tutorial we will be using lower case words separated by underscores (e.g., ```object_name```). There are other naming conventions, such as using a ```.``` as a separator (e.g., ```object.name```), or using upper case letters (```objectName```). It doesn't really matter which one you choose, as long as you are consistent.

### Data types

The most important types of data are:


Data type   | Description	 
-------------   | --------------------------------------------------------------------------
Numeric   | Approximations of the real numbers,  $\normalsize\mathbb{R}$ (e.g., mileage a car gets: 23.6, 20.9, etc.)
Integer   | Whole numbers,  $\normalsize\mathbb{Z}$ (e.g., number of sales: 7, 0, 120, 63, etc.)
Character   | Text data (strings, e.g., product names)
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
top10_sales <- c(163608, 126687, 120480, 110022, 108630, 95639, 94690, 89011, 87869, 85599) 

#Character:
top10_product_names <- c("Bio-Kaisersemmel", "Laktosefreie Bio-Vollmilch", "Ottakringer Helles", "Milka Ganze Haselnüsse", "Bio-Toastkäse Scheiben", "Ottakringer Bio Zwickl", "Vienna Coffee House Espresso", "Bio-Mozzarella", "Basmati Reis", "Bananen") # Characters have to be put in ""

#Factor variable with two categories:
private_label <- c(1,1,0,0,1,0,0,1,1,1)
private_label <- factor(private_label, 
                               levels = 0:1, 
                               labels = c("national brand", "private label"))

#Factor variable with more than two categories:
top10_brand <- c("Ja! Natürlich", "Ja! Natürlich", "Ottakringer", "Milka", "Ja! Natürlich", "Ottakringer", "Julius Meinl", "Ja! Natürlich", "Billa Bio", "Clever")
top10_brand <- as.factor(top10_brand)

#Date:
date_most_sold <- as.Date(c("2023-05-24", "2023-06-23", "2023-09-01", "2023-06-30", "2023-05-05", "2023-06-09", "2023-07-14", "2023-06-16", "2023-05-18", "2023-05-19"))

#Logical
private_label_logical <- c(TRUE,TRUE,FALSE,FALSE,TRUE,FALSE,FALSE,TRUE,TRUE,TRUE)  
```

In order to "return" a vector we can now simply enter its name:


``` r
top10_sales
```

```
##  [1] 163608 126687 120480 110022 108630  95639  94690  89011  87869  85599
```

``` r
date_most_sold
```

```
##  [1] "2023-05-24" "2023-06-23" "2023-09-01" "2023-06-30" "2023-05-05"
##  [6] "2023-06-09" "2023-07-14" "2023-06-16" "2023-05-18" "2023-05-19"
```

In order to check the type of a variable the ```class()``` function is used.


``` r
class(date_most_sold)
```

```
## [1] "Date"
```

### Data structures

Now let's create a table that contains the variables in columns and each observation in a row (like in SPSS or Excel). There are different data structures in R (e.g., Matrix, Vector, List, Array). In this course, we will mainly use <b>data frames</b>. 

<p style="text-align:center;"><img src="https://github.com/IMSMWU/Teaching/raw/master/MRDA2017/Graphics/dataframe.JPG" alt="data types" height="320"></p>

Data frames are similar to matrices but are more flexible in the sense that they may contain different data types (e.g., numeric, character, etc.), where all values of vectors and matrices have to be of the same type (e.g. character). It is often more convenient to use characters instead of numbers (e.g. when indicating a persons sex: "F", "M" instead of 1 for female , 2 for male). Thus we would like to combine both numeric and character values while retaining the respective desired features. This is where "data frames" come into play. Data frames can have different types of data in each column. For example, we can combine the vectors created above in one data frame using ```data.frame()```. This creates a separate column for each vector, which is usually what we want (similar to SPSS or Excel).


``` r
sales_data <- data.frame(top10_sales, 
                         top10_product_names, 
                         private_label, 
                         top10_brand, 
                         date_most_sold, 
                         private_label_logical)
```

#### Accessing data in data frames

When entering the name of a data frame, R returns the entire data frame: 


``` r
sales_data # Returns the entire data frame
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["top10_sales"],"name":[1],"type":["dbl"],"align":["right"]},{"label":["top10_product_names"],"name":[2],"type":["chr"],"align":["left"]},{"label":["private_label"],"name":[3],"type":["fct"],"align":["left"]},{"label":["top10_brand"],"name":[4],"type":["fct"],"align":["left"]},{"label":["date_most_sold"],"name":[5],"type":["date"],"align":["right"]},{"label":["private_label_logical"],"name":[6],"type":["lgl"],"align":["right"]}],"data":[{"1":"163608","2":"Bio-Kaisersemmel","3":"private label","4":"Ja! Natürlich","5":"2023-05-24","6":"TRUE"},{"1":"126687","2":"Laktosefreie Bio-Vollmilch","3":"private label","4":"Ja! Natürlich","5":"2023-06-23","6":"TRUE"},{"1":"120480","2":"Ottakringer Helles","3":"national brand","4":"Ottakringer","5":"2023-09-01","6":"FALSE"},{"1":"110022","2":"Milka Ganze Haselnüsse","3":"national brand","4":"Milka","5":"2023-06-30","6":"FALSE"},{"1":"108630","2":"Bio-Toastkäse Scheiben","3":"private label","4":"Ja! Natürlich","5":"2023-05-05","6":"TRUE"},{"1":"95639","2":"Ottakringer Bio Zwickl","3":"national brand","4":"Ottakringer","5":"2023-06-09","6":"FALSE"},{"1":"94690","2":"Vienna Coffee House Espresso","3":"national brand","4":"Julius Meinl","5":"2023-07-14","6":"FALSE"},{"1":"89011","2":"Bio-Mozzarella","3":"private label","4":"Ja! Natürlich","5":"2023-06-16","6":"TRUE"},{"1":"87869","2":"Basmati Reis","3":"private label","4":"Billa Bio","5":"2023-05-18","6":"TRUE"},{"1":"85599","2":"Bananen","3":"private label","4":"Clever","5":"2023-05-19","6":"TRUE"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

Hint: You may also use the ```View()```-function to view the data in a table format (like in SPSS or Excel), i.e. enter the command ```View(data)```. Note that you can achieve the same by clicking on the small table icon next to the data frame in the "Environment"-window on the right in RStudio. 

Sometimes it is convenient to return only specific values instead of the entire data frame. There are a variety of ways to identify the elements of a data frame. One easy way is to explicitly state, which rows and columns you wish to view. The general form of the command is ```data.frame[rows,columns]```. By leaving one of the arguments of ```data.frame[rows,columns]``` blank (e.g., ```data.frame[rows,]```) we tell R that we want to access either all rows or columns, respectively. Note that `a:b` (where `a` and `b` are numbers and `a` < `b`) is short hand notation for `seq(from = a, to = b, by = 1)`. Here are some examples:  


``` r
sales_data[ , 2:4] # all rows and columns 2,3,4
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["top10_product_names"],"name":[1],"type":["chr"],"align":["left"]},{"label":["private_label"],"name":[2],"type":["fct"],"align":["left"]},{"label":["top10_brand"],"name":[3],"type":["fct"],"align":["left"]}],"data":[{"1":"Bio-Kaisersemmel","2":"private label","3":"Ja! Natürlich"},{"1":"Laktosefreie Bio-Vollmilch","2":"private label","3":"Ja! Natürlich"},{"1":"Ottakringer Helles","2":"national brand","3":"Ottakringer"},{"1":"Milka Ganze Haselnüsse","2":"national brand","3":"Milka"},{"1":"Bio-Toastkäse Scheiben","2":"private label","3":"Ja! Natürlich"},{"1":"Ottakringer Bio Zwickl","2":"national brand","3":"Ottakringer"},{"1":"Vienna Coffee House Espresso","2":"national brand","3":"Julius Meinl"},{"1":"Bio-Mozzarella","2":"private label","3":"Ja! Natürlich"},{"1":"Basmati Reis","2":"private label","3":"Billa Bio"},{"1":"Bananen","2":"private label","3":"Clever"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

``` r
sales_data[5:7, ] # rows 5,6,7 and all columns
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":[""],"name":["_rn_"],"type":[""],"align":["left"]},{"label":["top10_sales"],"name":[1],"type":["dbl"],"align":["right"]},{"label":["top10_product_names"],"name":[2],"type":["chr"],"align":["left"]},{"label":["private_label"],"name":[3],"type":["fct"],"align":["left"]},{"label":["top10_brand"],"name":[4],"type":["fct"],"align":["left"]},{"label":["date_most_sold"],"name":[5],"type":["date"],"align":["right"]},{"label":["private_label_logical"],"name":[6],"type":["lgl"],"align":["right"]}],"data":[{"1":"108630","2":"Bio-Toastkäse Scheiben","3":"private label","4":"Ja! Natürlich","5":"2023-05-05","6":"TRUE","_rn_":"5"},{"1":"95639","2":"Ottakringer Bio Zwickl","3":"national brand","4":"Ottakringer","5":"2023-06-09","6":"FALSE","_rn_":"6"},{"1":"94690","2":"Vienna Coffee House Espresso","3":"national brand","4":"Julius Meinl","5":"2023-07-14","6":"FALSE","_rn_":"7"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

Typically we don't want to remember which row or column number is needed but use names and conditions (e.g, all explicit tracks). In order to make that easier we will add more functions to R by installing a package (sometimes also referred to as "library") called ```tidyverse```. We only have to install it once (per computer) and subsequently we can add the functions the package provides by calling ```library(tidyverse)```. Typically `library(PACKAGENAME)` has to be called again whenever you restart R/RStudio. If you see the error message `could not find function ...` make sure you have loaded all the required packages. The `tidyverse` provides us with convenient tools to manipulate data. 

You may create subsets of the data frame, e.g., using mathematical expressions using the `filter` function:


``` r
library(tidyverse)
filter(sales_data, private_label == "private label") # show only products that belong to private labels
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["top10_sales"],"name":[1],"type":["dbl"],"align":["right"]},{"label":["top10_product_names"],"name":[2],"type":["chr"],"align":["left"]},{"label":["private_label"],"name":[3],"type":["fct"],"align":["left"]},{"label":["top10_brand"],"name":[4],"type":["fct"],"align":["left"]},{"label":["date_most_sold"],"name":[5],"type":["date"],"align":["right"]},{"label":["private_label_logical"],"name":[6],"type":["lgl"],"align":["right"]}],"data":[{"1":"163608","2":"Bio-Kaisersemmel","3":"private label","4":"Ja! Natürlich","5":"2023-05-24","6":"TRUE"},{"1":"126687","2":"Laktosefreie Bio-Vollmilch","3":"private label","4":"Ja! Natürlich","5":"2023-06-23","6":"TRUE"},{"1":"108630","2":"Bio-Toastkäse Scheiben","3":"private label","4":"Ja! Natürlich","5":"2023-05-05","6":"TRUE"},{"1":"89011","2":"Bio-Mozzarella","3":"private label","4":"Ja! Natürlich","5":"2023-06-16","6":"TRUE"},{"1":"87869","2":"Basmati Reis","3":"private label","4":"Billa Bio","5":"2023-05-18","6":"TRUE"},{"1":"85599","2":"Bananen","3":"private label","4":"Clever","5":"2023-05-19","6":"TRUE"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

``` r
filter(sales_data, top10_sales > 100000) # show only products that sold more than 100,000 units  
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["top10_sales"],"name":[1],"type":["dbl"],"align":["right"]},{"label":["top10_product_names"],"name":[2],"type":["chr"],"align":["left"]},{"label":["private_label"],"name":[3],"type":["fct"],"align":["left"]},{"label":["top10_brand"],"name":[4],"type":["fct"],"align":["left"]},{"label":["date_most_sold"],"name":[5],"type":["date"],"align":["right"]},{"label":["private_label_logical"],"name":[6],"type":["lgl"],"align":["right"]}],"data":[{"1":"163608","2":"Bio-Kaisersemmel","3":"private label","4":"Ja! Natürlich","5":"2023-05-24","6":"TRUE"},{"1":"126687","2":"Laktosefreie Bio-Vollmilch","3":"private label","4":"Ja! Natürlich","5":"2023-06-23","6":"TRUE"},{"1":"120480","2":"Ottakringer Helles","3":"national brand","4":"Ottakringer","5":"2023-09-01","6":"FALSE"},{"1":"110022","2":"Milka Ganze Haselnüsse","3":"national brand","4":"Milka","5":"2023-06-30","6":"FALSE"},{"1":"108630","2":"Bio-Toastkäse Scheiben","3":"private label","4":"Ja! Natürlich","5":"2023-05-05","6":"TRUE"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

``` r
filter(sales_data, top10_product_names == 'Bio-Kaisersemmel') # returns all observations from product "Bio-Kaisersemmel"
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["top10_sales"],"name":[1],"type":["dbl"],"align":["right"]},{"label":["top10_product_names"],"name":[2],"type":["chr"],"align":["left"]},{"label":["private_label"],"name":[3],"type":["fct"],"align":["left"]},{"label":["top10_brand"],"name":[4],"type":["fct"],"align":["left"]},{"label":["date_most_sold"],"name":[5],"type":["date"],"align":["right"]},{"label":["private_label_logical"],"name":[6],"type":["lgl"],"align":["right"]}],"data":[{"1":"163608","2":"Bio-Kaisersemmel","3":"private label","4":"Ja! Natürlich","5":"2023-05-24","6":"TRUE"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

``` r
private_labels <- filter(sales_data, private_label == "private label") # creates a new data.frame by assigning only observations belonging to private labels
```


You may also change the order of the rows in a `data.frame` by using the ```arrange()```-function


``` r
# Arrange by sales (descending: most - least) 
arrange(sales_data, desc(top10_sales))
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["top10_sales"],"name":[1],"type":["dbl"],"align":["right"]},{"label":["top10_product_names"],"name":[2],"type":["chr"],"align":["left"]},{"label":["private_label"],"name":[3],"type":["fct"],"align":["left"]},{"label":["top10_brand"],"name":[4],"type":["fct"],"align":["left"]},{"label":["date_most_sold"],"name":[5],"type":["date"],"align":["right"]},{"label":["private_label_logical"],"name":[6],"type":["lgl"],"align":["right"]}],"data":[{"1":"163608","2":"Bio-Kaisersemmel","3":"private label","4":"Ja! Natürlich","5":"2023-05-24","6":"TRUE"},{"1":"126687","2":"Laktosefreie Bio-Vollmilch","3":"private label","4":"Ja! Natürlich","5":"2023-06-23","6":"TRUE"},{"1":"120480","2":"Ottakringer Helles","3":"national brand","4":"Ottakringer","5":"2023-09-01","6":"FALSE"},{"1":"110022","2":"Milka Ganze Haselnüsse","3":"national brand","4":"Milka","5":"2023-06-30","6":"FALSE"},{"1":"108630","2":"Bio-Toastkäse Scheiben","3":"private label","4":"Ja! Natürlich","5":"2023-05-05","6":"TRUE"},{"1":"95639","2":"Ottakringer Bio Zwickl","3":"national brand","4":"Ottakringer","5":"2023-06-09","6":"FALSE"},{"1":"94690","2":"Vienna Coffee House Espresso","3":"national brand","4":"Julius Meinl","5":"2023-07-14","6":"FALSE"},{"1":"89011","2":"Bio-Mozzarella","3":"private label","4":"Ja! Natürlich","5":"2023-06-16","6":"TRUE"},{"1":"87869","2":"Basmati Reis","3":"private label","4":"Billa Bio","5":"2023-05-18","6":"TRUE"},{"1":"85599","2":"Bananen","3":"private label","4":"Clever","5":"2023-05-19","6":"TRUE"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

You can order observations by several characteristics. Please note that the order of variables in the ```arrange()```-function specifies the order of arranging the data set. For example, here we first arrange the observations by the brand of the product, and only then require ordering by sales amounts:


``` r
# Arrange by brand (ascending by default) and then sales (descending: most - least) 
arrange(sales_data, top10_brand, desc(top10_sales))
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["top10_sales"],"name":[1],"type":["dbl"],"align":["right"]},{"label":["top10_product_names"],"name":[2],"type":["chr"],"align":["left"]},{"label":["private_label"],"name":[3],"type":["fct"],"align":["left"]},{"label":["top10_brand"],"name":[4],"type":["fct"],"align":["left"]},{"label":["date_most_sold"],"name":[5],"type":["date"],"align":["right"]},{"label":["private_label_logical"],"name":[6],"type":["lgl"],"align":["right"]}],"data":[{"1":"87869","2":"Basmati Reis","3":"private label","4":"Billa Bio","5":"2023-05-18","6":"TRUE"},{"1":"85599","2":"Bananen","3":"private label","4":"Clever","5":"2023-05-19","6":"TRUE"},{"1":"163608","2":"Bio-Kaisersemmel","3":"private label","4":"Ja! Natürlich","5":"2023-05-24","6":"TRUE"},{"1":"126687","2":"Laktosefreie Bio-Vollmilch","3":"private label","4":"Ja! Natürlich","5":"2023-06-23","6":"TRUE"},{"1":"108630","2":"Bio-Toastkäse Scheiben","3":"private label","4":"Ja! Natürlich","5":"2023-05-05","6":"TRUE"},{"1":"89011","2":"Bio-Mozzarella","3":"private label","4":"Ja! Natürlich","5":"2023-06-16","6":"TRUE"},{"1":"94690","2":"Vienna Coffee House Espresso","3":"national brand","4":"Julius Meinl","5":"2023-07-14","6":"FALSE"},{"1":"110022","2":"Milka Ganze Haselnüsse","3":"national brand","4":"Milka","5":"2023-06-30","6":"FALSE"},{"1":"120480","2":"Ottakringer Helles","3":"national brand","4":"Ottakringer","5":"2023-09-01","6":"FALSE"},{"1":"95639","2":"Ottakringer Bio Zwickl","3":"national brand","4":"Ottakringer","5":"2023-06-09","6":"FALSE"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

#### Inspecting the content of a data frame

The ```head()``` function displays the first X elements/rows of a vector, matrix, table, data frame or function.


``` r
head(sales_data, 3) # returns the first X rows (here, the first 3 rows)
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":[""],"name":["_rn_"],"type":[""],"align":["left"]},{"label":["top10_sales"],"name":[1],"type":["dbl"],"align":["right"]},{"label":["top10_product_names"],"name":[2],"type":["chr"],"align":["left"]},{"label":["private_label"],"name":[3],"type":["fct"],"align":["left"]},{"label":["top10_brand"],"name":[4],"type":["fct"],"align":["left"]},{"label":["date_most_sold"],"name":[5],"type":["date"],"align":["right"]},{"label":["private_label_logical"],"name":[6],"type":["lgl"],"align":["right"]}],"data":[{"1":"163608","2":"Bio-Kaisersemmel","3":"private label","4":"Ja! Natürlich","5":"2023-05-24","6":"TRUE","_rn_":"1"},{"1":"126687","2":"Laktosefreie Bio-Vollmilch","3":"private label","4":"Ja! Natürlich","5":"2023-06-23","6":"TRUE","_rn_":"2"},{"1":"120480","2":"Ottakringer Helles","3":"national brand","4":"Ottakringer","5":"2023-09-01","6":"FALSE","_rn_":"3"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

The ```tail()``` function is similar, except it displays the last elements/rows.


``` r
tail(sales_data, 3) # returns the last X rows (here, the last 3 rows)
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":[""],"name":["_rn_"],"type":[""],"align":["left"]},{"label":["top10_sales"],"name":[1],"type":["dbl"],"align":["right"]},{"label":["top10_product_names"],"name":[2],"type":["chr"],"align":["left"]},{"label":["private_label"],"name":[3],"type":["fct"],"align":["left"]},{"label":["top10_brand"],"name":[4],"type":["fct"],"align":["left"]},{"label":["date_most_sold"],"name":[5],"type":["date"],"align":["right"]},{"label":["private_label_logical"],"name":[6],"type":["lgl"],"align":["right"]}],"data":[{"1":"89011","2":"Bio-Mozzarella","3":"private label","4":"Ja! Natürlich","5":"2023-06-16","6":"TRUE","_rn_":"8"},{"1":"87869","2":"Basmati Reis","3":"private label","4":"Billa Bio","5":"2023-05-18","6":"TRUE","_rn_":"9"},{"1":"85599","2":"Bananen","3":"private label","4":"Clever","5":"2023-05-19","6":"TRUE","_rn_":"10"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

```names()``` returns the names of an R object. When, for example, it is called on a data frame, it returns the names of the columns. 


``` r
names(sales_data) # returns the names of the variables in the data frame
```

```
## [1] "top10_sales"           "top10_product_names"   "private_label"        
## [4] "top10_brand"           "date_most_sold"        "private_label_logical"
```

```str()``` displays the internal structure of an R object. In the case of a data frame, it returns the class (e.g., numeric, factor, etc.) of each variable, as well as the number of observations and the number of variables. 


``` r
str(sales_data) # returns the structure of the data frame
```

```
## 'data.frame':	10 obs. of  6 variables:
##  $ top10_sales          : num  163608 126687 120480 110022 108630 ...
##  $ top10_product_names  : chr  "Bio-Kaisersemmel" "Laktosefreie Bio-Vollmilch" "Ottakringer Helles" "Milka Ganze Haselnüsse" ...
##  $ private_label        : Factor w/ 2 levels "national brand",..: 2 2 1 1 2 1 1 2 2 2
##  $ top10_brand          : Factor w/ 6 levels "Billa Bio","Clever",..: 3 3 6 5 3 6 4 3 1 2
##  $ date_most_sold       : Date, format: "2023-05-24" "2023-06-23" ...
##  $ private_label_logical: logi  TRUE TRUE FALSE FALSE TRUE FALSE ...
```

```nrow()``` and ```ncol()``` return the rows and columns of a data frame or matrix, respectively. ```dim()``` displays the dimensions of an R object.


``` r
nrow(sales_data) # returns the number of rows 
```

```
## [1] 10
```

``` r
ncol(sales_data) # returns the number of columns 
```

```
## [1] 6
```

``` r
dim(sales_data) # returns the dimensions of a data frame
```

```
## [1] 10  6
```

```ls()``` can be used to list all objects that are associated with an R object. 


``` r
ls(sales_data) # list all objects associated with an object
```

```
## [1] "date_most_sold"        "private_label"         "private_label_logical"
## [4] "top10_brand"           "top10_product_names"   "top10_sales"
```

#### Select, group, append and delete variables to/from data frames

To return a single column in a data frame, use the ```$``` notation. For example, this returns all values associated with the variable "top10_track_streams":
  

``` r
sales_data$top10_sales
```

```
##  [1] 163608 126687 120480 110022 108630  95639  94690  89011  87869  85599
```

If you want to select more than one variable you can use the `select` function. It takes the `data.frame` containing the data as its first argument and  the variables that you need after it:


``` r
select(sales_data, top10_product_names, top10_sales, private_label)
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["top10_product_names"],"name":[1],"type":["chr"],"align":["left"]},{"label":["top10_sales"],"name":[2],"type":["dbl"],"align":["right"]},{"label":["private_label"],"name":[3],"type":["fct"],"align":["left"]}],"data":[{"1":"Bio-Kaisersemmel","2":"163608","3":"private label"},{"1":"Laktosefreie Bio-Vollmilch","2":"126687","3":"private label"},{"1":"Ottakringer Helles","2":"120480","3":"national brand"},{"1":"Milka Ganze Haselnüsse","2":"110022","3":"national brand"},{"1":"Bio-Toastkäse Scheiben","2":"108630","3":"private label"},{"1":"Ottakringer Bio Zwickl","2":"95639","3":"national brand"},{"1":"Vienna Coffee House Espresso","2":"94690","3":"national brand"},{"1":"Bio-Mozzarella","2":"89011","3":"private label"},{"1":"Basmati Reis","2":"87869","3":"private label"},{"1":"Bananen","2":"85599","3":"private label"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

`select` can also be used to remove columns by prepending a `-` to their name:


``` r
select(sales_data, -date_most_sold, -private_label_logical)
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["top10_sales"],"name":[1],"type":["dbl"],"align":["right"]},{"label":["top10_product_names"],"name":[2],"type":["chr"],"align":["left"]},{"label":["private_label"],"name":[3],"type":["fct"],"align":["left"]},{"label":["top10_brand"],"name":[4],"type":["fct"],"align":["left"]}],"data":[{"1":"163608","2":"Bio-Kaisersemmel","3":"private label","4":"Ja! Natürlich"},{"1":"126687","2":"Laktosefreie Bio-Vollmilch","3":"private label","4":"Ja! Natürlich"},{"1":"120480","2":"Ottakringer Helles","3":"national brand","4":"Ottakringer"},{"1":"110022","2":"Milka Ganze Haselnüsse","3":"national brand","4":"Milka"},{"1":"108630","2":"Bio-Toastkäse Scheiben","3":"private label","4":"Ja! Natürlich"},{"1":"95639","2":"Ottakringer Bio Zwickl","3":"national brand","4":"Ottakringer"},{"1":"94690","2":"Vienna Coffee House Espresso","3":"national brand","4":"Julius Meinl"},{"1":"89011","2":"Bio-Mozzarella","3":"private label","4":"Ja! Natürlich"},{"1":"87869","2":"Basmati Reis","3":"private label","4":"Billa Bio"},{"1":"85599","2":"Bananen","3":"private label","4":"Clever"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>


Assume that you wanted to add an additional variable to the data frame. You may use the ```$``` notation to achieve this:


``` r
# Create new variable as the log of sales
sales_data$log_sales <- log(sales_data$top10_sales) 
# Create an ascending count variable which might serve as an ID
sales_data$obs_number <- 1:nrow(sales_data)
head(sales_data)
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":[""],"name":["_rn_"],"type":[""],"align":["left"]},{"label":["top10_sales"],"name":[1],"type":["dbl"],"align":["right"]},{"label":["top10_product_names"],"name":[2],"type":["chr"],"align":["left"]},{"label":["private_label"],"name":[3],"type":["fct"],"align":["left"]},{"label":["top10_brand"],"name":[4],"type":["fct"],"align":["left"]},{"label":["date_most_sold"],"name":[5],"type":["date"],"align":["right"]},{"label":["private_label_logical"],"name":[6],"type":["lgl"],"align":["right"]},{"label":["log_sales"],"name":[7],"type":["dbl"],"align":["right"]},{"label":["obs_number"],"name":[8],"type":["int"],"align":["right"]}],"data":[{"1":"163608","2":"Bio-Kaisersemmel","3":"private label","4":"Ja! Natürlich","5":"2023-05-24","6":"TRUE","7":"12.00523","8":"1","_rn_":"1"},{"1":"126687","2":"Laktosefreie Bio-Vollmilch","3":"private label","4":"Ja! Natürlich","5":"2023-06-23","6":"TRUE","7":"11.74947","8":"2","_rn_":"2"},{"1":"120480","2":"Ottakringer Helles","3":"national brand","4":"Ottakringer","5":"2023-09-01","6":"FALSE","7":"11.69924","8":"3","_rn_":"3"},{"1":"110022","2":"Milka Ganze Haselnüsse","3":"national brand","4":"Milka","5":"2023-06-30","6":"FALSE","7":"11.60844","8":"4","_rn_":"4"},{"1":"108630","2":"Bio-Toastkäse Scheiben","3":"private label","4":"Ja! Natürlich","5":"2023-05-05","6":"TRUE","7":"11.59570","8":"5","_rn_":"5"},{"1":"95639","2":"Ottakringer Bio Zwickl","3":"national brand","4":"Ottakringer","5":"2023-06-09","6":"FALSE","7":"11.46834","8":"6","_rn_":"6"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

In order to add a function (e.g., `log`) of multiple existing variables to the `data.frame` use `mutate`. Multiple commands can be chained using so called pipes - operators that can be read as "then". Since R version 4.1 there are native pipes (`|>`) as well as the ones provided by the `tidyverse` (`%>%`):


``` r
music_data_new <- mutate(sales_data, 
       sqrt_sales = sqrt(top10_sales),
       # "%m" extracts the month, format returns a character so we convert it to integer
       most_sales_month = as.integer(format(date_most_sold, "%m")) 
       ) %>%
  select(top10_product_names, sqrt_sales, most_sales_month)
```

Two other important functions of `tidyverse` help calculating important summary statistics, such as totals, averages, etc. By using `group_by` function, we can ask R to pay attention to group-specific observations (e.g., by brand, label, date, ...) to then obtain values of interest by calling `summarize`:


``` r
sales_total <- sales_data %>% 
  group_by(top10_brand) %>%
  summarize(total_sales = sum(top10_sales), avg_sales = mean(top10_sales))
head(sales_total)
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["top10_brand"],"name":[1],"type":["fct"],"align":["left"]},{"label":["total_sales"],"name":[2],"type":["dbl"],"align":["right"]},{"label":["avg_sales"],"name":[3],"type":["dbl"],"align":["right"]}],"data":[{"1":"Billa Bio","2":"87869","3":"87869.0"},{"1":"Clever","2":"85599","3":"85599.0"},{"1":"Ja! Natürlich","2":"487936","3":"121984.0"},{"1":"Julius Meinl","2":"94690","3":"94690.0"},{"1":"Milka","2":"110022","3":"110022.0"},{"1":"Ottakringer","2":"216119","3":"108059.5"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>


You can also rename variables in a data frame, e.g., using the ```rename()```-function. In the following code "::" signifies that the function "rename" should be taken from the package "dplyr" (note: this package is part of the `tidyverse`). This can be useful if multiple packages have a function with the same name. Calling a function this way also means that you can access a function without loading the entire package via ```library()```.


``` r
sales_data <- dplyr::rename(sales_data, brand = top10_brand)
head(sales_data)
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":[""],"name":["_rn_"],"type":[""],"align":["left"]},{"label":["top10_sales"],"name":[1],"type":["dbl"],"align":["right"]},{"label":["top10_product_names"],"name":[2],"type":["chr"],"align":["left"]},{"label":["private_label"],"name":[3],"type":["fct"],"align":["left"]},{"label":["brand"],"name":[4],"type":["fct"],"align":["left"]},{"label":["date_most_sold"],"name":[5],"type":["date"],"align":["right"]},{"label":["private_label_logical"],"name":[6],"type":["lgl"],"align":["right"]},{"label":["log_sales"],"name":[7],"type":["dbl"],"align":["right"]},{"label":["obs_number"],"name":[8],"type":["int"],"align":["right"]}],"data":[{"1":"163608","2":"Bio-Kaisersemmel","3":"private label","4":"Ja! Natürlich","5":"2023-05-24","6":"TRUE","7":"12.00523","8":"1","_rn_":"1"},{"1":"126687","2":"Laktosefreie Bio-Vollmilch","3":"private label","4":"Ja! Natürlich","5":"2023-06-23","6":"TRUE","7":"11.74947","8":"2","_rn_":"2"},{"1":"120480","2":"Ottakringer Helles","3":"national brand","4":"Ottakringer","5":"2023-09-01","6":"FALSE","7":"11.69924","8":"3","_rn_":"3"},{"1":"110022","2":"Milka Ganze Haselnüsse","3":"national brand","4":"Milka","5":"2023-06-30","6":"FALSE","7":"11.60844","8":"4","_rn_":"4"},{"1":"108630","2":"Bio-Toastkäse Scheiben","3":"private label","4":"Ja! Natürlich","5":"2023-05-05","6":"TRUE","7":"11.59570","8":"5","_rn_":"5"},{"1":"95639","2":"Ottakringer Bio Zwickl","3":"national brand","4":"Ottakringer","5":"2023-06-09","6":"FALSE","7":"11.46834","8":"6","_rn_":"6"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

Note that the same can be achieved using:


``` r
names(sales_data)[names(sales_data)=="brand"] <- "top10_brand"
head(sales_data)
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":[""],"name":["_rn_"],"type":[""],"align":["left"]},{"label":["top10_sales"],"name":[1],"type":["dbl"],"align":["right"]},{"label":["top10_product_names"],"name":[2],"type":["chr"],"align":["left"]},{"label":["private_label"],"name":[3],"type":["fct"],"align":["left"]},{"label":["top10_brand"],"name":[4],"type":["fct"],"align":["left"]},{"label":["date_most_sold"],"name":[5],"type":["date"],"align":["right"]},{"label":["private_label_logical"],"name":[6],"type":["lgl"],"align":["right"]},{"label":["log_sales"],"name":[7],"type":["dbl"],"align":["right"]},{"label":["obs_number"],"name":[8],"type":["int"],"align":["right"]}],"data":[{"1":"163608","2":"Bio-Kaisersemmel","3":"private label","4":"Ja! Natürlich","5":"2023-05-24","6":"TRUE","7":"12.00523","8":"1","_rn_":"1"},{"1":"126687","2":"Laktosefreie Bio-Vollmilch","3":"private label","4":"Ja! Natürlich","5":"2023-06-23","6":"TRUE","7":"11.74947","8":"2","_rn_":"2"},{"1":"120480","2":"Ottakringer Helles","3":"national brand","4":"Ottakringer","5":"2023-09-01","6":"FALSE","7":"11.69924","8":"3","_rn_":"3"},{"1":"110022","2":"Milka Ganze Haselnüsse","3":"national brand","4":"Milka","5":"2023-06-30","6":"FALSE","7":"11.60844","8":"4","_rn_":"4"},{"1":"108630","2":"Bio-Toastkäse Scheiben","3":"private label","4":"Ja! Natürlich","5":"2023-05-05","6":"TRUE","7":"11.59570","8":"5","_rn_":"5"},{"1":"95639","2":"Ottakringer Bio Zwickl","3":"national brand","4":"Ottakringer","5":"2023-06-09","6":"FALSE","7":"11.46834","8":"6","_rn_":"6"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

Or by referring to the index of the variable:


``` r
names(sales_data)[4] <- "brand"
head(sales_data)
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":[""],"name":["_rn_"],"type":[""],"align":["left"]},{"label":["top10_sales"],"name":[1],"type":["dbl"],"align":["right"]},{"label":["top10_product_names"],"name":[2],"type":["chr"],"align":["left"]},{"label":["private_label"],"name":[3],"type":["fct"],"align":["left"]},{"label":["brand"],"name":[4],"type":["fct"],"align":["left"]},{"label":["date_most_sold"],"name":[5],"type":["date"],"align":["right"]},{"label":["private_label_logical"],"name":[6],"type":["lgl"],"align":["right"]},{"label":["log_sales"],"name":[7],"type":["dbl"],"align":["right"]},{"label":["obs_number"],"name":[8],"type":["int"],"align":["right"]}],"data":[{"1":"163608","2":"Bio-Kaisersemmel","3":"private label","4":"Ja! Natürlich","5":"2023-05-24","6":"TRUE","7":"12.00523","8":"1","_rn_":"1"},{"1":"126687","2":"Laktosefreie Bio-Vollmilch","3":"private label","4":"Ja! Natürlich","5":"2023-06-23","6":"TRUE","7":"11.74947","8":"2","_rn_":"2"},{"1":"120480","2":"Ottakringer Helles","3":"national brand","4":"Ottakringer","5":"2023-09-01","6":"FALSE","7":"11.69924","8":"3","_rn_":"3"},{"1":"110022","2":"Milka Ganze Haselnüsse","3":"national brand","4":"Milka","5":"2023-06-30","6":"FALSE","7":"11.60844","8":"4","_rn_":"4"},{"1":"108630","2":"Bio-Toastkäse Scheiben","3":"private label","4":"Ja! Natürlich","5":"2023-05-05","6":"TRUE","7":"11.59570","8":"5","_rn_":"5"},{"1":"95639","2":"Ottakringer Bio Zwickl","3":"national brand","4":"Ottakringer","5":"2023-06-09","6":"FALSE","7":"11.46834","8":"6","_rn_":"6"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

