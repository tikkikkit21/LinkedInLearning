#include "StudentRecords.h"
#include <iostream>
using namespace std;

StudentRecords::StudentRecords() {}
	
void StudentRecords::addStudent(Student student) {
	students.push_back(student);
}

void StudentRecords::addCourse(Course course) {
	courses.push_back(course);
}

void StudentRecords::addGrade(Grade grade ) {
	grades.push_back(grade);
}

string StudentRecords::getStudentName(int studentID) {
	for (Student& student: students) {
		if (student.getID() == studentID) {
			return student.getName();
		}
	}
	
	return NULL;
}

unsigned char StudentRecords::getCredits(int courseID) {
	for (Course& course: courses) {
		if (course.getID() == courseID) {
			return course.getCredits();
		}
	}
	
	return 0;
}

float StudentRecords::getPoints(char grade) {
	switch(grade) {
		case 'A':
			return 4.0f;
		case 'B':
			return 3.0f;
		case 'C':
			return 2.0f;
		case 'D':
			return 1.0f;
		case 'F':
			return 0.0f;
		default:
			cout << "Invalid grade: " << grade << endl;
			return -1.0f;
	}
}

float StudentRecords::getGPA(int studentID) {
	float points = 0.0f, credits = 0.0f;
	for (Grade& grade : grades) {
		if (grade.getStudent_ID() == studentID) {
			int c = getCredits(grade.getCourse_ID());
			
			credits += c;
			points += (c * getPoints(grade.getGrade()));
		}
	}
	
	return points / credits;
}

void StudentRecords::printReportCard(int studentID) {
	cout << "Name: " << getStudentName(studentID) << endl;
	cout << "===============\n";
	for (Grade& grade : grades) {
		if (grade.getStudent_ID() == studentID) {
			for (Course& course: courses) {
				if (course.getID() == grade.getCourse_ID()) {
					cout << course.getName() << ": " << grade.getGrade() << endl;
				}
			}
		}
	}
	
	cout << "===============\n";
	cout << "GPA: " << getGPA(studentID) << endl;
}
