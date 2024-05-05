import 'package:flutter/material.dart';

@immutable
class ComplainState {
  static const PROCESSING = 1;
  static const INITIAL = 0;
  static const COMPLETE = 2;

  final String error;
  final int state;

  ComplainState({
    required this.error,
    required this.state,
  });

  ComplainState clone({
    String? error,
    int? state,
  }) {
    return ComplainState(
      error: error ?? this.error,
      state: state ?? this.state,
    );
  }

  static ComplainState get initialState =>
      ComplainState(error: "", state: INITIAL);
}
