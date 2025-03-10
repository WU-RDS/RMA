---
output:
  html_document:
    toc: yes
  html_notebook: default
  pdf_document:
    toc: yes

---

# Summarizing data


## Summary statistics




This section discusses how to produce and analyze basic summary statistics. Summary statistics are often used to describe variables in terms of 1) the central tendency of the frequency distribution, and 2) the dispersion of values.  

<br>

A **measure of central tendency** is a single value that attempts to describe the data by identifying the central position within the data. There are various measures of central tendency as the following table shows. 

Statistic    | Description   | Definition 
---- | ------------------------------  | -----
Mean | The average value when you sum up all elements and divide by the number of elements  | $\bar{X}=\frac{\sum_{i=1}^{n}{X_i}}{n}$  
Mode  | The value that occurs most frequently (i.e., the highest peak of the frequency distribution)  |   
Median | The middle value when the data are arranged in ascending or descending order (i.e., the 50th percentile) |   

<br>

The **dispersion** refers to the degree to which the data is distributed around the central tendency and can be described in terms of the range, interquartile range, variance, and standard deviation. 

Statistic    | Description   | Definition 
---- | ------------------------------  | -----
Range | The difference between the largest and smallest values in the sample | $Range=X_{largest}-X_{smallest}$  
Interquartile range  | The range of the middle 50% of scores | $IQR=Q_3-Q_1$   
Variance | The mean squared deviation of all the values of the mean | $s^2=\frac{1}{n-1}*\sum_{i=1}^{n}{(X_i-\bar{X})^2}$
Standard deviation | The square root of the variance | $s_x=\sqrt{s^2}$

<br>

The answer to the question which measures to use depends on the level of measurement. Based on the discussion in chapter 1, we make a distinction between categorical and continuous variables, for which different statistics are permissible as summarized in the following table.

OK to compute...    | Nominal   | Ordinal   | Interval    | Ratio
------------- | ------------- | ------------- | --- | ---
frequency distribution  | Yes  | Yes  | Yes  | Yes
median and percentiles  | No  | Yes  | Yes  | Yes
mean, standard deviation, standard error of the mean | No  | No  | Yes  | Yes
ratio, or coefficient of variation  | No  | No  | No  | Yes

<br>

