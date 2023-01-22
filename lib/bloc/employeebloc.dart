///TODO: import
///TODO: List of employee

///TODO: Stream Controllers

///TODO: Stream Sink getter

///TODO: Constructor -add data; listen to changes

///TODO: Core functions

///TODO: dispose

import 'dart:async';
import 'package:flutterblocapp/model/employee.dart';

class EmployeeBloc {
  ///sink to add in pipe
  ///stream to get data from pipe
  ///by pipe i means data flow

  List<Employee> _employeeList = [
    Employee(1, "kripas khatiwada", 123.90),
    Employee(2, "sagun khatiwada", 400.90),
    Employee(3, "raja khatiwada", 300.90),
  ];
  final _employeeListStreamController = StreamController<List<Employee>>();

  ///for inc and dec
  final _employeeSalaryIncrementStreamController = StreamController<Employee>();
  final _employeeSalaryDecrementStreamController = StreamController<Employee>();

  /// getters
  Stream<List<Employee>> get employeeListStream =>
      _employeeListStreamController.stream;

  StreamSink<List<Employee>> get employeeListSink =>
      _employeeListStreamController.sink;

  StreamSink<Employee> get employeeIncrementSink =>
      _employeeSalaryIncrementStreamController.sink;

  StreamSink<Employee> get employeeDecrementSink =>
      _employeeSalaryDecrementStreamController.sink;

  ///TODO: Constructor -add data; listen to changes

  EmployeeBloc() {
    _employeeListStreamController.add(_employeeList);
    _employeeSalaryIncrementStreamController.stream.listen(_incrementSalary);
    _employeeSalaryDecrementStreamController.stream.listen(_decrementSalary);
  }

  ///TODO: Core functions

  _incrementSalary(Employee employee) {
    double salary = employee.salary;
    double incrementSalary = salary * 20 / 100;
    _employeeList[employee.id - 1].salary = salary + incrementSalary;
    employeeListSink.add(_employeeList);
  }

  _decrementSalary(Employee employee) {
    double salary = employee.salary;
    double decrementSalary = salary * 20 / 100;
    _employeeList[employee.id - 1].salary = salary - decrementSalary;
    employeeListSink.add(_employeeList);
  }

  ///TODO: dispose
  void dispose() {
    _employeeListStreamController.close();
    _employeeSalaryDecrementStreamController.close();
    _employeeSalaryIncrementStreamController.close();
  }
}
