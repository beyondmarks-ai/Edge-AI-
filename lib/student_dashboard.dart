import 'package:flutter/material.dart';

class StudentDashboardScreen extends StatelessWidget {
  final String name;
  final String email;
  final String usn;
  final String admissionNo;

  const StudentDashboardScreen({
    super.key,
    required this.name,
    required this.email,
    required this.usn,
    required this.admissionNo,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('Student Dashboard', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded),
            onPressed: () {},
          )
        ],
      ),
      drawer: _buildSidebar(context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildExamNotification(),
            const SizedBox(height: 16),
            _buildAttendanceCard(),
            const SizedBox(height: 16),
            _buildAssignmentsAndNotes(),
            const SizedBox(height: 16),
            _buildUpcomingHolidays(),
          ],
        ),
      ),
    );
  }

  Widget _buildSidebar(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.deepOrange, Colors.orangeAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 32,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 40, color: Colors.deepOrange),
                ),
                const Spacer(),
                Text(name, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                Text(email, style: const TextStyle(color: Colors.white70, fontSize: 13)),
              ],
            ),
          ),
          _buildDrawerItem(Icons.numbers_rounded, 'USN', usn),
          _buildDrawerItem(Icons.confirmation_number_outlined, 'Admission No.', admissionNo),
          const Divider(),
          _buildDrawerItem(Icons.book_outlined, 'My Courses', 'BTech'),
          _buildDrawerItem(Icons.assignment_ind_outlined, 'Results', ''),
          _buildDrawerItem(Icons.settings_outlined, 'Settings', ''),
          _buildDrawerItem(Icons.logout, 'Logout', ''),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, String trailingText) {
    return ListTile(
      leading: Icon(icon, color: Colors.deepOrange),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      trailing: trailingText.isNotEmpty 
          ? Text(trailingText, style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 12)) 
          : null,
      onTap: () {},
    );
  }

  Widget _buildExamNotification() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.redAccent.shade200, Colors.deepOrange],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.redAccent.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 5)),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.warning_amber_rounded, color: Colors.white, size: 40),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('Upcoming Exam!', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                SizedBox(height: 4),
                Text('Mid-Semester starting in 5 Days.', style: TextStyle(color: Colors.white70, fontSize: 14)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttendanceCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Overall Attendance', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    Icon(Icons.pie_chart_rounded, color: Colors.deepOrange),
                  ],
                ),
                const SizedBox(height: 24),
                _buildCircularProgress('Total Average', 0.82, Colors.deepOrange, size: 100, stroke: 12),
              ],
            ),
          ),
          Theme(
            data: ThemeData().copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              title: const Text('Subject-wise Average', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)),
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildCircularProgress('Math', 0.85, Colors.green),
                      _buildCircularProgress('Physics', 0.70, Colors.orange),
                      _buildCircularProgress('CS', 0.95, Colors.blue),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircularProgress(String subject, double percentage, Color color, {double size = 70, double stroke = 8}) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: size,
              height: size,
              child: CircularProgressIndicator(
                value: percentage,
                strokeWidth: stroke,
                backgroundColor: color.withOpacity(0.2),
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
            ),
            Text('${(percentage * 100).toInt()}%', style: TextStyle(fontWeight: FontWeight.w900, color: color, fontSize: size * 0.22)),
          ],
        ),
        const SizedBox(height: 12),
        Text(subject, style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black87)),
      ],
    );
  }

  Widget _buildAssignmentsAndNotes() {
    return Row(
      children: [
        Expanded(
          child: _buildDashboardCard(
            title: 'Assignments',
            count: '3 Pending',
            icon: Icons.assignment_rounded,
            color: Colors.blueAccent,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildDashboardCard(
            title: 'Notes',
            count: '12 Available',
            icon: Icons.menu_book_rounded,
            color: Colors.purpleAccent,
          ),
        ),
      ],
    );
  }

  Widget _buildDashboardCard({required String title, required String count, required IconData icon, required Color color}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 16),
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(count, style: TextStyle(fontSize: 13, color: Colors.grey.shade600, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildUpcomingHolidays() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Upcoming Holidays', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            _buildHolidayTile('Deepavali', 'Nov 12 - Nov 13', Icons.celebration),
            const Divider(),
            _buildHolidayTile('Winter Break', 'Dec 20 - Jan 5', Icons.ac_unit),
          ],
        ),
      ),
    );
  }

  Widget _buildHolidayTile(String event, String date, IconData icon) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: Colors.green),
      ),
      title: Text(event, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(date, style: const TextStyle(color: Colors.grey)),
    );
  }
}
