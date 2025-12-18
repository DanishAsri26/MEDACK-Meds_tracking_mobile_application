import 'package:flutter/material.dart';
import 'package:lab_5/scanner.dart';
import 'package:lab_5/medsInfo.dart';
import 'package:lab_5/profile.dart';

class Home_patient extends StatefulWidget {
  @override
  _Home_patientState createState() => _Home_patientState();
}

class _Home_patientState extends State<Home_patient> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    HomeTab(),
    Scanner(),
    Medsinfo(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.lightGreen,
        selectedItemColor: Colors.white,
        selectedFontSize: 19.0,
        unselectedFontSize: 14.0,
        iconSize: 30.0,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt),
            label: 'Scanner',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_services_rounded),
            label: 'Meds info',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

class HomeTab extends StatefulWidget {
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final List<bool> _isChecked = [false, false, false, false];
  final List<Map<String, String>> _prescriptions = [
    {'medicine': 'M1', 'time': '08:00 AM', 'dose': '1 tablet'},
    {'medicine': 'M2', 'time': '12:00 PM', 'dose': '2 tablets'},
    {'medicine': 'M3', 'time': '04:00 PM', 'dose': '1 tablet'},
    {'medicine': 'M4', 'time': '08:00 PM', 'dose': '2 tablets'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Handle notification icon press
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 45,
                    backgroundImage: AssetImage('assets/picture/avatar.png'),
                    backgroundColor: Colors.grey[300],
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome',
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        'Michael', // Replace with actual patient name
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 24),
              Text(
                "Today's Prescription",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _prescriptions.length,
                itemBuilder: (context, index) {
                  return _buildPrescriptionItem(
                    _prescriptions[index]['medicine']!,
                    _prescriptions[index]['time']!,
                    _prescriptions[index]['dose']!,
                    index,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPrescriptionItem(
      String medicine, String time, String dose, int index) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(medicine, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('Time: $time, Dose: $dose'),
        trailing: Checkbox(
          value: _isChecked[index],
          onChanged: (bool? value) {
            setState(() {
              _isChecked[index] = value!;
            });
          },
        ),
      ),
    );
  }
}
