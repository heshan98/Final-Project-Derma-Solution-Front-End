import unittest
import json
from app import app

class SkinDiseaseDetectionAppTestCase(unittest.TestCase):

    def setUp(self):
        app.config['TESTING'] = True
        self.app = app.test_client()

    def test_predict_endpoint(self):
       
        image_data = open('C:/Users/shaki/Desktop/Skin Desase Model/uploads/acne-closed-comedo-003.jpg', 'rb')

        response = self.app.post('/predict', data={'file': image_data})
        
      
        self.assertEqual(response.status_code, 200)

     
        data = json.loads(response.data.decode('utf-8'))

        self.assertTrue('class' in data)
        self.assertTrue('description' in data)
        self.assertTrue('proba' in data)

      
        print("Class:", data['class'])
        print("Description:", data['description'])
        print("Proba:", data['proba'])

    def tearDown(self):
        pass

if __name__ == '__main__':
    unittest.main()
