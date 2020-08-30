# Descarga y descompresión de los datos

download.file(
        "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
        destfile = "data.zip"
)
unzip(zipfile = "data.zip", exdir = ".")

# Cargar librerías requeridas

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

# Creación del gráfico y guardado en PNG

png(filename = "Plot1.png")

hist(
        housepc$Global_active_power,
        col = "red",
        xlab = "Global Active Power (kilowatts)",
        main = "Global Active Power"
)

dev.off()