As an example data set, we will be using a data set containing music streaming data from a popular streaming service. Let's load and inspect the data first.

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["Date"],"name":[1],"type":["chr"],"align":["left"]},{"label":["Store"],"name":[2],"type":["chr"],"align":["left"]},{"label":["Category"],"name":[3],"type":["chr"],"align":["left"]},{"label":["Brand"],"name":[4],"type":["chr"],"align":["left"]},{"label":["Sales_Amount"],"name":[5],"type":["dbl"],"align":["right"]},{"label":["Units_Sold"],"name":[6],"type":["int"],"align":["right"]},{"label":["Customer_Age"],"name":[7],"type":["int"],"align":["right"]}],"data":[{"1":"2023-11-30","2":"Store 3","3":"Grocery","4":"Trader Joe's","5":"26.32","6":"17","7":"29"},{"1":"2023-08-04","2":"Store 1","3":"Toys","4":"Mattel","5":"270.08","6":"5","7":"32"},{"1":"2023-02-26","2":"Store 6","3":"Clothing","4":"Puma","5":"372.76","6":"1","7":"31"},{"1":"2023-07-17","2":"Store 7","3":"Electronics","4":"LG","5":"1235.69","6":"3","7":"38"},{"1":"2023-11-03","2":"Store 4","3":"Furniture","4":"West Elm","5":"825.87","6":"1","7":"31"},{"1":"2023-06-03","2":"Store 1","3":"Grocery","4":"Walmart","5":"61.04","6":"9","7":"18"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

```
## [1] 5000    7
```


The data set contains information about several purchases made in a number of stores in 2023. The `dim()`-function returns the dimensions of the data frame (i.e., the number of rows and columns). As can be seen, the data set comprises information for 5000 transactions and 7 variables (columns). The variables in the data set are:

* Date: date of purchase
* Store: Store ID/number
* Category: product category of the purchased item
* Brand: name of the brand of the purchased item
* Sales_Amount: the monetary value of the purchase (i.e., store's revenue)
* Units_Sold: number of units purchased
* Customer_Age: the age of the customer who made the purchase

In a first step, we need to make sure all variables are in the correct format, according to these variable definitions: 


``` r
library(tidyverse)
sales_data <- sales_data %>% # pipe data into mutate
  dplyr::mutate(Date = as.Date(Date), # convert to date
         Store = as.factor(Store), # convert to factor w. new labels
         Category = as.factor(Category), # convert to factor with values as labels
         Brand = as.factor(Brand)) 
head(sales_data)
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["Date"],"name":[1],"type":["date"],"align":["right"]},{"label":["Store"],"name":[2],"type":["fct"],"align":["left"]},{"label":["Category"],"name":[3],"type":["fct"],"align":["left"]},{"label":["Brand"],"name":[4],"type":["fct"],"align":["left"]},{"label":["Sales_Amount"],"name":[5],"type":["dbl"],"align":["right"]},{"label":["Units_Sold"],"name":[6],"type":["int"],"align":["right"]},{"label":["Customer_Age"],"name":[7],"type":["int"],"align":["right"]}],"data":[{"1":"2023-11-30","2":"Store 3","3":"Grocery","4":"Trader Joe's","5":"26.32","6":"17","7":"29"},{"1":"2023-08-04","2":"Store 1","3":"Toys","4":"Mattel","5":"270.08","6":"5","7":"32"},{"1":"2023-02-26","2":"Store 6","3":"Clothing","4":"Puma","5":"372.76","6":"1","7":"31"},{"1":"2023-07-17","2":"Store 7","3":"Electronics","4":"LG","5":"1235.69","6":"3","7":"38"},{"1":"2023-11-03","2":"Store 4","3":"Furniture","4":"West Elm","5":"825.87","6":"1","7":"31"},{"1":"2023-06-03","2":"Store 1","3":"Grocery","4":"Walmart","5":"61.04","6":"9","7":"18"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

In the following sections, we will inspect the data in more detail.

### Categorical variables

Categorical variables contain a finite number of categories or distinct groups and are also known as qualitative or non-metric variables. There are different types of categorical variables:

* **Nominal variables**: variables that have two or more categories but no logical order (e.g., store ID, brand name). A dichotomous variable (also referred to as dummy variable or binary variable) is simply a nominal variable that only has two categories (absent in this data set).
* **Ordinal variables**: variables that have two or more categories that can also be ordered or ranked (absent in this data set).

Let's now start to investigate the **nominal variables** in our data set.

As the table above shows, the only permissible operation with nominal variables is counting. That is, we can inspect the frequency distribution, which tells us how many observations we have per category. The ```table()``` function creates a frequency table that counts how many observations we have in each category. 


``` r
table(sales_data$Category)  #absolute frequencies
```

```
## 
##    Clothing Electronics   Furniture     Grocery      Sports        Toys 
##        1265         490         286        1746         603         610
```

``` r
table(sales_data$Store)  #absolute frequencies
```

```
## 
##  Store 1 Store 10  Store 2  Store 3  Store 4  Store 5  Store 6  Store 7 
##      494      506      514      522      461      488      502      465 
##  Store 8  Store 9 
##      516      532
```

The numbers associated with the factor level in the output tell you, how many observations there are per category. For example, there are 1265 purchases from the Clothing category; also, 532 are from Store No. 9.

Often, we are interested in the relative frequencies (share of observations), which can be obtained by using the ```prop.table()``` function.


``` r
prop.table(table(sales_data$Category))  #relative frequencies
```

```
## 
##    Clothing Electronics   Furniture     Grocery      Sports        Toys 
##      0.2530      0.0980      0.0572      0.3492      0.1206      0.1220
```

``` r
prop.table(table(sales_data$Store))  #relative frequencies
```

```
## 
##  Store 1 Store 10  Store 2  Store 3  Store 4  Store 5  Store 6  Store 7 
##   0.0988   0.1012   0.1028   0.1044   0.0922   0.0976   0.1004   0.0930 
##  Store 8  Store 9 
##   0.1032   0.1064
```




Now the output gives you the relative frequencies. For example, the share of purchases (transactions) of groceries is ~34.9%, ~10.3% of purchases are from Store number 2.

Note that the above output shows the overall relative frequencies. In many cases, it is meaningful to consider conditional relative frequencies. This can be achieved by adding a ```,1``` to the ```prop.table()``` command, which tells R to compute the relative frequencies by row (which is in our case the Store variable). The following code can be used to show the relative frequency of purchases from specific categories by store  


``` r
prop.table(table(select(sales_data, Store, Category)),
    1)  #conditional relative frequencies
```

```
##           Category
## Store        Clothing Electronics  Furniture    Grocery     Sports       Toys
##   Store 1  0.26315789  0.08906883 0.05465587 0.34412955 0.11133603 0.13765182
##   Store 10 0.21541502  0.11264822 0.05533597 0.35177866 0.13241107 0.13241107
##   Store 2  0.27237354  0.08171206 0.05642023 0.35019455 0.12062257 0.11867704
##   Store 3  0.24329502  0.10536398 0.04214559 0.34674330 0.12452107 0.13793103
##   Store 4  0.26030369  0.09327549 0.05856833 0.36008677 0.11496746 0.11279826
##   Store 5  0.25819672  0.10655738 0.06352459 0.33196721 0.12295082 0.11680328
##   Store 6  0.23505976  0.07569721 0.07370518 0.34462151 0.14741036 0.12350598
##   Store 7  0.24301075  0.10752688 0.04516129 0.36559140 0.11397849 0.12473118
##   Store 8  0.29844961  0.09496124 0.06201550 0.33527132 0.10852713 0.10077519
##   Store 9  0.24060150  0.11278195 0.06015038 0.36278195 0.10902256 0.11466165
```

As can be seen, the the share of transactions from the Clothing category is high in all stores, with the highest share of ~30% of transactions in Store 8.



### Continuous variables

#### Descriptive statistics

Continuous variables (also know as metric variables) are numeric variables that can take on any value on a measurement scale (i.e., there is an infinite number of values between any two values). There are different types of continuous variables as we have seen in chapter 1:

* **Interval variables**: while the zero point is arbitrary, equal intervals on the scale represent equal differences in the property being measured. E.g., on a temperature scale measured in Celsius the difference between a temperature of 15 degrees and 25 degrees is the same difference as between 25 degrees and 35 degrees but the zero point is arbitrary (there are different scales to measure temperature, such as Fahrenheit or Celsius, and zero in this case doesn't indicate the absence of temperature). 
* **Ratio variables**: has all the properties of an interval variable, but also has an absolute zero point. When the variable equals 0.0, it means that there is none of that variable (e.g., sales amount and customer age in our example). 

For interval and ratio variables we can compute the mean as a measure of central tendency, as well as the variance and the standard deviation as measures of dispersion. Computing descriptive statistics for continuous variables is easy and there are many functions. The easiest are:


``` r
# average customer age
avg_age <- mean(sales_data$Customer_Age)
avg_age
```

```
## [1] 35.58
```

``` r
# median customer age
median_age <- median(sales_data$Customer_Age)
median_age
```

```
## [1] 35
```

``` r
# or using quantile()
median_age <- quantile(sales_data$Customer_Age, 0.5,
    type = 1)
median_age
```

```
## 50% 
##  35
```

``` r
# customer age by percentiles
quantile(sales_data$Customer_Age, c(0.25, 0.5, 0.75),
    type = 1)
```

```
## 25% 50% 75% 
##  27  35  43
```

``` r
# mode customer age
library(DescTools)
mode_age <- Mode(sales_data$Customer_Age)
mode_age
```

```
## [1] 18
## attr(,"freq")
## [1] 382
```


We can also use functions that return multiple statistics at once; those are available in  different packages that let you calculate summary statistics (including the ```summary()``` function from the ```base``` package). In this tutorial, we will use the ```describe()``` function from the ```psych``` package. Note that you could just as well use other packages to compute the descriptive statistics (e.g., the ```stat.desc()``` function from the ```pastecs``` package). Which one you choose depends on what type of information you seek (the results provide slightly different information) and on personal preferences. 

We could, for example, compute the summary statistics for the variables "sales amount", "units sold", and "customer age" in our data set as follows:


``` r
library(psych)
psych::describe(select(sales_data, Sales_Amount, Units_Sold,
    Customer_Age))
```

```
##              vars    n   mean     sd median trimmed    mad min     max   range
## Sales_Amount    1 5000 279.29 282.95 202.95  226.90 218.36  10 2181.03 2171.03
## Units_Sold      2 5000   6.35   4.97   5.00    5.64   4.45   1   20.00   19.00
## Customer_Age    3 5000  35.58  11.07  35.00   35.19  11.86  18   80.00   62.00
##              skew kurtosis   se
## Sales_Amount 1.75     3.59 4.00
## Units_Sold   1.06     0.36 0.07
## Customer_Age 0.32    -0.36 0.16
```

You can see that the output contains measures of central tendency (e.g., the mean) and dispersion (e.g., standard deviation) for the selected variables. It can be seen, for example, that the mean of the sales amount variable is 279.29 while the median is 202.95. This already tells us something about the distribution of the data. Because the mean is higher (though not as substantially as it could get, in theory) than the median, we can conclude that there are a some purchases that costed somewhat more than others, potentially resulting in a right skew of the distribution. The median as a measure of central tendency is generally less susceptible to outliers.   

In the above command, we used the ```psych::``` prefix to avoid confusion and to make sure that R uses the ```describe()``` function from the ```psych``` package since there are many other packages that also contain a ```desribe()``` function. Note that you could also compute these statistics separately by using the respective functions (e.g., ```mean()```, ```sd()```, ```median()```, ```min()```, ```max()```, etc.). There are many options for additional statistics for this function. For example, you could add the argument `IQR = TRUE` to add the interquartile range to the output.   

The ```psych``` package also contains the ```describeBy()``` function, which lets you compute the summary statistics by sub-groups separately. For example, we could compute the summary statistics by category as follows: 


``` r
describeBy(select(sales_data, Sales_Amount, Units_Sold,
    Customer_Age), sales_data$Category, skew = FALSE,
    range = FALSE)
```

```
## 
##  Descriptive statistics by group 
## group: Clothing
##              vars    n   mean     sd   se
## Sales_Amount    1 1265 338.44 118.93 3.34
## Units_Sold      2 1265   5.55   2.88 0.08
## Customer_Age    3 1265  35.62  11.10 0.31
## ------------------------------------------------------------ 
## group: Electronics
##              vars   n   mean     sd    se
## Sales_Amount    1 490 854.81 300.01 13.55
## Units_Sold      2 490   1.98   0.83  0.04
## Customer_Age    3 490  35.49  11.31  0.51
## ------------------------------------------------------------ 
## group: Furniture
##              vars   n   mean     sd    se
## Sales_Amount    1 286 711.63 200.33 11.85
## Units_Sold      2 286   1.48   0.50  0.03
## Customer_Age    3 286  35.22  11.37  0.67
## ------------------------------------------------------------ 
## group: Grocery
##              vars    n  mean    sd   se
## Sales_Amount    1 1746 51.73 19.34 0.46
## Units_Sold      2 1746 10.23  5.81 0.14
## Customer_Age    3 1746 35.69 10.92 0.26
## ------------------------------------------------------------ 
## group: Sports
##              vars   n   mean    sd   se
## Sales_Amount    1 603 218.76 92.84 3.78
## Units_Sold      2 603   4.51  2.34 0.10
## Customer_Age    3 603  35.29 10.90 0.44
## ------------------------------------------------------------ 
## group: Toys
##              vars   n   mean    sd   se
## Sales_Amount    1 610 202.83 87.78 3.55
## Units_Sold      2 610   4.53  2.23 0.09
## Customer_Age    3 610  35.72 11.26 0.46
```

In this example, we used the arguments `skew = FALSE` and `range = FALSE` to exclude some statistics from the output. 

R is open to user contributions and various users have contributed packages that aim at making it easier for researchers to summarize statistics. For example, the <a href="https://cran.r-project.org/web/packages/summarytools/vignettes/Recommendations-rmarkdown.html" target="_blank">summarytools</a> package can be used to summarize the variables. If you would like to use this package and you are a Mac user, you may need to also install XQuartz (X11) too. To do this, go to <a href="https://www.xquartz.org/" target="_blank">this page</a> and download the XQuartz-2.7.7.dmg, then open the downloaded folder and click XQuartz.pkg and follow the instruction on screen and install XQuartz. If you still encouter an error after installing XQuartz, you may find a solution <a href="href="https://www.xquartz.org/" target="_blank">here</a>.

<style type="text/css">
 img {   background-color: transparent;   border: 0; }  .st-table td, .st-table th {   padding: 8px; }  .st-table > thead > tr {    background-color: #eeeeee; }  .st-cross-table td {   text-align: center; }  .st-descr-table td {   text-align: right; }  table.st-table th {   text-align: center; }  table.st-table > thead > tr {    background-color: #eeeeee; }  table.st-table td span {   display: block; }  table.st-table > tfoot > tr > td {   border:none; }  .st-container {   width: 100%;   padding-right: 15px;   padding-left: 15px;   margin-right: auto;   margin-left: auto;   margin-top: 15px; }  .st-multiline {   white-space: pre; }  .st-table {     width: auto;     table-layout: auto;     margin-top: 20px;     margin-bottom: 20px;     max-width: 100%;     background-color: transparent;     border-collapse: collapse; }  .st-table > thead > tr > th, .st-table > tbody > tr > th, .st-table > tfoot > tr > th, .st-table > thead > tr > td, .st-table > tbody > tr > td, .st-table > tfoot > tr > td {   vertical-align: middle; }  .st-table-bordered {   border: 1px solid #bbbbbb; }  .st-table-bordered > thead > tr > th, .st-table-bordered > tbody > tr > th, .st-table-bordered > thead > tr > td, .st-table-bordered > tbody > tr > td {   border: 1px solid #cccccc; }  .st-table-bordered > thead > tr > th, .st-table-bordered > thead > tr > td, .st-table thead > tr > th {   border-bottom: none; }  .st-freq-table > thead > tr > th, .st-freq-table > tbody > tr > th, .st-freq-table > tfoot > tr > th, .st-freq-table > thead > tr > td, .st-freq-table > tbody > tr > td, .st-freq-table > tfoot > tr > td, .st-freq-table-nomiss > thead > tr > th, .st-freq-table-nomiss > tbody > tr > th, .st-freq-table-nomiss > tfoot > tr > th, .st-freq-table-nomiss > thead > tr > td, .st-freq-table-nomiss > tbody > tr > td, .st-freq-table-nomiss > tfoot > tr > td, .st-cross-table > thead > tr > th, .st-cross-table > tbody > tr > th, .st-cross-table > tfoot > tr > th, .st-cross-table > thead > tr > td, .st-cross-table > tbody > tr > td, .st-cross-table > tfoot > tr > td {   padding-left: 20px;   padding-right: 20px; }  .st-table-bordered > thead > tr > th, .st-table-bordered > tbody > tr > th, .st-table-bordered > thead > tr > td, .st-table-bordered > tbody > tr > td {   border: 1px solid #cccccc; }  .st-table-striped > tbody > tr:nth-of-type(odd) {   background-color: #ffffff; }  .st-table-striped > tbody > tr:nth-of-type(even) {   background-color: #f9f9f9; }  .st-descr-table > thead > tr > th, .st-descr-table > tbody > tr > th, .st-descr-table > thead > tr > td, .st-descr-table > tbody > tr > td {   padding-left: 24px;   padding-right: 24px;   word-wrap: break-word; }  .st-freq-table, .st-freq-table-nomiss, .st-cross-table {   border: medium none; }  .st-freq-table > thead > tr:nth-child(1) > th:nth-child(1), .st-cross-table > thead > tr:nth-child(1) > th:nth-child(1), .st-cross-table > thead > tr:nth-child(1) > th:nth-child(3) {   border: none;   background-color: #ffffff;   text-align: center; }  .st-protect-top-border {   border-top: 1px solid #cccccc !important; }  .st-ws-char {   display: inline;   color: #999999;   letter-spacing: 0.2em; }  /* Optional classes */ .st-small {   font-size: 13px; }  .st-small td, .st-small th {   padding: 8px; }  .st-small > thead > tr > th, .st-small > tbody > tr > th, .st-small > thead > tr > td, .st-small > tbody > tr > td {   padding-left: 12px;   padding-right: 12px; } </style>


``` r
library(summarytools)
print(dfSummary(select(sales_data, Sales_Amount, Units_Sold,
    Customer_Age, Store, Category, Brand), plain.ascii = FALSE,
    style = "grid", valid.col = FALSE, tmp.img.dir = "tmp",
    graph.magnif = 0.65), method = "render", headings = FALSE,
    footnote = NA)
```

```{=html}
<div class="container st-container"><table class="table table-striped table-bordered st-table st-table-striped st-table-bordered st-multiline ">
  <thead>
    <tr>
      <th align="center" class="st-protect-top-border"><strong>No</strong></th>
      <th align="center" class="st-protect-top-border"><strong>Variable</strong></th>
      <th align="center" class="st-protect-top-border"><strong>Stats / Values</strong></th>
      <th align="center" class="st-protect-top-border"><strong>Freqs (% of Valid)</strong></th>
      <th align="center" class="st-protect-top-border"><strong>Graph</strong></th>
      <th align="center" class="st-protect-top-border"><strong>Missing</strong></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td align="center">1</td>
      <td align="left">Sales_Amount
[numeric]</td>
      <td align="left" style="padding:8;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0;margin:0;border:0" align="left">Mean (sd) : 279.3 (283)</td></tr><tr style="background-color:transparent"><td style="padding:0;margin:0;border:0" align="left">min &le; med &le; max:</td></tr><tr style="background-color:transparent"><td style="padding:0;margin:0;border:0" align="left">10 &le; 202.9 &le; 2181</td></tr><tr style="background-color:transparent"><td style="padding:0;margin:0;border:0" align="left">IQR (CV) : 316.1 (1)</td></tr></table></td>
      <td align="left" style="vertical-align:middle">4635 distinct values</td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent;"><img style="border:none;background-color:transparent;padding:0;max-width:max-content;" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAGcAAABKCAQAAAAMeoKaAAAAAmJLR0QA/4ePzL8AAAAHdElNRQfpAwoOFR2Lr92ZAAAA3ElEQVRo3u3bQQrCMBQAUSO5o3fQ89g79JS6TUMlhNJk+p3ZiUXySpLFB9PnFqn77AXI+R9OLj8sOwfplWYvsVW56Lz96lE9us5ea2fBNpsccnLIySEnh5wccnLIySEnh5wccnLIySEnh1wwTm498K7m1uyZdZOznVrTZ9bBNpsccnLIySEnh5wccnLIySEnh5wccnLIBeM0B1N17LlbN4c9dwu22eSQk0Ou+2arY13chzn1xT2Xd5jT4o3Ns9PX2M13Omfs2Urlry+X/F/fs3gh6ZKCnwW7CuSQ+wK3kxqlmFevVgAAAD10RVh0aWNjOmNvcHlyaWdodABDb3B5cmlnaHQgMjAwNyBBcHBsZSBJbmMuLCBhbGwgcmlnaHRzIHJlc2VydmVkLp5m3CkAAAAjdEVYdGljYzpkZXNjcmlwdGlvbgBHZW5lcmljIFJHQiBQcm9maWxlGqc4jgAAAABJRU5ErkJggg=="></td>
      <td align="center">0
(0.0%)</td>
    </tr>
    <tr>
      <td align="center">2</td>
      <td align="left">Units_Sold
[integer]</td>
      <td align="left" style="padding:8;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0;margin:0;border:0" align="left">Mean (sd) : 6.4 (5)</td></tr><tr style="background-color:transparent"><td style="padding:0;margin:0;border:0" align="left">min &le; med &le; max:</td></tr><tr style="background-color:transparent"><td style="padding:0;margin:0;border:0" align="left">1 &le; 5 &le; 20</td></tr><tr style="background-color:transparent"><td style="padding:0;margin:0;border:0" align="left">IQR (CV) : 7 (0.8)</td></tr></table></td>
      <td align="left" style="vertical-align:middle">20 distinct values</td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent;"><img style="border:none;background-color:transparent;padding:0;max-width:max-content;" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAGcAAABKCAQAAAAMeoKaAAAAAmJLR0QA/4ePzL8AAAAHdElNRQfpAwoOFR2Lr92ZAAABIElEQVRo3u2bQQ6DIBBFS8MdvUN7HryDp2w3tQ5F6dAgfKb/bYxCzLwIAwZwj4slrr0DoM7/6Hh5M4uOdHe9Q9Mie7+Pi6bXdekd448Ya2zUQYY6yFAHGeogQx1kqIMMdZChDjLUQYY6yFAHGeogQx1kqIMMdZChDjLUQYY6yPijgvBe3x5nST6jM+aSvLHGRh1kqIOMMR2vrxp29lmijUkFOutYtIgxCW2wVeiEzO7XVKyvlkJHNz+YFHXOx1gqoA4yRZlNQ99cV12nbxKvrrMn1g5jfYc6yJzYd8oIVc4/NNVJc52U0Mz/vmXLJjpbEOvM7vNJnP/SWtkyIdZEJw25ZFob/5Lk32AsFTj5Pechz/XdRGNzQxocYqyxUQeZJ1TYOSZOtNhnAAAAPXRFWHRpY2M6Y29weXJpZ2h0AENvcHlyaWdodCAyMDA3IEFwcGxlIEluYy4sIGFsbCByaWdodHMgcmVzZXJ2ZWQunmbcKQAAACN0RVh0aWNjOmRlc2NyaXB0aW9uAEdlbmVyaWMgUkdCIFByb2ZpbGUapziOAAAAAElFTkSuQmCC"></td>
      <td align="center">0
(0.0%)</td>
    </tr>
    <tr>
      <td align="center">3</td>
      <td align="left">Customer_Age
[integer]</td>
      <td align="left" style="padding:8;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0;margin:0;border:0" align="left">Mean (sd) : 35.6 (11.1)</td></tr><tr style="background-color:transparent"><td style="padding:0;margin:0;border:0" align="left">min &le; med &le; max:</td></tr><tr style="background-color:transparent"><td style="padding:0;margin:0;border:0" align="left">18 &le; 35 &le; 80</td></tr><tr style="background-color:transparent"><td style="padding:0;margin:0;border:0" align="left">IQR (CV) : 16 (0.3)</td></tr></table></td>
      <td align="left" style="vertical-align:middle">57 distinct values</td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent;"><img style="border:none;background-color:transparent;padding:0;max-width:max-content;" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAGcAAABKCAQAAAAMeoKaAAAAAmJLR0QA/4ePzL8AAAAHdElNRQfpAwoOFR2Lr92ZAAABEUlEQVRo3u2ZQQ6DMAwEk4o/9g/te+gf+sr22BgJhCziTNydExwIjOI4C9RPycRt9ANI5390lvakOgdZNwvw6R3IRXvzxT2K4d4cvyNdNmQutvOs0P7uLjZKeVmSFZt0yEiHjHTInN53qBunU4e6cbp1zmNnMjJfd9EZN4/JWoF0yEiHjHTISIeMSQVjP/9drrONJ3Ok6AOdI7kZSLZ2pEOmy/uOJfJlLkAnsqEkKzbpkJEOGemQkQ4Z6ZAJyGyWvoE0XKdvIE1WbNIhIx0y0iGTTCd8G7VcnREG61ydEZIVm3TISIfM4M5madu2r2mjdH5t29u0VWwx+PJCba96TffjvZRSHo1qndJgl2RrRzpkvrSRJXNEka0NAAAAPXRFWHRpY2M6Y29weXJpZ2h0AENvcHlyaWdodCAyMDA3IEFwcGxlIEluYy4sIGFsbCByaWdodHMgcmVzZXJ2ZWQunmbcKQAAACN0RVh0aWNjOmRlc2NyaXB0aW9uAEdlbmVyaWMgUkdCIFByb2ZpbGUapziOAAAAAElFTkSuQmCC"></td>
      <td align="center">0
(0.0%)</td>
    </tr>
    <tr>
      <td align="center">4</td>
      <td align="left">Store
[factor]</td>
      <td align="left" style="padding:8;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0;margin:0;border:0" align="left">1. Store 1</td></tr><tr style="background-color:transparent"><td style="padding:0;margin:0;border:0" align="left">2. Store 10</td></tr><tr style="background-color:transparent"><td style="padding:0;margin:0;border:0" align="left">3. Store 2</td></tr><tr style="background-color:transparent"><td style="padding:0;margin:0;border:0" align="left">4. Store 3</td></tr><tr style="background-color:transparent"><td style="padding:0;margin:0;border:0" align="left">5. Store 4</td></tr><tr style="background-color:transparent"><td style="padding:0;margin:0;border:0" align="left">6. Store 5</td></tr><tr style="background-color:transparent"><td style="padding:0;margin:0;border:0" align="left">7. Store 6</td></tr><tr style="background-color:transparent"><td style="padding:0;margin:0;border:0" align="left">8. Store 7</td></tr><tr style="background-color:transparent"><td style="padding:0;margin:0;border:0" align="left">9. Store 8</td></tr><tr style="background-color:transparent"><td style="padding:0;margin:0;border:0" align="left">10. Store 9</td></tr></table></td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">494</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">9.9%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">506</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">10.1%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">514</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">10.3%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">522</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">10.4%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">461</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">9.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">488</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">9.8%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">502</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">10.0%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">465</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">9.3%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">516</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">10.3%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">532</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">10.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent;"><img style="border:none;background-color:transparent;padding:0;max-width:max-content;" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAABcAAACgCAQAAABN7D/mAAAAAmJLR0QA/4ePzL8AAAAHdElNRQfpAwoOFR2Lr92ZAAAAlUlEQVRYw+3WwQ2AIAyF4da4o0Mwj+7AlHoFpDFEjRT/dzP5DtQ8GnSXlkxN+mU+px9bZZCgu8VFlgLHnkeFP8SLEsQLnhVIqyQVdw6z1m+iGvxc4HKarv47/BtO363AXXAKbAU+IvfV96Am54X9T06BrcBH5O/2nRcH3HWBWdjwvjgLG+6a+1rYQt/hee4U+OuzN/IDwco4fxpwo9kAAAA9dEVYdGljYzpjb3B5cmlnaHQAQ29weXJpZ2h0IDIwMDcgQXBwbGUgSW5jLiwgYWxsIHJpZ2h0cyByZXNlcnZlZC6eZtwpAAAAI3RFWHRpY2M6ZGVzY3JpcHRpb24AR2VuZXJpYyBSR0IgUHJvZmlsZRqnOI4AAAAASUVORK5CYII="></td>
      <td align="center">0
(0.0%)</td>
    </tr>
    <tr>
      <td align="center">5</td>
      <td align="left">Category
[factor]</td>
      <td align="left" style="padding:8;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0;margin:0;border:0" align="left">1. Clothing</td></tr><tr style="background-color:transparent"><td style="padding:0;margin:0;border:0" align="left">2. Electronics</td></tr><tr style="background-color:transparent"><td style="padding:0;margin:0;border:0" align="left">3. Furniture</td></tr><tr style="background-color:transparent"><td style="padding:0;margin:0;border:0" align="left">4. Grocery</td></tr><tr style="background-color:transparent"><td style="padding:0;margin:0;border:0" align="left">5. Sports</td></tr><tr style="background-color:transparent"><td style="padding:0;margin:0;border:0" align="left">6. Toys</td></tr></table></td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1265</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">25.3%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">490</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">9.8%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">286</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">5.7%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">1746</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">34.9%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">603</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">12.1%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">610</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">12.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent;"><img style="border:none;background-color:transparent;padding:0;max-width:max-content;" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAC8AAABjCAQAAAChtJEwAAAAAmJLR0QA/4ePzL8AAAAHdElNRQfpAwoOFR2Lr92ZAAAAzElEQVRo3u2Yyw2EMAwFNyt6pAjqWXqgSjhilpCP4yBZmXeDoJGwzcgi7J+e+XalO8dP8mKtbsQS7vckZLoezVXwLfuE79qDBz8i/k8K+c+8LkEKKKgxMpL4ZnF+ESEvTa+UEXJrL3wPJnjw4M2D7xN59H2b56P40/dWPfA9mODBj4hHyIlkF3BNRR7wtX9EYrl2z/dgggcP3jz4PpEi3+uX8QLft/TD92CCBz8iHiEnUriAa5VctIDrO+J7MMGDB2+eN31vH9+174w/ALz0I2jnKeKHAAAAPXRFWHRpY2M6Y29weXJpZ2h0AENvcHlyaWdodCAyMDA3IEFwcGxlIEluYy4sIGFsbCByaWdodHMgcmVzZXJ2ZWQunmbcKQAAACN0RVh0aWNjOmRlc2NyaXB0aW9uAEdlbmVyaWMgUkdCIFByb2ZpbGUapziOAAAAAElFTkSuQmCC"></td>
      <td align="center">0
(0.0%)</td>
    </tr>
    <tr>
      <td align="center">6</td>
      <td align="left">Brand
[factor]</td>
      <td align="left" style="padding:8;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0;margin:0;border:0" align="left">1. Adidas</td></tr><tr style="background-color:transparent"><td style="padding:0;margin:0;border:0" align="left">2. Apple</td></tr><tr style="background-color:transparent"><td style="padding:0;margin:0;border:0" align="left">3. Ashley</td></tr><tr style="background-color:transparent"><td style="padding:0;margin:0;border:0" align="left">4. Costco</td></tr><tr style="background-color:transparent"><td style="padding:0;margin:0;border:0" align="left">5. Decathlon</td></tr><tr style="background-color:transparent"><td style="padding:0;margin:0;border:0" align="left">6. Fisher-Price</td></tr><tr style="background-color:transparent"><td style="padding:0;margin:0;border:0" align="left">7. H&M</td></tr><tr style="background-color:transparent"><td style="padding:0;margin:0;border:0" align="left">8. Hasbro</td></tr><tr style="background-color:transparent"><td style="padding:0;margin:0;border:0" align="left">9. IKEA</td></tr><tr style="background-color:transparent"><td style="padding:0;margin:0;border:0" align="left">10. LEGO</td></tr><tr style="background-color:transparent"><td style="padding:0;margin:0;border:0" align="left">[ 19 others ]</td></tr></table></td>
      <td align="left" style="padding:0;vertical-align:middle"><table style="border-collapse:collapse;border:none;margin:0"><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">238</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">4.8%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">97</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.9%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">76</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.5%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">350</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">7.0%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">111</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">131</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.6%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">254</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">5.1%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">119</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.4%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">61</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">1.2%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">121</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">2.4%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr><tr style="background-color:transparent"><td style="padding:0 5px 0 7px;margin:0;border:0" align="right">3442</td><td style="padding:0 2px 0 0;border:0;" align="left">(</td><td style="padding:0;border:0" align="right">68.8%</td><td style="padding:0 4px 0 2px;border:0" align="left">)</td></tr></table></td>
      <td align="left" style="vertical-align:middle;padding:0;background-color:transparent;"><img style="border:none;background-color:transparent;padding:0;max-width:max-content;" src="data:image/png;base64, iVBORw0KGgoAAAANSUhEUgAAAFAAAACwCAQAAAAyXCGkAAAAAmJLR0QA/4ePzL8AAAAHdElNRQfpAwoOFR2Lr92ZAAABWklEQVR42u3cQQ6CMBRF0WLYI4twPbgHV4kDEi0NCGlr3vvx3plxcmIl/LTisCTvbmoAwF835i8e7y/kfVCi8uti3L41pZRSeip1RfZLDBCgOoAA1QFsrbgXO92F14Z8cpCOMFmH08y8pKQetcqK7+Ck9pwB/QIIUB1AgOoAdgYybl0qN8Va4nmZ7XaEY32CjgEEqA4gQHUAW2Pcam1n++2Tw0bc7mnnmsf4b7/EAAGqAwhQHcDWOO2sKfo86DAFfuI4FqA6gADVAfw3IOPWpRi3esa4BVAdQIDqAAJUxzxY08nDBmsuQ9fBaafPUke7SPwCCFAdQIDq7IGcdtbE9lvP2H4DqA4gQHUAAapj+62mw3mQZzsBAgQI0C+AANXZA2ONW46x/dYZ6BdAgOoAAlQXDcju1qWij1sGZUv55b8+VG2vA/slBghQHUCA6gC2FuvXb47ZLzHA1l7gKTv0JK8p/wAAAD10RVh0aWNjOmNvcHlyaWdodABDb3B5cmlnaHQgMjAwNyBBcHBsZSBJbmMuLCBhbGwgcmlnaHRzIHJlc2VydmVkLp5m3CkAAAAjdEVYdGljYzpkZXNjcmlwdGlvbgBHZW5lcmljIFJHQiBQcm9maWxlGqc4jgAAAABJRU5ErkJggg=="></td>
      <td align="center">0
(0.0%)</td>
    </tr>
  </tbody>
</table></div>
```

The 'Missing' column in the output above gives us information about missing values. It this case, there are no missing values; however, in reality there are usually at least a couple of lost or not recorded values. To get more precise analysis results, we might want to exclude these observations by creating a "complete" subset of our data. Imagine that we have a missing value in the variable "Sales_Amount"; we would create a subset by filtering that hypothetical observation out:


``` r
sales_data_full <- filter(sales_data, !is.na(Sales_Amount))
```

In the command above, `!is.na()` is used to filter the rows for observations where the respective variable does not have missing values. The "!" in this case translates to "is not" and the function `is.na()` checks for missing values. Hence, the entire statement can be read as "select the rows from the 'sales_data' data set where the values of the 'Sales_Amount' variable are not missing".

As you can see, the output also includes a visualization of the frequency distribution using a histogram for the continuous variables and a bar chart for the categorical variables. The frequency distribution is an important element that allows us to assign probabilities to observed values if the observations come from a known probability distribution. How to derive these probability statements will be discussed next.   

#### Using frequency distributions to go beyond the data


The frequency distribution can be used to make statements about the probability that a certain observed value will occur if the observations come from a known probability distribution. For normally distributed data, the following table can be used to look up the probability that a certain value will occur. For example, the value of -1.96 has a probability of 2.5% (i.e., .0250).  

<div class="figure" style="text-align: center">
<img src="./images/prob_table.JPG" alt="Standard normal table" width="70%" />
<p class="caption">(\#fig:unnamed-chunk-14)Standard normal table</p>
</div>
There are two things worth noting. First, the normal distribution has two tails as the following figure shows and we need to take the probability mass at each side of the distribution into account. Hence, there is a 2.5% probability of observing a value of -1.96 or smaller and a 2.5% of observing a value of 1.96 or larger. Hence, the probability mass within this interval is 0.95.  

<div class="figure" style="text-align: center">
<img src="./images/normal_distribution.JPG" alt="Standard normal distribution" width="70%" />
<p class="caption">(\#fig:unnamed-chunk-15)Standard normal distribution</p>
</div>
The second point is related to the scale of the distribution. Since the variables that we will collect can be measured at many different scales (e.g., number of streams, duration in milliseconds), we need a way to convert the scale into a standardized measure that would allow us to compare the observations against the values from the probability table. The **standardized variate**, or z-score, allows us to do exactly that. It is computed as follows: 

$$\begin{align}
Z=\frac{X_i-\bar{X}}{s}
\end{align}
$$ 

By subtracting the mean of the variable from each observation and dividing by the standard deviation, the data is converted to a scale with mean = 0 and SD = 1, so we can use the tables of probabilities for the normal distribution to see how likely it is that a particular score will occur in the data. In other words, **the z-score tells us how many standard deviations above or below the mean a particular x-value is**. 


To see how this works in practice, let's inspect the distribution of the 'customer age' variable from the sales data set. The `hist()`-function can be used to draw the corresponding histogram.


``` r
hist(sales_data$Customer_Age)
```

<div class="figure" style="text-align: center">
<img src="04-basic_statistics_files/figure-html/unnamed-chunk-16-1.png" alt="Histogram of tempo variable" width="672" />
<p class="caption">(\#fig:unnamed-chunk-16)Histogram of tempo variable</p>
</div>

In this case, the variable is measured on the scale "years lived" (so it takes values from 0 to, potentially, infinity). To standardize this variable, we will subtract the mean of this variable from each observation and then divide by the standard deviation. We can compute the standardized variable by hand as follows:


``` r
sales_data$age_std <- (sales_data$Customer_Age - mean(sales_data$Customer_Age))/sd(sales_data$Customer_Age)
# sales_data$age_std <-
# scale(sales_data$Customer_Age)
```

If we create the histogram again, we can see that the scale has changed and now we can compare the standardized values to the values we find in the probability table.  


``` r
hist(sales_data$age_std)
```

<div class="figure" style="text-align: center">
<img src="04-basic_statistics_files/figure-html/unnamed-chunk-18-1.png" alt="Histogram of standardized tempo variable" width="672" />
<p class="caption">(\#fig:unnamed-chunk-18)Histogram of standardized tempo variable</p>
</div>


Instead of manually comparing the observed values to the values in the table, it is much easier to use the in-built functions to obtain the probabilities. The `pnorm()`-function gives the probability of obtaining values lower than the indicated values (i.e., the probability mass left of that value). For the value of 1.96, this probability mass is ~0.025, in line with the table above. 


``` r
pnorm(-1.96)
```

```
## [1] 0.0249979
```

To also take the other end of the distribution into consideration, we would need to multiply this value by to. This way, we arrive at a value of 5%.


``` r
pnorm(-1.96) * 2
```

```
## [1] 0.04999579
```
Regarding the standard normal distribution, it is helpful to remember the following numbers, indicating the points on the standard normal distribution, where the sum of the probability mass to the left at the lower end and to the right of the upper end exceed a certain threshold:  

* +/-**1.645** - 10% of probability mass outside this region
* +/-**1.960** - 5% of probability mass outside this region
* +/-**2.580** - 1% of probability mass outside this region

Going back to our example, we could also ask: what is the probability of obtaining the minimum (or maximum) observed value in our data? The minimum value on the standardized scale is:


``` r
min(sales_data$age_std)
```

```
## [1] -1.588711
```
And the associated probability is:  


``` r
pnorm(min(sales_data$age_std)) * 2
```

```
## [1] 0.1121256
```
Although the probability of observing this minimum value is low, there are very few observations in the extreme regions at each end of the histogram, so this doesn't seem too unusual. As a rule of thumb, you can remember that 68% of the observations of a normally distributed variable should be within 1 standard deviation of the mean, 95% within 2 standard deviations, and 99.7% within 3 standard deviations. This is also shown in the following plot: 

<div class="figure" style="text-align: center">
<img src="./images/prob_rule.JPG" alt="The 68, 95, 99.7 rule (source: Wikipedia)" width="70%" />
<p class="caption">(\#fig:unnamed-chunk-23)The 68, 95, 99.7 rule (source: Wikipedia)</p>
</div>

In case of our 'customer age' variable, we do observe values that are more than 3 standard deviations away from the mean. In this and other instances, checking the standardized values of a variable may help you to identify outliers. For example, if you conducted a survey and you would like to exclude respondents who answered the survey too fast, you may exclude cases with a low probability based on the distribution of the duration variable.   

