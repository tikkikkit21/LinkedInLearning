// Calculate a GPA
#include "Records.h"
#include "StudentRecords.h"
#include <vector>
#include <iostream>
#include <string>

using namespace std;

void init(StudentRecords&);

int main() {
	StudentRecords sr = StudentRecords();
	init(sr);

	cout << "Enter a student ID: ";
	int id;
	cin >> id;
	
	sr.printReportCard(id);
	
	return 0;
}

void init(StudentRecords& sr) {
	sr.addStudent(Student(1, "Tikki"));
	sr.addStudent(Student(2, "Mike"));
	
	sr.addCourse(Course(1, "Algebra", 5));
	sr.addCourse(Course(2, "Physics", 4));
	sr.addCourse(Course(3, "English", 3));
	sr.addCourse(Course(4, "Economics", 4));
	
	sr.addGrade(Grade(1,1,'B'));
	sr.addGrade(Grade (1,2,'A'));
	sr.addGrade(Grade(1,3,'C'));
	sr.addGrade(Grade(2,1,'A'));
	sr.addGrade(Grade(2,2,'A'));
	sr.addGrade(Grade(2,4,'B'));
}
