class Subject {
  String title;
  double percentageComplete;
  int lessonsCount;
  List<SubjectModule> subjectModules;
  Subject(
      {this.title,
      this.lessonsCount,
      this.percentageComplete,
      this.subjectModules});
}

class SubjectModule {
  String title;
  int index;
  List<SubjectLesson> subjectLessons;
  SubjectModule({this.title, this.index, this.subjectLessons});
}

class SubjectLesson {
  String title, artUrl, videoUrl, description;
}
