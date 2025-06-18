import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Predict extends StatefulWidget {
  const Predict({super.key});

  @override
  State<Predict> createState() => _PredictState();
}

class _PredictState extends State<Predict> {
  final _formKey = GlobalKey<FormState>();
  String? _prediction;
  bool _isLoading = false;
  final Map<String, dynamic> _formData = {
    'age': '',
    'sex': '0',
    'cp': '0',
    'trestbps': '',
    'chol': '',
    'fbs': '0',
    'restecg': '0',
    'thalach': '',
    'exang': '0',
    'oldpeak': '',
    'slope': '0',
    'ca': '0',
    'thal': '0',
  };

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() => _isLoading = true);

      debugPrint('Sending data: ${jsonEncode(_formData)}');

      try {
        final response = await http.post(
          Uri.parse('https://heart-disease-prediction-h1wv.onrender.com/predict'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(_formData),
        );

        debugPrint('Response status: ${response.statusCode}');
        debugPrint('Response body: ${response.body}');

        if (response.statusCode == 200) {
          final result = jsonDecode(response.body);
          setState(() => _prediction = result['prediction']);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Server error: ${response.statusCode}')),
          );
        }
      } catch (e) {
        debugPrint('Error: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Connection error: $e')),
        );
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Heart Disease Prediction"),
        backgroundColor: Colors.pink,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Image.asset('assets/heart.png', height: 100),
                        const SizedBox(height: 20),
                        const Text(
                          'Enter Your Health Details',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.pink,
                          ),
                        ),
                        const SizedBox(height: 20),
                        _buildTextField('Age', 'age', TextInputType.number),
                        const SizedBox(height: 10),
                        _buildDropdownField(
                            'Gender', 'sex', {'0': 'Female', '1': 'Male'}),
                        const SizedBox(height: 10),
                        _buildDropdownField('Chest Pain Type', 'cp', {
                          '0': 'Typical Angina',
                          '1': 'Atypical Angina',
                          '2': 'Non-anginal Pain',
                          '3': 'Asymptomatic',
                        }),
                        const SizedBox(height: 10),
                        _buildTextField('Resting Blood Pressure', 'trestbps',
                            TextInputType.number),
                        const SizedBox(height: 10),
                        _buildTextField(
                            'Cholesterol', 'chol', TextInputType.number),
                        const SizedBox(height: 10),
                        _buildDropdownField('Fasting Blood Sugar', 'fbs', {
                          '0': '≤ 120 mg/dl',
                          '1': '> 120 mg/dl',
                        }),
                        const SizedBox(height: 10),
                        _buildDropdownField('Resting ECG', 'restecg', {
                          '0': 'Normal',
                          '1': 'ST-T Wave Abnormality',
                          '2': 'Left Ventricular Hypertrophy',
                        }),
                        const SizedBox(height: 10),
                        _buildTextField('Maximum Heart Rate', 'thalach',
                            TextInputType.number),
                        const SizedBox(height: 10),
                        _buildDropdownField(
                            'Exercise Induced Angina', 'exang', {
                          '0': 'No',
                          '1': 'Yes',
                        }),
                        const SizedBox(height: 10),
                        _buildTextField(
                            'ST Depression', 'oldpeak', TextInputType.number),
                        const SizedBox(height: 10),
                        _buildDropdownField('Slope', 'slope', {
                          '0': 'Upsloping',
                          '1': 'Flat',
                          '2': 'Downsloping',
                        }),
                        const SizedBox(height: 10),
                        _buildDropdownField('Number of Vessels', 'ca', {
                          '0': '0',
                          '1': '1',
                          '2': '2',
                          '3': '3',
                        }),
                        const SizedBox(height: 10),
                        _buildDropdownField('Thalassemia', 'thal', {
                          '0': 'Normal',
                          '1': 'Fixed Defect',
                          '2': 'Reversible Defect',
                        }),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                if (_isLoading)
                  const CircularProgressIndicator()
                else
                  ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 50,
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Predict',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                if (_prediction != null)
                  Card(
                    color: _prediction!.contains('No')
                        ? Colors.green[100]
                        : Colors.red[100],
                    margin: const EdgeInsets.only(top: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Icon(
                            _prediction!.contains('No')
                                ? Icons.favorite
                                : Icons.warning,
                            size: 50,
                            color: _prediction!.contains('No')
                                ? Colors.green[900]
                                : Colors.red[900],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            _prediction!,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: _prediction!.contains('No')
                                  ? Colors.green[900]
                                  : Colors.red[900],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      String label, String field, TextInputType keyboardType) {
    return TextFormField(
      decoration: _buildInputDecoration(label),
      keyboardType: keyboardType,
      validator: (value) => value!.isEmpty ? 'Please enter $label' : null,
      onSaved: (value) => _formData[field] = value,
    );
  }

  InputDecoration _buildInputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      filled: true,
      fillColor: Colors.grey[100],
    );
  }

  Widget _buildDropdownField(
      String label, String field, Map<String, String> options) {
    return DropdownButtonFormField<String>(
      decoration: _buildInputDecoration(label),
      value: _formData[field],
      items: options.entries
          .map((e) => DropdownMenuItem(
                value: e.key,
                child: Text(e.value),
              ))
          .toList(),
      onChanged: (value) => setState(() => _formData[field] = value),
    );
  }
}
