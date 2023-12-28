#ifndef STUDENTRECORDS_H
#define STUDENTRECORDS_H

#include <vector>
#include "Records.h"
#include <string>

class StudentRecords {
private:
	std::vector<Student> students;
	std::vector<Course> courses;
	std::vector<Grade> grades;
public:
	StudentRecords();
	
	void addStudent(Student student);
	void addCourse(Course course);
	void addGrade(Grade grade);
	
	std::string getStudentName(int studentID);
	unsigned char getCredits(int courseID);
	float getPoints(char grade);
	float getGPA(int studentID);
	void printReportCard(int studentID);
};

#endif
