class Filters {
  DateTime startDate = DateTime(0);
  DateTime endDate = DateTime(2101);
  int minPriority = 0;
  int maxPriority = 5;

  void reset(){
    startDate = DateTime(0);
    endDate = DateTime(2101);
    minPriority = 0;
    maxPriority = 5;
  }
}