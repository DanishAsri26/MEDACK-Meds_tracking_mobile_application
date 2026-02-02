import 'dart:convert';
import 'dart:typed_data';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  final String apiKey = 'PUT KEY HERE';
  late final GenerativeModel _model;

  GeminiService() {
    _model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: apiKey,
    );
  }

  Future<Map<String, String>?> extractMedicationInfo(Uint8List imageBytes) async {
    try {
      final prompt = 'Extract the following information from this medication label image: '
          '1. Patient name '
          '2. Medication name '
          '3. General information '
          '4. When to eat (based on doctor\'s prescription). '
          'Please return the result in JSON format with keys: "patientName", "medicationName", "information", "dosageInstructions". '
          'If any field is not found, use "Not found".';

      final content = [
        Content.multi([
          TextPart(prompt),
          DataPart('image/jpeg', imageBytes),
        ])
      ];

      final response = await _model.generateContent(content);
      
      if (response.text != null) {
        // Find the JSON block in the response if it's wrapped in markdown
        String text = response.text!;
        if (text.contains('```json')) {
          text = text.split('```json')[1].split('```')[0].trim();
        } else if (text.contains('```')) {
          text = text.split('```')[1].split('```')[0].trim();
        }
        
        try {
          final Map<String, dynamic> decoded = jsonDecode(text);
          return decoded.map((key, value) => MapEntry(key, value.toString()));
        } catch (e) {
          print('Error parsing JSON from Gemini: $e');
          // Fallback parsing if JSON decode fails
          return {
            'patientName': 'Error parsing',
            'medicationName': 'Error parsing',
            'information': 'Error parsing',
            'dosageInstructions': text,
          };
        }
      }
    } catch (e) {
      print('Error calling Gemini API: $e');
    }
    return null;
  }
}
