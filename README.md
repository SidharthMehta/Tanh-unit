# Tanh Unit for LSTM cell

The project implements a g(t) gate within an LSTM cell. LSTM stands for Long Short Term Memory and is a type of neural network. 
![Screenshot](/Images/1.png? "LSTM")
![Screenshot](/Images/2.png? "g(t)")
 

g(t) gate is a tanh function performed on the weighted sum of inputs. Weighted sum is calculated using matrix multiplication of weight Wg with input Xt. 
•	Wg is a matrix of size 16*16. Each weight is 16-bit fixed point. 
•	Xt is a vector of size 16 with each element being 16-bit fixed point. 

g(t) gate finds its output using interpolation on weighted sum with help of a lookup table. 

The aim of this project was to design g(t) gate while achieving minimal area-delay product.

[Veiw project report](https://github.com/SidharthMehta/Tanh-unit/blob/master/report/Project%20report.pdf)
