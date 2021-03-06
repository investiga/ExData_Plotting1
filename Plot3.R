# Descarga y descompresión de los datos

download.file(
        "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
        destfile = "./data.zip"
)
unzip(zipfile = "./data.zip", exdir = ".")

# Cargar librearías necesarias

library(readr)
library(tidyverse)

# Importación de tablas y cambio de formato a columnas de fecha y tiempo

read_delim(
        "./household_power_consumption.txt",
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

png(filename = "./Plot3.png")

print(ggplot(housepc, aes(x = DateTime)) +
        geom_line(aes(y = Sub_metering_1, col = "Sub_metering_1")) +
        geom_line(aes(y = Sub_metering_2, col = "Sub_metering_2")) +
        geom_line(aes(y = Sub_metering_3, col = "Sub_metering_3")) +
        labs(x = NULL, y = "Energy submetering", colour = NULL) +
        scale_x_datetime(date_breaks = "1 day", date_labels = "%a") +
        theme_bw() +
        theme(
                legend.position = c(1, 1),
                legend.justification = c("right", "top"),
                legend.box.just = "right",
                legend.margin = margin(2, 2, 2, 2),
                legend.box.background = element_rect(color = "black", size =
                                                             1)
        )
)
dev.off()