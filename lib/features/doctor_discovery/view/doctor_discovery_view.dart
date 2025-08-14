import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tabibak/core/constant/colors.dart';

class DoctorDiscoveryView extends StatefulWidget {
  const DoctorDiscoveryView({super.key});

  @override
  State<DoctorDiscoveryView> createState() => _DoctorDiscoveryViewState();
}

class _DoctorDiscoveryViewState extends State<DoctorDiscoveryView> {
  String _selectedSpecialty = 'All';
  String _selectedLocation = 'All';
  String _selectedRating = 'All';
  final TextEditingController _searchController = TextEditingController();

  final List<String> _specialties = [
    'All',
    'Cardiology',
    'Dermatology',
    'Neurology',
    'Orthopedics',
    'Pediatrics',
    'Psychiatry',
    'Oncology',
    'Endocrinology',
    'Gastroenterology',
    'Ophthalmology',
    'ENT',
    'Urology',
    'Gynecology',
    'General Medicine',
  ];

  final List<String> _locations = [
    'All',
    'Cairo',
    'Alexandria',
    'Giza',
    'Sharm El Sheikh',
    'Hurghada',
    'Luxor',
    'Aswan',
  ];

  final List<String> _ratings = [
    'All',
    '5.0+',
    '4.5+',
    '4.0+',
    '3.5+',
  ];

