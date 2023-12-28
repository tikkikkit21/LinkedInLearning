// Create some classes

#include <iostream>
#include "Records.h"

using namespace std;

int main() {
    Student student = Student(17, "Tikki");
    Course course = Course(7, "physics 101", 4);
    Grade grade(1, 7, 'B');
    
    
    
	cout << "Student: " << student.getName() << endl;
    cout << "Course: " << course.getName() << endl;
    cout << "- Credits: " << (int)course.getCredits() << endl;
    cout << "Grade: " << grade.getGrade() << endl;
	return 0;
}
