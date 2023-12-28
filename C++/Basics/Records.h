#ifndef RECORDS_H
#define RECORDS_H

#include <string>
#include <stdint.h>
#include <vector>

class Student {
public:
    Student(int id, std::string name);
    
    int getID();
    std::string getName();

private:
    int id;
    std::string name;
};

class Course {
private:
    int id;
    std::string name;
    unsigned char credits;
public:
    Course(int id, std::string name, int8_t credits);
    
    int getID();
    std::string getName();
    int getCredits();
};

class Grade {
private:
    int student_id;
    int course_id;
    char grade;
public:
    Grade(int student_id, int course_id, char grade);
    
    int getStudent_ID();
    int getCourse_ID();
    char getGrade();
};

#endif
