// Work with Files (upgrading report card)

// Calculate a GPA
#include "Records.h"
#include "StudentRecords.h"
#include <vector>
#include <iostream>
#include <string>
#include <fstream>

using namespace std;
ifstream courses;
ifstream grades;
ifstream students;
//~ ostream report;
string str;

int main() {
	StudentRecords sr = StudentRecords();
	students.open("students.txt");
	if (students.fail()) {
		cout << endl << "students.txt was not found\n";
	} else {
		while (!students.eof()) {
			getline(students, str);
			int studentID = stoi(str);
			
			getline(students, str);
			
			sr.addStudent(Student(studentID, str));
		}
	}
	
	//~ cout << "Name: " << getStudentName(studentID) << endl;
	//~ cout << "===============\n";
	//~ for (Grade& grade : grades) {
		//~ if (grade.getStudent_ID() == studentID) {
			//~ for (Course& course: courses) {
				//~ if (course.getID() == grade.getCourse_ID()) {
					//~ cout << course.getName() << ": " << grade.getGrade() << endl;
				//~ }
			//~ }
		//~ }
	//~ }
	
	//~ cout << "===============\n";
	//~ cout << "GPA: " << getGPA(studentID) << endl;


	return 0;
}
