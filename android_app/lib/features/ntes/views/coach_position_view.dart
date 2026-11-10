import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_colors.dart';
import '../../../data/models/train_model.dart';
import '../../../data/services/mock_api_service.dart';

class CoachPositionView extends StatefulWidget {
  const CoachPositionView({super.key});

  @override
  State<CoachPositionView> createState() => _CoachPositionViewState();
}

class _CoachPositionViewState extends State<CoachPositionView> {
  final trainController = TextEditingController(text: '12952');
  List<CoachInfo> coaches = [];
  bool isLoading = false;
  int selectedCoachIndex = 6; // Defaults to B2

  @override
  void initState() {
    super.initState();
    _fetchCoachPosition('12952');
  }

  void _fetchCoachPosition(String train) async {
    setState(() => isLoading = true);
    final list = await MockApiService.getCoachPosition(train);
    setState(() {
      coaches = list;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Coach Position'),
      ),
      body: Column(
        children: [
          Container(
            color: AppColors.surface,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: trainController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Train Number',
                      hintText: 'Enter 5-digit train number',
                      prefixIcon: Icon(Icons.train_outlined, color: AppColors.primaryBlue),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () => _fetchCoachPosition(trainController.text),
                  child: const Text('Search'),
                ),
              ],
            ),
          ),
          if (isLoading)
            const Expanded(
              child: Center(
                child: CircularProgressIndicator(color: AppColors.primaryBlue),
              ),
            )
          else ...[
            Padding(
              padding: const EdgeInsets.all(16),
              child: Card(
                margin: EdgeInsets.zero,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Train ${trainController.text} - Rake Composition',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.primaryBlue.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              'Standard 15 Coaches',
                              style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.primaryBlue),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Engine -> Rear Guard sequence for platform alignment:',
                        style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Horizontal Train Track & Coach Formation Scroller
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              height: 110,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                scrollDirection: Axis.horizontal,
                itemCount: coaches.length,
                itemBuilder: (ctx, idx) {
                  final coach = coaches[idx];
                  final isSelected = idx == selectedCoachIndex;

                  Color coachColor;
                  if (coach.type == 'LOCOMOTIVE') {
                    coachColor = Colors.grey.shade800;
                  } else if (coach.type == '1A') {
                    coachColor = AppColors.coach1A;
                  } else if (coach.type == '2A') {
                    coachColor = AppColors.coach2A;
                  } else if (coach.type == '3A') {
                    coachColor = AppColors.coach3A;
                  } else if (coach.type == 'SLEEPER') {
                    coachColor = AppColors.coachSL;
                  } else {
                    coachColor = AppColors.coachGen;
                  }

                  return GestureDetector(
                    onTap: () => setState(() => selectedCoachIndex = idx),
                    child: Container(
                      width: 65,
                      margin: const EdgeInsets.only(right: 6),
                      decoration: BoxDecoration(
                        color: isSelected ? coachColor.withOpacity(0.18) : AppColors.surface,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isSelected ? coachColor : AppColors.cardBorder,
                          width: isSelected ? 2.5 : 1.0,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: coachColor,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              '${coach.position}',
                              style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            coach.code,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: coachColor,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            coach.type,
                            style: const TextStyle(fontSize: 9, color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            // Selected Coach Detail Card
            if (selectedCoachIndex < coaches.length)
              Padding(
                padding: const EdgeInsets.all(16),
                child: Card(
                  margin: EdgeInsets.zero,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Selected Coach: ${coaches[selectedCoachIndex].code} (${coaches[selectedCoachIndex].type})',
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Position ${coaches[selectedCoachIndex].position} from Engine • Capacity: ${coaches[selectedCoachIndex].berthCount} Berths',
                          style: const TextStyle(fontSize: 13, color: AppColors.textSecondary),
                        ),
                        const Divider(height: 20),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text('Lower Berth: 1-18', style: TextStyle(fontSize: 12)),
                            Text('Middle: 19-36', style: TextStyle(fontSize: 12)),
                            Text('Upper: 37-54', style: TextStyle(fontSize: 12)),
                            Text('Side: 55-72', style: TextStyle(fontSize: 12)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ],
      ),
    );
  }
}

