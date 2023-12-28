#ifndef PERCEPTRON_H
#define PERCEPTRON_H

#include <algorithm>
#include <vector>
#include <iostream>
#include <random>
#include <numeric>
#include <cmath>
#include <time.h>

class Perceptron {
public:
	std::vector<double> weights;
	double bias;
	
	Perceptron(int inputs, double bias = 1.0);
	double run(std::vector<double> x);
	void setWeights(std::vector<double> weights);
	double sigmoid(double x);	
};

class MultiLayerPerceptron {
public:
	MultiLayerPerceptron(std::vector<int> layers, double bias=1.0, double eta=0.5);
	
	void setWeights(std::vector<std::vector<std::vector<double>>> weights);	
	void printWeights();
	std::vector<double> run(std::vector<double> input);
	double bp(std::vector<double> x, std::vector<double> y);
	
	std::vector<int> layers;
	double bias;
	double eta; // earning rate
	std::vector<std::vector<Perceptron>> network;
	std::vector<std::vector<double>> values;
	std::vector<std::vector<double>> d;
};

#endif
