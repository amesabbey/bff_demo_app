import 'package:bff_demo_app/form/birthday_datepicker.dart';
import 'package:bff_demo_app/form/checkbox_list.dart';
import 'package:bff_demo_app/form/dropdown.dart';
import 'package:bff_demo_app/form/radio_button.dart';
import 'package:bff_demo_app/settings/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileQuestionnairePage extends StatelessWidget {
  const ProfileQuestionnairePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Update Profile Details'),
        ),
        body: const ProfileQuestionnaireForm());
  }
}

class ProfileQuestionnaireForm extends StatefulWidget {
  const ProfileQuestionnaireForm({super.key});

  @override
  State<ProfileQuestionnaireForm> createState() => _ProfileQuestionnaireFormState();
}

class _ProfileQuestionnaireFormState extends State<ProfileQuestionnaireForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var authProvider = context.watch<AuthProvider>();

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: 'First Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Last Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your last name';
                  }
                  return null;
                },
              ),
            ),
            const BirthdayPicker(),
            const RadioButtonQuestion(
              field: 'gender',
              questionText: 'Gender',
              options: ['Female', 'Nonbinary', 'Male'],
            ),
            const RadioButtonQuestion(
              field: 'pronouns',
              questionText: 'Preferred Pronouns',
              options: ['She/Her', 'She/They', 'They/Them', 'He/They', 'He/Him'],
            ),
            const RadioButtonQuestion(
              field: 'birth_role',
              questionText: 'Select the role that best describes you',
              options: ['Birth Giver', 'Birth Partner'],
            ),
            const RadioButtonQuestion(
              field: 'children',
              questionText: 'Do you currently have children?',
              options: ['Yes', 'No'],
            ),
            const RadioButtonQuestion(
              field: 'time_frame',
              questionText: 'How long have you been on the fertility journey?', 
              options: ['> One Year', '1-2 Years', '3-5 Years', '5+ Years'],
            ),
            const CheckboxQuestion(
              field: 'fertility_treatments_tried',
              questionText: 'Which of the following fertility treatments have you tried?',
              options: ['IUI', 'IVF', 'IVF with ICSI', 'IVF with PGS', 'IVF with PGD', 'Donor Egg', 'Donor Embryo', 'Surrogacy', 'Other'],
            ),
            const CheckboxQuestion(
              field: 'fertility_treatments_interested',
              questionText: 'Which of the following fertility treatments would you like additional information about?',
              options: ['IUI', 'IVF', 'IVF with ICSI', 'IVF with PGS', 'IVF with PGD', 'Donor Egg', 'Donor Embryo', 'Surrogacy', 'Other'],
            ),
            const RadioButtonQuestion(
              field: 'lost_pregnancy',
              questionText: 'Have you experienced a lost pregnancy?', 
              options: ['Yes', 'No'],
            ),
            const DropdownQuestion(
              field: 'state',
              questionText: 'In which state do you primarily reside?',
              initialSelectedItem: 'Option 1',
              options: ['Option 1', 'Option 2', 'Option 3'],
            ),
            const RadioButtonQuestion(
              field: 'success_stories',
              questionText: "Are you interested in hearing others' success stories?", 
              options: ['Yes', 'No'],
            ),
            getFormButtons(authProvider, context),
          ],
        ),
      ),
    );
  }

  Center getFormButtons(AuthProvider appState, BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
            child: const Text('Cancel'),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: () {
              // Validate returns true if the form is valid, or false otherwise.
              if (_formKey.currentState!.validate()) {
                // If the form is valid, display a snackbar. In the real world,
                // you'd often call a server or save the information in a database.
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Processing Data')),
                );
              }
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
