from keras.models import load_model
import numpy as np

model = load_model('MNIST_digits.h5')

def predict(input_list):
    input_array = np.asarray(input_list)
    pred = model.predict(input_array)
    pred_list = []
    for i in range(10):
        pred_list.append((i,float(pred[0,i])))
    return pred_list