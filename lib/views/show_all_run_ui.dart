import 'package:flutter/material.dart';
import 'package:flutter_run_tracker_app/models/run.dart';
import 'package:flutter_run_tracker_app/services/supabase_services.dart';
import 'package:flutter_run_tracker_app/views/add_run_ui.dart';
import 'package:flutter_run_tracker_app/views/update_delete_run_ui.dart';

class ShowAllRunUi extends StatefulWidget {
  const ShowAllRunUi({super.key});

  @override
  State<ShowAllRunUi> createState() => _ShowAllRunUiState();
}

class _ShowAllRunUiState extends State<ShowAllRunUi> {
  List<Run> runs = [];// 🔥 ตัวแปรเก็บข้อมูล

  final service = SupabaseService();

void loadAllRun() async {
    final data = await service.getAllRun();

    setState(() {
      runs = data;
    });
  }
@override
  void initState() {
    super.initState();
    loadAllRun();
  }


  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          'กินกัน LOG',
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
                //สร้างหน้าตา
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(
                      left: 30,
                      right: 30,
                      top: 5,
                      bottom: 5
                    ),
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>UpdateDeleteRunUi(
                              //ส่งข้อมูลไปหน้า UpdateDelRunUi
                              run: runs[index],
                            ),
                          ),
                        ).then((value) {
                          //กลับมาหน่าแล้วจะให้ทำอะไร
                          //เรียก 
                          loadAllRun();
                        });
                        
                      },
                      leading: Image.asset(
                        'assets/images/RUN.png',
                      ),
                      trailing: Icon(
                        Icons.info,
                        color: Colors.red,
                      ),
                      title: Text(
                        'วิ่งที่ไหน ${runs[index].runWhere} วิ่งกับใคร ${runs[index].runPerson} ระยะทาง ${runs[index].runDistance} กม.',
                      ),
                      subtitle: Text(
                        'วันไหน ${runs[index].runWhere},วิ่งกับใคร ${runs[index].runPerson} ระยะทาง ${runs[index].runDistance} กม.'),
                      tileColor: index % 2 == 0 ? Colors.red.shade50 : Colors.red.shade100,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),

                  );
                },
                  
            ),
            ),
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
