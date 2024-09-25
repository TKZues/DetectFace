class AttendanceData {
  final String studentName;
  final double attendanceRate;  // Tỷ lệ tham gia (%)
  final int lateCount;           // Số lần đi muộn
  final int absentCount;         // Số buổi vắng mặt không lý do
  final DateTime date;           // Dùng cho biểu đồ xu hướng

  AttendanceData({
    required this.studentName,
    required this.attendanceRate,
    required this.lateCount,
    required this.absentCount,
    required this.date,
  });
}
