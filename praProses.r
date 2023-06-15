data <- read.csv("C:/Users/azkaf/Downloads/kidney_disease.csv")

library(dplyr)


# mengisi string kosong dengan NA

data <- data %>% 
  mutate(across(where(is.character), na_if, "")) 

# Menghitung jumlah NA dalam dataset

jumlah_na <- sum(is.na(data))
print(jumlah_na)
#melihat atribut dengan missing value
md.pattern(data)

# membuat fungsi untuk menggantikan nilai na pada atribut nominal
# dengan modus

custom_impute <- function(x) {
  if (any(is.na(x))) {
    mode_value <- names(sort(-table(x)))[1]
    x[is.na(x)] <- mode_value
  }
  return(x)
}

# mengisi nilai kosong pada atribut nominal

data <- data %>% 
  mutate(across(where(is.character), ~custom_impute(.)))


# mengisi missing value atribut numerik

data <- data %>%
  mutate(across(where(is.numeric), ~ifelse(is.na(.), mean(., na.rm = TRUE), .)))