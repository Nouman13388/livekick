import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AccountSettingsPage extends StatefulWidget {
  const AccountSettingsPage({super.key});

  @override
  _AccountSettingsPageState createState() => _AccountSettingsPageState();
}

class _AccountSettingsPageState extends State<AccountSettingsPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isEditing = false;
  late User _user;
  String _username = '';
  String _email = '';
  String _password = '';

  @override
  void initState() {
    super.initState();
    _fetchUserDetails();
  }

  void _fetchUserDetails() {
    _user = FirebaseAuth.instance.currentUser!;
    setState(() {
      _username = _user.displayName ?? 'No Name';
      _email = _user.email ?? 'No Email';
    });
  }

  void _toggleEditing() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _saveSettings() async {
    try {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();

        await _user.updateDisplayName(_username);
        await _user.updateEmail(_email);

        setState(() {
          _isEditing = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Settings saved successfully!')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save settings: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Settings'),
        leading: _isEditing
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: _toggleEditing,
              )
            : null,
        actions: [
          if (!_isEditing)
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: _toggleEditing,
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Center(
                child: CircleAvatar(
                  radius: 100,
                  backgroundImage: NetworkImage(
                      _user.photoURL ?? 'https://via.placeholder.com/150'),
                ),
              ),
              const SizedBox(height: 16.0),
              if (_isEditing)
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                  ),
                  initialValue: _username,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a username';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _username = value!;
                  },
                )
              else
                ListTile(
                  title: const Text('Username'),
                  subtitle: Text(_username),
                ),
              const SizedBox(height: 16.0),
              if (_isEditing)
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  initialValue: _email,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _email = value!;
                  },
                )
              else
                ListTile(
                  title: const Text('Email'),
                  subtitle: Text(_email),
                ),
              const SizedBox(height: 16.0),
              if (_isEditing)
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _password = value!;
                  },
                )
              else
                const ListTile(
                  title: Text('Password'),
                  subtitle: Text('******'),
                ),
              const SizedBox(height: 16.0),
              if (_isEditing)
                ElevatedButton(
                  onPressed: _saveSettings,
                  child: const Text('Save Settings'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
