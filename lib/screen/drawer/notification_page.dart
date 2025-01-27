import 'package:flutter/material.dart';

class NotificationSettingsPage extends StatefulWidget {
  @override
  _NotificationSettingsPageState createState() =>
      _NotificationSettingsPageState();
}

class _NotificationSettingsPageState extends State<NotificationSettingsPage> {
  // States for switches
  bool generalNotification = true;
  bool sound = false;
  bool callSound = true;
  bool vibration = false;
  bool specialOffers = true;
  bool payment = true;
  bool promo = false;
  bool discount = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Paramètres Notifications"),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          _buildSwitch("Notification Général", generalNotification, (value) {
            setState(() => generalNotification = value);
          }),
          _buildSwitch("Son", sound, (value) {
            setState(() => sound = value);
          }),
          _buildSwitch("Son Appel", callSound, (value) {
            setState(() => callSound = value);
          }),
          _buildSwitch("Vibration", vibration, (value) {
            setState(() => vibration = value);
          }),
          _buildSwitch("Offres Spéciales", specialOffers, (value) {
            setState(() => specialOffers = value);
          }),
          _buildSwitch("Payement", payment, (value) {
            setState(() => payment = value);
          }),
          _buildSwitch("Promo", promo, (value) {
            setState(() => promo = value);
          }),
          _buildSwitch("Remise", discount, (value) {
            setState(() => discount = value);
          }),
        ],
      ),
    );
  }

  Widget _buildSwitch(String title, bool value, ValueChanged<bool> onChanged) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: onChanged,
    );
  }
}