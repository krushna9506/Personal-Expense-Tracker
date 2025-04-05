#!/bin/bash

# Initialize filename variable
filename="expenses.txt"

# Function to create a new expense storing file
create_expense_file() {
    read -p "Enter the name of the expense file (default: expenses.txt): " new_filename
    if [[ -z "$new_filename" ]]; then
        new_filename="expenses.txt"
    fi

    if [[ -f "$new_filename" ]]; then
        echo "File '$new_filename' already exists. Using this file."
    else
        touch "$new_filename"
        echo "Created new expense file: $new_filename"
    fi

    filename="$new_filename"
}

# Function to add an expense
add_expense() {
    read -p "Enter expense statement (e.g., '50 rs. Groceries'): " statement
    echo "$(date "+%Y-%m-%d") $statement" >> "$filename"
    echo "Expense added: $statement"
}

# Function to calculate total expenses for the current year
calculate_expenses() {
    year=$(date +"%Y")
    total=$(awk -v year="$year" '$1 ~ year {sum += $2} END {print sum}' "$filename")
    echo "Total expenses for $year: ${total:-0}"
}

# Function to list all recorded expenses
list_expenses() {
    if [[ -f "$filename" ]]; then
        echo "Recorded Expenses:"
        cat "$filename"
    else
        echo "No expenses recorded yet."
    fi
}
# Main menu
while true; do
    echo "Personal Expense Tracker"
    echo "------------------------"
    echo "1. Create/Select Expense File"
    echo "2. Add Expense"
    echo "3. Calculate Total Expenses"
    echo "4. List All Expenses"
    echo "5. Exit"
    read -p "Choose an option (1-5): " option

    case $option in
        1) create_expense_file ;;
        2) add_expense ;;
        3) calculate_expenses ;;
        4) list_expenses ;;
        5) echo "Exiting..."; exit 0 ;;
        *) echo "Invalid option. Please try again." ;;
    esac
    echo ""
done
