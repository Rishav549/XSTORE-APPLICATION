import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:xstore/core/bloc/adddata_bloc/add_data_bloc.dart';

import '../models/qrdatamodel.dart';
import '../repository/adddata.dart';
import 'listpage.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  var qrController = TextEditingController();
  var entryBy = TextEditingController();
  var remarksController = TextEditingController();
  String groupValue = "Yes";
  String dropdownvalue = 'GSM Gateway';
  var time = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Database database = Database();
    return BlocProvider(
      create: (context) => AddDataBloc(database),
      child:
          BlocConsumer<AddDataBloc, AddDataState>(listener: (context, state) {
        if (state is AddDataSuccessState) {
          Navigator.pop(context, state.qrData);
        }
        if (state is AddDataErrorState) {
          Fluttertoast.showToast(msg: state.error.message);
        }
      }, builder: (context, state) {
        if (state is AddDataLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            titleSpacing: 0,
            leadingWidth: 0,
            title: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const Listpage();
                    }));
                  },
                  icon: const Icon(Icons.arrow_back_outlined),
                  color: Colors.white,
                ),
                const Expanded(
                  child: Center(
                    child: Text(
                      'XSTORE',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 40),
                // To balance the leading IconButton width
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            heroTag: null,
            onPressed: () async {
              QrData newData = QrData(
                id: '',
                qrArray: qrController.text,
                deviceType: dropdownvalue,
                entryBy: entryBy.text,
                isActive: groupValue.toString(),
                remarks: remarksController.text,
                createdAt: DateFormat('yyyy-MM-dd HH:mm:ss').format(time),
                updatedAt: DateFormat('yyyy-MM-dd HH:mm:ss').format(time),
              );
              context
                  .read<AddDataBloc>()
                  .add(AddDataToFirebaseEvent(data: newData));
            },
            backgroundColor: Colors.deepPurpleAccent.withOpacity(0.3),
            child: const Icon(
              Icons.save,
              color: Colors.white,
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 30, right: 30, bottom: 20, top: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(top: 30, left: 10),
                          child: const Text(
                            'Enter QR_Code:',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: qrController,
                            decoration: InputDecoration(
                              hintText: 'QR Code',
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(11),
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: Colors.deepPurpleAccent
                                        .withOpacity(0.6),
                                  )),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(11),
                                borderSide: BorderSide(
                                  color:
                                      Colors.deepPurpleAccent.withOpacity(0.3),
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(top: 10, left: 10),
                          child: const Text(
                            'Enter Entry_By:',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: entryBy,
                            decoration: InputDecoration(
                              hintText: 'Entry_By',
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(11),
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: Colors.deepPurpleAccent
                                        .withOpacity(0.6),
                                  )),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(11),
                                borderSide: BorderSide(
                                  color:
                                      Colors.deepPurpleAccent.withOpacity(0.3),
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(top: 10, left: 10),
                          child: const Text(
                            'Is_Active',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Radio(
                                  value: "Yes",
                                  groupValue: groupValue,
                                  onChanged: (value) {
                                    setState(() {
                                      groupValue = value!;
                                    });
                                  }),
                              const Text(
                                "Yes",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Radio(
                                  value: "No",
                                  groupValue: groupValue,
                                  onChanged: (value) {
                                    setState(() {
                                      groupValue = value!;
                                    });
                                  }),
                              const Text(
                                "No",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Device_Type: ',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButton<String>(
                              value: dropdownvalue,
                              icon: const Icon(Icons.arrow_drop_down),
                              style: const TextStyle(color: Colors.black),
                              underline: Container(
                                height: 2,
                                color: Colors.black,
                              ),
                              items: const [
                                DropdownMenuItem<String>(
                                  value: 'ESP Gateway',
                                  child: Text('ESP Gateway'),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'GSM Gateway',
                                  child: Text('GSM Gateway'),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'Day Camera',
                                  child: Text('Day Camera'),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'Night Camera',
                                  child: Text('Night Camera'),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'Beacon',
                                  child: Text('Beacon'),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'Nano Beacon',
                                  child: Text('Nano Beacon'),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'Nurse Tag',
                                  child: Text('Nurse Tag'),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'Rfid Tag',
                                  child: Text('Rfid Tag'),
                                ),
                              ],
                              onChanged: (String? newValue) {
                                if (newValue != null) {
                                  setState(() {
                                    dropdownvalue = newValue;
                                  });
                                }
                              }),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(top: 10, left: 10),
                          child: const Text(
                            'Remarks',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: remarksController,
                            decoration: InputDecoration(
                              hintText: 'Remarks(Optional)',
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(11),
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: Colors.deepPurpleAccent
                                        .withOpacity(0.6),
                                  )),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(11),
                                borderSide: BorderSide(
                                  color:
                                      Colors.deepPurpleAccent.withOpacity(0.3),
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]),
            ),
          ),
        );
      }),
    );
  }
}
