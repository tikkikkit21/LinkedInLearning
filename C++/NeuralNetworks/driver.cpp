#include <iostream>
#include "Perceptron.h"

using namespace std;

int main() {
	srand(time(NULL));
	rand();
	
	Perceptron p = Perceptron(2);
	
	// Weights for an AND gate
	p.setWeights({10,10,-15});
	
	cout << "AND Gate:" << endl;
	cout << p.run({0,0}) << endl;
	cout << p.run({0,1}) << endl;
	cout << p.run({1,0}) << endl;
	cout << p.run({1,1}) << endl;
	
	// Weights for an OR gate
	p.setWeights({10,10,-5});
	
	cout << "\nOR Gate:" << endl;
	cout << p.run({0,0}) << endl;
	cout << p.run({0,1}) << endl;
	cout << p.run({1,0}) << endl;
	cout << p.run({1,1}) << endl;
	
	// Setting up an XOR gate
	MultiLayerPerceptron mlp = MultiLayerPerceptron({2,2,1});
	mlp.setWeights({{{-10,-10,15},{15,15,-10}},{{10,10,-15}}});
	cout << "\nHard-coded weights:" << endl;
	mlp.printWeights();
	
	cout << "XOR Gate:" << endl;
	cout << mlp.run({0,0})[0] << endl;
	cout << mlp.run({0,1})[0] << endl;
	cout << mlp.run({1,0})[0] << endl;
	cout << mlp.run({1,1})[0] << endl;
	
	// Training to get weights
	mlp = MultiLayerPerceptron({2,2,1});
	
	double MSE;
	for (int i = 0; i < 3000; i++) {
		MSE = 0.0;
		MSE += mlp.bp({0,0}, {0});
		MSE += mlp.bp({0,1}, {1});
		MSE += mlp.bp({1,0}, {1});
		MSE += mlp.bp({1,1}, {0});
		
		MSE = MSE / 4.0;
		if (i % 100 == 0) {
			cout << "MSE: " << MSE << endl;
		}
	}
	
	cout << "\nTrained weights:" << endl;
	mlp.printWeights();
	
	cout << "XOR Gate:" << endl;
	cout << mlp.run({0,0})[0] << endl;
	cout << mlp.run({0,1})[0] << endl;
	cout << mlp.run({1,0})[0] << endl;
	cout << mlp.run({1,1})[0] << endl;
	
	return 0;
}
