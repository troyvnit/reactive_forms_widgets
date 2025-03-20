import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reactive_forms/reactive_forms.dart';

/// Represents a control value accessor that convert between data types
/// [DateTimeRange] and [String].
class DateTimeRangeValueAccessor
    extends ControlValueAccessor<DateTimeRange, String> {
  final DateFormat dateTimeFormat;
  final String delimiter;

  DateTimeRangeValueAccessor({
    DateFormat? dateTimeFormat,
    this.delimiter = ' - ',
  }) : dateTimeFormat = dateTimeFormat ?? DateFormat('yyyy/MM/dd');

  @override
  String? modelToViewValue(DateTimeRange? modelValue) {
    return modelValue == null
        ? ''
        : '${dateTimeFormat.format(modelValue.start)}$delimiter${dateTimeFormat.format(modelValue.end)}';
  }

  @override
  DateTimeRange? viewToModelValue(String? viewValue) {
    final dateRange = viewValue == null || viewValue.isEmpty
        ? null
        : viewValue.trim().split(delimiter);

    return dateRange == null || dateRange.isEmpty
        ? null
        : DateTimeRange(
            start: dateTimeFormat.parse(dateRange.first),
            end: dateTimeFormat.parse(dateRange.last));
  }
}
