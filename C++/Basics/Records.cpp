#include "Records.h"
using namespace std;

// Student
Student::Student(int id, string name) {
	this->id = id;
	this->name = name;
}

int Student::getID() {return id;}
string Student::getName() {return name;}

// Course
Course::Course(int id, string name, int8_t credits) {
	this->id = id;
	this->name = name;
	this->credits = credits;
}

int Course::getID() {return id;}
string Course::getName() {return name;}
int Course::getCredits() {return credits;}

// Grade
Grade::Grade(int student_id, int course_id, char grade) {
	this->student_id = student_id;
	this->course_id = course_id;
	this->grade = grade;
}
    
int Grade::getStudent_ID() {return student_id;}
int Grade::getCourse_ID() {return course_id;}
char Grade::getGrade() {return grade;}
