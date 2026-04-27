import 'package:flutter/material.dart';
import 'record_tile.dart';

void showAllRecordsBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) {
      return DraggableScrollableSheet(
        initialChildSize: 0.85,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (context, scrollController) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
            ),
            child: Column(
              children: [
                const SizedBox(height: 12),

                Container(
                  width: 50,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  "All Records",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 20),

                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: 20,
                    itemBuilder: (_, index) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        child: RecordTile(),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
