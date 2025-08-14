import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tabibak/core/constant/colors.dart';

class SymptomCheckerView extends StatefulWidget {
  const SymptomCheckerView({super.key});

  @override
  State<SymptomCheckerView> createState() => _SymptomCheckerViewState();
}

class _SymptomCheckerViewState extends State<SymptomCheckerView> {
  final TextEditingController _symptomController = TextEditingController();
  final List<String> _selectedSymptoms = [];
  bool _isAnalyzing = false;
  Map<String, dynamic>? _analysisResult;

  final List<String> _commonSymptoms = [
    'Fever',
    'Headache',
    'Cough',
    'Fatigue',
    'Nausea',
    'Dizziness',
    'Chest pain',
    'Shortness of breath',
    'Abdominal pain',
    'Joint pain',
    'Rash',
    'Swelling',
    'Loss of appetite',
    'Insomnia',
    'Anxiety',
    'Depression',
    'Memory problems',
    'Vision changes',
    'Hearing problems',
    'Numbness',
  ];

  @override
  void dispose() {
    _symptomController.dispose();
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
          'Symptom Checker',
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
            _buildSymptomInput(),
            const SizedBox(height: 24),
            _buildCommonSymptoms(),
            const SizedBox(height: 24),
            _buildSelectedSymptoms(),
            const SizedBox(height: 24),
            _buildAnalyzeButton(),
            if (_analysisResult != null) ...[
              const SizedBox(height: 24),
              _buildAnalysisResult(),
            ],
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
                  Icons.psychology,
                  size: 24,
                  color: ColorsApp.kWhiteColor,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  'AI-Powered Symptom Analysis',
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
            'Describe your symptoms and get instant insights about possible conditions and recommended specialists.',
            style: GoogleFonts.montserrat(
              fontSize: 14,
              color: ColorsApp.kWhiteColor.withOpacity(0.9),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSymptomInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Describe Your Symptoms',
          style: GoogleFonts.montserrat(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: ColorsApp.kTextColor,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: ColorsApp.kWhiteColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: ColorsApp.kLightGreyColor),
          ),
          child: TextField(
            controller: _symptomController,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'Describe your symptoms in detail...\nExample: I have been experiencing severe headaches for the past 3 days, accompanied by nausea and sensitivity to light.',
              hintStyle: TextStyle(color: ColorsApp.kSecondaryTextColor),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(16),
            ),
            onChanged: (value) {
              // TODO: Implement real-time symptom analysis
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCommonSymptoms() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Common Symptoms',
          style: GoogleFonts.montserrat(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: ColorsApp.kTextColor,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _commonSymptoms.map((symptom) {
            final isSelected = _selectedSymptoms.contains(symptom);
            return GestureDetector(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    _selectedSymptoms.remove(symptom);
                  } else {
                    _selectedSymptoms.add(symptom);
                  }
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? ColorsApp.kPrimaryColor : ColorsApp.kWhiteColor,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected ? ColorsApp.kPrimaryColor : ColorsApp.kLightGreyColor,
                  ),
                ),
                child: Text(
                  symptom,
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: isSelected ? ColorsApp.kWhiteColor : ColorsApp.kTextColor,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSelectedSymptoms() {
    if (_selectedSymptoms.isEmpty) return const SizedBox.shrink();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Selected Symptoms',
          style: GoogleFonts.montserrat(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: ColorsApp.kTextColor,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: ColorsApp.kPrimaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: ColorsApp.kPrimaryColor.withOpacity(0.3)),
          ),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _selectedSymptoms.map((symptom) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: ColorsApp.kPrimaryColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      symptom,
                      style: GoogleFonts.montserrat(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: ColorsApp.kWhiteColor,
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedSymptoms.remove(symptom);
                        });
                      },
                      child: Icon(
                        Icons.close,
                        size: 16,
                        color: ColorsApp.kWhiteColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildAnalyzeButton() {
    final hasSymptoms = _symptomController.text.isNotEmpty || _selectedSymptoms.isNotEmpty;
    
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: hasSymptoms && !_isAnalyzing ? _analyzeSymptoms : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorsApp.kPrimaryColor,
          foregroundColor: ColorsApp.kWhiteColor,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
        ),
        child: _isAnalyzing
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
                    'Analyzing...',
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
                  Icon(Icons.psychology, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Analyze Symptoms',
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

  Widget _buildAnalysisResult() {
    return Container(
      padding: const EdgeInsets.all(20),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
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
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Analysis Complete',
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: ColorsApp.kTextColor,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // Possible Conditions
          _buildResultSection(
            'Possible Conditions',
            _analysisResult!['conditions'],
            Icons.medical_services,
            ColorsApp.kPrimaryColor,
          ),
          
          const SizedBox(height: 16),
          
          // Recommended Specialists
          _buildResultSection(
            'Recommended Specialists',
            _analysisResult!['specialists'],
            Icons.person,
            ColorsApp.kAccentColor,
          ),
          
          const SizedBox(height: 16),
          
          // Urgency Level
          _buildUrgencyLevel(),
          
          const SizedBox(height: 20),
          
          // Action Buttons
          Row(
            children: [
                             Expanded(
                 child: OutlinedButton.icon(
                   onPressed: () {
                     Navigator.pushNamed(context, '/doctorDiscovery');
                   },
                   icon: Icon(Icons.search, color: ColorsApp.kPrimaryColor),
                   label: Text(
                     'Find Doctors',
                     style: GoogleFonts.montserrat(
                       color: ColorsApp.kPrimaryColor,
                       fontWeight: FontWeight.w600,
                     ),
                   ),
                   style: OutlinedButton.styleFrom(
                     padding: const EdgeInsets.symmetric(vertical: 12),
                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(8),
                     ),
                     side: BorderSide(color: ColorsApp.kPrimaryColor),
                   ),
                 ),
               ),
               const SizedBox(width: 12),
               Expanded(
                 child: ElevatedButton.icon(
                   onPressed: () {
                     Navigator.pushNamed(context, '/appointmentBooking');
                   },
                   icon: Icon(Icons.calendar_today, color: ColorsApp.kWhiteColor),
                   label: Text(
                     'Book Appointment',
                     style: GoogleFonts.montserrat(
                       color: ColorsApp.kWhiteColor,
                       fontWeight: FontWeight.w600,
                     ),
                   ),
                   style: ElevatedButton.styleFrom(
                     backgroundColor: ColorsApp.kPrimaryColor,
                     padding: const EdgeInsets.symmetric(vertical: 12),
                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(8),
                     ),
                     elevation: 0,
                   ),
                 ),
               ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildResultSection(String title, List<String> items, IconData icon, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 16),
            const SizedBox(width: 8),
            Text(
              title,
              style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: ColorsApp.kTextColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: items.map((item) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: color.withOpacity(0.3)),
              ),
              child: Text(
                item,
                style: GoogleFonts.montserrat(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: color,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildUrgencyLevel() {
    final urgency = _analysisResult!['urgency'];
    Color urgencyColor;
    String urgencyText;
    
    switch (urgency) {
      case 'High':
        urgencyColor = ColorsApp.kErrorColor;
        urgencyText = 'Seek immediate medical attention';
        break;
      case 'Medium':
        urgencyColor = ColorsApp.kWarningColor;
        urgencyText = 'Schedule appointment within 24-48 hours';
        break;
      case 'Low':
        urgencyColor = ColorsApp.kSuccessColor;
        urgencyText = 'Monitor symptoms, schedule routine checkup';
        break;
      default:
        urgencyColor = ColorsApp.kGreyColor;
        urgencyText = 'Consult with healthcare provider';
    }
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.warning, color: urgencyColor, size: 16),
            const SizedBox(width: 8),
            Text(
              'Urgency Level: $urgency',
              style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: urgencyColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          urgencyText,
          style: GoogleFonts.montserrat(
            fontSize: 14,
            color: urgencyColor,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }

  void _analyzeSymptoms() {
    setState(() {
      _isAnalyzing = true;
    });

    // Simulate AI analysis
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _isAnalyzing = false;
        _analysisResult = _generateMockAnalysis();
      });
    });
  }

  Map<String, dynamic> _generateMockAnalysis() {
    // Mock AI analysis result - in real app this would come from AI service
    final symptoms = [..._selectedSymptoms];
    if (_symptomController.text.isNotEmpty) {
      symptoms.add('Custom symptoms');
    }
    
    // Simple logic to generate mock results based on symptoms
    if (symptoms.contains('Fever') && symptoms.contains('Cough')) {
      return {
        'conditions': ['Common Cold', 'Flu', 'COVID-19 (possible)'],
        'specialists': ['General Medicine', 'Infectious Disease', 'Pulmonology'],
        'urgency': 'Medium',
      };
    } else if (symptoms.contains('Chest pain') || symptoms.contains('Shortness of breath')) {
      return {
        'conditions': ['Angina', 'Heart Attack', 'Pulmonary Embolism'],
        'specialists': ['Cardiology', 'Emergency Medicine', 'Pulmonology'],
        'urgency': 'High',
      };
    } else if (symptoms.contains('Headache') && symptoms.contains('Nausea')) {
      return {
        'conditions': ['Migraine', 'Tension Headache', 'Cluster Headache'],
        'specialists': ['Neurology', 'General Medicine'],
        'urgency': 'Medium',
      };
    } else {
      return {
        'conditions': ['General Consultation Needed', 'Symptom Monitoring Required'],
        'specialists': ['General Medicine', 'Family Medicine'],
        'urgency': 'Low',
      };
    }
  }
}
