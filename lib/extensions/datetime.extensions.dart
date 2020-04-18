extension DateOnlyCompare on DateTime {
  int compareDate(DateTime other) {
    if (other == null) {
      return 1;
    }
    if (year != other.year) {
      return year < other.year ? -1 : 1;
    }
    if (month != other.month) {
      return month < other.month ? -1 : 1;
    }
    if (day != other.day) {
      return day < other.day ? -1 : 1;
    }
    return 0;
  }
}
