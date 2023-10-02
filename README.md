# Building and Deploying a CNN via Shiny


1. Train a CNN model using a Tesla V100 GPU and a Domino environment preconfigured with an NVIDIA driver, CUDA 9, Tensorflow, and Keras. 

    * Use this notebook to train and save the model: MNIST_keras.ipynb
    


2. Use Domino to deploy and manage a model API Endpoint on AWS. 

    * Use this file as when building the API: MNIST_predict_list.py
    


3. Use Domino to deploy and manage a Web App on AWS allowing others to interact with your model.

    * Use these files to define the web app: ui.R and server.R
    


app inspiration taken from https://github.com/agenis/handwritten-digits
