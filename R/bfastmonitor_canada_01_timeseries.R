###################################################
# BFAST 
# Exercise with Sentinel data 
# Apply bfastmonitor onto a timeseries
###################################################




## ---- 0.  First-time setup (run JUST ONCE) ----
# Uncomment the next lines the very first time you use BFAST.
# They will grab the current CRAN build (released 2024-10-22, v1.7.0)
# If you prefer the R-Forge build, change repos accordingly.
# pkgs <- c("bfast", "zoo", "forecast", "strucchangeRcpp")
# install.packages(pkgs)                               # <- CRAN binaries
# 
# install.packages("bfast",
#                   repos = "http://R-Forge.R-project.org",
#                   type  = "source")                  # <- dev build



# --- Load packages ---
library(bfast)
library(zoo)
library(forecast)

# --- 1. Input: Your actual data with NAs ---
y_raw <- c(NA, 0.73687944, 0.83934842, NA, 0.56831812,
           NA, 0.82357086, 0.83902481, 0.85076777, 0.84763258,
           NA, NA, NA, NA, NA,
           0.54304661, 0.62340673, 0.83094795, 0.83216367, 0.80749318,
           0.83621608, 0.71431479, NA, NA, 0.62307812,
           NA, 0.81726161, 0.51340237, NA, 0.77090131,
           0.82610377, 0.83719644, 0.82148001, 0.76688557, 0.69338906,
           0.67627497, NA, 0.80831386, 0.87601826, 0.45517796,
           0.53259776, 0.73009611, 0.82144912, 0.82902152, 0.82566682,
           0.78687131, 0.65904611, NA, NA, 0.832682,
           0.76275935, 0.57756266, 0.64452723, 0.79027327, 0.81199537,
           0.77830773, 0.80715826, 0.79793233, 0.64288732, 0.72337595,
           NA, 0.81890751, 0.87376179, 0.93780074, 0.591528,
           0.80557348, 0.84363452, 0.83515138, 0.75471156, 0.68573978,
           0.74744293, 0.76809969)

# --- 2. Interpolate missing values ---
y_interp <- y_raw#na.approx(y_raw, rule = 2)

# --- 3. Create float-format time vector (YYYY.fraction) ---
dates <- 2017 + (0:(length(y_interp) - 1)) / 12

# --- 4. Create time series object ---
data_ts <- as.ts(zoo(y_interp, dates))

# --- 5. Count number of regressors ---
n_harmonics <- 3
dummy_ts <- ts(rnorm(24), frequency = 12)
harmonics <- fourier(dummy_ts, K = n_harmonics)

dummy_data <- data.frame(
  response = as.numeric(dummy_ts),
  trend = 1:24,
  harmonics
)
num_regressors <- ncol(model.matrix(response ~ trend + ., data = dummy_data))

# --- 6. Auto-select valid monitoring start date ---
min_index <- NA
for (i in (num_regressors + 1):length(data_ts)) {
  hist_data <- data_ts[1:(i - 1)]
  if (sum(!is.na(hist_data)) > num_regressors) {
    min_index <- i
    break
  }
}
if (is.na(min_index)) {
  stop("❌ Not enough clean history to fit the model.")
}
start_numeric <- dates[min_index]
start_year <- floor(start_numeric)
start_month <- round((start_numeric - start_year) * 12 + 1)

cat("✅ Monitoring start:", start_year, "-", sprintf("%02d", start_month), "\n")

start_year = 2021
start_month = 8

# --- 7. Run bfastmonitor ---
bfm <- bfastmonitor(
  data_ts,
  start = c(start_year, start_month),
  formula = response ~ trend + harmon,
  history=c("ROC"),
  plot = TRUE
  )

#summary(bfm$model)
#AIC(bfm$model)
bfm$breakpoint