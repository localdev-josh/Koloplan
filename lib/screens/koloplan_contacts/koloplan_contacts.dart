import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_svg/svg.dart';
import 'package:koloplan/styles/colors.dart';
import 'package:koloplan/utils/margin.dart';
import 'package:koloplan/utils/strings.dart';

class ContactList extends StatefulWidget {
  @override
  _ContactListState createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  List<Contact> _contacts;
  bool _permissionDenied = false;

  @override
  void initState() {
    super.initState();
    _fetchContacts();
  }

  Future _fetchContacts() async {
    if (!await FlutterContacts.requestPermission(readonly: true)) {
      setState(() => _permissionDenied = true);
    } else {
      final contacts = await FlutterContacts.getContacts();
      setState(() => _contacts = contacts);
    }
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.kBlack300,
          brightness: Brightness.dark,
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: IntrinsicWidth(
              child: Container(
                margin: EdgeInsets.only(left: 15),
                color: Colors.transparent,
                child: Row(
                  children: [
                    SvgPicture.asset("assets/icons/arrow_right.svg",
                    width: 13,),
                  ],
                ),
              ),
            ),
          ),
        ),
          body: SafeArea(
            child: _body(),
          )));

  Widget _body() {
    if (_permissionDenied) return Center(child: Text('Permission denied'));
    if (_contacts == null) return Center(child: CircularProgressIndicator());
    return ListView.builder(
        itemCount: _contacts.length,
        itemBuilder: (context, i) => ListTile(
            title: Text(_contacts[i].displayName),
            onTap: () async {
              final fullContact =
              await FlutterContacts.getContact(_contacts[i].id);
              await Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => ContactPage(fullContact)));
            }));
  }
}

class ContactPage extends StatelessWidget {
  final Contact contact;
  ContactPage(this.contact);

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: Text(contact.displayName)),
      body: Column(children: [
        Text('First name: ${contact.name.first}'),
        Text('Last name: ${contact.name.last}'),
        Text(
            'Phone number: ${contact.phones.isNotEmpty ? contact.phones.first.number : '(none)'}'),
        Text(
            'Email address: ${contact.emails.isNotEmpty ? contact.emails.first.address : '(none)'}'),
      ]));
}