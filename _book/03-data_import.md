---
output:
  html_document:
    toc: yes
  html_notebook: default
  pdf_document:
    toc: yes
---

## Data import and export 






Before you can start your analysis in R, you first need to import the data you wish to perform the analysis on. You will often be faced with different types of data formats (usually produced by some other statistical software like SPSS or Excel or a text editor). Fortunately, R is fairly flexible with respect to the sources from which data may be imported and you can import the most common data formats into R with the help of a few packages. R can, among others, handle data from the following sources: 

![](https://github.com/IMSMWU/Teaching/raw/master/MRDA2017/Graphics/data_import.JPG)

In the previous chapter, we saw how we may use the keyboard to input data in R. In the following sections, we will learn how to import data from text files and other statistical software packages. 

### Getting data for this course

Most of the data sets we will be working with in this course will be stored in text files (i.e., .dat, .txt, .csv). All data sets we will be working with are stored in a repository on GitHub (similar to other cloud storage services such as Dropbox). You can directly import these data sets from GitHub without having to copy data sets from one place to another. If you know the location, where the files are stored, you may conveniently load the data directly from GitHub into R using the ```read.csv()``` function. To figure out the structure of the data you can read the first couple of lines of a file using the `readLines` function. The ```header=TRUE``` argument in the `read.csv` function indicates that the first line of data represents the header, i.e., it contains the names of the columns. The ```sep=";"```-argument specifies the delimiter (the character used to separate the columns), which is a ";" in this case. 


```r
readLines("https://short.wu.ac.at/ma22_musicdata", n = 3)
```

```
## [1] "\"isrc\";\"artist_id\";\"streams\";\"weeks_in_charts\";\"n_regions\";\"danceability\";\"energy\";\"speechiness\";\"instrumentalness\";\"liveness\";\"valence\";\"tempo\";\"song_length\";\"song_age\";\"explicit\";\"n_playlists\";\"sp_popularity\";\"youtube_views\";\"tiktok_counts\";\"ins_followers_artist\";\"monthly_listeners_artist\";\"playlist_total_reach_artist\";\"sp_fans_artist\";\"shazam_counts\";\"artistName\";\"trackName\";\"release_date\";\"genre\";\"label\";\"top10\";\"expert_rating\""
## [2] "\"BRRGE1603547\";3679;11944813;141;1;50,9;80,3;4;0,05;46,3;65,1;166,018;3,11865;228,285714285714;0;450;51;145030723;9740;29613108;4133393;24286416;3308630;73100;\"Luan Santana\";\"Eu, VocÃª, O Mar e Ela\";\"2016-06-20\";\"other\";\"Independent\";1;\"excellent\""                                                                                                                                                                                                                                            
## [3] "\"USUM71808193\";5239;8934097;51;21;35,3;75,5;73,3;0;39;43,7;191,153;3,228;144,285714285714;0;768;54;13188411;358700;3693566;18367363;143384531;465412;588550;\"Alessia Cara\";\"Growing Pains\";\"2018-06-14\";\"Pop\";\"Universal Music\";0;\"good\""
```

```r
test_data <- read.csv("https://short.wu.ac.at/ma22_musicdata", 
                        sep = ";", 
                        header = TRUE)
head(test_data)
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["isrc"],"name":[1],"type":["chr"],"align":["left"]},{"label":["artist_id"],"name":[2],"type":["int"],"align":["right"]},{"label":["streams"],"name":[3],"type":["dbl"],"align":["right"]},{"label":["weeks_in_charts"],"name":[4],"type":["int"],"align":["right"]},{"label":["n_regions"],"name":[5],"type":["int"],"align":["right"]},{"label":["danceability"],"name":[6],"type":["chr"],"align":["left"]},{"label":["energy"],"name":[7],"type":["chr"],"align":["left"]},{"label":["speechiness"],"name":[8],"type":["chr"],"align":["left"]},{"label":["instrumentalness"],"name":[9],"type":["chr"],"align":["left"]},{"label":["liveness"],"name":[10],"type":["chr"],"align":["left"]},{"label":["valence"],"name":[11],"type":["chr"],"align":["left"]},{"label":["tempo"],"name":[12],"type":["chr"],"align":["left"]},{"label":["song_length"],"name":[13],"type":["chr"],"align":["left"]},{"label":["song_age"],"name":[14],"type":["chr"],"align":["left"]},{"label":["explicit"],"name":[15],"type":["int"],"align":["right"]},{"label":["n_playlists"],"name":[16],"type":["int"],"align":["right"]},{"label":["sp_popularity"],"name":[17],"type":["int"],"align":["right"]},{"label":["youtube_views"],"name":[18],"type":["dbl"],"align":["right"]},{"label":["tiktok_counts"],"name":[19],"type":["int"],"align":["right"]},{"label":["ins_followers_artist"],"name":[20],"type":["int"],"align":["right"]},{"label":["monthly_listeners_artist"],"name":[21],"type":["int"],"align":["right"]},{"label":["playlist_total_reach_artist"],"name":[22],"type":["int"],"align":["right"]},{"label":["sp_fans_artist"],"name":[23],"type":["int"],"align":["right"]},{"label":["shazam_counts"],"name":[24],"type":["int"],"align":["right"]},{"label":["artistName"],"name":[25],"type":["chr"],"align":["left"]},{"label":["trackName"],"name":[26],"type":["chr"],"align":["left"]},{"label":["release_date"],"name":[27],"type":["chr"],"align":["left"]},{"label":["genre"],"name":[28],"type":["chr"],"align":["left"]},{"label":["label"],"name":[29],"type":["chr"],"align":["left"]},{"label":["top10"],"name":[30],"type":["int"],"align":["right"]},{"label":["expert_rating"],"name":[31],"type":["chr"],"align":["left"]}],"data":[{"1":"BRRGE1603547","2":"3679","3":"11944813","4":"141","5":"1","6":"50,9","7":"80,3","8":"4","9":"0,05","10":"46,3","11":"65,1","12":"166,018","13":"3,11865","14":"228,285714285714","15":"0","16":"450","17":"51","18":"145030723","19":"9740","20":"29613108","21":"4133393","22":"24286416","23":"3308630","24":"73100","25":"Luan Santana","26":"Eu, VocÃª, O Mar e Ela","27":"2016-06-20","28":"other","29":"Independent","30":"1","31":"excellent"},{"1":"USUM71808193","2":"5239","3":"8934097","4":"51","5":"21","6":"35,3","7":"75,5","8":"73,3","9":"0","10":"39","11":"43,7","12":"191,153","13":"3,228","14":"144,285714285714","15":"0","16":"768","17":"54","18":"13188411","19":"358700","20":"3693566","21":"18367363","22":"143384531","23":"465412","24":"588550","25":"Alessia Cara","26":"Growing Pains","27":"2018-06-14","28":"Pop","29":"Universal Music","30":"0","31":"good"},{"1":"ES5701800181","2":"776407","3":"38835","4":"1","5":"1","6":"68,3","7":"67,6","8":"14,7","9":"0","10":"7,26","11":"43,4","12":"98,992","13":"3,01555","14":"112,285714285714","15":"0","16":"48","17":"32","18":"6116639","19":"0","20":"623778","21":"888273","22":"4846378","23":"23846","24":"0","25":"Ana Guerra","26":"El Remedio","27":"2018-04-26","28":"Pop","29":"Universal Music","30":"0","31":"good"},{"1":"ITRSE2000050","2":"433730","3":"46766","4":"1","5":"1","6":"70,4","7":"56,8","8":"26,8","9":"0,000253","10":"8,91","11":"49,5","12":"91,007","13":"3,45341666666667","14":"50,7142857142857","15":"0","16":"6","17":"44","18":"0","19":"13","20":"81601","21":"143761","22":"156521","23":"1294","24":"0","25":"Claver Gold feat. Murubutu","26":"Ulisse","27":"2020-03-31","28":"HipHop/Rap","29":"Independent","30":"0","31":"poor"},{"1":"QZJ842000061","2":"526471","3":"2930573","4":"7","5":"4","6":"84,2","7":"57,8","8":"13,8","9":"0","10":"22,8","11":"19","12":"74,496","13":"3,94631666666667","14":"58,2857142857143","15":"0","16":"475","17":"52","18":"0","19":"515","20":"11962358","21":"15551876","22":"90841884","23":"380204","24":"55482","25":"Trippie Redd feat. Young Thug","26":"YELL OH","27":"2020-02-07","28":"HipHop/Rap","29":"Universal Music","30":"0","31":"excellent"},{"1":"USIR20400274","2":"1939","3":"72199738","4":"226","5":"8","6":"35,2","7":"91,1","8":"7,47","9":"0","10":"9,95","11":"23,6","12":"148,033","13":"3,71621666666667","14":"876,714285714286","15":"0","16":"20591","17":"81","18":"20216069","19":"67300","20":"1169284","21":"16224250","22":"80408253","23":"1651866","24":"5281161","25":"The Killers","26":"Mr. Brightside","27":"2004-06-07","28":"Rock","29":"Universal Music","30":"1","31":"fair"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

Note that it is also possible to download the data, placing it in the working directory and importing it from there. However, this requires an additional step to download the file manually first. If you chose this option, please **remember to put the data file in the working directory first**. If the import is not working, check your working directory setting using ```getwd()```. Once you placed the file in the working directory, you can import it using the same command as above. Note that the file must be given as a character string (i.e., in quotation marks) and has to end with the file extension (e.g., .csv, .tsv, etc.).


```r
test_data <- read.csv("data/music_data_fin.csv", header=TRUE, sep = ";")
head(test_data)
```

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["isrc"],"name":[1],"type":["chr"],"align":["left"]},{"label":["artist_id"],"name":[2],"type":["int"],"align":["right"]},{"label":["streams"],"name":[3],"type":["dbl"],"align":["right"]},{"label":["weeks_in_charts"],"name":[4],"type":["int"],"align":["right"]},{"label":["n_regions"],"name":[5],"type":["int"],"align":["right"]},{"label":["danceability"],"name":[6],"type":["chr"],"align":["left"]},{"label":["energy"],"name":[7],"type":["chr"],"align":["left"]},{"label":["speechiness"],"name":[8],"type":["chr"],"align":["left"]},{"label":["instrumentalness"],"name":[9],"type":["chr"],"align":["left"]},{"label":["liveness"],"name":[10],"type":["chr"],"align":["left"]},{"label":["valence"],"name":[11],"type":["chr"],"align":["left"]},{"label":["tempo"],"name":[12],"type":["chr"],"align":["left"]},{"label":["song_length"],"name":[13],"type":["chr"],"align":["left"]},{"label":["song_age"],"name":[14],"type":["chr"],"align":["left"]},{"label":["explicit"],"name":[15],"type":["int"],"align":["right"]},{"label":["n_playlists"],"name":[16],"type":["int"],"align":["right"]},{"label":["sp_popularity"],"name":[17],"type":["int"],"align":["right"]},{"label":["youtube_views"],"name":[18],"type":["dbl"],"align":["right"]},{"label":["tiktok_counts"],"name":[19],"type":["int"],"align":["right"]},{"label":["ins_followers_artist"],"name":[20],"type":["int"],"align":["right"]},{"label":["monthly_listeners_artist"],"name":[21],"type":["int"],"align":["right"]},{"label":["playlist_total_reach_artist"],"name":[22],"type":["int"],"align":["right"]},{"label":["sp_fans_artist"],"name":[23],"type":["int"],"align":["right"]},{"label":["shazam_counts"],"name":[24],"type":["int"],"align":["right"]},{"label":["artistName"],"name":[25],"type":["chr"],"align":["left"]},{"label":["trackName"],"name":[26],"type":["chr"],"align":["left"]},{"label":["release_date"],"name":[27],"type":["chr"],"align":["left"]},{"label":["genre"],"name":[28],"type":["chr"],"align":["left"]},{"label":["label"],"name":[29],"type":["chr"],"align":["left"]},{"label":["top10"],"name":[30],"type":["int"],"align":["right"]},{"label":["expert_rating"],"name":[31],"type":["chr"],"align":["left"]}],"data":[{"1":"BRRGE1603547","2":"3679","3":"11944813","4":"141","5":"1","6":"50,9","7":"80,3","8":"4","9":"0,05","10":"46,3","11":"65,1","12":"166,018","13":"3,11865","14":"228,285714285714","15":"0","16":"450","17":"51","18":"145030723","19":"9740","20":"29613108","21":"4133393","22":"24286416","23":"3308630","24":"73100","25":"Luan Santana","26":"Eu, VocÃª, O Mar e Ela","27":"2016-06-20","28":"other","29":"Independent","30":"1","31":"excellent"},{"1":"USUM71808193","2":"5239","3":"8934097","4":"51","5":"21","6":"35,3","7":"75,5","8":"73,3","9":"0","10":"39","11":"43,7","12":"191,153","13":"3,228","14":"144,285714285714","15":"0","16":"768","17":"54","18":"13188411","19":"358700","20":"3693566","21":"18367363","22":"143384531","23":"465412","24":"588550","25":"Alessia Cara","26":"Growing Pains","27":"2018-06-14","28":"Pop","29":"Universal Music","30":"0","31":"good"},{"1":"ES5701800181","2":"776407","3":"38835","4":"1","5":"1","6":"68,3","7":"67,6","8":"14,7","9":"0","10":"7,26","11":"43,4","12":"98,992","13":"3,01555","14":"112,285714285714","15":"0","16":"48","17":"32","18":"6116639","19":"0","20":"623778","21":"888273","22":"4846378","23":"23846","24":"0","25":"Ana Guerra","26":"El Remedio","27":"2018-04-26","28":"Pop","29":"Universal Music","30":"0","31":"good"},{"1":"ITRSE2000050","2":"433730","3":"46766","4":"1","5":"1","6":"70,4","7":"56,8","8":"26,8","9":"0,000253","10":"8,91","11":"49,5","12":"91,007","13":"3,45341666666667","14":"50,7142857142857","15":"0","16":"6","17":"44","18":"0","19":"13","20":"81601","21":"143761","22":"156521","23":"1294","24":"0","25":"Claver Gold feat. Murubutu","26":"Ulisse","27":"2020-03-31","28":"HipHop/Rap","29":"Independent","30":"0","31":"poor"},{"1":"QZJ842000061","2":"526471","3":"2930573","4":"7","5":"4","6":"84,2","7":"57,8","8":"13,8","9":"0","10":"22,8","11":"19","12":"74,496","13":"3,94631666666667","14":"58,2857142857143","15":"0","16":"475","17":"52","18":"0","19":"515","20":"11962358","21":"15551876","22":"90841884","23":"380204","24":"55482","25":"Trippie Redd feat. Young Thug","26":"YELL OH","27":"2020-02-07","28":"HipHop/Rap","29":"Universal Music","30":"0","31":"excellent"},{"1":"USIR20400274","2":"1939","3":"72199738","4":"226","5":"8","6":"35,2","7":"91,1","8":"7,47","9":"0","10":"9,95","11":"23,6","12":"148,033","13":"3,71621666666667","14":"876,714285714286","15":"0","16":"20591","17":"81","18":"20216069","19":"67300","20":"1169284","21":"16224250","22":"80408253","23":"1651866","24":"5281161","25":"The Killers","26":"Mr. Brightside","27":"2004-06-07","28":"Rock","29":"Universal Music","30":"1","31":"fair"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>


### Export data

Exporting to different formats is also easy, as you can just replace "read" with "write" in many of the previously discussed functions (e.g. ```write.csv(object, "file_name")```). This will save the data file to the working directory. To check what the current working directory is you can use ```getwd()```. By default, the ```write.csv(object, "file_name")```function includes the row number as the first variable. By specifying ```row.names = FALSE```, you may exclude this variable since it doesn't contain any useful information.  


```r
write.csv(music_data, "musicData.csv", row.names = FALSE)  #writes to a comma-separated value file 
write_sav(music_data, "musicData.sav")
```



## Learning check {-}

**(LC3.1) Which of the following are data types are recognized by R?**

- [ ] Factor
- [ ] Date
- [ ] Decimal
- [ ] Vector
- [ ] None of the above 	

**(LC3.2) What function should you use to check if an object is a data frame?**

- [ ] `type()`
- [ ] `str()`
- [ ] `class()`
- [ ] `object.type()`
- [ ] None of the above 	

**(LC3.3) You would like to combine three vectors (student, grade, date) in a data frame. What would happen when executing the following code?** 


```r
student <- c("Max", "Jonas", "Saskia", "Victoria")
grade <- c(3, 2, 1, 2)
date <- as.Date(c("2020-10-06", "2020-10-08", "2020-10-09"))
df <- data.frame(student, grade, date)
```

- [ ] Error because a data frame can not have different data types
- [ ] Error because you should use `as.data.frame()` instead of `data.frame()`
- [ ] Error because all vectors need to have the same length
- [ ] Error because the column names are not specified
- [ ] This code should not report an error	

**You would like to analyze the following data frame**

<div data-pagedtable="false">
  <script data-pagedtable-source type="application/json">
{"columns":[{"label":["student"],"name":[1],"type":["chr"],"align":["left"]},{"label":["grade"],"name":[2],"type":["dbl"],"align":["right"]},{"label":["country"],"name":[3],"type":["chr"],"align":["left"]}],"data":[{"1":"Christian","2":"1","3":"AT"},{"1":"Matthias","2":"1","3":"AT"},{"1":"Max","2":"NA","3":"AT"},{"1":"Christina","2":"3","3":"AT"},{"1":"Ines","2":"2","3":"DE"},{"1":"Eddie","2":"1","3":"DE"},{"1":"Janine","2":"2","3":"DE"},{"1":"Victoria","2":"3","3":"SK"},{"1":"Pia","2":"1","3":"US"},{"1":"Julia","2":"2","3":"CA"},{"1":"Lena","2":"3","3":"AT"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>

**(LC3.4) How can you obtain Christina's grade from the data frame?**

- [ ] `df[4,2]`
- [ ] `df[2,4]`
- [ ] `filter(df, student = Christina) %>% select(grade)`
- [ ] `filter(df, student == "Christina") %>% select(grade)`
- [ ] None of the above 	

**(LC3.5) How can you add a new variable 'student_id' to the data frame that assigns numbers to students in an ascending order?**

- [ ] `df$student_id <- 1:nrow(df)`
- [ ] `df&student_id <- 1:nrow(df)`
- [ ] `mutate(df, student_id = 1:nrow(df))`
- [ ] `mutate(df, student_id = 1:length(df))`
- [ ] None of the above 	

**(LC3.6) How could you obtain all rows with students who obtained a 1?**

- [ ] `filter(df, grade == 1)`
- [ ] `filter(df, grade == min(df$grade, na.rm = TRUE))`
- [ ] `select(df, grade == 1)`
- [ ] `filter(df, grade == min(df$grade))`
- [ ] None of the above 	

**(LC3.7) How could you create a subset of observations where the grade is not missing (NA) **

- [ ] `df_subset <- filter(df, !is.na(grade))`
- [ ] `df_subset <- filter(df, isnot.na(grade))`
- [ ] `df_subset <- filter(df, grade != NA)`
- [ ] `df_subset <- filter(df, grade != "NA")`
- [ ] None of the above 

**(LC3.8) What is the share of students with a grade better than 3?**

- [ ] `filter(df, grade < 3)/nrow(df)`
- [ ] `nrow(filter(df, grade < 3))/length(df)`
- [ ] `nrow(filter(df, grade < 3))/nrow(df)`
- [ ] `filter(df, grade < 3)/length(df)`
- [ ] None of the above

**(LC3.9) You would like to load a .csv file from your working directory. What function would you use do it?**

- [ ] `read.table(file_name.csv)`
- [ ] `load.csv("file.csv")`
- [ ] `read.table("file.csv")`
- [ ] `get.table(file_name.csv)`
- [ ] None of the above

**(LC3.10) After you loaded the file, you would like to inspect the types of data contained in it. How would you do it?**

- [ ] `ncol(df)`
- [ ] `nrow(df)`
- [ ] `dim(df)`
- [ ] `str(df)`
- [ ] None of the above

