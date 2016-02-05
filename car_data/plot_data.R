library(ggplot2)
library(grid)
library(gridExtra)

car_data <- read.csv('honda_crv.csv', header=TRUE)
car_data$Date <- as.Date(car_data$Date, '%m-%d-%y')

miles_v_date <- ggplot(data=car_data, aes(x=Date, y=Miles)) + geom_point(color="blue", size=1.25, alpha=0.7) + scale_x_date()
mpg_v_date <- ggplot(data=car_data, aes(x=Date, y=Miles/Gallons)) + geom_point(color="red", size=1.25, alpha=0.7) + scale_x_date()
price_v_date <- ggplot(data=car_data, aes(x=Date, y=Money/Gallons)) + geom_point(color="purple", size=1.25, alpha=0.7) + scale_x_date()

miles_v_date <- miles_v_date + labs(title = "Miles per Date", y = "Miles", x = "Date")
mpg_v_date <- mpg_v_date + labs(title = "MPG per Date", y = "Miles per Gallon", x = "Date")
price_v_date <- price_v_date + labs(title = "Gas Price per Date", y = "Dollars per Gallon", x = "Date")

pdf("grid_plots.pdf", width=8, height=12)
grid.arrange(miles_v_date, mpg_v_date, price_v_date, nrow=3, top="2003 Honda CRV")
dev.off()

total_miles <- tail(cumsum(car_data$Miles), n=1)
total_gallons <- tail(cumsum(car_data$Gallons), n=1)
total_money <- tail(cumsum(car_data$Money), n=1)

total_miles_v_date <- ggplot(data=car_data, aes(x=Date, y=cumsum(Miles))) + geom_point(color="blue", size=1, alpha=0.5)
total_gallons_v_date <- ggplot(data=car_data, aes(x=Date, y=cumsum(Gallons))) + geom_point(color="red", size=1, alpha=0.5) 
total_money_v_date <- ggplot(data=car_data, aes(x=Date, y=cumsum(Money))) + geom_point(color="purple", size=1, alpha=0.5) 

total_miles_v_date <- total_miles_v_date + labs(title = "Total Miles per Date", y = "Miles", x = "Date")
total_gallons_v_date <- total_gallons_v_date + labs(title = "Total Gallons per Date", y = "Gallons", x = "Date")
total_money_v_date <- total_money_v_date + labs(title = "Total Money per Date", y = "Dollars", x = "Date")

total_miles_v_date <- total_miles_v_date + geom_text(data=subset(car_data, cumsum(Miles) == total_miles), aes(label=total_miles, y=total_miles), size=3, vjust=3.0)
total_gallons_v_date <- total_gallons_v_date + geom_text(data=subset(car_data, cumsum(Gallons) == total_gallons), aes(label=total_gallons, y=total_gallons), size=3, vjust=3.0)
total_money_v_date <- total_money_v_date + geom_text(data=subset(car_data, cumsum(Money) == total_money), aes(label=total_money, y=total_money), size=3, vjust=3.0)

pdf("total_grid_plots.pdf", width=8, height=12)
grid.arrange(total_miles_v_date, total_gallons_v_date, total_money_v_date, nrow=3, top="2003 Honda CRV")
dev.off()

miles_hist <- ggplot(data=car_data, aes(x=Miles)) + geom_bar(binwidth=5, fill="royalblue") +
              geom_text(stat="bin", binwidth=5, aes(label=..count..), position="dodge", vjust=-0.75, size=1.75)
mpg_hist <- ggplot(data=car_data, aes(x=Miles/Gallons)) + geom_bar(binwidth=0.5, fill="firebrick") +
            geom_text(stat="bin", binwidth=0.5, aes(label=..count..), position="dodge", vjust=-0.75, size=1.75)
price_hist <- ggplot(data=car_data, aes(x=Money/Gallons)) + geom_bar(binwidth=0.1, fill="purple") +
              geom_text(stat="bin", binwidth=0.1, aes(label=..count..), posiiton="dodge", vjust=-0.75, size=1.75)

miles_hist <- miles_hist + labs(title = "Miles Histogram", y = "Count (per 5 Miles)", x = "Miles") #+ geom_vline(aes(xintercept=median(Miles)), linetype="dashed", size=0.5)
mpg_hist <- mpg_hist + labs(title = "MPG Histogram", y = "Count (per 0.5 Gallons)", x = "MPG")
price_hist <- price_hist + labs(title = "Gas Price Histogram", y = "Count (per 10 cents)", x = "Price / Gallon")

pdf("grid_hist.pdf", width=8, height=12)
grid.arrange(miles_hist, mpg_hist, price_hist, nrow=3, top="2003 Honda CRV")
dev.off()

miles_hist_stat <- ggplot(data=car_data, aes(x=Miles)) + geom_bar(binwidth=5, fill="royalblue") + 
                   geom_vline(aes(xintercept=mean(Miles)), linetype="dashed", size=0.5) +
                   geom_vline(aes(xintercept=median(Miles)), linetype="dotted", size=0.5)

mpg_hist_stat <- ggplot(data=car_data, aes(x=Miles/Gallons)) + geom_bar(binwidth=0.5, fill="firebrick") + 
                   geom_vline(aes(xintercept=mean(Miles/Gallons)), linetype="dashed", size=0.5) +
                   geom_vline(aes(xintercept=median(Miles/Gallons)), linetype="dotted", size=0.5)

price_hist_stat <- ggplot(data=car_data, aes(x=Money/Gallons)) + geom_bar(binwidth=0.1, fill="purple") + 
                   geom_vline(aes(xintercept=mean(Money/Gallons)), linetype="dashed", size=0.5) +
                   geom_vline(aes(xintercept=median(Money/Gallons)), linetype="dotted", size=0.5)

miles_hist_stat <- miles_hist_stat + labs(title = "Miles Histogram", y = "Count (per 5 Miles)", x = "Miles")
mpg_hist_stat <- mpg_hist_stat + labs(title = "MPG Histogram", y = "Count (per 0.5 Gallons)", x = "MPG")
price_hist_stat <- price_hist_stat + labs(title = "Gas Price Histogram", y = "Count (per 10 cents)", x = "Price / Gallon")

pdf("grid_hist_stat.pdf", width=8, height=12)
grid.arrange(miles_hist_stat, mpg_hist_stat, price_hist_stat, nrow=3, top="2003 Honda CRV")
dev.off()
