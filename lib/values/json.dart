import 'package:roavapp/models/podos/dashboard_item.dart';
import 'package:roavapp/models/podos/destination.dart';
import 'package:roavapp/models/podos/physician.dart';
import 'package:roavapp/values/images.dart';

const List<DashboardItem> dashItems = [
  DashboardItem(
    title: "Visit a doctor",
    icon: AppSvgs.steth,
    route: "/doctors",
  ),
  DashboardItem(
    title: "Prescription",
    icon: AppSvgs.notepad,
    route: "/prescriptions",
  ),
  DashboardItem(
    title: "Directions",
    icon: AppSvgs.compass,
    route: "/map",
  ),
  DashboardItem(
    title: "Covid",
    icon: AppSvgs.call,
    route: "/covid",
  ),
  DashboardItem(
    title: "Emergency",
    icon: AppSvgs.ambulance,
    route: "/emergency",
  ),
  DashboardItem(
    title: "Discharged",
    icon: AppSvgs.discharged,
    route: "/discharges",
  ),
];

const List<String> tabItems = [
  "GP",
  "Specialist",
  "Dentist",
  "Therapist",
];

const List<Physician> physicians = [
  const Physician(
    picture: AppImages.docLily,
    name: "Dr. Lily Aldrin",
    specialty: "Neurologist",
    qalifications: [
      "Specialist",
      "Therapist",
    ],
    experience: 25,
    schedule: Schedule(
      weekStart: 2,
      weekEnd: 5,
      dayStart: 9,
      dayEnd: 17,
    ),
    education: [
      Education(
        institution: "NYU",
        discipline: "Medicine",
        graduated: 1980,
      ),
      Education(
        institution: "Northwestern",
        discipline: "Neurology",
        graduated: 1985,
      ),
    ],
    bio:
        "Dr. Lily was born on Jun 1962 in Los Angeles. She went to NYO medical school to study medical science. She graduated in 1980 and started to work in some clinics. After 5 years she established 2 health clinics in NYC. According to patient reviews, Lily is the best Neurologist ever.",
  ),
  const Physician(
    picture: AppImages.docMosby,
    name: "Dr. Ted Mosby",
    specialty: "Pediatrician",
    qalifications: [
      "Specialist",
      "GP",
    ],
    experience: 10,
    schedule: Schedule(
      weekStart: 1,
      weekEnd: 5,
      dayStart: 9,
      dayEnd: 17,
    ),
    education: [
      Education(
        institution: "NYU",
        discipline: "Medicine",
        graduated: 2004,
      ),
      Education(
        institution: "Stanford",
        discipline: "Pediatrics",
        graduated: 2010,
      ),
    ],
    bio:
        "Dr. Mosby was born on Jun 1982 in NYC. He went to NYO medical school to study medical science. He graduated in 2010 and started to work in some clinics. After 5 years he established 2 health clinics in NYC. According to parents reviews, most of the children like Dr. Mosby because he knows about child psychology and can communicate well with children.",
  ),
  const Physician(
    picture: AppImages.docEmma,
    name: "Dr. Emma Lee",
    specialty: "Dermatologist",
    qalifications: [
      "Specialist",
      "Therapist",
    ],
    schedule: Schedule(
      weekStart: 3,
      weekEnd: 6,
      dayStart: 9,
      dayEnd: 15,
    ),
    education: [
      Education(
        institution: "NYU",
        discipline: "Medicine",
        graduated: 2010,
      ),
      Education(
        institution: "Princeton",
        discipline: "Dermatology",
        graduated: 2015,
      ),
    ],
    experience: 5,
    bio:
        "Dr. Emma was born on Jun 1992 in Alabama. She went to NYO medical school to study medical science. She graduated in 2015 and started to work in some clinics. After 5 years she established 2 health clinics in NYC. According to patient reviews, Lily is the best Dermatologist ever.",
  ),
  const Physician(
    picture: AppImages.docRoss,
    name: "Dr. Ross Geller",
    specialty: "Cardiologist",
    qalifications: [
      "Specialist",
    ],
    schedule: Schedule(
      weekStart: 2,
      weekEnd: 5,
      dayStart: 7,
      dayEnd: 13,
    ),
    education: [
      Education(
        institution: "Ben Gurion",
        discipline: "Medicine",
        graduated: 1985,
      ),
      Education(
        institution: "NYU",
        discipline: "Cardiology",
        graduated: 1992,
      ),
    ],
    experience: 12,
    bio:
        "Dr. Geller was born on Jun 1972 in Beth-Lehem Israel. He went to NYO medical school to study medical science. He graduated in 1992 and started to work in some clinics. After 5 years he established 2 health clinics in NYC. According to patient reviews, Emma is the best Cardiologist ever.",
  ),
  const Physician(
    picture: AppImages.docAmy,
    name: "Dr. Amy Joy",
    specialty: "Gynecologist",
    qalifications: [
      "Specialist",
      "Therapist",
    ],
    schedule: Schedule(
      weekStart: 1,
      weekEnd: 4,
      dayStart: 8,
      dayEnd: 16,
    ),
    education: [
      Education(
        institution: "NYU",
        discipline: "Dermatology",
        graduated: 1988,
      ),
    ],
    experience: 15,
    bio:
        "Dr. Amy was born on Jun 1968 in Anchorage, She went to NYO medical school to study medical science. She graduated in 1988 and started to work in some clinics. After 5 years she established 2 health clinics in NYC. According to patient reviews, Lily is the best Gynecologist ever.",
  ),
];

const Destination hospitalLocation = Destination(
  name: "Green Medical Center",
  long: 3.3507791,
  lat: 6.5819464,
  picture: "",
);

const days = [
  {
    "short": "Mon",
    "long": "Monday",
  },
  {
    "short": "Tue",
    "long": "Tuesday",
  },
  {
    "short": "Wed",
    "long": "Wednesday",
  },
  {
    "short": "Thu",
    "long": "Thursday",
  },
  {
    "short": "Fri",
    "long": "Friday",
  },
  {
    "short": "Sat",
    "long": "Saturday",
  },
  {
    "short": "Sun",
    "long": "Sunday",
  },
];
