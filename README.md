## RUL-Esteem-for-aircraft-motor-fleet
An algorithm for Runtime Remaining Useful Life (RUL) Esteem of an aircraft fleet is implemented in MATLAB. The original database is CMAPSS by NASA. 

# Project description
The main parts of the work consisted in adapting the database to Matlab environment, data pre-precessing, health-indicator definition, RUL Model determination and validation.

# Dataset Conversion
The original ``h5`` database was extracted, an _ensemble table_ with the most relevant variables was created for _training_ and _validation_ datasets; moreover, the entire dataset was undersampled (the original timeframe is 1s, the dataset was resampled every 90s) to enhance calculation performance.

# Data pre-processing
The ensamble table was split in sub-tables containing motors with relative flight variables and health status, all gathered in a vector of tables; following, these were clusterized in **6** groups, using _K-means_ algorithm, according to flight variables such as altitude, external temperature, fan speed and flap angle.

# Health-indicator definition
Each motor table was normalised to confront the flight variables with other motors'; then by the use of an _Exponential Degradation Model_ a health indicator depending on the variables was created for each motor; consequently, a general health indicator was defined for each cluster.

# RUL Model determination and validation
A ``residualSimilarityModel`` was used to determine RUL in function of cluster flight conditions and health indicators, trained on _training dataset_; the validation was executed by choosing motors singularly, associating them to one of the clusters, constructing its health indicators and confronting them with the health status provided by the original database, the esteem error for each cluster was consequently assessed.
