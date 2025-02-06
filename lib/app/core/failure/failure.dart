/// A Failure class in Dart is typically used for handling errors in a more granular way.
/// It represents a more specific kind of error with an explanatory message.
class Failure {
  /// The message of the error, explaining what went wrong.
  final String message;

  /// Constructor for the Failure class.
  /// It takes a message as a parameter to provide detailed error information.
  Failure(this.message);
}
