from flask import Flask, request, jsonify
import joblib
import numpy as np

app = Flask(__name__)

# Load the pre-trained model
model = joblib.load('model/model_joblib_heart.pkl')

@app.route('/')
def home():
    return "Heart Disease Prediction API"

@app.route('/predict', methods=['POST'])
def predict():
    # Get user input from the JSON payload
    print(request)
    try:
        data = request.get_json()
        features = [float(data['age']),
            int(data['sex']),
            int(data['cp']),
            float(data['trestbps']),
            float(data['chol']),
            int(data['fbs']),
            int(data['restecg']),
            float(data['thalach']),
            int(data['exang']),
            float(data['oldpeak']),
            int(data['slope']),
            int(data['ca']),
            int(data['thal'])]
    
        # Convert features to numpy array and reshape for prediction
        features = np.array(features).reshape(1, -1)
        
        # Make prediction
        prediction = model.predict(features)
        
        # Interpret the prediction
        result = "No Heart Disease" if prediction[0] == 0 else "Possibility of Heart Disease"
        
        return jsonify({'prediction': result})
    except Exception as e:
        print(f"Error during prediction: {e}")
        return jsonify({'error': str(e)}), 500


if __name__ == '__main__':
    app.run(debug=True, host='192.168.23.28', port=5000)