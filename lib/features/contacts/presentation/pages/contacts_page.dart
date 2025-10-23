import 'package:flutter/material.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: Text('Contacts', style: textTheme.titleLarge)),
      body: ListView.separated(
        itemCount: 15,
        separatorBuilder: (_, _) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final name = 'Contact ${index + 1}';
          return ListTile(
            leading: CircleAvatar(child: Text(name.substring(0, 1))),
            title: Text(name, style: textTheme.titleMedium),
            subtitle: Text('Tap to chat', style: textTheme.bodySmall),
            onTap: () {},
          );
        },
      ),
    );
  }
}
