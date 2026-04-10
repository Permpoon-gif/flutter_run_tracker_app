import 'package:flutter/material.dart';
import 'package:flutter_run_tracker_app/models/run.dart';

import 'package:flutter_run_tracker_app/services/supabase_services.dart';

class UpdateDeleteRunUi extends StatefulWidget {
  Run? run;

  UpdateDeleteRunUi({super.key, this.run});

  @override
  State<UpdateDeleteRunUi> createState() => _UpdateDeleteRunUiState();
}

class _UpdateDeleteRunUiState extends State<UpdateDeleteRunUi> {
  TextEditingController locationCtrl = TextEditingController();
  TextEditingController withCtrl = TextEditingController();
  TextEditingController distanceCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();

    locationCtrl.text = widget.run!.runWhere;
    withCtrl.text = widget.run!.runPerson;
    distanceCtrl.text = widget.run!.runDistance.toString();
  }

  // 🔥 แก้ไขข้อมูล
  void updateRun() async {
    if (locationCtrl.text.isEmpty ||
        withCtrl.text.isEmpty ||
        distanceCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('กรุณากรอกข้อมูลให้ครบ'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    Run run = Run(
      runWhere: locationCtrl.text,
      runPerson: withCtrl.text,
      runDistance: double.parse(distanceCtrl.text),
    );

    final service = SupabaseService();
    await service.updateRun(widget.run!.id!, run);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('แก้ไขเรียบร้อย'),
        backgroundColor: Colors.green,
      ),
    );

    Navigator.pop(context);
  }

  // 🔥 ลบข้อมูล
  Future deleteRun() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('ยืนยันการลบ'),
        content: Text('ต้องการลบรายการนี้หรือไม่?'),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: Text('ยกเลิก'),
          ),
          ElevatedButton(
            onPressed: () async {
              final service = SupabaseService();
              await service.deleteRun(widget.run!.id!);

              Navigator.pop(context); // ปิด dialog
              Navigator.pop(context); // กลับหน้า list

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('ลบสำเร็จ'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: Text('ลบ'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('แก้ไขข้อมูลการวิ่ง'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            // วิ่งที่ไหน
            TextField(
              controller: locationCtrl,
              decoration: InputDecoration(
                labelText: 'วิ่งที่ไหน',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),

            // วิ่งกับใคร
            TextField(
              controller: withCtrl,
              decoration: InputDecoration(
                labelText: 'วิ่งกับใคร',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),

            // ระยะทาง
            TextField(
              controller: distanceCtrl,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'ระยะทาง (กม.)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),

            // ปุ่มแก้ไข
            ElevatedButton(
              onPressed: updateRun,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text('บันทึกแก้ไข'),
            ),

            SizedBox(height: 10),

            // ปุ่มลบ
            ElevatedButton(
              onPressed: deleteRun,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text('ลบข้อมูล'),
            ),
          ],
        ),
      ),
    );
  }
}