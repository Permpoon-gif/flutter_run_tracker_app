// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_run_tracker_app/models/Run.dart';
import 'package:flutter_run_tracker_app/services/supabase_services.dart';
import 'package:flutter_run_tracker_app/views/add_run_ui.dart';
import 'package:flutter_run_tracker_app/views/update_delete_run_ui.dart';

class ShowAllRunUi extends StatefulWidget {
  const ShowAllRunUi({super.key});

  @override
  State<ShowAllRunUi> createState() => _ShowAllRunUiState();
}

class _ShowAllRunUiState extends State<ShowAllRunUi> {
  List<Run> runs = [];

  final service = SupabaseService();

  void loadAllRun() async {

    final data = await service.getAllRun();

    setState(() {
      runs = data;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadAllRun();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          'Run Tracker',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 40),
            Image.asset(
              'assets/images/RUN.png',
              width: 180,
              height: 180,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
          Expanded(
            child: ListView.builder(

              itemCount: runs.length,

              itemBuilder: (context, index) {
                return ListTile(
                  onTap: () {

                  },
                  leading: Image.asset(
                    'assets/images/boy.png',
                  ),
                  trailing: Icon(
                    Icons.info,
                    color: Colors.red,
                  ),
                  title: Text(
                    'วิ่งที่ไหน ${runs[index].runWhere}',),
                  subtitle: Text(
                    'วิ่งกับใคร ${runs[index].runPerson} ระยะทาง ${runs[index].runDistance} กม.',
                  ),
                );  
              },
              
            ))
          ],
        ),
      ),
              
                
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddRunUi()
          ),
          ).then((value) {
            //กลับมาหน่าแล้วจะให้ทำอะไร
            //เรียก 
            loadAllRun();
          });
        },
        backgroundColor: Colors.red,
        child: Icon(
          Icons.add,
          color: Colors.white,
          ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
