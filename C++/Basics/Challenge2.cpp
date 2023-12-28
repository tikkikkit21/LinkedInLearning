// Calculating an average
#include <iostream>
using namespace std;

#define LENGTH 5
int numbers[LENGTH] = {1, 23, 32, 24, 337};

int main() {
	int sum = 0;
	for (int i = 0; i < LENGTH; i++) {
		sum += numbers[i];
	}
	
	float average = (float)sum / LENGTH;
	
	cout << "The average is: " << average << endl;
	
	return 0;
}
