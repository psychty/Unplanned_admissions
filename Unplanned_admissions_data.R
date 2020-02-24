
# Unplanned admissions ####

library(easypackages)

libraries(c("readxl", "readr", "plyr", "dplyr", "ggplot2", "png", "tidyverse", "reshape2", "scales", "rgdal", 'rgeos', "tmaptools", 'sp', 'sf', 'maptools', 'leaflet', 'leaflet.extras', 'spdplyr', 'geojsonio', 'rmapshaper', 'jsonlite', 'zoo'))

run_length <- 6
trend_length <- 7

capwords = function(s, strict = FALSE) {
  cap = function(s) paste(toupper(substring(s, 1, 1)),
                          {s = substring(s, 2); if(strict) tolower(s) else s},sep = "", collapse = " " )
  sapply(strsplit(s, split = " "), cap, USE.NAMES = !is.null(names(s)))}

options(scipen = 999)

github_repo_dir <- "~/Documents/Repositories/Unplanned_admissions"

# This is a command to create a sub-directory if it does not exist in the working directory
if (!file.exists(paste0(github_repo_dir, "/Data"))) {
  dir.create(paste0(github_repo_dir, "/Data"))}

# Any new months of data can be downloaded using R, just copy the 'Total Delayed Days Local Authority' file for the month and paste it into the download.file("", paste0(github_repo_dir, "/DTOC_data/x .xls"), mode = "wb"). The mode = "wb" saves it as a binary file.

