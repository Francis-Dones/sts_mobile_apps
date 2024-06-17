import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sunmi_printer_plus/enums.dart';
import 'package:flutter_sunmi_printer_plus/flutter_sunmi_printer_plus.dart';
import 'package:flutter_sunmi_printer_plus/sunmi_style.dart';
import 'package:intl/intl.dart';
import 'package:sts_mobile_apps/View/login.dart';

class MainMenu extends StatefulWidget {
  final VoidCallback signOut;
  final String title;

  const MainMenu(this.signOut, {Key? key, required this.title})
      : super(key: key);

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  Future<void> accountSettings() async {}
  Future<void> aboutUs() async {}

  void _showSnackBar(String _text, bool _isSuccess) {
    if (_isSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(backgroundColor: Colors.green, content: Text(_text)));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(backgroundColor: Colors.red, content: Text(_text)));
    }
  }

  late final bool enableFeedback;

  @override
  void initState() {
    super.initState();
  }

  Future<void> signOut() async {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return const Homepage(
        title: 'home',
      );
    }));
  }

  var myMenuItems = <String>[
    'Account Settings',
    'Logout',
  ];

  void onSelect(String item) {
    switch (item) {
      case 'Account Settings':
        accountSettings();
        break;
      case 'Logout':
        signOut();
        break;
    }
  }

  void warning() {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: const Text(
            'Wanna Exit?',
            style: TextStyle(color: Colors.blue),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text(
                'No',
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text(
                'Close',
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        );
      },
    ).then((exit) {
      if (exit == null) return;

      if (exit) {
        SystemNavigator.pop();
      }
    });
  }

  void login() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Homepage(title: ''),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    var screenSize = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        warning();
        return false;
      },
      child: Scaffold(
        body: DefaultTabController(
          length: 4,
          child: Scaffold(
            appBar: AppBar(
              actions: <Widget>[
                Container(
                  color: const Color.fromARGB(108, 248, 246, 248),
                  child: PopupMenuButton<String>(
                    onSelected: onSelect,
                    itemBuilder: (BuildContext context) {
                      return myMenuItems.map((String choice) {
                        return PopupMenuItem<String>(
                          value: choice,
                          child: Text(choice),
                        );
                      }).toList();
                    },
                  ),
                ),
              ],
              title: const Padding(
                padding: EdgeInsets.only(left: 30),
                child: Text(
                  "Single Ticketing System",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              bottom: const TabBar(
                tabs: [
                  Tab(
                    icon: Icon(
                      Icons.menu_rounded,
                      color: Colors.black,
                      size: 30,
                    ),
                    text: 'Home',
                  ),
                  Tab(
                    icon: Icon(
                      Icons.airplane_ticket_sharp,
                      color: Colors.black,
                      size: 30,
                    ),
                    text: 'Ticket',
                  ),
                  Tab(
                    icon: Icon(
                      Icons.card_membership,
                      color: Colors.black,
                      size: 30,
                    ),
                    text: 'Card',
                  ),
                  Tab(
                    icon: Icon(
                      Icons.people,
                      color: Colors.black,
                      size: 30,
                    ),
                    text: 'User',
                  ),
                ],
              ),
            ),
            body: const TabBarView(
              children: [
                Center(child: Text('Homeb Tab')),
                Step1Form(),
                Center(child: Text('Card Tab')),
                Center(child: Text('User Tab')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Step1Form extends StatefulWidget {
  const Step1Form({Key? key}) : super(key: key);

  @override
  _Step1FormState createState() => _Step1FormState();
}

class _Step1FormState extends State<Step1Form> {
  int currentStep = 0;
  // Controllers for each text field
  final TextEditingController searchController = TextEditingController();
  final TextEditingController licenseNameController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController middleNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController addressHouseNumberController =
      TextEditingController();
  final TextEditingController streetSubdivisionController =
      TextEditingController();
  final TextEditingController barangayController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController provinceController = TextEditingController();
  final TextEditingController zipCodeController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  final TextEditingController expirationController = TextEditingController();
  final TextEditingController emailAddressController = TextEditingController();
  final TextEditingController remarksController = TextEditingController();

  @override
  void dispose() {
    // Dispose controllers to avoid memory leaks
    searchController.dispose();
    licenseNameController.dispose();
    firstNameController.dispose();
    middleNameController.dispose();
    lastNameController.dispose();
    addressHouseNumberController.dispose();
    streetSubdivisionController.dispose();
    barangayController.dispose();
    cityController.dispose();
    provinceController.dispose();
    zipCodeController.dispose();
    statusController.dispose();
    expirationController.dispose();
    emailAddressController.dispose();
    remarksController.dispose();
    super.dispose();
  }

  List<Step> getSteps() => [
        Step(
          title: Text(
            'Step 1',
            style: TextStyle(
              color: currentStep == 0 ? Colors.blue : Colors.grey,
            ),
          ),
          content: step1(),
          isActive: currentStep == 0,
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
        ),
        Step(
          title: Text(
            'Step 2',
            style: TextStyle(
              color: currentStep == 1 ? Colors.blue : Colors.grey,
            ),
          ),
          content: step2(),
          isActive: currentStep == 1,
          state: currentStep > 1 ? StepState.complete : StepState.indexed,
        ),
        Step(
          title: Text(
            'Step 3',
            style: TextStyle(
              color: currentStep == 2 ? Colors.blue : Colors.grey,
            ),
          ),
          content: step3(),
          isActive: currentStep == 2,
          state: currentStep > 2 ? StepState.complete : StepState.indexed,
        ),
        // Add more steps as needed
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Theme(
        data: ThemeData(
          colorScheme: const ColorScheme.light(primary: Colors.black),
        ),
        child: Stepper(
          type: StepperType.horizontal,
          steps: getSteps(),
          currentStep: currentStep,
          onStepContinue: () {
            saveTextFields();
            setState(() {
              if (currentStep < getSteps().length - 1) {
                currentStep++;
              }
            });
          },
          onStepCancel: () {
            setState(() {
              if (currentStep > 0) {
                currentStep--;
              }
            });
          },
          controlsBuilder: (context, ControlsDetails details) {
            final isLastStep = currentStep == getSteps().length - 1;
            return Container(
              margin: const EdgeInsets.only(top: 25),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 55,
                      child: ElevatedButton(
                        // ignore: sort_child_properties_last
                        child: currentStep != 0
                            ? const Text(
                                'Previous',
                                style: TextStyle(
                                  color: Colors.red, // Text color
                                  fontWeight:
                                      FontWeight.bold, // Bold font weight
                                ),
                              )
                            : const Text(
                                'Close',
                                style: TextStyle(
                                  color: Colors.red, // Text color
                                  fontWeight:
                                      FontWeight.bold, // Bold font weight
                                ),
                              ),
                        onPressed:
                            currentStep != 0 ? details.onStepCancel : () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),

                  // ignore: avoid_unnecessary_containers

                  Expanded(
                    child: SizedBox(
                      height: 55,
                      child: ElevatedButton(
                        // ignore: sort_child_properties_last
                        child: isLastStep
                            ? const Text(
                                'Submit',
                                style: TextStyle(
                                  color: Colors.white, // Text color
                                  fontWeight:
                                      FontWeight.bold, // Bold font weight
                                ),
                              )
                            : const Text(
                                'Next',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                                style: TextStyle(
                                  color: Colors.white, // Text color
                                  fontWeight:
                                      FontWeight.bold, // Bold font weight
                                ),
                              ),

                        onPressed: details.onStepContinue,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              isLastStep ? Colors.black : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget step1() {
    DateTime now = new DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd').format(now);
    return SingleChildScrollView(
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: 'Search....',
                        filled: true,
                        fillColor: const Color.fromARGB(255, 244, 239, 239),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        prefixIcon: const Icon(Icons.search),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                    height: 44,
                    width: 100, // Fixed width for the button
                    child: ElevatedButton(
                      onPressed: () async {
                        await SunmiPrinter.initPrinter();

                        await SunmiPrinter.printText(
                          content: 'Single Ticketing',
                          style: SunmiStyle(
                              align: SunmiPrintAlign.CENTER,
                              bold: true,
                              fontSize: 45),
                        );
                        await SunmiPrinter.lineWrap(2);
                        await SunmiPrinter.printText(
                          content: 'Date: $formattedDate',
                          style: SunmiStyle(
                              align: SunmiPrintAlign.CENTER,
                              bold: true,
                              fontSize: 26),
                        );
                        await SunmiPrinter.lineWrap(2);
                        await SunmiPrinter.printText(
                          content: 'Address: Bagong Silang Caloocan City',
                          style: SunmiStyle(
                              align: SunmiPrintAlign.CENTER,
                              bold: true,
                              fontSize: 26),
                        );
                        await SunmiPrinter.lineWrap(5);
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(255, 15, 16, 15)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                      child: const Text(
                        'Search',
                        style: TextStyle(
                          color: Color.fromARGB(255, 241, 241, 243),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: licenseNameController,
              decoration: const InputDecoration(
                labelText: 'License Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: firstNameController,
              decoration: const InputDecoration(
                labelText: 'First Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: middleNameController,
              decoration: const InputDecoration(
                labelText: 'Middle Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: lastNameController,
              decoration: const InputDecoration(
                labelText: 'Last Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: addressHouseNumberController,
              decoration: const InputDecoration(
                labelText: 'House Number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: streetSubdivisionController,
              decoration: const InputDecoration(
                labelText: 'Street/Subdivision',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: barangayController,
              decoration: const InputDecoration(
                labelText: 'Barangay',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: cityController,
              decoration: const InputDecoration(
                labelText: 'City',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: provinceController,
              decoration: const InputDecoration(
                labelText: 'Province',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: zipCodeController,
              decoration: const InputDecoration(
                labelText: 'Zip Code',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: statusController,
              decoration: const InputDecoration(
                labelText: 'Status',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: expirationController,
              decoration: const InputDecoration(
                labelText: 'Expiration Date',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: emailAddressController,
              decoration: const InputDecoration(
                labelText: 'Email Address',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: remarksController,
              decoration: const InputDecoration(
                labelText: 'Remarks',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget step2() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: 'Search....',
                      filled: true,
                      fillColor: const Color.fromARGB(255, 244, 239, 239),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: const Icon(Icons.search),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  height: 44,
                  width: 100, // Fixed width for the button
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 15, 16, 15)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                    child: const Text(
                      'Search',
                      style: TextStyle(
                        color: Color.fromARGB(255, 241, 241, 243),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          RichText(
            text: const TextSpan(),
          ),
          const Divider(
            height: 1,
            thickness: 1,
            indent: 3,
            endIndent: 3,
            color: Color.fromARGB(84, 96, 125, 139),
          ),
          RichText(
            text: const TextSpan(
              text: 'chassis_number: ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Colors.black,
              ),
              children: [
                TextSpan(
                  text: '?',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            height: 1,
            thickness: 1,
            indent: 3,
            endIndent: 3,
            color: Color.fromARGB(84, 96, 125, 139),
          ),
          RichText(
            text: const TextSpan(
              text: 'engine_number: ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Colors.black,
              ),
              children: [
                TextSpan(
                  text: '?',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            height: 1,
            thickness: 1,
            indent: 3,
            endIndent: 3,
            color: Color.fromARGB(84, 96, 125, 139),
          ),
          RichText(
            text: const TextSpan(
              text: 'plate_number: ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Colors.black,
              ),
              children: [
                TextSpan(
                  text: '?',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            height: 1,
            thickness: 1,
            indent: 3,
            endIndent: 3,
            color: Color.fromARGB(84, 96, 125, 139),
          ),
          RichText(
            text: const TextSpan(
              text: 'conduction sticker number: ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Colors.black,
              ),
              children: [
                TextSpan(
                  text: '?',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            height: 1,
            thickness: 1,
            indent: 3,
            endIndent: 3,
            color: Color.fromARGB(84, 96, 125, 139),
          ),
          RichText(
            text: const TextSpan(
              text: 'make: ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Colors.black,
              ),
              children: [
                TextSpan(
                  text: '?',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            height: 1,
            thickness: 1,
            indent: 3,
            endIndent: 3,
            color: Color.fromARGB(84, 96, 125, 139),
          ),
          RichText(
            text: const TextSpan(
              text: 'series: ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Colors.black,
              ),
              children: [
                TextSpan(
                  text: '?',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            height: 1,
            thickness: 1,
            indent: 3,
            endIndent: 3,
            color: Color.fromARGB(84, 96, 125, 139),
          ),
          RichText(
            text: const TextSpan(
              text: 'year_model: ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Colors.black,
              ),
              children: [
                TextSpan(
                  text: '?',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            height: 1,
            thickness: 1,
            indent: 3,
            endIndent: 3,
            color: Color.fromARGB(84, 96, 125, 139),
          ),
          RichText(
            text: const TextSpan(
              text: 'classification: ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Colors.black,
              ),
              children: [
                TextSpan(
                  text: '?',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            height: 1,
            thickness: 1,
            indent: 3,
            endIndent: 3,
            color: Color.fromARGB(84, 96, 125, 139),
          ),
          RichText(
            text: const TextSpan(
              text: 'body_type: ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Colors.black,
              ),
              children: [
                TextSpan(
                  text: '?',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            height: 1,
            thickness: 1,
            indent: 3,
            endIndent: 3,
            color: Color.fromARGB(84, 96, 125, 139),
          ),
          RichText(
            text: const TextSpan(
              text: 'last_registration_date: ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Colors.black,
              ),
              children: [
                TextSpan(
                  text: '?',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            height: 1,
            thickness: 1,
            indent: 3,
            endIndent: 3,
            color: Color.fromARGB(84, 96, 125, 139),
          ),
          RichText(
            text: const TextSpan(
              text: 'name: ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Colors.black,
              ),
              children: [
                TextSpan(
                  text: '?',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            height: 1,
            thickness: 1,
            indent: 3,
            endIndent: 3,
            color: Color.fromARGB(84, 96, 125, 139),
          ),
          RichText(
            text: const TextSpan(
              text: 'address: ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: Colors.black,
              ),
              children: [
                TextSpan(
                  text: '?',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            height: 1,
            thickness: 1,
            indent: 3,
            endIndent: 3,
            color: Color.fromARGB(84, 96, 125, 139),
          ),
        ],
      ),
    );
  }

  String? dropdownvalue;
  @override
  void initState() {
    super.initState();
    // Initialize the _isChecked list with the same length as _titles and set all values to false
    _isChecked = List<bool>.filled(_titles.length, false);
  }

  List<String> searchClientItem = ['Group 1', 'Group 2', 'Group 3'];
  final List<String> _titles = ['Violation 1', 'Violation 2', 'Violation 3'];
  late List<bool> _isChecked;

  Widget step3() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
              child: DropdownButtonFormField<String>(
                value: dropdownvalue,
                icon: const Icon(Icons.keyboard_arrow_down),
                items: searchClientItem.map((String items) {
                  return DropdownMenuItem<String>(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                decoration: const InputDecoration(
                  isDense: true,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 9.0, horizontal: 11),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 108, 108, 124),
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 0, 1, 8),
                      width: 1.0,
                    ),
                  ),
                  hintText: "Select...",
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownvalue = newValue!;
                  });
                  print(dropdownvalue);
                },
              ),
            ),
            SizedBox(
              height: 200, // Specify a height for the ListView.builder
              child: ListView.builder(
                itemCount: _titles.length,
                itemBuilder: (BuildContext context, int index) {
                  return CheckboxListTile(
                    title: Text(_titles[index]),
                    value: _isChecked[index],
                    onChanged: (bool? value) {
                      setState(() {
                        _isChecked[index] = value!;
                        print(_titles[index]);
                      });
                    },
                    controlAffinity: ListTileControlAffinity
                        .leading, // Move controlAffinity here
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  // Method to save the entered text in all text fields
  void saveTextFields() {
    // Store the entered text in each controller
    searchController.text;
    licenseNameController.text;
    firstNameController.text;
    middleNameController.text;
    lastNameController.text;
    addressHouseNumberController.text;
    streetSubdivisionController.text;
    barangayController.text;
    cityController.text;
    provinceController.text;
    zipCodeController.text;
    statusController.text;
    expirationController.text;
    emailAddressController.text;
    remarksController.text;
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kitty Burger',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: MainMenu(
        () {
          print("User signed out");
        },
        title: 'Main Menu',
      ),
    );
  }
}
