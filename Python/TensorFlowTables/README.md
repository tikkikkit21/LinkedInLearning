# TensorFlow: Neural Networks and Working with Tables
https://www.linkedin.com/learning/tensorflow-neural-networks-and-working-with-tables

## Fashion MNIST & Neural Networks
### Fashion-MNIST
- The *Fashion MNIST* dataset is a drop-in replacement for MNIST
    - Classic dataset of 0-9 handwritten digits
- The fashion dataset contains zalando images
    - 60k training, 10k test
    - 28x28 grayscale images
    - 10 classes

### Neural Network Intuition
- Each pixel in a grayscale image ranges from 0-255
    - 0 is black
    - 255 is white
- We want to use min-max scaling to adjust the range from 0-1
- We also want to flatten the grid of numbers into a single row
    - We take the grid row by row and append to our flattened row
    - Result is a long vector of 28x28 = 784 values

## Loss, Gradient Descent, Optimizers
### Loss
- The loss function determine the quantity that will be minimized during training

| Problem Type                                                       | Activation | LossFunction                   |
| ------------------------------------------------------------------ | ---------- | ------------------------------ |
| binary classification                                              | sigmoid    | binary crossentropy            |
| multi-class, single-label classification (integer labels)          | softmax    | SparseCategorical crossentropy |
| multi-class, single-label classification (one-hot encoding labels) | softmax    | Categorical crossentropy       |
| regression to arbitrary                                            | none       | MSE                            |
| regression to values 0-1                                           | sigmoid    | MSE or binary crossentropy     |

### Gradient Descent
- Gradient descent finds the direction in order to minimize loss
- Uses advanced calculus
- TensorFlow helps optimize all this math

### Optimizers
- Optimizers determine how the model is updated based on loss function
- Uses a variant of stochastic gradient descent (SGD)
