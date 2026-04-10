// ignore_for_file: non_constant_identifier_names

class Run {
  String? id;
  String runWhere;   // วิ่งที่ไหน
  String runPerson;       // วิ่งกับใคร
  double runDistance;   // ระยะทาง (กม.)

  Run({
    this.id,
    required this.runWhere,
    required this.runPerson,
    required this.runDistance,
  });

  // รับข้อมูลจาก Supabase
  factory Run.fromJson(Map<String, dynamic> json) {
  return Run(
    id: json['id'],
    runWhere: json['runWhere'],
    runPerson: json['runPerson'],
    runDistance: (json['runDistance'] as num).toDouble(),
  );
}

  // ส่งข้อมูลไป Supabase
  Map<String, dynamic> toJson() {
    return {
      "runWhere": runWhere,
      "runPerson": runPerson,
      "runDistance": runDistance,
    };
  }
}