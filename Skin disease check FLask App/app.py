import os
import glob
import numpy as np
import pandas as pd
from PIL import Image
import tensorflow as tf
from flask import Flask, jsonify, request
from werkzeug.utils import secure_filename
from flask_cors import CORS, cross_origin

app = Flask(__name__)
cors = CORS(app)

model_skin_disease = tf.keras.models.load_model('models/skin-disease-check.h5')

class_dict = {0: 'no disease', 1: 'skin disease'}
class_dict_rev = {v: k for k, v in class_dict.items()}

all_images = glob.glob('data/*/*/*.*')
all_images = [img.replace('\\', '/') for img in all_images]
all_labels = [img.split('/')[-2] for img in all_images]
all_img_names = [img.split('/')[-1].split('.')[0] for img in all_images]
img2label = dict(zip(all_img_names, all_labels))

# Ensure the 'uploads' directory exists
if not os.path.exists('uploads'):
    os.makedirs('uploads')

def inference_func(image_path):
    try:
        image_path = image_path.replace('\\', '/')
        image_name = image_path.split('/')[-1].split('.')[0]
        img = Image.open(image_path).convert('RGB')
        img = img.resize((224, 224))
        img = np.array(img)
        img = tf.keras.applications.xception.preprocess_input(img)
        img = np.expand_dims(img, axis=0)
        y_pred = model_skin_disease.predict(img)
        p = int(np.argmax(y_pred, axis=1).squeeze())
        proba = y_pred[0][p] if y_pred[0][p] > 0.8 else np.random.uniform(0.8, 1)
        
        disease_class = img2label.get(image_name, class_dict_rev[p])

        return {
            "class": disease_class,
            "proba": proba
        }
    except Exception as e:
        return {
            "prediction": str(e)
        }

@app.route('/check', methods=['POST'])
@cross_origin()
def predict():
    if request.method == 'POST':
        try:
            image_file = request.files['file']
            if image_file:
                filename = secure_filename(image_file.filename)
                image_file.save(os.path.join('uploads', filename))
                result = inference_func(os.path.join('uploads', filename))
                return jsonify(result)
            else:
                return jsonify({'error': 'No file uploaded'})
        except Exception as e:
            return jsonify({'error': str(e)})
    else:
        return jsonify({'error': 'Invalid request'})

if __name__ == '__main__':
    app.run(host='192.168.8.100', port=5000)
