#include "Perceptron.h"

using namespace std;

// gets a double between -1 and 1
double frand() {
	return (2.0 * (double)rand() / RAND_MAX) - 1.0;
}

Perceptron::Perceptron(int inputs, double bias) {
	this->bias = bias;
	weights.resize(inputs + 1);
	generate(weights.begin(), weights.end(), frand);
}

double Perceptron::run(vector<double> x) {
	x.push_back(bias);
	double sum = inner_product(x.begin(), x.end(), weights.begin(), (double)0.0);
	return sigmoid(sum);
}

void Perceptron::setWeights(vector<double> weights) {
	this->weights = weights;
}

double Perceptron::sigmoid(double x) {
	return 1.0 / (1.0 + exp(-x));
}

MultiLayerPerceptron::MultiLayerPerceptron(vector<int> layers, double bias, double eta) {
	this->layers = layers;
	this->bias = bias;
	this->eta = eta;
	
	// create neurons layer by layer
	for (int i = 0; i < layers.size(); i++) {
		values.push_back(vector<double>(layers[i], 0.0));
		d.push_back(vector<double>(layers[i], 0.0));
		network.push_back(vector<Perceptron>());
		
		if (i == 0) continue; // network[0] is input layer, so no neurons
		for (int j = 0; j < layers[i]; j++) {
			network[i].push_back(Perceptron(layers[i-1], bias));
		}
	}
}

// weights represents input > neuron > layer for each weight
void MultiLayerPerceptron::setWeights(vector<vector<vector<double>>> weights) {
	for (int i = 0; i < weights.size(); i++) { // layers
		for (int j = 0; j < weights[i].size(); j++) { // neurons
			network[i+1][j].setWeights(weights[i][j]);
		}
	}
}

void MultiLayerPerceptron::printWeights() {
	for (int i = 1; i < network.size(); i++) {
		for (int j = 0; j < layers[i]; j++) {
			cout << "Layer " << i + 1 << " Neuron " << j << ": ";
			for (auto &it: network[i][j].weights) {
				cout << it << "  ";
			}
			
			cout << endl;
		}
	}
	
	cout << endl;
}

vector<double> MultiLayerPerceptron::run(vector<double> input) {
	values[0] = input;
	
	for (int i = 1; i < network.size(); i++) {
		for (int j = 0; j < layers[i]; j++) {
			values[i][j] = network[i][j].run(values[i-1]);
		}
	}
	
	return values.back();
}

double MultiLayerPerceptron::bp(vector<double> input, vector<double> expected) {
	// Step 1: feed a sample to network
	vector<double> outputs = run(input);
	
	// Step 2: calcaulte MSE
	vector<double> error;
	double MSE = 0.0;
	for (int i = 0; i < expected.size(); i++) {
		error.push_back(expected[i] - outputs[i]);
		MSE += error[i] * error[i];
	}
	MSE /= layers.back();
	
	// Step 3: calculate output error terms
	for (int i = 0; i < outputs.size(); i++) {
		d.back()[i] = outputs[i] * (1 - outputs[i]) * (error[i]);
	}
	
	// Step 4: calculate the error term of each neuron	
	for (int i = network.size() - 2; i > 0; i--) {
		for (int j = 0; j < network[i].size(); j++) {
			double fwdError = 0.0;
			for (int k = 0; k < layers[i+1]; k++) {
				fwdError += network[i+1][k].weights[j] * d[i+1][k];
			}
			
			d[i][j] = values[i][j] * (1 - values[i][j]) * fwdError;
		}
	}
	
	// Step 5 & 6: calcualte the delats and udpate weights
	for (int i = 1; i < network.size(); i++) {
		for (int j = 0; j < layers[i]; j++) {
			for (int k = 0; k < layers[i-1] + 1; k++) {
				double delta;
				if (k == layers[i-1]) {
					delta = eta * d[i][j] * bias;
				} else {
					delta = eta * d[i][j] * values[i-1][k];
				}
				
				network[i][j].weights[k] += delta;
			}
		}
	}
	
	return MSE;
}
