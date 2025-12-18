import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Data model for a medication
class Medication {
  final String name;
  final DateTime prescribeDate;

  Medication({required this.name, required this.prescribeDate});
}

class Medsinfo extends StatefulWidget {
  @override
  _MedsInfoState createState() => _MedsInfoState();
}

enum SortOption { byDate, byName }

class _MedsInfoState extends State<Medsinfo> {
  SortOption _sortOption = SortOption.byDate;

  // Sample medication data to simulate a database
  final List<Medication> _medications = [
    Medication(name: 'Ibuprofen', prescribeDate: DateTime(2024, 5, 20)),
    Medication(name: 'Paracetamol', prescribeDate: DateTime(2024, 5, 20)),
    Medication(name: 'Amoxicillin', prescribeDate: DateTime(2024, 5, 22)),
    Medication(name: 'Cetirizine', prescribeDate: DateTime(2024, 5, 22)),
    Medication(name: 'Loratadine', prescribeDate: DateTime(2024, 5, 20)),
    Medication(name: 'Omeprazole', prescribeDate: DateTime(2024, 5, 21)),
    Medication(name: 'M1', prescribeDate: DateTime(2024, 5, 23)),
    Medication(name: 'M2', prescribeDate: DateTime(2024, 5, 23)),
    Medication(name: 'M3', prescribeDate: DateTime(2024, 5, 23)),
    Medication(name: 'M4', prescribeDate: DateTime(2024, 5, 23)),
  ];

  void _setSortOption(SortOption option) {
    setState(() {
      _sortOption = option;
    });
  }

  // Helper to group medications by date
  Map<DateTime, List<Medication>> _groupMedsByDate(List<Medication> meds) {
    Map<DateTime, List<Medication>> grouped = {};
    for (var med in meds) {
      // Use date only, ignoring time component
      DateTime date = DateTime(med.prescribeDate.year, med.prescribeDate.month, med.prescribeDate.day);
      if (grouped[date] == null) {
        grouped[date] = [];
      }
      grouped[date]!.add(med);
    }
    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meds Info' ,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        actions: [
          PopupMenuButton<SortOption>(
            onSelected: _setSortOption,
            icon: Icon(Icons.sort),
            itemBuilder: (BuildContext context) => <PopupMenuEntry<SortOption>>[
              const PopupMenuItem<SortOption>(
                value: SortOption.byDate,
                child: Text('Sort by Date'),
              ),
              const PopupMenuItem<SortOption>(
                value: SortOption.byName,
                child: Text('Sort by Name (A-Z)'),
              ),
            ],
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_sortOption == SortOption.byName) {
      List<Medication> sortedMeds = List.from(_medications);
      sortedMeds.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
      return _buildAlphabeticalList(sortedMeds);
    } else {
      // Default to sorting by date
      List<Medication> sortedMeds = List.from(_medications);
      sortedMeds.sort((a, b) => b.prescribeDate.compareTo(a.prescribeDate));
      
      Map<DateTime, List<Medication>> groupedMeds = _groupMedsByDate(sortedMeds);
      var sortedDates = groupedMeds.keys.toList();
      // Dates are already sorted descending due to the initial sort

      return _buildGroupedByDateList(groupedMeds, sortedDates);
    }
  }

  Widget _buildAlphabeticalList(List<Medication> meds) {
    return ListView.builder(
      itemCount: meds.length,
      itemBuilder: (context, index) {
        final med = meds[index];
        return Card(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: ListTile(
            title: Text(med.name),
            subtitle: Text('Prescribed on: ${DateFormat.yMMMd().format(med.prescribeDate)}'),
          ),
        );
      },
    );
  }

  Widget _buildGroupedByDateList(Map<DateTime, List<Medication>> groupedMeds, List<DateTime> sortedDates) {
    return ListView.builder(
      itemCount: sortedDates.length,
      itemBuilder: (context, index) {
        DateTime date = sortedDates[index];
        List<Medication> medsOnDate = groupedMeds[date]!;
        // Sort meds on the same day alphabetically for a consistent order
        medsOnDate.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
                child: Text(
                  'Date of prescribe: ${DateFormat.yMMMd().format(date)}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3.5,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: medsOnDate.length,
                itemBuilder: (context, gridIndex) {
                  return Card(
                    elevation: 2,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          medsOnDate[gridIndex].name,
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
