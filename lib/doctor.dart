import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Doctor_info extends StatefulWidget {
  const Doctor_info({Key? key}) : super(key: key);

  @override
  State<Doctor_info> createState() => _Doctor_infoState();
}

class _Doctor_infoState extends State<Doctor_info> {
  final url = "https://khar.hindujahospital.com/doctors/ameya-udyavar/";
  final url1 = "https://drsureshadvani.in/make-appointment/";
  final url2 = "https://tmc.gov.in/index.php/en/";
  final url3 =
      "https://www.kokilabenhospital.com/professionals/sandeepgoyle.html";
  final url4 = "https://www.mocindia.co.in/our-team/dr-vashistha-maniar";
  final url5 = "https://www.mocindia.co.in/our-team/dr-pritam-alaskar";
  final url6 =
      "https://www.apollo247.com/doctors/dr-rakesh-rattan-jalali-c4948d93-3a09-420c-98c6-ee5fc2b61ed5";
  final url7 = "https://myacare.com/doctor/dr-rajeev-kumar-india";
  final url8 = "https://www.hcgoncology.com/doctors/dr-ramesh-s-bilimagga/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Doctors"),
        backgroundColor: Colors.pink,
        leading: const Icon(Icons.health_and_safety),
        elevation: 10,
      ),
      body: SingleChildScrollView(
        child: Container(
            child: Column(
          children: [
            Card(
              margin: const EdgeInsets.fromLTRB(25, 25, 25, 25),
              elevation: 5,
              child: Column(
                children: <Widget>[
                  SizedBox(
                      width: 200,
                      height: 150,
                      child: Image.asset("assets/ameya-udaywar.png")),
                  const SizedBox(height: 10),
                  const Text(
                    'Dr. Ameya Udyavar',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    ' Medical Cardiologist',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Icon(Icons.location_on, size: 14),
                      const SizedBox(width: 5),
                      Text(
                        'Hinduja Hospital,Mumbai',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      launch(url);
                    },
                    child: const Text("For Appointment"),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Card(
              margin: const EdgeInsets.fromLTRB(25, 25, 25, 25),
              elevation: 5,
              child: Column(
                children: <Widget>[
                  SizedBox(
                      width: 200,
                      height: 150,
                      child: Image.asset("assets/Dr.suresh_advani.jpg")),
                  const SizedBox(height: 10),
                  const Text(
                    'Dr.Suresh Advani',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Medical Cardiology',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Icon(Icons.location_on, size: 14),
                      const SizedBox(width: 5),
                      Text(
                        'Jashlok Hospital,Mumbai',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      launch(url1);
                    },
                    child: const Text("For Appointment"),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Card(
              margin: const EdgeInsets.fromLTRB(25, 25, 25, 25),
              elevation: 5,
              child: Column(
                children: <Widget>[
                  SizedBox(
                      width: 200,
                      height: 150,
                      child: Image.asset("assets/Dr.kumar Prabhash.webp")),
                  const SizedBox(height: 10),
                  const Text(
                    'Dr.Kumar Prabhash',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Medical Cardiology',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Icon(Icons.location_on, size: 14),
                      const SizedBox(width: 5),
                      Text(
                        'Tata Memorial Hospital,Mumbai',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      launch(url2);
                    },
                    child: const Text("For Appointment"),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Card(
              margin: const EdgeInsets.fromLTRB(25, 25, 25, 25),
              elevation: 5,
              child: Column(
                children: <Widget>[
                  SizedBox(
                      width: 200,
                      height: 150,
                      child: Image.asset("assets/Dr.Sandeep Goyle.webp")),
                  const SizedBox(height: 10),
                  const Text(
                    'Dr.Sandeep Goyle',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Medical Cardiology',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Icon(Icons.location_on, size: 14),
                      const SizedBox(width: 5),
                      Text(
                        'Kokilaben Dhirubhai Ambani Hospital,\nMumbai',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      launch(url3);
                    },
                    child: const Text("For Appointment"),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Card(
              margin: const EdgeInsets.fromLTRB(25, 25, 25, 25),
              elevation: 5,
              child: Column(
                children: <Widget>[
                  SizedBox(
                      width: 200,
                      height: 150,
                      child: Image.asset("assets/dr.Vashistha Maniar.webp")),
                  const SizedBox(height: 10),
                  const Text(
                    'Dr.Vashistha Maniar',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Medical Cardiology',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Icon(Icons.location_on, size: 14),
                      const SizedBox(width: 5),
                      Text(
                        'Mumbai Oncocare Center,Mumbai',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      launch(url4);
                    },
                    child: const Text("For Appointment"),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Card(
              margin: const EdgeInsets.fromLTRB(25, 25, 25, 25),
              elevation: 5,
              child: Column(
                children: <Widget>[
                  SizedBox(
                      width: 200,
                      height: 150,
                      child: Image.asset("assets/Dr. Pritam Kalashar.jpg")),
                  const SizedBox(height: 10),
                  const Text(
                    'Dr. Pritam Kalashar',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Medical Cardiology',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Icon(Icons.location_on, size: 14),
                      const SizedBox(width: 5),
                      Text(
                        'Mumbai Cardiologist,Mumbai',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      launch(url5);
                    },
                    child: const Text("For Appointment"),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Card(
              margin: const EdgeInsets.fromLTRB(25, 25, 25, 25),
              elevation: 5,
              child: Column(
                children: <Widget>[
                  SizedBox(
                      width: 200,
                      height: 150,
                      child: Image.asset("assets/dr-rakesh-jalali.jpg")),
                  const SizedBox(height: 10),
                  const Text(
                    'Dr. Rakesh Jalali',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Medical Cardiology',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Icon(Icons.location_on, size: 14),
                      const SizedBox(width: 5),
                      Text(
                        'Apollo Proton Cardiology Centre,Mumbai',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      launch(url6);
                    },
                    child: const Text("For Appointment"),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Card(
              margin: const EdgeInsets.fromLTRB(25, 25, 25, 25),
              elevation: 5,
              child: Column(
                children: <Widget>[
                  SizedBox(
                      width: 200,
                      height: 150,
                      child: Image.asset("assets/Dr.Rajeev-Kumar.jpg")),
                  const SizedBox(height: 10),
                  const Text(
                    'Dr.Rajeev Kumar',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Medical Cardiology',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Icon(Icons.location_on, size: 14),
                      const SizedBox(width: 5),
                      Text(
                        'Asian Cancer Instiute ,Mumbai',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      launch(url7);
                    },
                    child: const Text("For Appointment"),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Card(
              margin: const EdgeInsets.fromLTRB(25, 25, 25, 25),
              elevation: 5,
              child: Column(
                children: <Widget>[
                  SizedBox(
                      width: 200,
                      height: 150,
                      child: Image.asset("assets/Dr.Ramesh-Bilimagga.jpg")),
                  const SizedBox(height: 10),
                  const Text(
                    'Dr. Ramesh S. Bilimagga',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Medical Cardiology',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Icon(Icons.location_on, size: 14),
                      const SizedBox(width: 5),
                      Text(
                        'Global Hospital ,Mumbai',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      launch(url8);
                    },
                    child: const Text("For Appointment"),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Card(
              margin: const EdgeInsets.fromLTRB(25, 25, 25, 25),
              elevation: 5,
              child: Column(
                children: <Widget>[
                  SizedBox(
                      width: 200,
                      height: 150,
                      child: Image.asset("assets/Dr. Amit Joshi .png")),
                  const SizedBox(height: 10),
                  const Text(
                    'Dr.Amit Joshi',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Medical Cardiology',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Icon(Icons.location_on, size: 14),
                      const SizedBox(width: 5),
                      Text(
                        'Tata Memorial Hospital,Mumbai',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      launch(url2);
                    },
                    child: const Text("For Appointment"),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        )),
      ),
    );
  }
}
