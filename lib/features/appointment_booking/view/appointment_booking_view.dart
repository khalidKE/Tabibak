import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tabibak/core/constant/colors.dart';

class AppointmentBookingView extends StatefulWidget {
  const AppointmentBookingView({super.key});

  @override
  State<AppointmentBookingView> createState() => _AppointmentBookingViewState();
}

class _AppointmentBookingViewState extends State<AppointmentBookingView> {
  String? _selectedDoctor;
  String? _selectedDate;
  String? _selectedTime;
  String? _selectedSpecialty;
  String? _appointmentType;
  final TextEditingController _notesController = TextEditingController();
  bool _isLoading = false;

  final List<String> _specialties = [
    'Cardiology', 'Dermatology', 'Neurology', 'Orthopedics',
    'Pediatrics', 'Psychiatry', 'Oncology', 'Endocrinology',
    'Gastroenterology', 'Ophthalmology', 'ENT', 'Urology',
    'Gynecology', 'General Medicine',
  ];

  final List<String> _appointmentTypes = [
    'In-person Consultation', 'Video Consultation', 'Follow-up Visit',
    'Emergency Visit', 'Routine Checkup',
  ];

  final List<String> _availableDates = [
    'Today', 'Tomorrow', 'Next Week', 'Custom Date',
  ];

