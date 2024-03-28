import 'package:flutter/material.dart';
import '../models/trip.dart';
import '../screens/moreTripInfo.dart'; // Импортируйте новый экран

class TripCard extends StatelessWidget {
  final Trip trip;
  final VoidCallback loadDataFromServer;

  const TripCard({Key? key, required this.trip, required this.loadDataFromServer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TripMoreInfoScreen(trip: trip, loadDataFromServer: loadDataFromServer)),
        );
      },
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              trip.imageUrl,
              width: double.infinity,
              height: 70,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    trip.title,
                    style: Theme.of(context).textTheme.titleSmall
                  ),
                  const SizedBox(height: 8),
                  Text(
                    trip.destination,
                    style: Theme.of(context).textTheme.labelMedium
                    ),
                  const SizedBox(height: 8),
                  Text(
                    'Number of Days: ${trip.numberOfDays}',
                     style: Theme.of(context).textTheme.labelMedium),
                  Text(
                    'Number of People: ${trip.numberOfPeople}',
                    style: Theme.of(context).textTheme.labelMedium)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
