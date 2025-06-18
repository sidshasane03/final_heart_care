# Heart Disease Prediction Web Application

This project is a web application for predicting heart disease using machine learning. It utilizes a trained model to provide predictions based on user input.

## Project Structure

```
heart-disease-prediction
├── app.py
├── templates
│   ├── index.html
├── static
│   ├── css
│       └── styles.css
├── model
│   └── model_joblib_heart
├── requirements.txt
└── README.md
```

### File Descriptions

- **app.py**: The main Flask application that sets up the server, handles routing, and connects the UI with the machine learning model for heart disease prediction.

- **templates/index.html**: Contains the HTML structure for the user interface, including forms for user input and displaying prediction results.

- **static/css/styles.css**: Contains the CSS styles for the HTML page, defining the layout, colors, fonts, and overall appearance of the user interface.

- **model/model_joblib_heart**: The saved machine learning model in joblib format, used for making predictions based on user input.

- **requirements.txt**: Lists the Python dependencies required for the project, including Flask and any other libraries needed for the application to run.

- **README.md**: Documentation for the project, including instructions on how to set up and run the application.

### Instructions to Run the Project

1. **Clone the Repository**: If the project is hosted on a version control system, clone it to your local machine.

2. **Navigate to the Project Directory**: Open a terminal and navigate to the `heart-disease-prediction` directory.

3. **Create a Virtual Environment** (optional but recommended):
   - Run `python -m venv venv` to create a virtual environment.
   - Activate the virtual environment:
     - On Windows: `venv\Scripts\activate`
     - On macOS/Linux: `source venv/bin/activate`

4. **Install Dependencies**: Run `pip install -r requirements.txt` to install the required libraries.

5. **Run the Flask Application**: Execute `python app.py` in the terminal. This will start the Flask server.

6. **Access the Application**: Open a web browser and go to `http://127.0.0.1:5000/` to access the heart disease prediction web application.

7. **Input Data**: Fill in the required fields in the form and submit to get predictions.

8. **Stop the Server**: To stop the server, go back to the terminal and press `Ctrl + C`.