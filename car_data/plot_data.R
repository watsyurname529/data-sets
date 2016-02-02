library(ggplot2)

car_data <- read.csv('honda_crv.csv', header=TRUE)
car_data$Date <- as.Date(car_data$Dates, '%m-%d-%y')

miles_v_date <- ggplot(data=car_data, aes(x=Date, y=Miles)) + geom_line() + geom_point() + scale_x_date()

total_miles_v_date <- ggplot(data=car_data, aes(x=Date, y=cumsum(Miles))) + geom_line() + geom_point() + scale_x_date()

mpg_v_date <- ggplot(data=car_data, aes(x=Date, y=Miles/Gallon)) + geom_line() + geom_point() + scale_x_date()

price_v_date <- ggplot(data=car_data, aes(x=Date, y=Money/Gallon)) + geom_point() + geom_smooth(span=0.2) + scale_x_date()
