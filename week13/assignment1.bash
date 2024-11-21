#! /bin/bash
clear

# filling courses.txt
bash courses.bash

courseFile="courses.txt"

function displayCoursesofInst(){

echo -n "Please Input an Instructor Full Name: "
read instName

echo ""
echo "Courses of $instName :"
cat "$courseFile" | grep "$instName" | cut -d';' -f1,2 | \
sed 's/;/ | /g'
echo ""

}

function courseCountofInsts(){

echo ""
echo "Course-Instructor Distribution"
cat "$courseFile" | cut -d';' -f7 | \
grep -v "/" | grep -v "\.\.\." | \
sort -n | uniq -c | sort -n -r 
echo ""

}

# TODO - 1
# Make a function that displays all the courses in given location
# function dislaplays course code, course name, course days, time, instructor
# Add function to the menu
# Example input: JOYC 310
# Example output: See the screenshots in canvas

function coursesLocation(){
	echo -n "Enter the Class Location: "
	read locationInput

	echo ""
	echo "All Courses $locationIput in Given Location:"
	cat "$courseFile" | grep "$locationInput" | cut -d";" -f1,2,5,6,7 | \
	sed 's/;/ | /g'
	echo ""
}

# TODO - 2
# Make a function that displays all the courses that has availability
# (seat number will be more than 0) for the given course code
# Add function to the menu
# Example input: SEC
# Example output: See the screenshots in canvas
 
function coursesAvailable(){
	echo "Please Input a Subject Name: "
	read subjectInput

	echo ""
	echo "Available Courses in $subjectInput"

	while read -r line; 
	do
		count=$(echo "$line" | cut -d";" -f4 | sed 's/-[1-9][1-9]*/0/')
		
		if [[ "$count" > 0 ]]; then
			echo "$line" | grep "$subjectInput" | \
			sed 's/;/ | /g'
		fi
	done < "$courseFile"
}

while :
do
	echo ""
	echo "Please select and option:"
	echo "[1] Display courses of an instructor"
	echo "[2] Display course count of instructors"
	echo "[3] Display courses of given location"
	echo "[4] Display courses on availabitity"
	echo "[5] Exit"

	read userInput
	echo ""

	if [[ "$userInput" == "5" ]]; then
		echo "Goodbye"
		break

	elif [[ "$userInput" == "1" ]]; then
		displayCoursesofInst

	elif [[ "$userInput" == "2" ]]; then
		courseCountofInsts

	elif [[ "$userInput" == "3" ]]; then
		coursesLocation

	elif [[ "$userInput" == "4" ]]; then
		coursesAvailable

	# TODO - 3 Display a message, if an invalid input is given
	else 
		echo "Invalid Input(1-5)! Try Again"
	fi
done
