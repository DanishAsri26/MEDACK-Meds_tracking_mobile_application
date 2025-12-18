import 'package:flutter/material.dart';
import 'package:lab_5/settings.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              CircleAvatar(
                radius: 45,
                backgroundImage: AssetImage('assets/picture/avatar.png'),
                backgroundColor: Colors.grey[300],
              ),
              SizedBox(height: 20),
              Text(
                'Patient Name',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                'patient.email@example.com',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              SizedBox(height: 30),
              _buildProfileDetailItem(Icons.phone, 'Phone Number', '+60 12-347 37356'),
              Divider(),
              _buildProfileDetailItem(Icons.calendar_today, 'Date of Birth', 'January 1, 1970'),
              Divider(),
              _buildProfileDetailItem(Icons.location_on, 'Address', '123 Health St, Wellness City'),
              Divider(),
              SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: () {
                  // Handle adding a family member
                },
                icon: Icon(Icons.group_add),
                label: Text('Add Family Member'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileDetailItem(IconData icon, String title, String subtitle) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle, style: TextStyle(fontSize: 16)),
    );
  }
}