  final List<String> _availableTimes = [
    '09:00 AM', '10:00 AM', '11:00 AM', '12:00 PM',
    '02:00 PM', '03:00 PM', '04:00 PM', '05:00 PM',
  ];

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsApp.kBackgroundColor,
      appBar: AppBar(
        backgroundColor: ColorsApp.kPrimaryColor,
        elevation: 0,
        title: Text(
          'Book Appointment',
          style: GoogleFonts.montserrat(
            color: ColorsApp.kWhiteColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: ColorsApp.kWhiteColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 24),
            _buildBookingForm(),
            const SizedBox(height: 32),
            _buildBookButton(),
            const SizedBox(height: 24),
            _buildAppointmentSummary(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [ColorsApp.kPrimaryColor, ColorsApp.kTealColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: ColorsApp.kWhiteColor.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.calendar_today,
                  size: 24,
                  color: ColorsApp.kWhiteColor,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  'Schedule Your Appointment',
                  style: GoogleFonts.montserrat(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: ColorsApp.kWhiteColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Choose your preferred doctor, date, and time to book your appointment.',
            style: GoogleFonts.montserrat(
              fontSize: 14,
              color: ColorsApp.kWhiteColor.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Appointment Details',
          style: GoogleFonts.montserrat(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: ColorsApp.kTextColor,
          ),
        ),
        const SizedBox(height: 20),
        
        _buildFormField(
          'Specialty',
          _selectedSpecialty,
          _specialties,
          (value) => setState(() => _selectedSpecialty = value),
          Icons.medical_services,
          ColorsApp.kPrimaryColor,
        ),
        
        const SizedBox(height: 20),
        
        if (_selectedSpecialty != null) ...[
          _buildDoctorSelection(),
          const SizedBox(height: 20),
        ],
        
        _buildFormField(
          'Appointment Type',
          _appointmentType,
          _appointmentTypes,
          (value) => setState(() => _appointmentType = value),
          Icons.category,
          ColorsApp.kAccentColor,
        ),
        
        const SizedBox(height: 20),
        
        _buildFormField(
          'Preferred Date',
          _selectedDate,
          _availableDates,
          (value) => setState(() => _selectedDate = value),
          Icons.calendar_today,
          ColorsApp.kSuccessColor,
        ),
        
        const SizedBox(height: 20),
        
        if (_selectedDate != null) ...[
          _buildFormField(
            'Preferred Time',
            _selectedTime,
            _availableTimes,
            (value) => setState(() => _selectedTime = value),
            Icons.access_time,
            ColorsApp.kWarningColor,
          ),
          const SizedBox(height: 20),
        ],
        
        _buildNotesField(),
      ],
    );
  }

  Widget _buildFormField(
    String label,
    String? value,
    List<String> options,
    Function(String?) onChanged,
    IconData icon,
    Color iconColor,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: ColorsApp.kTextColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: ColorsApp.kWhiteColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: ColorsApp.kLightGreyColor),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              hint: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Select $label',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: ColorsApp.kSecondaryTextColor,
                  ),
                ),
              ),
              icon: Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Icon(Icons.keyboard_arrow_down, color: ColorsApp.kPrimaryColor),
              ),
              items: options.map((String option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      option,
                      style: GoogleFonts.montserrat(fontSize: 14),
                    ),
                  ),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDoctorSelection() {
    final doctors = _getDoctorsBySpecialty(_selectedSpecialty!);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: ColorsApp.kPurpleColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.person, color: ColorsApp.kPurpleColor, size: 20),
            ),
            const SizedBox(width: 12),
            Text(
              'Select Doctor',
              style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: ColorsApp.kTextColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: ColorsApp.kWhiteColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: ColorsApp.kLightGreyColor),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedDoctor,
              isExpanded: true,
              hint: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Select Doctor',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: ColorsApp.kSecondaryTextColor,
                  ),
                ),
              ),
              icon: Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Icon(Icons.keyboard_arrow_down, color: ColorsApp.kPrimaryColor),
              ),
              items: doctors.map((Map<String, dynamic> doctor) {
                return DropdownMenuItem<String>(
                  value: doctor['name'],
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: ColorsApp.kPrimaryColor.withOpacity(0.1),
                          child: Text(
                            doctor['name'].split(' ').map((e) => e[0]).join(''),
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: ColorsApp.kPrimaryColor,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                doctor['name'],
                                style: GoogleFonts.montserrat(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                '${doctor['rating']} ⭐ • ${doctor['experience']}',
                                style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  color: ColorsApp.kSecondaryTextColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
              onChanged: (value) => setState(() => _selectedDoctor = value),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNotesField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: ColorsApp.kOrangeColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.note, color: ColorsApp.kOrangeColor, size: 20),
            ),
            const SizedBox(width: 12),
            Text(
              'Additional Notes (Optional)',
              style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: ColorsApp.kTextColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: ColorsApp.kWhiteColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: ColorsApp.kLightGreyColor),
          ),
          child: TextField(
            controller: _notesController,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: 'Describe your symptoms or any special requirements...',
              hintStyle: TextStyle(color: ColorsApp.kSecondaryTextColor),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(16),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBookButton() {
    final canBook = _selectedSpecialty != null &&
        _selectedDoctor != null &&
        _appointmentType != null &&
        _selectedDate != null &&
        _selectedTime != null;
    
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: canBook && !_isLoading ? _bookAppointment : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorsApp.kPrimaryColor,
          foregroundColor: ColorsApp.kWhiteColor,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: _isLoading
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(ColorsApp.kWhiteColor),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Booking...',
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.calendar_today, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Book Appointment',
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildAppointmentSummary() {
    if (_selectedDoctor == null || _selectedDate == null || _selectedTime == null) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ColorsApp.kSuccessColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ColorsApp.kSuccessColor.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info,
                color: ColorsApp.kSuccessColor,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'Appointment Summary',
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: ColorsApp.kSuccessColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildSummaryRow('Doctor', _selectedDoctor!),
          _buildSummaryRow('Specialty', _selectedSpecialty!),
          _buildSummaryRow('Type', _appointmentType!),
          _buildSummaryRow('Date', _selectedDate!),
          _buildSummaryRow('Time', _selectedTime!),
          if (_notesController.text.isNotEmpty)
            _buildSummaryRow('Notes', _notesController.text),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: ColorsApp.kSecondaryTextColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: ColorsApp.kTextColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Map<String, dynamic>> _getDoctorsBySpecialty(String specialty) {
    final allDoctors = [
      {
        'name': 'Dr. Sarah Ahmed',
        'specialty': 'Cardiology',
        'rating': 4.9,
        'experience': '15 years',
        'location': 'Cairo',
        'availability': 'Mon-Fri, 9AM-5PM',
      },
      {
        'name': 'Dr. Mohamed Hassan',
        'specialty': 'Dermatology',
        'rating': 4.8,
        'experience': '12 years',
        'location': 'Alexandria',
        'availability': 'Sun-Thu, 10AM-6PM',
      },
      {
        'name': 'Dr. Fatima Ali',
        'specialty': 'Pediatrics',
        'rating': 4.7,
        'experience': '18 years',
        'location': 'Giza',
        'availability': 'Sat-Wed, 8AM-4PM',
      },
      {
        'name': 'Dr. Omar Khalil',
        'specialty': 'Neurology',
        'rating': 4.9,
        'experience': '20 years',
        'location': 'Cairo',
        'availability': 'Mon-Fri, 9AM-6PM',
      },
      {
        'name': 'Dr. Aisha Mahmoud',
        'specialty': 'Gynecology',
        'rating': 4.6,
        'experience': '14 years',
        'location': 'Sharm El Sheikh',
        'availability': 'Sun-Thu, 9AM-5PM',
      },
    ];

    return allDoctors.where((doctor) => doctor['specialty'] == specialty).toList();
  }

  void _bookAppointment() {
    setState(() {
      _isLoading = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
      
      _showSuccessDialog();
    });
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: ColorsApp.kSuccessColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_circle,
                  color: ColorsApp.kSuccessColor,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Appointment Booked!',
                style: GoogleFonts.montserrat(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: ColorsApp.kTextColor,
                ),
              ),
            ],
          ),
          content: Text(
            'Your appointment has been successfully booked. You will receive a confirmation message shortly.',
            style: GoogleFonts.montserrat(
              fontSize: 16,
              color: ColorsApp.kSecondaryTextColor,
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsApp.kPrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Great!',
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: ColorsApp.kWhiteColor,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
