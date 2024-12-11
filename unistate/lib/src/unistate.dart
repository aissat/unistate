/// An abstract class representing a state management interface.
///
/// Provides methods to get the current state, update it, and perform
/// actions or reset the state.
abstract class UniState<T> {
  /// Retrieves the current state.
  T get state;

  /// Cleans up resources when they are no longer needed.
  void dispose();

  /// Performs a custom operation based on the [actionType].
  ///
  /// The optional [payload] can be used to pass additional data.
  void performAction(String actionType, [dynamic payload]);

  /// Resets to the initial state.
  void resetState();

  /// Updates the state with [newState].
  void updateState(T newState);
}
