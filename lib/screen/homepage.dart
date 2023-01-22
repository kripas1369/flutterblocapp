// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutterblocapp/bloc/employeebloc.dart';
import 'package:flutterblocapp/model/employee.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void dispose() {
    _employeeBloc.dispose();
    super.dispose();
  }

  final EmployeeBloc _employeeBloc = EmployeeBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      // body: Container(child: Text("xxsbndjkbsx")),
      body: Container(
        child: StreamBuilder<List<Employee>>(
          stream: _employeeBloc.employeeListStream,
          builder:
              (BuildContext context, AsyncSnapshot<List<Employee>> snapshot) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(20.0),
                        child: Text(
                          "${snapshot.data![index].id}",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            " ${snapshot.data![index].name}",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            " ${snapshot.data?[index].salary}",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      Spacer(),
                      Container(
                        child: IconButton(
                            onPressed: () {
                              _employeeBloc.employeeIncrementSink
                                  .add(snapshot.data![index]);
                            },
                            icon: Icon(
                              Icons.thumb_up,
                              color: Colors.green,
                            )),
                      ),
                      Container(
                        child: IconButton(
                            onPressed: () {
                              _employeeBloc.employeeDecrementSink
                                  .add(snapshot.data![index]);
                            },
                            icon: Icon(
                              Icons.thumb_down,
                              color: Colors.red,
                            )),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
