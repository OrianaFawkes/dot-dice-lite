// Defines the Log entity class.

// Represents a single log entry in the dice roll history.
class Log {
  final String firstImage;
  final String secondImage;
  final int sum;

  Log({
    required this.firstImage,
    required this.secondImage,
    required this.sum,
  });
}
