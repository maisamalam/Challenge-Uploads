import csv
import os

# define the path for the input file
file_path = os.path.join("Pybank","Resources","budget_data.csv")


# define variables to store the financial analysis data
total_months = 0
total_profit_losses = 0
previous_profit_loss = 0
profit_loss_changes = []
greatest_increase = {"date": "", "amount": 0}
greatest_decrease = {"date": "", "amount": 0}

# open the input file and read its content
with open(file_path, newline="") as csvfile:
    csvreader = csv.reader(csvfile, delimiter=",")
    # skip the header row
    next(csvreader)
    # loop through each row of the file
    for row in csvreader:
        # increment the total number of months
        total_months += 1
        # extract the profit/loss for the current month
        current_profit_loss = int(row[1])
        # add the current profit/loss to the total
        total_profit_losses += current_profit_loss
        # calculate the change in profit/loss from the previous month
        if total_months > 1:
            profit_loss_change = current_profit_loss - previous_profit_loss
            # add the change to the list of changes
            profit_loss_changes.append(profit_loss_change)
            # update the greatest increase and decrease if necessary
            if profit_loss_change > greatest_increase["amount"]:
                greatest_increase["date"] = row[0]
                greatest_increase["amount"] = profit_loss_change
            elif profit_loss_change < greatest_decrease["amount"]:
                greatest_decrease["date"] = row[0]
                greatest_decrease["amount"] = profit_loss_change
        # store the current profit/loss for the next iteration
        previous_profit_loss = current_profit_loss

# calculate the average change in profit/loss
average_profit_loss_change = sum(profit_loss_changes) / len(profit_loss_changes)
print("Financial Analysis")
print("------------------")
print(f"Total Months: {total_months}")
print(f"Total: ${total_profit_losses}")
print(f"Average Change: ${average_profit_loss_change:.2f}")
print(f"Greatest Increase in Profits: {greatest_increase['date']} (${greatest_increase['amount']})")
print(f"Greatest Decrease in Profits: {greatest_decrease['date']} (${greatest_decrease['amount']})")
# print the financial analysis results
with open('financial_analysis.txt', 'w') as f:
    f.write("Financial Analysis\n")
    f.write("------------------\n")
    f.write(f"Total Months: {total_months}\n")
    f.write(f"Total: ${total_profit_losses}\n")
    f.write(f"Average Change: ${average_profit_loss_change:.2f}\n")
    f.write(f"Greatest Increase in Profits: {greatest_increase['date']} (${greatest_increase['amount']})\n")
    f.write(f"Greatest Decrease in Profits: {greatest_decrease['date']} (${greatest_decrease['amount']})\n")