if (!file.exists(paste0(github_repo_dir, "/Data/Dec_19.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2020/02/MAR_Comm-Web-file-Dec-19-9tun8.xls' ,paste0(github_repo_dir, "/Data/Dec_19.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Nov_19.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2020/02/MAR_Comm-Web-file-Nov-19-9tun8.xls' ,paste0(github_repo_dir, "/Data/Nov_19.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Oct_19.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2019/12/MAR_Comm-Web-file-Oct-19-Kt68p.xls' ,paste0(github_repo_dir, "/Data/Oct_19.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Sep_19.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2020/02/MAR_Comm-Web-file-Sep-19-9tun8.xls' ,paste0(github_repo_dir, "/Data/Sep_19.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Aug_19.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2020/02/MAR_Comm-Web-file-Aug-19-9tun8.xls' ,paste0(github_repo_dir, "/Data/Aug_19.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Jul_19.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2020/02/MAR_Comm-Web-file-Jul-19-9tun8.xls' ,paste0(github_repo_dir, "/Data/Jul_19.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Jun_19.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2020/02/MAR_Comm-Web-file-Jun-19-9tun8.xls' ,paste0(github_repo_dir, "/Data/Jun_19.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/May_19.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2020/02/MAR_Comm-Web-file-May-19-9tun8.xls' ,paste0(github_repo_dir, "/Data/May_19.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Apr_19.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2020/02/MAR_Comm-Web-file-Apr-19-9tun8.xls' ,paste0(github_repo_dir, "/Data/Apr_19.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Mar_19.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2020/02/MAR_Comm-Web-file-March-19-9tun8.xls' ,paste0(github_repo_dir, "/Data/Mar_19.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Feb_19.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2020/02/MAR_Comm-Web-file-Feb-19-9tun8.xls' ,paste0(github_repo_dir, "/Data/Feb_19.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Jan_19.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2020/02/MAR_Comm-Web-file-Jan-19-9tun8.xls' ,paste0(github_repo_dir, "/Data/Jan_19.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Dec_18.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2020/02/MAR_Comm-Web-file-Dec-18-9tun8.xls' ,paste0(github_repo_dir, "/Data/Dec_18.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Nov_18.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2020/02/MAR_Comm-Web-file-Nov-18-9tun8.xls' ,paste0(github_repo_dir, "/Data/Nov_18.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Oct_18.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2020/02/MAR_Comm-Web-file-Oct-18-9tun8-1.xls' ,paste0(github_repo_dir, "/Data/Oct_18.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Sep_18.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2020/02/MAR_Comm-Web-file-Sept-18-9tun8.xls' ,paste0(github_repo_dir, "/Data/Sep_18.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Aug_18.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2020/02/MAR_Comm-Web-file-Aug-18-9tun8.xls' ,paste0(github_repo_dir, "/Data/Aug_18.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Jul_18.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2020/02/MAR_Comm-Web-file-July-18-9tun8.xls' ,paste0(github_repo_dir, "/Data/Jul_18.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Jun_18.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2020/02/MAR_Comm-Web-file-June-18-9tun8.xls' ,paste0(github_repo_dir, "/Data/Jun_18.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/May_18.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2020/02/MAR_Comm-Web-file-May-18-9tun8.xls' ,paste0(github_repo_dir, "/Data/May_18.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Apr_18.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2020/02/MAR_Comm-Web-file-April-18-9tun8.xls' ,paste0(github_repo_dir, "/Data/Apr_18.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Mar_18.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2019/06/MAR_Comm-Web-file-Mar-18_K8wY3N.xls' ,paste0(github_repo_dir, "/Data/Mar_18.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Feb_18.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2019/06/MAR_Comm-Web-file-Feb-18_jEhD65.xls' ,paste0(github_repo_dir, "/Data/Feb_18.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Jan_18.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2019/06/MAR_Comm-Web-file-Jan-18_A7aWL4.xls' ,paste0(github_repo_dir, "/Data/Jan_18.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Dec_17.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2019/06/MAR_Comm-Web-file-Dec-17_4EdUMb.xls' ,paste0(github_repo_dir, "/Data/Dec_17.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Nov_17.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2019/06/MAR_Comm-Web-file-Nov-17_65Vwsp.xls' ,paste0(github_repo_dir, "/Data/Nov_17.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Oct_17.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2019/06/MAR_Comm-Web-file-Oct-17_tN447v.xls' ,paste0(github_repo_dir, "/Data/Oct_17.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Sep_17.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2019/06/MAR_Comm-Web-file-Sept-17_LA6nMv.xls' ,paste0(github_repo_dir, "/Data/Sep_17.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Aug_17.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2019/06/MAR_Comm-Web-file-August-17_G9v7nU.xls' ,paste0(github_repo_dir, "/Data/Aug_17.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Jul_17.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2019/06/MAR_Comm-Web-file-July-17_9JerHD.xls' ,paste0(github_repo_dir, "/Data/Jul_17.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Jun_17.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2019/06/MAR_Comm-Web-file-June-17_3cnVWF.xls' ,paste0(github_repo_dir, "/Data/Jun_17.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/May_17.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2019/06/MAR_Comm-Web-file-May-17_R5KbMZ.xls' ,paste0(github_repo_dir, "/Data/May_17.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Apr_17.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2019/06/MAR_Comm-Web-file-Apr-17_FYsC2A.xls' ,paste0(github_repo_dir, "/Data/Apr_17.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Mar_17.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2018/02/MAR_Comm-Web-file-March-2017-Revised.xls' ,paste0(github_repo_dir, "/Data/Mar_17.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Feb_17.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2018/02/MAR_Comm-Web-file-February-2017-Revised.xls' ,paste0(github_repo_dir, "/Data/Feb_17.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Jan_17.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2018/02/MAR_Comm-Web-file-January-2017-Revised.xls' ,paste0(github_repo_dir, "/Data/Jan_17.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Dec_16.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2018/02/MAR_Comm-Web-file-December-2016-Revised.xls' ,paste0(github_repo_dir, "/Data/Dec_16.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Nov_16.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2018/02/MAR_Comm-Web-file-November-2016-Revised.xls' ,paste0(github_repo_dir, "/Data/Nov_16.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Oct_16.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2018/02/MAR_Comm-Web-file-October-2016-Revised.xls' ,paste0(github_repo_dir, "/Data/Oct_16.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Sep_16.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2018/02/MAR_Comm-Web-file-September-2016-Revised.xls' ,paste0(github_repo_dir, "/Data/Sep_16.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Aug_16.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2018/02/MAR_Comm-Web-file-August-2016-Revised.xls' ,paste0(github_repo_dir, "/Data/Aug_16.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Jul_16.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2018/02/MAR_Comm-Web-file-July-2016-Revised.xls' ,paste0(github_repo_dir, "/Data/Jul_16.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Jun_16.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2018/02/MAR_Comm-Web-file-June-2016-Revised.xls' ,paste0(github_repo_dir, "/Data/Jun_16.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/May_16.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2018/02/MAR_Comm-Web-file-May-2016-Revised.xls' ,paste0(github_repo_dir, "/Data/May_16.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Apr_16.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2018/02/MAR_Comm-Web-file-April-2016-Revised.xls' ,paste0(github_repo_dir, "/Data/Apr_16.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Mar_16.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/04/MAR_Comm-Web-file-March-2016-2121.xls' ,paste0(github_repo_dir, "/Data/Mar_16.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Feb_16.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/04/MAR_Comm-Web-file-Feb-16-1546.xls' ,paste0(github_repo_dir, "/Data/Feb_16.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Jan_16.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/04/MAR_Comm-Web-file-January-16-1354.xls' ,paste0(github_repo_dir, "/Data/Jan_16.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Dec_15.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/04/MAR_Comm-Web-file-December-15-1564-1.xls' ,paste0(github_repo_dir, "/Data/Dec_15.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Nov_15.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/04/MAR_Comm-Web-file-November-15-2138.xls' ,paste0(github_repo_dir, "/Data/Nov_15.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Oct_15.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/04/MAR_Comm-Web-file-October-15-2318.xls' ,paste0(github_repo_dir, "/Data/Oct_15.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Sep_15.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/04/MAR_Comm-Web-file-Sept-15-1589.xls' ,paste0(github_repo_dir, "/Data/Sep_15.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Aug_15.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/04/MAR_Comm-Web-file-Aug-15-1596.xls' ,paste0(github_repo_dir, "/Data/Aug_15.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Jul_15.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/04/MAR_Comm-Web-file-July-15-3298-1.xls' ,paste0(github_repo_dir, "/Data/Jul_15.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Jun_15.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/04/MAR_Comm-Web-file-June-15-2358.xls' ,paste0(github_repo_dir, "/Data/Jun_15.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/May_15.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/04/MAR_Comm-Web-file-May-15-3646.xls' ,paste0(github_repo_dir, "/Data/May_15.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Apr_15.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/04/MAR_Comm-Web-APRIL-15-1378.xls' ,paste0(github_repo_dir, "/Data/Apr_15.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Mar_15.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/04/MAR_Comm-Web-file-March-15-16216185-Nov-15-Refresh.xls' ,paste0(github_repo_dir, "/Data/Mar_15.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Feb_15.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/04/MAR_Comm-Web-file-February-15-741100-Nov-15-Refresh.xls' ,paste0(github_repo_dir, "/Data/Feb_15.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Jan_15.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/04/MAR_Comm-Web-file-January-15-58293-Nov-15-Refresh.xls' ,paste0(github_repo_dir, "/Data/Jan_15.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Dec_14.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/04/MAR_Comm-Web-file-December-14-58293-Nov-15-Refresh.xls' ,paste0(github_repo_dir, "/Data/Dec_14.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Nov_14.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/04/MAR_Comm-Web-file-November-14-12342-Nov-15-refresh.xls' ,paste0(github_repo_dir, "/Data/Nov_14.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Oct_14.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/04/MAR_Comm-Web-file-October-14-12342-Nov-15-refresh.xls' ,paste0(github_repo_dir, "/Data/Oct_14.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Sep_14.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/04/MAR_Comm-Web-file-September-14-87964-Nov-15-refresh.xls' ,paste0(github_repo_dir, "/Data/Sep_14.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Aug_14.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/04/MAR_Comm-Web-file-August-14-36289-Nov-15-refresh.xls' ,paste0(github_repo_dir, "/Data/Aug_14.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Jul_14.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/04/MAR_Comm-Web-file-July-14-08698-Nov-15-refresh.xls' ,paste0(github_repo_dir, "/Data/Jul_14.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Jun_14.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/04/MAR_Comm-Web-file-June-14-46819-Nov-15-refresh.xls' ,paste0(github_repo_dir, "/Data/Jun_14.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/May_14.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/04/MAR_Comm-Web-file-May-14-84354-Nov-15-refresh.xls' ,paste0(github_repo_dir, "/Data/May_14.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Apr_14.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/04/MAR_Comm-Web-file-April-14-12476-Nov-15-refresh.xls' ,paste0(github_repo_dir, "/Data/Apr_14.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Mar_14.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/04/MAR_Comm-Web-file-March-14-32646-Nov-15-refresh.xls' ,paste0(github_repo_dir, "/Data/Mar_14.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Feb_14.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/04/MAR_Comm-Web-file-Feb14-51285-Nov-15-refresh.xls' ,paste0(github_repo_dir, "/Data/Feb_14.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Jan_14.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/04/MAR_Comm-Web-file-Jan14_54864-Nov-15-refresh.xls' ,paste0(github_repo_dir, "/Data/Jan_14.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Dec_13.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/04/MAR_Comm-Web-file-Dec13_96816-Nov-15-refresh.xls' ,paste0(github_repo_dir, "/Data/Dec_13.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Nov_13.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/04/MAR_Comm-Web-file-Nov13_75281-Nov-15-refresh.xls' ,paste0(github_repo_dir, "/Data/Nov_13.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Oct_13.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/04/MAR_Comm-Web-file-Oct13_78921-Nov-15-refresh.xls' ,paste0(github_repo_dir, "/Data/Oct_13.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Sep_13.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/04/MAR_Comm-Web-file-Sep13_24634-Nov-15-refresh.xls' ,paste0(github_repo_dir, "/Data/Sep_13.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Aug_13.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2014/07/MAR_Comm-Web-file-Aug-13-97234-Jul14-refresh.xls' ,paste0(github_repo_dir, "/Data/Aug_13.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Jul_13.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2014/07/MAR_Comm-Web-file-July13_97547-Jul-14-refresh.xls' ,paste0(github_repo_dir, "/Data/Jul_13.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Jun_13.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2014/07/MAR_Comm-Web-file-June13_25729-Jul-14-refresh.xls' ,paste0(github_repo_dir, "/Data/Jun_13.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/May_13.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2014/07/MAR_Comm-Web-file-May13_92465-Jul-14-refresh-2.xls' ,paste0(github_repo_dir, "/Data/May_13.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Apr_13.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2014/07/MAR_Comm-Web-file-Apr13_87395-Jul-14-refresh.xls' ,paste0(github_repo_dir, "/Data/Apr_13.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Mar_13.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/04/MAR_Comm-Web-file-Mar13_Revised-July13.xls' ,paste0(github_repo_dir, "/Data/Mar_13.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Feb_13.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/04/MAR_Comm-Web-file-Feb13_Revised-July13.xls' ,paste0(github_repo_dir, "/Data/Feb_13.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Jan_13.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/04/MAR_Comm-Web-file-Jan13_Refresh-July-13.xls' ,paste0(github_repo_dir, "/Data/Jan_13.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Dec_12.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/04/MAR_Comm-Web-file-Dec12_Rev-July13.xls' ,paste0(github_repo_dir, "/Data/Dec_12.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Nov_12.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/04/MAR_Comm-Web-file-Nov12_Rev-July13.xls' ,paste0(github_repo_dir, "/Data/Nov_12.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Oct_12.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/04/MAR_Comm-Web-file-Oct12_64944-Rev-July13.xls' ,paste0(github_repo_dir, "/Data/Oct_12.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Sep_12.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/04/MAR_Comm-Web-file-Sept12_86493-Rev-July13.xls' ,paste0(github_repo_dir, "/Data/Sep_12.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Aug_12.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/04/MAR_Comm-Web-file-Aug12_16659-Rev-July13.xls' ,paste0(github_repo_dir, "/Data/Aug_12.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Jul_12.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/04/MAR_Comm-Web-file-Jul-12-Rev-July13.xls' ,paste0(github_repo_dir, "/Data/Jul_12.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Jun_12.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/04/MAR_Comm-Web-file-Jun-12-Rev-July13.xls' ,paste0(github_repo_dir, "/Data/Jun_12.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/May_12.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/04/MAR_Comm-Web-file-May-12-Rev-July-2013.xls' ,paste0(github_repo_dir, "/Data/May_12.xls"), mode = "wb")}

if (!file.exists(paste0(github_repo_dir, "/Data/Apr_12.xls"))) {download.file('https://www.england.nhs.uk/statistics/wp-content/uploads/sites/2/2013/04/MAR_Comm-Web-file-April-12-Rev-Jul13.xls' ,paste0(github_repo_dir, "/Data/Apr_12.xls"), mode = "wb")}

# You can clean up the data as follows. Notoriously, NHS publishing monthly excel spreadsheets means that you can expect a couple of rogue typos in at least a couple of files. My favourite is changing the headings at an arbitrary point in time, but these are also fun. Some capitals, some wide intervals and some interpretations on month spelling.

# By using an ifelse statement, you can continue to run this even if the authors fix the bugs.

unplanned_df <- unique(list.files(paste0(github_repo_dir, "/Data/"))) %>% 
  map_df(~read_xls(paste0(github_repo_dir, '/Data/',.), skip = 13)) %>% 
  filter(!is.na(Period)) %>% 
  mutate(Year = ifelse(Year %in% c('2017-19', '2017-20', '2017-21', '2017-22', '2017-23', '2017-24', '2017-25', '2017-26', '2017-27', '2017-28', '2017-29', '2017-30'), '2017-18', Year)) %>% # its funky friday's in June 2017/18, someone hit the 'fill series' button rather than ctrl c + ctrl v. No worries, we can account for that. 
  mutate(Period = ifelse(Period == 'Janaury', 'January', Period)) %>% # Of course, its also jazzy Janaury too.
  mutate(Period = capwords(Period, strict = TRUE)) %>% 
  mutate(Year_recoded = ifelse(Period %in% c('January', 'February', 'March'), paste0('20',substr(Year, nchar(Year) - 1, nchar(Year))), substr(Year, 0, 4))) %>% 
  mutate(Period_recoded = paste0('01-', Period, '-', Year_recoded)) %>% 
  mutate(Date = as.Date(Period_recoded, format = '%d-%b-%Y'))

WSx_unplanned_df <- unplanned_df %>%
  filter(`Org Name` %in% c('WEST SUSSEX PCT','NHS COASTAL WEST SUSSEX CCG', 'NHS CRAWLEY CCG', 'NHS HORSHAM AND MID SUSSEX CCG'))

# WSx_unplanned_df %>%
# group_by( Date) %>%
# summarise(n()) %>%
# View()

Wsx_combined_commissioners <- WSx_unplanned_df %>% 
  mutate(Period_year = paste0(Period, '-', Year_recoded)) %>% 
  group_by(Period_year, Date) %>% 
  summarise(Unplanned_admissions = sum(`Total Non-elective G&A Admissions (FFCEs)`, na.rm = TRUE)) %>% 
  mutate(Name = 'West Sussex (PCT 12/13 CCGs onwards)') %>% 
  ungroup() %>% 
  mutate(track = ifelse(Date < '2017-04-01', 'Pre-intervention', 'Post-intervention')) %>% 
  arrange(Date) %>% 
  mutate(Period = factor(Period_year, levels =c(Period_year))) %>% 
  group_by(Name, track) %>% 
  mutate(process_mean = mean(Unplanned_admissions, na.rm = TRUE)) %>% 
  mutate(mR = abs(Unplanned_admissions - lag(Unplanned_admissions))) %>% 
  mutate(mean_mR = mean(mR, na.rm = TRUE)) %>% 
  mutate(seq_dev = mean_mR / 1.128) %>% 
  mutate(lower_control_limit = process_mean - (seq_dev * 3),
         upper_control_limit = process_mean + (seq_dev * 3)) %>% 
  mutate(one_sigma_lci = process_mean - seq_dev,
         one_sigma_uci = process_mean + seq_dev,
         two_sigma_lci = process_mean - (seq_dev * 2),
         two_sigma_uci = process_mean + (seq_dev * 2)) %>% 
  mutate(location = ifelse(Unplanned_admissions > upper_control_limit, 'Outside +/- 3sigma', ifelse(Unplanned_admissions < lower_control_limit, 'Outside +/- 3sigma', ifelse(Unplanned_admissions > two_sigma_uci, 'Between +/- 2sigma and 3sigma', ifelse(Unplanned_admissions < two_sigma_lci, 'Between +/- 2sigma and 3sigma', ifelse(Unplanned_admissions > one_sigma_uci, 'Between +/- 1sigma and 2sigma', ifelse(Unplanned_admissions < one_sigma_lci, 'Between +/- 1sigma and 2sigma', 'Within +/- 1sigma'))))))) %>% 
  mutate(rule_1 = ifelse(Unplanned_admissions > upper_control_limit, 'Special cause concern', ifelse(Unplanned_admissions < lower_control_limit, 'Special cause concern', 'Common cause variation'))) %>%
  mutate(above_mean = ifelse(Unplanned_admissions > process_mean, 1, 0)) %>% 
  mutate(rule_2a = rollapplyr(above_mean, run_length, sum, align = 'right', partial = TRUE)) %>% 
  mutate(rule_2a_label = rollapply(rule_2a, run_length, function(x)if(any(x == run_length)) 'Run above (shift)' else 'No run', align = 'left', partial = TRUE)) %>% 
  mutate(below_mean = ifelse(Unplanned_admissions < process_mean, 1, 0)) %>% 
  mutate(rule_2b = rollapplyr(below_mean, run_length, sum, partial = TRUE)) %>%
  mutate(rule_2b_label = rollapply(rule_2b, run_length, function(x)if(any(x == run_length)) 'Run below (shift)' else 'No run', align = 'left', partial = TRUE)) %>%
  mutate(rule_2 = ifelse(rule_2a_label == 'Run above (shift)', rule_2a_label, rule_2b_label)) %>% 
  select(-c(above_mean, below_mean, rule_2a, rule_2a_label, rule_2b, rule_2b_label)) %>% 
  mutate(trend_down = ifelse(Unplanned_admissions < lag(Unplanned_admissions, 1), 1, 0)) %>% 
  mutate(trend_down = ifelse(is.na(trend_down), lead(trend_down, 1), trend_down)) %>% 
  mutate(rule_3a = rollapplyr(trend_down, trend_length, sum, align = 'right', partial = TRUE)) %>% 
  mutate(rule_3a_label = rollapply(rule_3a, trend_length, function(x)if(any(x == trend_length)) 'Trend down (drift)' else 'No trend', align = 'left', partial = TRUE)) %>%
  mutate(trend_up = ifelse(Unplanned_admissions > lag(Unplanned_admissions, 1), 1, 0)) %>% 
  mutate(trend_up = ifelse(is.na(trend_up), lead(trend_up, 1), trend_up)) %>% 
  mutate(rule_3b = rollapplyr(trend_up, trend_length, sum, align = 'right', partial = TRUE)) %>% 
  mutate(rule_3b_label = rollapply(rule_3b, trend_length, function(x)if(any(x == trend_length)) 'Trend up (drift)' else 'No trend', align = 'left', partial = TRUE)) %>%
  mutate(rule_3 = ifelse(rule_3a_label == 'Trend down (drift)', rule_3a_label, rule_3b_label)) %>% 
  select(-c(trend_down, trend_up, rule_3a, rule_3a_label, rule_3b, rule_3b_label)) %>%
  mutate(close_to_limit = ifelse(location == 'Between +/- 2sigma and 3sigma', 1, 0)) %>% 
  mutate(rule_4 = rollapplyr(close_to_limit, 3, sum, align = 'right', partial = TRUE)) %>% 
  mutate(rule_4_label = ifelse(rule_4 >= 2, 'Close to limits', ifelse(lead(rule_4,1) >= 2, 'Close to limits', 'Not two out of three'))) %>% 
  mutate(rule_4_label = ifelse(is.na(rule_4_label), ifelse(rule_4 >= 2, 'Close to limits', 'Not two out of three'), rule_4_label)) %>% 
  mutate(rule_4 = rule_4_label) %>% 
  select(-c(rule_4_label, close_to_limit)) %>% 
  mutate(no_variation = ifelse(location == 'Within +/- 1sigma', 1, 0)) %>% 
  mutate(rule_5 = rollapplyr(no_variation, 15, sum, align = 'right', partial = TRUE)) %>% 
  mutate(rule_5 = rollapply(rule_5, 15, function(x)if(any(x == 15)) 'Little variation' else 'Variation', align = 'left', partial = TRUE)) %>% 
  select(-no_variation) %>% 
  mutate(top_label = factor(ifelse(rule_1 == 'Special cause concern', 'Special cause concern', ifelse(rule_2 %in% c('Run above (shift)', 'Run below (shift)'), rule_2, ifelse(rule_3 %in% c('Trend down (drift)', 'Trend up (drift)'), rule_3, ifelse(rule_4 == 'Close to limits', 'Close to limits', ifelse(rule_5 == 'Little variation', rule_5, 'Common cause variation'))))), levels = c('Common cause variation', 'Close to limits', 'Special cause concern', 'Run above (shift)', 'Run below (shift)','Trend up (drift)', 'Trend down (drift)', 'Little variation'))) %>% 
  mutate(variation_label = factor(ifelse(rule_1 == 'Special cause concern', 'Special cause variation', ifelse(rule_2 %in% c('Run above (shift)', 'Run below (shift)'), 'Special cause variation', ifelse(rule_3 %in% c('Trend down (drift)', 'Trend up (drift)'), 'Special cause variation', 'Common cause variation'))), levels = c('Common cause variation', 'Special cause concern')))

# unique(Wsx_combined_commissioners$Date)

match('Post-intervention', Wsx_combined_commissioners$track)

Wsx_combined_commissioners %>% 
  ggplot(aes(x = Period, 
             y = Unplanned_admissions,
             group = 1)) +
  geom_line(aes(y = process_mean),
            colour = "#264852",
            lwd = .8) +
  geom_line(aes(y = lower_control_limit),
             colour = "#A8423F",
             linetype="dotted",
             lwd = .7) +
  geom_line(aes(y = upper_control_limit),
             colour = "#A8423F",
             linetype="dotted",
             lwd = .7) +
  geom_line(colour = '#999999') +
  geom_point(aes(fill =  top_label,
                 colour = top_label), 
             size = 4, 
             shape = 21) +
  scale_x_discrete() +
  scale_fill_manual(values= c("#b5a7b6","#fdbf00","#cc6633", "#61b8d2","#00fdf6","#832157","#ef4d96", '#5a535b'),
                    breaks = c('Common cause variation', 'Close to limits', 'Special cause concern', 'Run above (shift)', 'Run below (shift)','Trend up (drift)', 'Trend down (drift)', 'Little variation'),
                    limits = c('Common cause variation', 'Close to limits', 'Special cause concern', 'Run above (shift)', 'Run below (shift)','Trend up (drift)', 'Trend down (drift)', 'Little variation'),
                    name = 'Variation key') +  
  scale_colour_manual(values=  c("#b5a7b6","#fdbf00","#cc6633", "#61b8d2","#00fdf6","#832157","#ef4d96", '#5a535b'),
                      breaks = c('Common cause variation', 'Close to limits', 'Special cause concern', 'Run above (shift)', 'Run below (shift)','Trend up (drift)', 'Trend down (drift)', 'Little variation'),
                      limits = c('Common cause variation', 'Close to limits', 'Special cause concern', 'Run above (shift)', 'Run below (shift)','Trend up (drift)', 'Trend down (drift)', 'Little variation'),
                      name = 'Variation key') +  
  labs(caption = "Note: Y axis does not start at zero.\nThe red dotted lines represent 99% control limits (3σ, moving range) control limits respectively\nThe solid line represents the long term average.") +
  theme(legend.position = "bottom", 
        axis.text.x = element_text(angle = 90, hjust = 1, vjust = .5, size = 8),
        plot.background = element_rect(fill = "white", colour = "#E2E2E3"), 
        panel.background = element_rect(fill = '#ffffff'),
        axis.line = element_line(colour = "#E7E7E7", size = .3),
        axis.text = element_text(colour = "#000000", size = 8), 
        plot.title = element_text(colour = "#000000", face = "bold", size = 10, vjust = -.5), 
        axis.title = element_text(colour = "#000000", face = "bold", size = 8),     
        panel.grid = element_blank(), 
        strip.background = element_rect(fill = "#327d9c"),
        axis.ticks = element_line(colour = "#9e9e9e"),
        legend.key = element_rect(fill = '#ffffff'),
        legend.text = element_text(colour = "#000000", size = 8),
        legend.title = element_text(face = 'bold', size = 8))


  