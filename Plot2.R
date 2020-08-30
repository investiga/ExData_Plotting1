# Descarga y descompresión de los datos

download.file(
        "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
        destfile = "data.zip"
)
unzip(zipfile = "data.zip", exdir = ".")

# Cargar librerías necesarias
library(readr)
library(tidyverse)

# Importación de tablas y cambio de formato a columnas de fecha y tiempo
read_delim(
        "household_power_consumption.txt",
        ";",
        escape_double = FALSE,
        col_types = cols(
                Date = col_date(format = "%d/%m/%Y"),
                Time = col_time(format = "%H:%M:%S")
        ),
        trim_ws = TRUE
) %>%
        subset(Date == "2007-02-01" |
                       Date == "2007-02-02") -> housepc

housepc$DateTime <- as.POSIXct(paste(housepc$Date, housepc$Time),
                               format = "%Y-%m-%d %H:%M:%S")

# Creación del gráfico y guardado en PNG

png("Plot2.png", width = 480, height = 480)

print(ggplot(housepc, aes(x = DateTime, y = Global_active_power)) +
        geom_line() +
        ylab("Global Active Power (kilowatts)") +
        xlab(NULL) +
        scale_x_datetime(date_breaks = "1 day", date_labels = "%a") +
        theme_bw()
)
dev.off()
