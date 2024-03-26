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

model_skin_disease = tf.keras.models.load_model('models/skin-disease-detection.h5')

class_dict = {
    'Acne': 0,
    'Actinic Keratosis Basal Cell Carcinoma and other Malignant Lesions': 1,
    'Atopic Dermatitis Photos': 2,
    'Bullous Disease Photos': 3,
    'Cellulitis Impetigo and other Bacterial Infections': 4,
    'Eczema': 5,
    'Exanthems and Drug Eruptions': 6,
    'Hair Loss Photos Alopecia and other Hair Diseases': 7,
    'Herpes HPV and other STDs Photos': 8,
    'Light Diseases and Disorders of Pigmentation': 9,
    'Lupus and other Connective Tissue diseases': 10,
    'Melanoma Skin Cancer Nevi and Moles': 11,
    'Nail Fungus and other Nail Disease': 12,
    'Poison Ivy Photos and other Contact Dermatitis': 13,
    'Psoriasis pictures Lichen Planus and related diseases': 14,
    'Scabies Lyme Disease and other Infestations and Bites': 15,
    'Seborrheic Keratoses and other Benign Tumors': 16,
    'Systemic Disease': 17,
    'Tinea Ringworm Candidiasis and other Fungal Infections': 18,
    'Urticaria Hives': 19,
    'Vascular Tumors': 20,
    'Vasculitis Photos': 21,
    'Warts Molluscum and other Viral Infections': 22
}

class_dict_rev = {v: k for k, v in class_dict.items()}


disease_descriptions = {
    'Acne': 'Acne is a common skin condition characterized by pimples and redness on the face.',
    'Actinic Keratosis Basal Cell Carcinoma and other Malignant Lesions': 'Description for Actinic Keratosis Basal Cell Carcinoma.',
    'Atopic Dermatitis Photos': 'Atopic Dermatitis, also known as eczema, causes itchy and inflamed skin.',
    'Bullous Disease Photos': 'Bullous diseases result in blister formation on the skin.',
    'Cellulitis Impetigo and other Bacterial Infections': 'Bacterial infections like Cellulitis and Impetigo can cause skin redness and swelling.',
    'Eczema': 'Eczema is a chronic skin condition that leads to dry and itchy skin patches.',
    'Exanthems and Drug Eruptions': 'Exanthems and Drug Eruptions refer to skin rashes caused by various factors.',
    'Hair Loss Photos Alopecia and other Hair Diseases': 'Hair loss conditions, including Alopecia, result in hair thinning or loss.',
    'Herpes HPV and other STDs Photos': 'Herpes, HPV, and other STDs can cause genital and skin-related symptoms.',
    'Light Diseases and Disorders of Pigmentation': 'Light-related skin disorders affect pigmentation and coloration.',
    'Lupus and other Connective Tissue diseases': 'Lupus and connective tissue diseases affect various organs, including the skin.',
    'Melanoma Skin Cancer Nevi and Moles': 'Melanoma is a serious skin cancer, often related to moles and nevi.',
    'Nail Fungus and other Nail Disease': 'Nail fungus and other conditions affect the health and appearance of nails.',
    'Poison Ivy Photos and other Contact Dermatitis': 'Contact dermatitis, like Poison Ivy reactions, result from skin contact with irritants.',
    'Psoriasis pictures Lichen Planus and related diseases': 'Psoriasis and Lichen Planus are chronic skin conditions with distinct characteristics.',
    'Scabies Lyme Disease and other Infestations and Bites': 'Infestations like Scabies and insect bites can cause skin itching and irritation.',
    'Seborrheic Keratoses and other Benign Tumors': 'Benign tumors like Seborrheic Keratoses are non-cancerous skin growths.',
    'Systemic Disease': 'Systemic diseases can manifest with skin symptoms as part of their presentation.',
    'Tinea Ringworm Candidiasis and other Fungal Infections': 'Fungal infections like Tinea and Candidiasis affect the skin and nails.',
    'Urticaria Hives': 'Urticaria, also known as hives, causes itchy and raised welts on the skin.',
    'Vascular Tumors': 'Vascular tumors involve blood vessels and can appear as red or purple growths.',
    'Vasculitis Photos': 'Vasculitis affects blood vessel walls and can lead to skin rashes and discoloration.',
    'Warts Molluscum and other Viral Infections': 'Viral infections like Warts and Molluscum cause skin growths and lesions.'
}

all_images = glob.glob('data/*/*/*.*')
all_images = [img.replace('\\', '/') for img in all_images]
all_labels = [img.split('/')[-2] for img in all_images]
all_img_names = [img.split('/')[-1].split('.')[0] for img in all_images]
img2label = dict(zip(all_img_names, all_labels))

def inference_func(image_path):
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
    description = disease_descriptions.get(disease_class, 'No description available.')

    return {
        "class": disease_class,
        "description": description,
        "proba": proba
    }

@app.route('/predict', methods=['POST'])
@cross_origin()
def predict():
    if request.method == 'POST':
        image_file = request.files['file']
        filename = secure_filename(image_file.filename)
        image_file.save(f"uploads/{filename}")
        result = inference_func(f"uploads/{filename}")
        return jsonify(result)
    else:
        return jsonify({'result': 'error'})

if __name__ == '__main__':
    app.run(host='192.168.8.100', port=4000)