  @override
  void dispose() {
    _searchController.dispose();
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
          'Find Doctors',
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
      body: Column(
        children: [
          _buildSearchAndFilters(),
          Expanded(
            child: _buildDoctorsList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ColorsApp.kWhiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Search Bar
          Container(
            decoration: BoxDecoration(
              color: ColorsApp.kBackgroundColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: ColorsApp.kLightGreyColor),
            ),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search doctors, specialties...',
                hintStyle: TextStyle(color: ColorsApp.kSecondaryTextColor),
                prefixIcon: Icon(Icons.search, color: ColorsApp.kPrimaryColor),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(16),
              ),
              onChanged: (value) {
                setState(() {
                  // Trigger search filter
                });
              },
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Filters - Make responsive
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 600) {
                // Mobile layout - Stack vertically
                return Column(
                  children: [
                    _buildFilterDropdown(
                      'Specialty',
                      _selectedSpecialty,
                      _specialties,
                      (value) => setState(() => _selectedSpecialty = value!),
                    ),
                    const SizedBox(height: 16),
                    _buildFilterDropdown(
                      'Location',
                      _selectedLocation,
                      _locations,
                      (value) => setState(() => _selectedLocation = value!),
                    ),
                    const SizedBox(height: 16),
                    _buildFilterDropdown(
                      'Rating',
                      _selectedRating,
                      _ratings,
                      (value) => setState(() => _selectedRating = value!),
                    ),
                  ],
                );
              } else {
                // Desktop/Tablet layout - Row
                return Row(
                  children: [
                    Expanded(
                      child: _buildFilterDropdown(
                        'Specialty',
                        _selectedSpecialty,
                        _specialties,
                        (value) => setState(() => _selectedSpecialty = value!),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildFilterDropdown(
                        'Location',
                        _selectedLocation,
                        _locations,
                        (value) => setState(() => _selectedLocation = value!),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildFilterDropdown(
                        'Rating',
                        _selectedRating,
                        _ratings,
                        (value) => setState(() => _selectedRating = value!),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFilterDropdown(
    String label,
    String value,
    List<String> items,
    Function(String?) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.montserrat(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: ColorsApp.kTextColor,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: ColorsApp.kBackgroundColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: ColorsApp.kLightGreyColor),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              icon: Icon(Icons.keyboard_arrow_down, color: ColorsApp.kPrimaryColor),
              items: items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: GoogleFonts.montserrat(fontSize: 14),
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

  Widget _buildDoctorsList() {
    final doctors = _getFilteredDoctors();
    
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: doctors.length,
      itemBuilder: (context, index) {
        final doctor = doctors[index];
        return _buildDoctorCard(doctor);
      },
    );
  }

  Widget _buildDoctorCard(Map<String, dynamic> doctor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: ColorsApp.kWhiteColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 400) {
              // Mobile layout - Stack vertically
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // Doctor Avatar
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: ColorsApp.kPrimaryColor.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.medical_services,
                          size: 30,
                          color: ColorsApp.kPrimaryColor,
                        ),
                      ),
                      
                      const SizedBox(width: 16),
                      
                      // Doctor Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              doctor['name'],
                              style: GoogleFonts.montserrat(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: ColorsApp.kTextColor,
                              ),
                            ),
                            
                            const SizedBox(height: 4),
                            
                            Text(
                              doctor['specialty'],
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                color: ColorsApp.kPrimaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Location and Rating
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 16,
                              color: ColorsApp.kSecondaryTextColor,
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                doctor['location'],
                                style: TextStyle(
                                  fontSize: 12,
                                  color: ColorsApp.kSecondaryTextColor,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: 16,
                            color: ColorsApp.kAmberColor,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${doctor['rating']}',
                            style: TextStyle(
                              fontSize: 12,
                              color: ColorsApp.kSecondaryTextColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: ColorsApp.kPrimaryColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'Book Appointment',
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: ColorsApp.kWhiteColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      
                      const SizedBox(width: 12),
                      
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: ColorsApp.kBackgroundColor,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: ColorsApp.kPrimaryColor),
                          ),
                          child: Text(
                            'View Profile',
                            style: GoogleFonts.montserrat(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: ColorsApp.kPrimaryColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            } else {
              // Desktop/Tablet layout - Row
              return Row(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: ColorsApp.kPrimaryColor.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.medical_services,
                      size: 40,
                      color: ColorsApp.kPrimaryColor,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          doctor['name'] ?? '',
                          style: GoogleFonts.montserrat(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: ColorsApp.kTextColor,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          doctor['specialty'] ?? '',
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            color: ColorsApp.kPrimaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 16,
                              color: ColorsApp.kSecondaryTextColor,
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                doctor['location'] ?? '',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: ColorsApp.kSecondaryTextColor,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              size: 16,
                              color: ColorsApp.kAmberColor ?? Colors.amber,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${doctor['rating'] ?? ''} (${doctor['reviews'] ?? 0} reviews)',
                              style: TextStyle(
                                fontSize: 12,
                                color: ColorsApp.kSecondaryTextColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Action Buttons
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: ColorsApp.kPrimaryColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Book',
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: ColorsApp.kWhiteColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: ColorsApp.kBackgroundColor,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: ColorsApp.kPrimaryColor),
                        ),
                        child: Text(
                          'Profile',
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: ColorsApp.kPrimaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _getFilteredDoctors() {
    // Mock data - in real app this would come from API
    final allDoctors = [
      {
        'name': 'Dr. Sarah Ahmed',
        'specialty': 'Cardiology',
        'location': 'Cairo',
        'rating': 4.9,
        'reviews': 127,
        'experience': '15 years',
        'languages': ['Arabic', 'English'],
        'availability': 'Mon-Fri, 9AM-5PM',
        'consultationFee': '500 EGP',
        'nextAvailable': 'Tomorrow, 10:00 AM',
      },
      {
        'name': 'Dr. Mohamed Hassan',
        'specialty': 'Dermatology',
        'location': 'Alexandria',
        'rating': 4.8,
        'reviews': 89,
        'experience': '12 years',
        'languages': ['Arabic', 'English'],
        'availability': 'Sun-Thu, 10AM-6PM',
        'consultationFee': '400 EGP',
        'nextAvailable': 'Today, 2:00 PM',
      },
      {
        'name': 'Dr. Fatima Ali',
        'specialty': 'Pediatrics',
        'location': 'Giza',
        'rating': 4.7,
        'reviews': 156,
        'experience': '18 years',
        'languages': ['Arabic', 'English', 'French'],
        'availability': 'Sat-Wed, 8AM-4PM',
        'consultationFee': '350 EGP',
        'nextAvailable': 'Next Week',
      },
      {
        'name': 'Dr. Omar Khalil',
        'specialty': 'Neurology',
        'location': 'Cairo',
        'rating': 4.9,
        'reviews': 203,
        'experience': '20 years',
        'languages': ['Arabic', 'English'],
        'availability': 'Mon-Fri, 9AM-6PM',
        'consultationFee': '600 EGP',
        'nextAvailable': 'Friday, 11:00 AM',
      },
      {
        'name': 'Dr. Aisha Mahmoud',
        'specialty': 'Gynecology',
        'location': 'Sharm El Sheikh',
        'rating': 4.6,
        'reviews': 67,
        'experience': '14 years',
        'languages': ['Arabic', 'English'],
        'availability': 'Sun-Thu, 9AM-5PM',
        'consultationFee': '450 EGP',
        'nextAvailable': 'Sunday, 9:00 AM',
      },
      {
        'name': 'Dr. Karim El-Sayed',
        'specialty': 'Orthopedics',
        'location': 'Cairo',
        'rating': 4.8,
        'reviews': 134,
        'experience': '16 years',
        'languages': ['Arabic', 'English'],
        'availability': 'Mon-Fri, 8AM-4PM',
        'consultationFee': '550 EGP',
        'nextAvailable': 'Today, 4:00 PM',
      },
      {
        'name': 'Dr. Nour Ibrahim',
        'specialty': 'Psychiatry',
        'location': 'Giza',
        'rating': 4.7,
        'reviews': 98,
        'experience': '13 years',
        'languages': ['Arabic', 'English', 'German'],
        'availability': 'Sun-Thu, 9AM-7PM',
        'consultationFee': '400 EGP',
        'nextAvailable': 'Tomorrow, 3:00 PM',
      },
    ];

    // Apply filters
    return allDoctors.where((doctor) {
      bool specialtyMatch = _selectedSpecialty == 'All' ||
        doctor['specialty'] == _selectedSpecialty;
      bool locationMatch = _selectedLocation == 'All' ||
        doctor['location'] == _selectedLocation;
      bool ratingMatch = true;
      if (_selectedRating != 'All') {
        final ratingValue = double.tryParse(_selectedRating.replaceAll('+', ''));
        ratingMatch = ratingValue != null &&
          (doctor['rating'] != null && (doctor['rating'] as double) >= ratingValue);
      }
      bool searchMatch = _searchController.text.isEmpty ||
        ((doctor['name'] != null && (doctor['name'] as String).toLowerCase().contains(_searchController.text.toLowerCase())) || false) ||
        ((doctor['specialty'] != null && (doctor['specialty'] as String).toLowerCase().contains(_searchController.text.toLowerCase())) || false) ||
        ((doctor['location'] != null && (doctor['location'] as String).toLowerCase().contains(_searchController.text.toLowerCase())) || false);

      return specialtyMatch && locationMatch && ratingMatch && searchMatch;
    }).toList();
  }
}
