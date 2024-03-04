# The following code is taken from the fourth chapter of the online script, which provides more detailed explanations:
# https://imsmwu.github.io/MRDA2020/exploratory-factor-analysis.html


#-------------------------------------------------------------------#
#---------------------Install missing packages----------------------#
#-------------------------------------------------------------------#

# At the top of each script this code snippet will make sure that all required packages are installed
## ------------------------------------------------------------------------
req_packages <- c("Hmisc", "ggplot2", "car", "psych", "GPArotation","hornpa")
req_packages <- req_packages[!req_packages %in% installed.packages()]
lapply(req_packages, install.packages)


#-------------------------------------------------------------------#
#-------------------Principal Component Analysis--------------------#
#-------------------------------------------------------------------#

# Load data
## ------------------------------------------------------------------------
pca_data <- read.table("https://raw.githubusercontent.com/IMSMWU/Teaching/master/MRDA2017/raq.dat", 
                          sep = "\t", 
                          header = TRUE) #read in data
pca_data <- read.csv2("data/wholesale_customers_data.csv", sep = ',')
head(pca_data)

# STEP 1

# Inspect correlation matrix
pca_selected <- pca_selected
pca_matrix <- cor(pca_selected) #create matrix
round(pca_matrix, 3)

# Low correlations by variable
correlations <- as.data.frame(pca_matrix)
# Correlation plot
library(psych)
corPlot(correlations, numbers = TRUE, upper = FALSE, diag = FALSE, main = "Correlations between variables")
# Check number of low correlations and mean correlation per variable
diag(correlations) <- NA #set diagonal elements to missing
apply(abs(correlations) < 0.3, 1, sum, na.rm = TRUE) #count number of low correlations for each variable
apply(abs(correlations), 1, mean, na.rm = TRUE) #mean correlation per variable
# Conduct Bartlett's test (p should be < 0.05)
cortest.bartlett(pca_matrix, n = nrow(pca_selected))
# Count number of high correlations for each variable
apply(abs(correlations) > 0.8, 1, sum, na.rm = TRUE)
# Compute determinant (should be > 0.00001)
det(pca_matrix)
det(pca_matrix) > 0.00001

# Compute MSA statistic (should be > 0.5)
KMO(pca_selected)

# STEP 2

# Deriving factors
# Find the number of factors to extract
pc1 <- principal(pca_selected, nfactors = 6, rotate = "none")
pc1

plot(pc1$values, type = "b")
abline(h = 1, lty = 2)

# Run model with appropriate number of factors
pc2 <- principal(pca_selected, nfactors = 2, rotate = "none")
pc2
# Inspect residuals
# Create residuals matrix
residuals <- factor.residuals(pca_matrix, pc2$loadings)
round(residuals, 3)
# Create reproduced matrix
reproduced_matrix <- factor.model(pc2$loadings)
round(reproduced_matrix, 3)
# Compute model fit manually (optional - also included in output)
ssr <- (sum(residuals[upper.tri((residuals))]^2)) #sum of squared residuals 
ssc <- (sum(pca_matrix[upper.tri((pca_matrix))]^2)) #sum of squared correlations
ssr/ssc #ratio of ssr and ssc
1-(ssr/ssc) #model fit
# Share of residuals > 0.05 (should be < 50%)
residuals <- as.matrix(residuals[upper.tri((residuals))])
large_res <- abs(residuals) > 0.05
sum(large_res)
sum(large_res)/nrow(residuals)
# Compute root mean square of the residuals manually (also included in output)
sqrt(mean(residuals^2))
# Test if residuals are approximately normally distributed
hist(residuals)
qqnorm(residuals) 
qqline(residuals)
shapiro.test(residuals)

# STEP 3

# Orthogonal factor rotation 
pc3 <- principal(pca_selected, nfactors = 2, rotate = "varimax")
pc3
print.psych(pc3, cut = 0.3, sort = TRUE)

# Oblique factor rotation 
pc4 <- principal(pca_selected, nfactors = 2, rotate = "oblimin", scores = TRUE)
print.psych(pc4, cut = 0.3, sort = TRUE)

# STEP 4

# Compute factor scores 
head(pc4$scores)
# Add factor scores to dataframe 
pca_data <- cbind(pca_data, pc4$scores)


#-------------------------------------------------------------------#
#-----------------------Reliability Analysis------------------------#
#-------------------------------------------------------------------#

# Specify subscales according to results of PCA
first_necessity <- pca_selected[,c(2, 3, 5)]
upper_segment <- pca_selected[,c(1, 4, 6)]
# Test reliability of subscales
psych::alpha(first_necessity)
psych::alpha(upper_segment)
