library(ggplot2)
library(grid)
library(gridExtra)

car_data <- read.csv('honda_crv.csv', header=TRUE)
car_data$Date <- as.Date(car_data$Date, '%m-%d-%y')

miles_v_date <- ggplot(data=car_data, aes(x=Date, y=Miles)) + geom_point(color="blue", size=1.25, alpha=0.7) + scale_x_date()
mpg_v_date <- ggplot(data=car_data, aes(x=Date, y=Miles/Gallons)) + geom_point(size=1.25, alpha=0.7) + scale_x_date()
price_v_date <- ggplot(data=car_data, aes(x=Date, y=Money/Gallons)) + geom_point(size=1.25, alpha=0.7) + scale_x_date()

miles_v_date <- miles_v_date + labs(title = "Miles per Date", y = "Miles", x = "Date")
mpg_v_date <- mpg_v_date + labs(title = "MPG per Date", y = "Miles per Gallon", x = "Date")
price_v_date <- price_v_date + labs(title = "Gas Price per Date", y = "Dollars per Gallon", x = "Date")

pdf("grid_plots.pdf", width=8, height=12)
grid.arrange(miles_v_date, mpg_v_date, price_v_date, nrow=3, top="2003 Honda CRV")
dev.off()
#grid_plots <- arrangeGrob(miles_v_date, mpg_v_date, price_v_date, ncol=3, top="2003 Honda CRV")
#ggsave(file="grid_plots.pdf", grid_plots)

#ggsave("miles_v_date.pdf", miles_v_date)
#ggsave("mpg_v_date.pdf", mpg_v_date)
#ggsave("price_v_date.pdf", price_v_date)

total_miles_v_date <- ggplot(data=car_data, aes(x=Date, y=cumsum(Miles))) + geom_point(size=1, alpha=0.5)
total_gallons_v_date <- ggplot(data=car_data, aes(x=Date, y=cumsum(Gallons))) + geom_point(size=1, alpha=0.5) 
total_money_v_date <- ggplot(data=car_data, aes(x=Date, y=cumsum(Money))) + geom_point(size=1, alpha=0.5) 

total_miles_v_date <- total_miles_v_date + labs(title = "Total Miles per Date", y = "Miles", x = "Date")
total_gallons_v_date <- total_gallons_v_date + labs(title = "Total Gallons per Date", y = "Gallons", x = "Date")
total_money_v_date <- total_money_v_date + labs(title = "Total Money per Date", y = "Dollars", x = "Date")

pdf("total_grid_plots.pdf", width=8, height=12)
grid.arrange(total_miles_v_date, total_gallons_v_date, total_money_v_date, nrow=3, top="2003 Honda CRV")
dev.off()

miles_hist <- ggplot(data=car_data, aes(x=Miles)) + geom_bar(binwidth=5) +
              geom_text(stat="bin", binwidth=5, aes(label=..count..), position="dodge", vjust=-0.5, size=1.5)
mpg_hist <- ggplot(data=car_data, aes(x=Miles/Gallons)) + geom_bar(binwidth=0.5) +
            geom_text(stat="bin", binwidth=0.5, aes(label=..count..), position="dodge", vjust=-0.5, size=1.5)
price_hist <- ggplot(data=car_data, aes(x=Money/Gallons)) + geom_bar(binwidth=0.10) +
              geom_text(stat="bin", binwidth=0.1, aes(label=..count..), posiiton="dodge", vjust=-0.5, size=1.5)

miles_hist <- miles_hist + labs(title = "Miles Histogram", y = "Count (per 5 Miles)", x = "Miles")
mpg_hist <- mpg_hist + labs(title = "MPG Histogram", y = "Count (per 0.5 Gallons)", x = "MPG")
price_hist <- price_hist + labs(title = "Gas Price Histogram", y = "Count (per 10 cents)", x = "Price / Gallon")

pdf("grid_hist.pdf", width=8, height=12)
grid.arrange(miles_hist, mpg_hist, price_hist, nrow=3, top="2003 Honda CRV")
dev.off()
