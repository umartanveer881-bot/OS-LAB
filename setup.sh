#!/bin/bash
# CS330 Lab 02 - bootstrap script.
# Paste this whole thing into a terminal (or run: bash setup.sh).
# It creates all five task scripts in the current directory and makes them executable.

mkdir -p ~/Lab02 && cd ~/Lab02

cat > task1.sh << 'LAB1'
#!/bin/bash
# Task 1: Input two students' name, batch number and CGPA, then display it.

echo "===== Student Information Entry ====="

for i in 1 2
do
    echo ""
    echo "--- Enter details for Student $i ---"

    echo -n "Enter Name: "
    read name

    echo -n "Enter Batch Number: "
    read batch

    echo -n "Enter CGPA: "
    read cgpa

    # store each student's data in a variable named after the loop counter
    eval "name$i='$name'"
    eval "batch$i='$batch'"
    eval "cgpa$i='$cgpa'"
done

echo ""
echo "========== Student Records =========="
printf "%-20s %-15s %-6s\n" "NAME" "BATCH" "CGPA"
printf "%-20s %-15s %-6s\n" "$name1" "$batch1" "$cgpa1"
printf "%-20s %-15s %-6s\n" "$name2" "$batch2" "$cgpa2"
echo "====================================="
LAB1

cat > task2.sh << 'LAB2'
#!/bin/bash
# Task 2: Generate a series of the first 25 even numbers
#         using BOTH a for loop and a while loop.

echo "=========================================="
echo " First 25 even numbers -- using FOR loop"
echo "=========================================="

for (( i=1; i<=25; i++ ))
do
    even=$(( i * 2 ))
    echo -n "$even "
done
echo ""

echo ""
echo "=========================================="
echo " First 25 even numbers -- using WHILE loop"
echo "=========================================="

count=1
num=2
while [ $count -le 25 ]
do
    echo -n "$num "
    num=$(( num + 2 ))
    count=$(( count + 1 ))
done
echo ""
LAB2

cat > task3.sh << 'LAB3'
#!/bin/bash
# Task 3: Simple calculator (+, -, *, /, %) with repeated input from the user.
#         Integer operations print integers, division prints a decimal result.

echo "############################################"
echo "#           SIMPLE BASH CALCULATOR         #"
echo "############################################"

while true
do
    echo ""
    echo -n "Enter first number  : "
    read a
    echo -n "Enter second number : "
    read b

    echo ""
    echo "Choose an operation:"
    echo "  1) Addition       (+)"
    echo "  2) Subtraction    (-)"
    echo "  3) Multiplication (*)"
    echo "  4) Division       (/)"
    echo "  5) Modulus        (%)"
    echo -n "Enter your choice [1-5]: "
    read choice

    case $choice in
        1)
            result=$(( a + b ))
            echo "Result: $a + $b = $result"
            ;;
        2)
            result=$(( a - b ))
            echo "Result: $a - $b = $result"
            ;;
        3)
            result=$(( a * b ))
            echo "Result: $a * $b = $result"
            ;;
        4)
            if [ "$b" -eq 0 ]
            then
                echo "Error: Division by zero is not allowed!"
            else
                # awk gives us a floating point (proper data type) result
                result=$(awk "BEGIN { printf \"%.2f\", $a / $b }")
                echo "Result: $a / $b = $result"
            fi
            ;;
        5)
            if [ "$b" -eq 0 ]
            then
                echo "Error: Modulus by zero is not allowed!"
            else
                result=$(( a % b ))
                echo "Result: $a % $b = $result"
            fi
            ;;
        *)
            echo "INVALID CHOICE! Please pick a number between 1 and 5."
            ;;
    esac

    echo ""
    echo -n "Do you want to perform another calculation? (y/n): "
    read again

    case $again in
        y|Y|yes|YES)
            continue
            ;;
        *)
            echo "Exiting calculator. Goodbye!"
            break
            ;;
    esac
done
LAB3

cat > task4.sh << 'LAB4'
#!/bin/bash
# Task 4: Copy all .txt files from a source folder into a destination directory.
#         Source and destination paths are taken from the user.

echo "===== Copy all .txt files ====="

echo -n "Enter the SOURCE directory path: "
read src

echo -n "Enter the DESTINATION directory path: "
read dest

# 1. Make sure the source directory actually exists
if [ ! -d "$src" ]
then
    echo "Error: Source directory '$src' does not exist."
    exit 1
fi

# 2. Create the destination directory if it is not already there
if [ ! -d "$dest" ]
then
    echo "Destination '$dest' not found. Creating it..."
    mkdir -p "$dest"
fi

# 3. Count how many .txt files are present
count=0
for file in "$src"/*.txt
do
    if [ -f "$file" ]
    then
        cp "$file" "$dest"
        echo "Copied: $(basename "$file")"
        count=$(( count + 1 ))
    fi
done

echo ""
if [ $count -eq 0 ]
then
    echo "No .txt files were found in '$src'."
else
    echo "Done. $count .txt file(s) copied from '$src' to '$dest'."
    echo ""
    echo "Contents of destination directory:"
    ls -l "$dest"
fi
LAB4

cat > task5.sh << 'LAB5'
#!/bin/bash
# Task 5: Find the number of lines, words and characters in a given file
#         and display each piece of information separately.

echo "===== File Statistics using wc ====="

echo -n "Enter the file name (with path): "
read fname

if [ ! -f "$fname" ]
then
    echo "Error: '$fname' is not a valid file."
    exit 1
fi

lines=$(wc -l < "$fname")
words=$(wc -w < "$fname")
chars=$(wc -c < "$fname")

echo ""
echo "File name            : $fname"
echo "Number of lines      : $lines"
echo "Number of words      : $words"
echo "Number of characters : $chars"
LAB5

chmod u=rwx *.sh
echo ""
echo "All five scripts created in $(pwd):"
ls -l *.sh
