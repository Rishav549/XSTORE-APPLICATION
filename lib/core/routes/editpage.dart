import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/updatedata_bloc/update_data_bloc.dart';
import '../repository/updatedata.dart';
import 'listpage.dart';

class EditPage extends StatefulWidget {
  final String qr;
  final String entryBy;
  final String initialDeviceType;
  final String id;

  const EditPage({
    required this.qr,
    required this.entryBy,
    required this.initialDeviceType,
    required this.id,
    super.key,
  });

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  var remarks = TextEditingController();
  late String dropdownvalue;
  bool additionalButton = true;

  @override
  void initState() {
    super.initState();
    dropdownvalue = widget.initialDeviceType;
  }

  @override
  Widget build(BuildContext context) {
    final UpdateData updateData = UpdateData();
    return BlocProvider(
        create: (context) => UpdateDataBloc(updateData),
        child: BlocConsumer<UpdateDataBloc, UpdateDataState>(
            listener: (context, state) {
          if (state is UpdateLoadingState) {
          } else if (state is UpdateLoadedState) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text("Device type updated successfully!")),
            );
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => const Listpage()));
          } else if (state is UpdateErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error.message)),
            );
          }
        }, builder: (context, state) {
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
                ],
              ),
            ),
            floatingActionButton: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (!additionalButton)
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FloatingActionButton(
                          heroTag: null,
                          onPressed: () {
                            _updateDeviceType(context);
                          },
                          backgroundColor:
                              Colors.deepPurpleAccent.withOpacity(0.3),
                          child: const Icon(Icons.save, color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FloatingActionButton(
                          heroTag: null,
                          onPressed: () {
                            setState(() {
                              additionalButton = true;
                            });
                          },
                          backgroundColor:
                              Colors.deepPurpleAccent.withOpacity(0.3),
                          child: const Icon(Icons.cancel, color: Colors.white),
                        ),
                      ),
                    ],
                  )
                else
                  FloatingActionButton(
                    heroTag: null,
                    onPressed: () {
                      setState(() {
                        additionalButton = false;
                      });
                    },
                    backgroundColor: Colors.deepPurpleAccent.withOpacity(0.3),
                    child: const Icon(Icons.edit, color: Colors.white),
                  ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'QR_Code: ${widget.qr}',
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Entry_BY: ${widget.entryBy}',
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Device_Type: ',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
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
                              },
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
                              controller: remarks,
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
                                    color: Colors.deepPurpleAccent
                                        .withOpacity(0.3),
                                    width: 2,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }));
  }

  void _updateDeviceType(BuildContext context) {
    context.read<UpdateDataBloc>().add(
          UpdateDeviceTypeEvent(
            id: widget.id,
            deviceType: dropdownvalue,
          ),
        );
  }
}
