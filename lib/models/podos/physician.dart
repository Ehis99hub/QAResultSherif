class Physician {
  final String name;
  final String picture;
  final String specialty;
  final String bio;
  final Schedule schedule;
  final List<String> qalifications;
  final List<Education> education;
  final int experience;

  const Physician({
    this.name,
    this.picture,
    this.specialty,
    this.bio,
    this.qalifications,
    this.experience,
    this.schedule,
    this.education,
  });
}

class Schedule {
  final num weekStart;
  final num weekEnd;
  final num dayStart;
  final num dayEnd;

  const Schedule({
    this.weekEnd,
    this.weekStart,
    this.dayEnd,
    this.dayStart,
  });
}

class Education {
  final num graduated;
  final String discipline;
  final String institution;

  const Education({
    this.graduated,
    this.discipline,
    this.institution,
  });
}