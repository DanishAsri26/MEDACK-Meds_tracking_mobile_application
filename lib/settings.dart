import 'package:flutter/material.dart';
import 'package:lab_5/login.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // State variables to hold user data - you will fetch these from Firebase
  String _username = 'Michael';
  String _email = 'michael@example.com';
  String _phoneNumber = '+60 12-347 37356';

  final Color darkGreen = Color(0xFF1B5E20);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildProfilePictureEditor(),
            SizedBox(height: 30),
            Text(
              'Account Information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: darkGreen),
            ),
            Divider(thickness: 1),
            _buildEditableInfoTile(
              icon: Icons.person,
              title: 'Username',
              value: _username,
              onTap: () => _showEditDialog('Username', _username, (newValue) {
                setState(() => _username = newValue);
                // Add Firebase update logic here
              }),
            ),
            _buildEditableInfoTile(
              icon: Icons.email,
              title: 'Email',
              value: _email,
              onTap: () => _showEditDialog('Email', _email, (newValue) {
                setState(() => _email = newValue);
                // Add Firebase update logic here
              }),
            ),
            _buildEditableInfoTile(
              icon: Icons.phone,
              title: 'Phone Number',
              value: _phoneNumber,
              onTap: () => _showEditDialog('Phone Number', _phoneNumber, (newValue) {
                setState(() => _phoneNumber = newValue);
                // Add Firebase update logic here
              }),
            ),
            SizedBox(height: 30),
            Text(
              'Security',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: darkGreen),
            ),
            Divider(thickness: 1),
            _buildSecurityOption(title: 'Change Password', onTap: () {
              // Navigate to a dedicated change password screen or show a dialog
            }),
            SizedBox(height: 50),
            _buildLogoutButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildProfilePictureEditor() {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/picture/avatar.png'), // Placeholder
            backgroundColor: Colors.grey[200],
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                // Add image picker logic here
              },
              child: CircleAvatar(
                radius: 18,
                backgroundColor: darkGreen,
                child: Icon(Icons.edit, size: 20, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditableInfoTile({
    required IconData icon,
    required String title,
    required String value,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: darkGreen),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(value, style: TextStyle(color: Colors.grey[600])),
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
    );
  }

  Widget _buildSecurityOption({required String title, required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(Icons.lock, color: darkGreen),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.w600)),
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
    );
  }

  Widget _buildLogoutButton() {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LoginPage()),
          (Route<dynamic> route) => false,
        );
      },
      icon: Icon(Icons.logout),
      label: Text('Logout'),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red[700],
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  void _showEditDialog(String field, String currentValue, Function(String) onSave) {
    final controller = TextEditingController(text: currentValue);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit $field'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Enter new $field',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              onSave(controller.text);
              Navigator.pop(context);
            },
            child: Text('Save'),
            style: ElevatedButton.styleFrom(backgroundColor: darkGreen),
          ),
        ],
      ),
    );
  }
}
