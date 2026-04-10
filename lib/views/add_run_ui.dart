import 'package:flutter/material.dart';
import 'package:flutter_run_tracker_app/services/supabase_services.dart';
import '../models/run.dart';

class AddRunUi extends StatefulWidget {
  const AddRunUi({super.key});

  @override
  State<AddRunUi> createState() => _AddRunUiState();
}

class _AddRunUiState extends State<AddRunUi> {
  TextEditingController runWhereCtrl = TextEditingController();
  TextEditingController runPersonCtrl = TextEditingController();
  TextEditingController runDistanceCtrl = TextEditingController();

  void saveRun() async {
    if (runWhereCtrl.text.isEmpty ||
        runPersonCtrl.text.isEmpty ||
        runDistanceCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('กรุณากรอกข้อมูลให้ครบ'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    Run run = Run(
      runWhere: runWhereCtrl.text,
      runPerson: runPersonCtrl.text,
      runDistance: double.parse(runDistanceCtrl.text),
    );

    await SupabaseService().insertRun(run);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('บันทึกสำเร็จ'),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEDE7F6),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 59, 144, 255),
        title:
            Text('Run Tracker (เพิ่ม)', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Image.asset('assets/images/RUN.png', height: 120),
            SizedBox(height: 20),

            // วิ่งที่ไหน
            Column(
              crossAxisAlignment: CrossAxisAlignment.start, // 👈 เพิ่มตรงนี้
              children: [
                Text(
                  'วิ่งที่ไหน',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                TextField(
                  controller: runWhereCtrl,
                  decoration: InputDecoration(
                    hintText: 'เช่น สวนสาธารณะ, สนามกีฬา หรือ อื่นๆ',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 15),
              ],
            ),
            SizedBox(height: 15),

            // วิ่งกับใคร
            Column(
              crossAxisAlignment: CrossAxisAlignment.start, // 👈 เพิ่มตรงนี้
              children: [
                Text('วิ่งกับใคร',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                TextField(
                  controller: runPersonCtrl,
                  decoration: InputDecoration(
                    hintText: 'เช่น เพื่อน 3 คน, แฟน หรือ อื่นๆ',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 15),
              ],
            ),
                SizedBox(height: 15),
            // ระยะทาง
          
            Column(
              crossAxisAlignment: CrossAxisAlignment.start, // 👈 เพิ่มตรงนี้
              children: [
                Text('ระยะทาง',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                TextField(
                  controller: runDistanceCtrl,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'เช่น 1, 5, 11 หรือ อื่นๆ',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
                SizedBox(height: 50),
            // ปุ่มบันทึก
            ElevatedButton(
              onPressed: saveRun,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: Size(double.infinity, 50),
                
              ),
              child:
              
                  Text('บันทึกข้อมูล', style: TextStyle(color: Colors.white)),
            ),
            SizedBox(height: 10),

            // ปุ่มยกเลิก
            ElevatedButton(
              onPressed: () {
                runWhereCtrl.clear();
                runPersonCtrl.clear();
                runDistanceCtrl.clear();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: Size(double.infinity, 50),
                
              ),
              child: Text('ยกเลิก', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
