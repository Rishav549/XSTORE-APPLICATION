import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xstore/core/bloc/listdata_bloc/list_data_bloc.dart';
import 'package:xstore/core/models/qrdatamodel.dart';
import 'addpage.dart';
import 'editpage.dart';

class Listpage extends StatefulWidget {
  const Listpage({super.key});

  @override
  State<Listpage> createState() => _ListpageState();
}

class _ListpageState extends State<Listpage> {
  final scrollcontroller = ScrollController();

  void _scrollListener() {
    if (scrollcontroller.position.pixels ==
        scrollcontroller.position.maxScrollExtent) {
      context.read<ListDataBloc>().add(NextListDataEvent());
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<ListDataBloc>().add(InitialListDataEvent());
    scrollcontroller.addListener((_scrollListener));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        titleSpacing: 0.0,
        leadingWidth: 0,
        title: const Align(
          alignment: Alignment.center,
          child: Text(
            'XSTORE',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        leading: Container(),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        onPressed: () async {
          final QrData? data = await Navigator.push(context,
              MaterialPageRoute(builder: (context) {
            return const AddPage();
          }));
          if (data != null && context.mounted) {
            context.read<ListDataBloc>().add(NewEntryAddEvent(data: data));
          }
        },
        backgroundColor: Colors.deepPurpleAccent.withOpacity(0.3),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: BlocConsumer<ListDataBloc, ListDataStates>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is ListLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ListLoadedState) {
            final dataList = state.dataList;
            return ListView.builder(
              controller: scrollcontroller,
              itemCount: dataList.length,
              itemBuilder: (context, index) {
                final data = dataList[index];
                String initialLetter =
                    data.deviceType.substring(0, 1).toUpperCase();
                return Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          children: [
                            Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      radius: 25,
                                      child: Text(initialLetter),
                                    ),
                                    title: Text(
                                      data.qrArray,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(data.deviceType,
                                        style: const TextStyle(fontSize: 12)),
                                    trailing: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data.entryBy,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          data.updatedAt,
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                    onTap: () async {
                                      await Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return EditPage(
                                            qr: data.qrArray,
                                            entryBy: data.entryBy,
                                            initialDeviceType: data.deviceType,
                                            id: data.id);
                                      }));
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (state is ListErrorState) {
            return Center(child: Text(state.error.message));
          }
          return const Center(child: Text('No Data Available'));
        },
      ),
    );
  }
}
