import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'dart:html' as html;
import 'dart:typed_data';

import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:tin_portfolio/main.dart';
import 'package:tin_portfolio/pages/education.dart';
import 'package:tin_portfolio/pages/experience.dart';
import 'package:tin_portfolio/pages/project.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class HeroSection extends StatefulWidget {
  final String page;
  const HeroSection({
    super.key,
    required this.page,
  });

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  // Add controllers to get the text field values
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  // Scroll controller for smooth scrolling
  final ScrollController _scrollController = ScrollController();

  // GlobalKeys for each section

  final GlobalKey _experiencesKey = GlobalKey();
  final GlobalKey _educationKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  // Back to top button visibility
  bool _showBackToTop = false;

  // Animation controllers for scroll-triggered animations
  late AnimationController _mainController;
  late AnimationController _experiencesController;
  late AnimationController _educationController;
  late AnimationController _projectsController;
  late AnimationController _contactController;

  // Section animations
  late Animation<double> _experiencesFadeAnimation;
  late Animation<double> _educationFadeAnimation;
  late Animation<double> _projectsFadeAnimation;
  late Animation<double> _contactFadeAnimation;

  final List<Experience> _experiences = const [
    Experience(
      title: 'Software Engineer',
      company: 'Whatif Solutions Sdn Bhd',
      duration: 'May 2025 - Present',
      responsibilities: [
        'Developed high-performance Flutter apps such as Digicraft Home, Zcultures, and Thine, with scalable and user-focused mobile solutions in various fields.',
        'Bring on boarded Apple in-app purchase subscriptions, and payment flows, providing secure, compliant and seamless billing experiences on iOS.',
        'Added live chat and messaging services with ZEGOCLOUD which allow responsiveness and reliability when communicating within the app.',
        'Design and development of maintainable application architectures in modular form, which is important in ensuring easy integration of features in complex multi-module systems.',
        'Created and added Apple Shortcuts to automate user workflows and make apps more accessible and user friendly in the Apple ecosystem.',
        'Worked closely with the cross-functional teams to improve the performance, reliability, and scalability of the applications and adhering to the best practices in clean architecture and state management.'
      ],
      link: 'https://www.whatifsolutions.my/',
    ),
    Experience(
      title: 'Senior Mobile Developer(Team Lead)',
      company: 'Startrick Sdn Bhd',
      duration: 'Dec 2024 - May 2025',
      responsibilities: [
        'Created high performance Flutter software in the areas of Gym Management, Point and Loyalty systems, and E-commerce sites.',
        'Developed as a contribution to the Event Planning System included in the MoveOn SuperApp and provides scalability in a multi-module application.',
        'Managed a development team, increased performance and scaling of apps, and reviewed the code to guarantee the high code quality.'
      ],
      link: 'https://www.linkedin.com/company/startrick-sdn-bhd/',
    ),
    Experience(
      title: 'Senior Mobile Developer',
      company: 'AYA Innovation Labs',
      duration: 'Dec 2023 - Dec 2024',
      responsibilities: [
        'Designed and developed the AYA Pay Wallet App, Partner App, and AYA Agency App, supporting secure financial transactions and agent management in the fintech ecosystem.',
        'Integrated payment gateways and real-time notifications using Firebase, working closely with backend teams to implement secure APIs, authentication flows, and transaction processing.',
        'Collaborated with UI/UX and backend teams to enhance performance, usability, and overall system reliability.',
      ],
      link: 'https://www.ayainnovationlabs.com/',
    ),
    Experience(
      title: 'Senior Mobile Developer',
      company: 'Super Seven Stars',
      duration: 'Dec 2022 - Dec 2023',
      responsibilities: [
        'Developed and maintained mobile applications for customer engagement solutions,including an on-demand delivery feature.',
        'Integrated Firebase and WebSocket to provide real-time delivery man’s location updates to customer.',
        'Improved app stability and reduce app crash rates by 90% through performance optimizations'
      ],
      link: 'https://www.supersevenstars.com/',
    ),
    Experience(
      title: 'Mobile Developer',
      company: 'UMG Myanmar',
      duration: 'Dec 2021 - Dec 2022',
      responsibilities: [
        'Built and maintained Hi5 App (HR & Attendance tracking system) with selfie-based',
        'Worked on the development of the PyawMae (Chatting App) with NodeJS backend and WebSocket, and Interviewer (HR) App with Flutter.',
        'Integrated Firebase services for push notifications and real-time data synchronization.',
        'Integrated Odoo ERP for HR automation and data synchronization.'
      ],
      link: 'https://www.umgmyanmar.com/',
    ),
    Experience(
      title: 'Junior Mobile Developer',
      company: 'KH Logistics',
      duration: 'May 2021 - Nov 2021',
      responsibilities: [
        'Developed an Ecommerce Mobile App similar to the Alibaba and Shopee, handling product listings, order management and authentication',
        'Designed the app UI/UX from scratch using Figma, ensuring an intuitive and visually appealing user experience.',
      ],
      link: 'https://www.linkedin.com/company/kh-logistic/',
    ),
  ];

  final List<EducationItem> _educationItems = const [
    EducationItem(
      degree: 'Bachelor of Science - BSc(Hons), Computing',
      university: 'University of Greenwich',
      duration: 'Dec 2024 - Nov 2025',
      linkUni: 'https://www.gre.ac.uk/',
      linkDegree: '',
    ),
    EducationItem(
      degree: 'Level-5 Higher Diploma, Computing',
      university: 'NCC Education',
      duration: 'Dec 2023 - Oct 2024',
      linkUni: 'https://www.nccedu.com/',
      linkDegree:
          'https://drive.google.com/file/d/1iII3wrVCnA3Imhl637isbUbec9l4_6gN/view?usp=sharing',
    ),
    EducationItem(
      degree: 'Level-4 Higher Diploma, Computing',
      university: 'NCC Education',
      duration: 'Jan 2023 - Dec 2023',
      linkUni: 'https://www.nccedu.com/',
      linkDegree:
          'https://drive.google.com/file/d/1tHmTdBznx6mqbwAFevGjSgFia1aazUE9/view?usp=sharing',
    ),
    EducationItem(
      degree: 'Bachelor of Eletronic and Communication Engineering(Final)',
      university: 'Technological University (Thanlyin)',
      duration: 'Dec 2014 - Feb 2020',
      linkUni: 'https://tuthanlyin.edu.mm/',
      linkDegree:
          'https://tuthanlyin.edu.mm/department/electronic-engineering/',
    ),
  ];

  final List<CertificationItem> _certificationItems = const [
    CertificationItem(
      icon: Icons.phone_android,
      name: 'Myanmar Roboleague',
      link:
          'https://drive.google.com/file/d/1omIB7SXl7D_xmjbrkk-nEPDkfPuxvqD8/view?usp=sharing',
    ),
  ];

  final List<Project> _projects = const [
    Project(
      company: "Whatif Solutions Sdn Bhd",
      status: "Live on Google Play/App Store",
      images: [
        "assets/images/digi_5.png",
        "assets/images/digi_1.png",
        "assets/images/digi_2.png",
        "assets/images/digi_3.png",
        "assets/images/digi_4.png",
      ],
      imagePath: 'assets/images/digicraft_main.png',
      title: 'Digicraft Home',
      description:
          'A smart home control app that connects users with their IoT devices, allowing them to monitor and manage appliances remotely.',
      techIcons: FontAwesomeIcons.flutter,
      role: 'Code refactoring of legacy project, bug fixing on spot',
      platform: "mobile",
      iosLink: "https://apps.apple.com/th/app/digicraft-home/id6443853027",
      androidLink:
          "https://play.google.com/store/apps/details?id=com.whatif.mobile.homesecurity&pcampaignid=web_share",
      webLink: "",
      techStacks: [
        {"Framework/Language": "Flutter/Dart"},
        {"Architecture": "MVC"},
        {"State Management": "Flutx"},
        {"Backend": "MQTT broker"},
      ],
      psAndKf: [
        "Remote monitoring and control of smart appliances",
        "Real-time device status updates through MQTT",
        "Unified dashboard for managing multiple IoT devices",
        "Lightweight and efficient communication for low-power devices",
        "Apple Shortcuts integration enabling quick gate and door control via  iOS automations",
      ],
      challenges: [
        "Refactoring legacy Flutter codebase into a maintainable MVC structure",
        "Fixing critical bugs in device connectivity and real-time updates",
        "Ensuring smooth MQTT communication across different device types",
        "Improving UI consistency and responsiveness within Flutx framework"
      ],
    ),
    Project(
      status: "Live on Google Play/App Store",
      company: "Whatif Solutions Sdn Bhd",
      images: [
        "assets/images/zcul_1.png",
        "assets/images/zcul_2.png",
        "assets/images/zcul_3.png",
        "assets/images/zcul_4.png",
        "assets/images/zcul_5.png",
        "assets/images/zcul_6.png",
      ],
      imagePath: 'assets/images/zcultures_main.png',
      title: 'Zcultures',
      description:
          'A global AI-powered social commerce platform that leverages an O2O strategy to connect brands, creators, and nightlife venues for engagement.',
      techIcons: FontAwesomeIcons.flutter,
      role:
          'Implemented application features, refactored legacy code, fixed production bugs, and optimized app stability and performance',
      platform: "mobile",
      iosLink: "https://apps.apple.com/th/app/zcultures/id6747009373",
      androidLink:
          "https://play.google.com/store/apps/details?id=com.zcultures.friends&pcampaignid=web_share",
      webLink: "",
      techStacks: [
        {"Framework/Language": "Flutter/Dart"},
        {"Architecture": "MVC"},
        {"State Management": "Flutx"},
        {"Backend": "PHP"},
      ],
      psAndKf: [
        "AI-powered recommendations for products, events, and venues",
        "Seamless O2O (Online-to-Offline) integration for social and commercial activities",
        "Interactive platform connecting brands, creators, and nightlife venues",
        "Personalized user experiences through smart data-driven features",
        "Real-time in-app messaging and chat powered by ZEGOCLOUD"
      ],
      challenges: [
        "Refactoring legacy Flutter codebase for improved maintainability",
        "Fixing UI inconsistencies and optimizing state management with Provider",
        "Resolving performance issues in real-time feed and recommendation rendering",
        "Enhancing app stability and scalability within the MVC + Flutx structure",
        "Ensuring reliable real-time chat communication through seamless integration with ZEGOCLOUD",
      ],
    ),
    Project(
      status: "Not launched yet",
      company: "Whatif Solutions Sdn Bhd",
      images: [
        "assets/images/Soul-Login-Phone.png",
        "assets/images/Soul-Sign-up.png",
        "assets/images/Soul-Onboarding-gender.png",
        "assets/images/Soul-Match.png",
        "assets/images/Soul-Non-match-User-view.png",
        "assets/images/Soul-Feed.png",
      ],
      imagePath: "assets/images/Soul-Login-Phone.png",
      title: 'Thine App',
      description:
          'A next-generation social discovery and dating app that connect users based on interests, preferences, and behaviors.',
      techIcons: FontAwesomeIcons.flutter,
      role:
          'Implemented application features, refactored legacy code, fixed production bugs, and optimized app stability and performance',
      platform: "mobile",
      iosLink: "",
      androidLink: "",
      webLink: "",
      techStacks: [
        {"Framework/Language": "Flutter/Dart"},
        {"Architecture": "MVC"},
        {"State Management": "Flutx"},
        {"Backend": "PHP"},
      ],
      psAndKf: [
        "User matching based on interests and behaviors",
        "Personalized content feed with social discovery features",
        "Secure user authentication and profile management",
        "Interactive UI/UX design for engaging user experiences",
      ],
      challenges: [
        "Refactoring legacy Flutter codebase for improved maintainability",
        "Fixing UI inconsistencies and optimizing state management with Flutx",
        "Resolving performance issues in real-time feed and recommendation rendering",
        "Enhancing app stability and scalability within the MVC + Flutx structure",
      ],
    ),
    Project(
        company: "Startrick Sdn Bhd",
        images: [
          "assets/images/gym1.png",
          "assets/images/gym2.png",
          "assets/images/gym3.png",
          "assets/images/gym4.png",
          "assets/images/gym5.png",
        ],
        imagePath: 'assets/images/gymmain.png',
        title: '1664 Gym ',
        description:
            '1664 Gym is a gym management mobile application that provides users with a comprehensive platform to manage their fitness journey. The app offers features such as class scheduling, membership management, workout tracking, and progress monitoring. Users can easily book classes, track their workouts, and stay motivated on their fitness goals through an intuitive and user-friendly interface.',
        techIcons: FontAwesomeIcons.flutter,
        role:
            'Led the project as Team Lead, implementing core application features, refactoring legacy code, resolving production issues, and optimizing overall app stability and performance.',
        platform: "mobile",
        iosLink: "",
        androidLink:
            "https://play.google.com/store/apps/details?id=com.startrick.gym1664&hl=en",
        webLink: "",
        status: "Live on Google Play",
        techStacks: [
          {"Framework/Language": "Flutter/Dart"},
          {"Architecture": "MVVM"},
          {"State Management": "Provier"},
          {"Backend": "PHP"},
        ],
        psAndKf: [
          "Gym class and training program discovery with schedules and detailed descriptions",
          "Member registration and check-in management with real-time attendance status",
          "In-app purchase of gym memberships and training packages",
        ],
        challenges: [
          "Designing a scalable MVVM architecture to support multiple gym branches and high concurrent users",
          "Integrating secure payment gateways with backend APIs for memberships and package purchases",
          "Handling real-time updates for class bookings, check-ins, and transaction statuses",
          "Optimizing app performance for large class schedules, member data, and media-rich fitness content"
        ]),
    Project(
        company: "Move On Team",
        images: [
          "assets/images/moveon1.PNG",
          "assets/images/moveon2.PNG",
          "assets/images/moveon3.PNG",
          "assets/images/moveon4.PNG",
          "assets/images/moveon5.PNG",
          "assets/images/moveon6.PNG",
          "assets/images/moveon7.PNG",
          "assets/images/moveon8.PNG",
          "assets/images/moveon9.PNG",
          "assets/images/moveon10.PNG",
          "assets/images/moveon11.PNG",
        ],
        imagePath: 'assets/images/moveon1.PNG',
        title: 'MOVE-ON Super Apps',
        description:
            'MOVE-ON is a multi-service Super App that has been created to serve the needs of big running events in Malaysia and provide a convenient digital ecosystem to event participants, organizers, and partners. The application will allow participants to find and participate in ongoing events, enroll and participate, buy event-related products and goods in one mobile tool. It focuses on convenience, real-time communications, and scalable architecture to support a high number of users when the nation-wide running events take place.',
        techIcons: FontAwesomeIcons.flutter,
        role:
            'Led the project as Team Lead, implementing core application features, refactoring legacy code, resolving production issues, and optimizing overall app stability and performance.',
        platform: "mobile",
        iosLink:
            "https://apps.apple.com/ru/app/move-on-super-apps/id6749819421?l=en-GB",
        androidLink:
            "https://play.google.com/store/apps/details?id=com.moveonmy.moveon",
        webLink: "",
        status: "Live on Google Play/App Store",
        techStacks: [
          {"Framework/Language": "Flutter/Dart"},
          {"Architecture": "Clean Architecture"},
          {"State Management": "Bloc"},
          {"Backend": "PHP"},
        ],
        psAndKf: [
          "Running event discovery and registration with event details and schedules",
          "Participant management with real-time registration and check-in status updates",
          "In-app purchase of event tickets, race kits, and merchandise",
        ],
        challenges: [
          "Designing a scalable MVVM architecture to support multiple running events and high concurrent users",
          "Integrating secure payment gateways with backend APIs for event registration and merchandise purchases",
          "Handling real-time updates for event participation, check-ins, and transaction statuses",
          "Optimizing app performance for large event listings, participant data, and media-rich content"
        ]),
    Project(
      company: "Mya Satt Yaung Co., Ltd",
      images: [
        "assets/images/jade1.PNG",
        "assets/images/jade2.PNG",
        "assets/images/jade3.PNG",
        "assets/images/jade4.PNG",
        "assets/images/jade5.PNG",
        "assets/images/jade6.PNG",
      ],
      imagePath: 'assets/images/jademain.PNG',
      title: 'Jade Property',
      description:
          'Real Estate Application for managing properties, agents, clients, and transactions efficiently.',
      techIcons: FontAwesomeIcons.flutter,
      role:
          'Independently developed and maintained the mobile application, including feature implementation, legacy refactoring, bug fixes, and performance optimization',
      platform: "mobile",
      iosLink: "",
      androidLink: "",
      // webLink: "https://admin.bluescreen.site/",
      webLink: "",
      status: "Not launched yet",
      techStacks: [
        {"Framework/Language": "Flutter/Dart"},
        {"Architecture": "MVC"},
        {"State Management": "GetX"},
        {"Backend": "PHP"},
      ],
      psAndKf: [
        "Property listing creation and management, enabling agents and administrators to add, update, and manage real estate assets.",
        "Automated property tax fee calculations based on property type, location, and transaction details.",
        "AI-powered chatbot providing instant assistance for property inquiries, pricing, and user support.",
        "Integrated payment processing for property create and advertisement fees.",
      ],
      challenges: [
        "Integrating OneSignal to deliver reliable real-time push notifications across iOS and Android platforms.",
        "Implementing Pusher for real-time in-app events and live data updates.",
        "Ensuring message delivery consistency and synchronization between push notifications and in-app states.",
        "Handling edge cases such as background, foreground, and terminated app states for real-time communication.",
      ],
    ),
    Project(
      company: "AYA Innovation Labs",
      images: [
        "assets/images/partner1.PNG",
        "assets/images/partner2.png",
        "assets/images/partner3.png",
        "assets/images/partner4.png",
      ],
      imagePath: "assets/images/partnermain.PNG",
      title: 'AYA PAY Partner App',
      description:
          'AYA Pay Partner App is created to change the manner in which companies engage with their customers and conduct financial transactions.',
      techIcons: FontAwesomeIcons.flutter,
      role:
          'Implemented application features, refactored legacy code, fixed production bugs, and optimized app stability and performance',
      platform: "mobile",
      iosLink: "https://apps.apple.com/th/app/aya-pay-partner/id6449485948",
      androidLink:
          "https://play.google.com/store/apps/details?id=com.ayaplus.partner&hl=en",
      // webLink: "https://admin.bluescreen.site/",
      webLink: "",
      status: "Live on Google Play/App Store",
      techStacks: [
        {"Framework/Language": "Flutter/Dart"},
        {"Architecture": "Clean Architecture"},
        {"State Management": "Bloc"},
        {"Backend": "NodeJs"},
      ],
      psAndKf: [
        "Customer transaction assistance and management, enabling partners to support payments and financial operations efficiently.",
        "Centralized management of DTRs, DSEs, agents, and merchant networks within a single platform.",
        "Real-time transaction tracking and account monitoring to improve operational visibility and decision-making.",
        "Secure financial transaction handling and reporting to optimize business performance and customer experience.",
      ],

      challenges: [
        "Integrating secure payment and transaction APIs to support customer-assisted financial operations.",
        "Ensuring real-time transaction status updates and accurate account balance synchronization.",
        "Managing complex user roles and permissions for DTRs, DSEs, agents, and merchants.",
        "Handling edge cases for financial workflows, including failed, pending, and reversed transactions.",
      ],
    ),
    Project(
      company: "AYA Innovation Labs",
      images: [
        "assets/images/agency1.png",
        "assets/images/agency2.png",
        "assets/images/agency3.png",
        "assets/images/agency4.png",
      ],
      imagePath: "assets/images/agency_main.png",
      title: 'Agency Banking App',
      description:
          'Agency Banking app is created to change the manner in which companies engage with their customers and  agents financial transactions.',
      techIcons: FontAwesomeIcons.flutter,
      role:
          'Implemented application features, refactored legacy code, fixed production bugs, and optimized app stability and performance',
      platform: "mobile",
      iosLink: "",
      androidLink: "",
      // webLink: "https://admin.bluescreen.site/",
      webLink: "",
      status: "Not launched yet",
      techStacks: [
        {"Framework/Language": "Flutter/Dart"},
        {"Architecture": "Clean Architecture"},
        {"State Management": "Bloc"},
        {"Backend": "NodeJs"},
      ],
      psAndKf: [
        "Customer account inquiry and registration services, enabling agents to onboard and support customers efficiently.",
        "Cash deposit and withdrawal operations, including mobile and NRC-based cash-out transactions.",
        "Support for multiple fund transfer types, including account-to-account, account-to-mobile, and NRC-based transfers.",
        "Secure handling of NRC-to-NRC and NRC-to-mobile transfers to expand access to agency banking services.",
        "Real-time transaction processing and monitoring to ensure accuracy, reliability, and customer trust.",
      ],
      challenges: [
        "Integrating core banking and agency banking APIs to support cash deposits, withdrawals, and fund transfers.",
        "Ensuring real-time transaction status updates and accurate balance synchronization across customer and agent accounts.",
        "Managing complex agent, customer, and account validation flows, including NRC and mobile-based transactions.",
        "Handling edge cases in agency banking workflows such as transaction failures, reversals, and network interruptions.",
      ],
    ),
    Project(
        company: "Super Seven Stars",
        images: [
          "assets/images/vendor1.png",
          "assets/images/vendor2.png",
          "assets/images/vendor3.png",
          "assets/images/vendor4.png"
        ],
        imagePath: 'assets/images/vendor1.png',
        title: 'Nova Vendor App',
        description:
            'Nova Vendor App is a vendor management platform supporting vendor onboarding, product catalog control, order processing, and performance analytics. It integrates with a rider app to enable on-demand delivery workflows including order acceptance, pickup, and customer delivery.',
        techIcons: FontAwesomeIcons.flutter,
        role:
            'Independently developed and maintained the mobile application, including feature implementation, legacy refactoring, bug fixes, and performance optimization',
        platform: "mobile",
        iosLink: "",
        androidLink: "",
        webLink: "",
        status: "Not launched yet",
        techStacks: [
          {"Framework/Language": "Flutter/Dart"},
          {"Architecture": "MVVM"},
          {"State Management": "Provier"},
          {"Backend": "PHP"},
        ],
        psAndKf: [
          "Vendor product catalog management, enabling vendors to add, update, and manage their product listings efficiently.",
          "Order processing and management with real-time order status updates and tracking.",
          "Integration with rider app for on-demand delivery workflows including order acceptance, pickup, and customer delivery.",
        ],
        challenges: [
          "Integrating Firebase Push Notifications to deliver reliable real-time push notifications across iOS and Android platforms.",
          "Implementing Firebase Realtime for real-time in-app events and live data updates.",
          "Ensuring message delivery consistency and synchronization between push notifications and in-app states.",
          "Handling edge cases such as background, foreground, and terminated app states for real-time communication.",
        ]),
    Project(
        company: "Super Seven Stars",
        images: [
          "assets/images/rider1.png",
          "assets/images/rider2.png",
          "assets/images/rider3.png",
          "assets/images/rider4.png",
          "assets/images/rider5.png"
        ],
        imagePath: 'assets/images/rider1.png',
        title: 'Nova Rider App ',
        description:
            'Nova Rider App is a rider management platform supporting rider onboarding, delivery tracking, order management, and performance analytics. It integrates with a vendor app to enable on-demand delivery workflows including order acceptance, pickup, and customer delivery.',
        techIcons: FontAwesomeIcons.flutter,
        role:
            'Independently developed and maintained the mobile application, including feature implementation, legacy refactoring, bug fixes, and performance optimization',
        platform: "mobile",
        iosLink: "",
        androidLink: "",
        webLink: "",
        status: "Not launched yet",
        techStacks: [
          {"Framework/Language": "Flutter/Dart"},
          {"Architecture": "MVVM"},
          {"State Management": "Provier"},
          {"Backend": "PHP"},
        ],
        psAndKf: [
          "Rider onboarding and profile management, enabling riders to register, update their profiles, and manage their delivery assignments efficiently.",
          "Delivery tracking and management with real-time order status updates and route optimization.",
          "Integration with vendor app for on-demand delivery workflows including order acceptance, pickup, and customer delivery.",
        ],
        challenges: [
          "Integrating Firebase Push Notifications to deliver reliable real-time push notifications across iOS and Android platforms.",
          "Implementing Firebase Realtime for real-time in-app events and live data updates.",
          "Ensuring message delivery consistency and synchronization between push notifications and in-app states.",
          "Handling edge cases such as background, foreground, and terminated app states for real-time communication.",
        ]),
    Project(
        company: "UMG Myanmar",
        images: [
          "assets/images/hi51.png",
          "assets/images/hi52.png",
          "assets/images/hi53.png",
          "assets/images/hi54.png",
        ],
        imagePath: 'assets/images/hi5main.png',
        title: 'Hi5 App',
        description:
            'Hi5 Application is to conduct Employee attending, requisition and sharing about policy & announcement to all UMG Employee and can review all employee information from the database storage.',
        techIcons: FontAwesomeIcons.flutter,
        role:
            'Implemented application features, refactored legacy code, fixed production bugs, and optimized app stability and performance',
        platform: "mobile",
        iosLink: "",
        androidLink:
            "https://play.google.com/store/apps/details?id=com.umg.cid.hi5&hl=en",
        webLink: "",
        status: "Live on Google Play Store",
        techStacks: [
          {"Framework/Language": "Flutter/Dart"},
          {"Architecture": "Clean Architecture"},
          {"State Management": "Bloc"},
          {"Backend": "Odoo ERP"},
        ],
        psAndKf: [
          "Employee attendance tracking with selfie verification and geolocation tagging.",
          "Leave requisition and approval workflows integrated with Odoo ERP backend.",
          "Company policy and announcement sharing for effective internal communication.",
          "Employee profile management and information retrieval from centralized database.",
        ],
        challenges: [
          "Integrating Odoo ERP backend for seamless data synchronization and workflow management.",
          "Implementing selfie verification with facial recognition for secure attendance tracking.",
          "Handling real-time notifications and updates for leave approvals and announcements.",
          "Optimizing app performance for large employee datasets and media-rich content.",
        ]),
    Project(
        company: "Freelance",
        images: [
          "assets/images/comic1.png",
          "assets/images/comic2.png",
          "assets/images/comic3.png",
          "assets/images/comic4.png",
          "assets/images/comic5.png",
          "assets/images/comic6.png",
          "assets/images/comic7.png",
        ],
        imagePath: 'assets/images/comicmain.jpg',
        title: 'Lazy Comic App',
        description:
            'Lazy Comic App is a mobile application that allows users to browse and read comics on the go.',
        techIcons: FontAwesomeIcons.flutter,
        role:
            'Implemented application features, refactored legacy code, fixed production bugs, and optimized app stability and performance',
        platform: "mobile",
        iosLink: "",
        androidLink: "",
        webLink: "",
        status: "Not launched yet",
        techStacks: [
          {"Framework/Language": "Flutter/Dart"},
          {"Architecture": "Clean Architecture"},
          {"State Management": "Bloc"},
          {"Backend": "PHP"},
        ],
        psAndKf: [
          " Social authentication for quick and secure sign-in using Google and Facebook accounts.",
          "Read free and premium books anytime and anywhere with an extensive comic library.",
          "Purchase premium books using in-app coins for a seamless buying experience.",
          "Full-screen reading mode for an immersive experience",
        ],
        challenges: [
          "Integrating social authentication using Firebase Authentication for Google and Facebook sign-in.",
          "Implementing in-app coin purchase system with secure payment gateway integration.",
          "Designing an intuitive UI/UX for seamless comic browsing and reading experience.",
          "Optimizing app performance for smooth navigation and fast loading times.",
        ]),
  ];

  bool _isProfilePrecached = false;
  bool _typewriterDone = false;
  bool _isSending = false;
  PageController? _projectsPageController;
  int _currentProjectIndex = 0;
  @override
  void initState() {
    super.initState();

    // Initialize main animation controller
    _mainController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    );

    // Initialize section animation controllers
    _experiencesController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _educationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _projectsController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _contactController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _scrollController.addListener(() {
      if (_scrollController.offset >= 400) {
        if (!_showBackToTop) {
          setState(() {
            _showBackToTop = true;
          });
        }
      } else {
        if (_showBackToTop) {
          setState(() {
            _showBackToTop = false;
          });
        }
      }

      _triggerSectionAnimations();
    });

    // Section animations
    _experiencesFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: _experiencesController, curve: Curves.easeInOut));
    _educationFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _educationController, curve: Curves.easeInOut));
    _projectsFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _projectsController, curve: Curves.easeInOut));
    _contactFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _contactController, curve: Curves.easeInOut));

    _mainController.forward();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _precacheProfileImage();
    });

    _projectsPageController = PageController(viewportFraction: 0.85);
  }

  Future<void> _precacheProfileImage() async {
    const imagePath = "assets/images/pp.png";
    await precacheImage(const AssetImage(imagePath), context);
    await Future.delayed(const Duration(seconds: 1));

    if (mounted) {
      setState(() {
        _isProfilePrecached = true;
      });
    }
  }

  // Method to trigger section animations based on scroll position
  void _triggerSectionAnimations() {
    final scrollOffset = _scrollController.offset;
    final screenHeight = MediaQuery.of(context).size.height;

    // Trigger experiences animation when section comes into view
    if (scrollOffset > screenHeight * 0.3 &&
        !_experiencesController.isCompleted) {
      _experiencesController.forward();
    }

    // Trigger education animation when section comes into view
    if (scrollOffset > screenHeight * 0.8 &&
        !_educationController.isCompleted) {
      _educationController.forward();
    }

    // Trigger projects animation when section comes into view
    if (scrollOffset > screenHeight * 1.5 && !_projectsController.isCompleted) {
      _projectsController.forward();
    }

    // Trigger contact animation when section comes into view
    if (scrollOffset > screenHeight * 2.2 && !_contactController.isCompleted) {
      _contactController.forward();
    }
  }

  @override
  void dispose() {
    _mainController.dispose();
    _experiencesController.dispose();
    _educationController.dispose();
    _projectsController.dispose();
    _contactController.dispose();
    _projectsPageController?.dispose();
    _scrollController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  // Method to scroll to specific section
  void _scrollToSection(String section) {
    GlobalKey? targetKey;

    switch (section) {
      case 'Experiences':
        targetKey = _experiencesKey;
        break;
      case 'Education':
        targetKey = _educationKey;
        break;
      case 'Projects':
        targetKey = _projectsKey;
        break;
      case 'Contact':
        targetKey = _contactKey;
        break;
    }

    if (targetKey != null && targetKey.currentContext != null) {
      Scrollable.ensureVisible(
        targetKey.currentContext!,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
        alignment: 0.1, // Scroll to show the section near the top
      );
    }
  }

  // Method to scroll to top
  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _sendEmail() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSending = true;
      });

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) {
          return Center(
            child: LoadingAnimationWidget.twistingDots(
              leftDotColor: const Color(0xFF1A1A3F),
              rightDotColor: const Color(0xFFEA3799),
              size: 100,
            ),
          );
        },
      );

      try {
        final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
        const serviceId = 'service_dx6jkwf';
        const templateId = 'template_dsbktpk';
        const userId = 'nEOpcklJoxm-lX5As';

        final response = await http.post(
          url,
          headers: {
            'Content-Type': 'application/json',
          },
          body: json.encode({
            'service_id': serviceId,
            'template_id': templateId,
            'user_id': userId,
            'template_params': {
              'name': _nameController.text,
              'email': _emailController.text,
              'message': _messageController.text,
            }
          }),
        );

        Navigator.of(context, rootNavigator: true).pop();

        if (response.statusCode == 200) {
          _nameController.clear();
          _emailController.clear();
          _messageController.clear();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Message sent successfully!')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  'Failed to send message. (${response.statusCode}) Please try again.'),
            ),
          );
        }
      } catch (e) {
        Navigator.of(context, rootNavigator: true).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('An error occurred. Please try again later.')),
        );
      } finally {
        if (mounted) {
          setState(() {
            _isSending = false;
          });
        }
      }
    }
  }

  Future<void> _downloadResume() async {
    try {
      // Load the asset as bytes
      final ByteData data = await rootBundle.load("assets/Resume(Tin).pdf");
      final Uint8List bytes = data.buffer.asUint8List();
      
      // Create a blob from the bytes
      final blob = html.Blob([bytes], 'application/pdf');
      final url = html.Url.createObjectUrlFromBlob(blob);
      
      // Create and trigger download
      final anchor = html.AnchorElement(href: url)
        ..setAttribute("download", "Resume(Tin).pdf")
        ..click();
      
      // Clean up
      html.Url.revokeObjectUrl(url);
    } catch (e) {
      // Handle error - show snackbar or error message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to download resume. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final bool isDesktop = screenSize.width > 800;

    return (!_isProfilePrecached)
        ? Container(
            color: const Color.fromRGBO(1, 0, 0, 1),
            child: Center(
              child: LoadingAnimationWidget.twistingDots(
                leftDotColor: const Color(0xFF1A1A3F),
                rightDotColor: const Color(0xFFEA3799),
                size: 120,
              ),
            ),
          )
        : Scaffold(
            backgroundColor: const Color.fromRGBO(1, 0, 0, 1),
            appBar: (!isDesktop)
                ? AppBar(
                    elevation: 0,
                    backgroundColor: const Color.fromRGBO(1, 0, 0, 1),
                    iconTheme: const IconThemeData(color: Colors.white),
                  )
                : null,
            drawer: (!isDesktop)
                ? Drawer(
                    elevation: 0,
                    width: 160,
                    backgroundColor: const Color.fromRGBO(1, 0, 0, 1),
                    child: SafeArea(
                      child: ListView(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        children: [
                          ListTile(
                            title: Text('Home',
                                style:
                                    GoogleFonts.poppins(color: Colors.white)),
                            onTap: () {
                              Navigator.pop(context);
                              _scrollToTop();
                            },
                          ),
                          ListTile(
                            title: Text('Projects',
                                style:
                                    GoogleFonts.poppins(color: Colors.white)),
                            onTap: () {
                              Navigator.pop(context);
                              _scrollToSection('Projects');
                            },
                          ),
                          ListTile(
                            title: Text('Experiences',
                                style:
                                    GoogleFonts.poppins(color: Colors.white)),
                            onTap: () {
                              Navigator.pop(context);
                              _scrollToSection('Experiences');
                            },
                          ),
                          ListTile(
                            title: Text('Education',
                                style:
                                    GoogleFonts.poppins(color: Colors.white)),
                            onTap: () {
                              Navigator.pop(context);
                              _scrollToSection('Education');
                            },
                          ),
                          ListTile(
                            title: Text('Contact',
                                style:
                                    GoogleFonts.poppins(color: Colors.white)),
                            onTap: () {
                              Navigator.pop(context);
                              _scrollToSection('Contact');
                            },
                          ),
                        ],
                      ),
                    ),
                  )
                : null,
            floatingActionButton: _showBackToTop
                ? FloatingActionButton(
                    onPressed: _scrollToTop,
                    backgroundColor: const Color.fromARGB(255, 201, 250, 136),
                    foregroundColor: const Color(0xFF121212),
                    elevation: 8,
                    child: const Icon(Icons.keyboard_arrow_up, size: 28),
                  )
                : null,
            body: Container(
              decoration: const BoxDecoration(
                color: Color.fromRGBO(1, 0, 0, 1),
              ),
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (isDesktop)
                      Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          margin: const EdgeInsets.only(top: 40, right: 60),
                          height: 50,
                          child: ListView(
                            shrinkWrap: true,
                            physics: const AlwaysScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            children: [
                              NavLink(
                                  title: 'Projects',
                                  page: widget.page,
                                  onSectionClick: _scrollToSection),
                              NavLink(
                                  title: 'Experiences',
                                  page: widget.page,
                                  onSectionClick: _scrollToSection),
                              NavLink(
                                  title: 'Education',
                                  page: widget.page,
                                  onSectionClick: _scrollToSection),
                              NavLink(
                                  title: 'Contact',
                                  page: widget.page,
                                  onSectionClick: _scrollToSection),
                            ],
                          ),
                        ),
                      ),
                    const SizedBox(height: 40),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isDesktop ? 120 : 20,
                      ),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                            maxWidth: isDesktop ? double.infinity : 900),
                        child: Flex(
                          direction:
                              isDesktop ? Axis.horizontal : Axis.vertical,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // --- Left Section: Text and Buttons ---
                            Flexible(
                              flex: isDesktop ? 2 : 0,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: isDesktop
                                    ? CrossAxisAlignment.start
                                    : CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Hello, welcome...',
                                    style: GoogleFonts.oxanium(
                                      fontSize: isDesktop ? 23 : 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                    textAlign: isDesktop
                                        ? TextAlign.start
                                        : TextAlign.center,
                                  ),
                                  Text(
                                    'I am Tin Yadanar',
                                    style: GoogleFonts.oxanium(
                                      fontSize: isDesktop ? 55 : 34,
                                      fontWeight: FontWeight.bold,
                                      color: const Color.fromARGB(
                                          255, 201, 250, 136),
                                      // color: const Color.fromARGB(255, 201, 250, 136),
                                    ),
                                    textAlign: isDesktop
                                        ? TextAlign.start
                                        : TextAlign.center,
                                  ),
                                  const SizedBox(height: 8),
                                  AnimatedTextKit(
                                    animatedTexts: [
                                      TypewriterAnimatedText(
                                        'Senior Mobile Developer(Flutter)/Software Engineer',
                                        textStyle: GoogleFonts.oxanium(
                                          fontSize: isDesktop ? 32 : 18,
                                          color: Colors.white,
                                        ),
                                        speed:
                                            const Duration(milliseconds: 100),
                                        textAlign: isDesktop
                                            ? TextAlign.start
                                            : TextAlign.center,
                                      ),
                                    ],
                                    totalRepeatCount: 1,
                                    pause: const Duration(milliseconds: 500),
                                    displayFullTextOnTap: true,
                                    onFinished: () {
                                      if (mounted) {
                                        setState(() {
                                          _typewriterDone = true;
                                        });
                                      }
                                    },
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                    'Building cross-platform apps with Flutter & Dart.',
                                    style: GoogleFonts.poppins(
                                      fontSize: isDesktop ? 20 : 14,
                                      color: Colors.grey[400],
                                    ),
                                    textAlign: isDesktop
                                        ? TextAlign.start
                                        : TextAlign.center,
                                  ),
                                  const SizedBox(height: 32),
                                  Text(
                                      """Senior Mobile Developer with over 5 years of experiences architecting high-performance, scalable applications for the FinTech and E-commerce sectors and more. Expert in bridging Flutter eﬃciency with native Swift and Kotlin performance to deliver secure, enterprise-grade solutions. Deep proficiency in Clean Architecture and comprehensive state management ecosystems (BLoC, Riverpod, GetX, Provider), with a proven track record of optimizing app start-up times, reducing technical debt, and driving user retention through seamless UI/UX. Skilled in CI/CD pipeline implementation using GitHub Actions and Bitrise, ensuring rapid, reliable deployments. Adept at collaborating with cross-functional teams to translate complex requirements into robust mobile solutions that align with business goals.""",
                                      style: GoogleFonts.poppins(
                                        fontSize: isDesktop ? 16 : 12,
                                        color: Colors.white,
                                      ),
                                      textAlign: TextAlign.justify
                                      // textAlign: isDesktop
                                      //     ? TextAlign.justify
                                      //     : TextAlign.justify,
                                      ),
                                  const SizedBox(height: 24),
                                  ElevatedButton.icon(
                                    onPressed: () {
                                      _downloadResume();
                                    },
                                    icon: const Icon(Icons.download),
                                    label: Text(
                                      'Download Resume',
                                      style: GoogleFonts.oxanium(fontSize: 14),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color.fromARGB(
                                          255, 201, 250, 136),
                                      foregroundColor: const Color(0xFF121212),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 24, vertical: 16),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      elevation: 2,
                                    ),
                                  ),
                                  const SizedBox(height: 32),
                                  Text(
                                    'My Skills',
                                    style: GoogleFonts.oxanium(
                                      fontSize: 24,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  buildSkillsWrap(isDesktop),
                                ],
                              ),
                            ),

                            if (isDesktop) const SizedBox(width: 80),
                            if (!isDesktop) const SizedBox(height: 40),

                            // --- Right Section: Profile Picture ---
                            Flexible(
                              flex: isDesktop ? 2 : 0,
                              child: AnimatedOpacity(
                                duration: const Duration(milliseconds: 1000),
                                curve: Curves.easeOut,
                                opacity:
                                    (_typewriterDone && _isProfilePrecached)
                                        ? 1.0
                                        : 0.0,
                                child: AnimatedScale(
                                  duration: const Duration(milliseconds: 600),
                                  curve: Curves.easeOutBack,
                                  scale:
                                      (_typewriterDone && _isProfilePrecached)
                                          ? 1.0
                                          : 0.85,
                                  child: Container(
                                    width: isDesktop ? 380 : 200,
                                    height: isDesktop ? 380 : 200,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: const Color(0xFF1E1E1E),
                                      boxShadow: [
                                        BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.08),
                                            blurRadius: 40,
                                            offset: const Offset(0, 15))
                                      ],
                                      border: Border.all(
                                          color: const Color.fromARGB(
                                                  255, 201, 250, 136)
                                              .withOpacity(0.3),
                                          width: 6),
                                    ),
                                    child: ClipOval(
                                      child: Image.asset(
                                        'assets/images/pp2.png',
                                        fit: BoxFit.fitWidth,
                                        errorBuilder: (context, error,
                                                stackTrace) =>
                                            const Icon(Icons.person, size: 100),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 100),
                    // Home section
                    Container(
                      key: _experiencesKey,
                      child: _buildHeader(),
                    ),
                    const SizedBox(height: 48),
                    FadeTransition(
                      opacity: _experiencesFadeAnimation,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 0.3),
                          end: Offset.zero,
                        ).animate(CurvedAnimation(
                          parent: _experiencesController,
                          curve: Curves.easeOutCubic,
                        )),
                        child: _buildTimeline(),
                      ),
                    ),
                    const SizedBox(height: 100),
                    Container(
                      key: _educationKey,
                      child: _buildSectionHeader('Education'),
                    ),
                    const SizedBox(height: 24),
                    FadeTransition(
                      opacity: _educationFadeAnimation,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 0.3),
                          end: Offset.zero,
                        ).animate(CurvedAnimation(
                          parent: _educationController,
                          curve: Curves.easeOutCubic,
                        )),
                        child: _buildEducationTimeline(),
                      ),
                    ),
                    const SizedBox(height: 48),
                    // _buildSectionHeader('Competitions & Certifications'),
                    // const SizedBox(height: 24),
                 //   _buildCertificationsGrid(),
                    // const SizedBox(height: 100),
                    // Projects section
                    Container(
                      key: _projectsKey,
                      child: _buildProjectHeader(),
                    ),
                    const SizedBox(height: 48),
                    FadeTransition(
                      opacity: _projectsFadeAnimation,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 0.3),
                          end: Offset.zero,
                        ).animate(CurvedAnimation(
                          parent: _projectsController,
                          curve: Curves.easeOutCubic,
                        )),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: _buildProjectsGrid(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 60),
                    // Contact section
                    Container(
                      key: _contactKey,
                      child: _buildContactHeader(context),
                    ),
                    const SizedBox(height: 32),
                    FadeTransition(
                      opacity: _contactFadeAnimation,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 0.3),
                          end: Offset.zero,
                        ).animate(CurvedAnimation(
                          parent: _contactController,
                          curve: Curves.easeOutCubic,
                        )),
                        child: Column(
                          children: [
                            _buildFormCard(context),
                            const SizedBox(height: 48),
                            _buildContactFooter(context),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 48),
                  ],
                ),
              ),
            ),
          );
  }

  Widget buildSkillsWrap(bool isLargeScreen) {
    final List<String> skills = [
      'Flutter',
      'Dart',
      'Flutter Web',
      'Firebase',
      'REST API',
      'Provider',
      'Riverpod',
      'Bloc',
      'GetX',
      'Git',
      'Laravel',
      'SQL',
    
    ];
    return Wrap(
      spacing: 10.0,
      runSpacing: 10.0,
      alignment: isLargeScreen ? WrapAlignment.start : WrapAlignment.center,
      children: skills.map((skill) => buildSkillChip(skill)).toList(),
    );
  }

  Widget buildSkillChip(String skill) {
    return Chip(
      label: Text(
        skill,
        style: GoogleFonts.oxanium(
          color: const Color.fromARGB(255, 201, 250, 136),
          fontWeight: FontWeight.w500,
        ),
      ),
      backgroundColor: const Color(0xFF1E1E1E),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
            color: const Color.fromARGB(255, 201, 250, 136).withOpacity(0.3)),
      ),
    );
  }

  Widget buildQuickStatsSection(bool isLargeScreen) {
    final List<Map<String, String>> stats = [
      {'value': '3+', 'label': 'Years Experience'},
      {'value': '8+', 'label': 'Projects Completed'},
    ];

    if (!isLargeScreen) {
      return Column(
        children: stats
            .map((stat) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: buildStatCard(stat)))
            .toList(),
      );
    } else {
      return Row(
        children: stats
            .map((stat) => Expanded(
                child: buildStatCard(stat,
                    margin: const EdgeInsets.only(right: 16.0))))
            .toList(),
      );
    }
  }

  Widget buildStatCard(Map<String, String> stat, {EdgeInsetsGeometry? margin}) {
    return Container(
      margin: margin,
      padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
      decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 20,
                offset: const Offset(0, 4))
          ],
          border: Border.all(color: Colors.grey.shade700)),
      child: Column(
        children: [
          Text(stat['value']!,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 201, 250, 136))),
          const SizedBox(height: 8),
          Text(stat['label']!,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: Colors.grey[400]),
              textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: GoogleFonts.oxanium(
              fontSize: 40,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
            children: const [
              TextSpan(text: 'My Professional '),
              TextSpan(
                text: 'Experience',
                style:
                    TextStyle(color: const Color.fromARGB(255, 201, 250, 136)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'A timeline of my journey as a Flutter Developer, contributing to innovative mobile applications.',
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: Colors.grey[400],
          ),
        ),
      ],
    );
  }

  Widget _buildTimeline() {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Use a single-column layout on narrow screens
        bool isNarrow = constraints.maxWidth < 760;

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: (isNarrow) ? 14 : 100),
          child: Column(
            children: List.generate(_experiences.length, (index) {
              final experience = _experiences[index];
              final isFirst = index == 0;
              final isLast = index == _experiences.length - 1;
              // On wide screens, alternate alignment. On narrow, all are right-aligned.
              final isLeftAligned = !isNarrow && index % 2 == 1;

              return AnimatedTimelineTile(
                experience: experience,
                isFirst: isFirst,
                isLast: isLast,
                isLeftAligned: isLeftAligned,
                isNarrow: isNarrow,
                animationController: _experiencesController,
                delay:
                    Duration(milliseconds: index * 200), // Staggered animation
              );
            }),
          ),
        );
      },
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: GoogleFonts.oxanium(
        fontSize: 28,
        fontWeight: FontWeight.w500,
        color: const Color.fromARGB(255, 201, 250, 136),
      ),
    );
  }

  Widget _buildEducationTimeline() {
    Future<void> _launchUrl(String url) async {
      final Uri uri = Uri.parse(url);
      if (!await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      )) {
        throw "Cannot launch url";
      }
    }

    return Column(
      children: List.generate(_educationItems.length, (index) {
        // Alternate between left and right alignment for zigzag effect
        final isLeftAligned = index % 2 == 1;

        return AnimatedEducationTile(
          onTapLinkDegree: () async {
            if (_educationItems[index].linkDegree != '') {
              await _launchUrl(_educationItems[index].linkDegree);
            }
          },
          item: _educationItems[index],
          isFirst: index == 0,
          isLast: index == _educationItems.length - 1,
          isLeftAligned: isLeftAligned,
          animationController: _educationController,
          delay: Duration(milliseconds: index * 200), // Staggered animation
          onTapLinkUni: () async {
            await _launchUrl(_educationItems[index].linkUni);
          },
        );
      }),
    );
  }

  Widget _buildCertificationsGrid() {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: _certificationItems
          .map(
            (item) => CertificationCard(item: item),
          )
          .toList(),
    );
  }

  Widget _buildProjectHeader() {
    return Column(
      children: [
        Text(
          'My Projects',
          style: GoogleFonts.oxanium(
            fontSize: 42,
            fontWeight: FontWeight.w500,
            color: const Color.fromARGB(255, 201, 250, 136),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'A selection of my recent work, showcasing my skills and experience in software development.',
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: Colors.grey[400],
          ),
        ),
      ],
    );
  }

  Widget _buildProjectsGrid() {
    final Size screenSize = MediaQuery.of(context).size;
    final bool isDesktop = screenSize.width > 800;

    if (isDesktop) {
      return Wrap(
        spacing: 34,
        runSpacing: 0,
        alignment: WrapAlignment.center,
        children:
            _projects.map((project) => ProjectCard(project: project)).toList(),
      );
    }

    // Mobile: horizontal pager with indicator
    return Column(
      children: [
        SizedBox(
          height: 500,
          child: PageView.builder(
            controller: _projectsPageController,
            itemCount: _projects.length,
            onPageChanged: (index) {
              setState(() {
                _currentProjectIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ProjectCard(project: _projects[index]),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_projects.length, (i) {
            final bool isActive = i == _currentProjectIndex;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: isActive ? 20 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: isActive
                    ? const Color.fromARGB(255, 201, 250, 136)
                    : const Color.fromARGB(255, 201, 250, 136).withOpacity(0.3),
                borderRadius: BorderRadius.circular(8),
              ),
            );
          }),
        ),
        const SizedBox(height: 4),
        Text(
          '${_currentProjectIndex + 1} / ${_projects.length}',
          style: GoogleFonts.poppins(color: Colors.grey[400], fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildContactHeader(BuildContext context) {
    return Column(
      children: [
        Text(
          'Get in Touch',
          style: GoogleFonts.oxanium(
            fontSize: 42,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 201, 250, 136),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          "I'm always open to discussing new projects, creative ideas, or opportunities.\nFeel free to reach out, and I'll get back to you as soon as possible.",
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: Colors.grey[400],
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildFormCard(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final bool isDesktop = screenSize.width > 800;
    return Container(
      width: isDesktop ? (screenSize.width) / 2 : null,
      margin: isDesktop
          ? const EdgeInsets.symmetric(horizontal: 0)
          : const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(32.0),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(24.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Use LayoutBuilder for responsive Name/Email fields
            LayoutBuilder(
              builder: (context, constraints) {
                // Use a breakpoint to switch between Row and Column
                if (constraints.maxWidth > 550) {
                  return Row(
                    children: [
                      Expanded(
                          child: _buildTextFormField('Your Name',
                              controller: _nameController)),
                      const SizedBox(width: 16),
                      Expanded(
                          child: _buildTextFormField('Your Email',
                              controller: _emailController)),
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      _buildTextFormField('Your Name',
                          controller: _nameController),
                      const SizedBox(height: 16),
                      _buildTextFormField('Your Email',
                          controller: _emailController),
                    ],
                  );
                }
              },
            ),
            const SizedBox(height: 16),
            _buildTextFormField('Your Message',
                maxLines: 5, controller: _messageController),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _isSending ? null : _sendEmail,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 201, 250, 136),
                foregroundColor: const Color(0xFF121212),
                padding: const EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                elevation: 4,
                shadowColor: Colors.indigo.withOpacity(0.4),
              ),
              child: Text(
                'Send Message',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFormField(String label,
      {int maxLines = 1, required TextEditingController controller}) {
    return TextFormField(
      controller: controller, // Assign the controller
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: label,
        hintStyle: GoogleFonts.poppins(
          color: Colors.grey[500],
        ),
        filled: true,
        fillColor: const Color(0xFF2D2D2D),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: Colors.grey[600]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(
              color: Color.fromARGB(255, 201, 250, 136), width: 2),
        ),
      ),
      style: GoogleFonts.poppins(
        color: Colors.white,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your $label';
        }
        if (label == 'Your Email' && !RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
          return 'Please enter a valid email address';
        }
        return null;
      },
    );
  }

  Widget _buildContactFooter(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final bool isDesktop = screenSize.width > 800;

    Future<void> _launchUrl(String url) async {
      final Uri uri = Uri.parse(url);
      if (!await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      )) {
        throw "Cannot launch url";
      }
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 0 : 16),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: isDesktop ? 0 : 40),
                child: SizedBox(
                  height: 30,
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildSocialIcon(FontAwesomeIcons.github, () async {
                        await _launchUrl('https://github.com/tin1810');
                      }, 'Github'),
                      const SizedBox(width: 24),
                      _buildSocialIcon(FontAwesomeIcons.linkedin, () async {
                        await _launchUrl(
                            'https://www.linkedin.com/in/tinyadanar/');
                      }, 'LinkedIn'),
                      const SizedBox(width: 24),
                      _buildSocialIcon(
                          FontAwesomeIcons
                              .whatsapp, // Phone is available in default Material Icons
                          () async {
                        await _launchUrl(
                            'https://wa.me/+660829523886'); // opens phone dialer
                      }, 'Whatsapp'),
                      const SizedBox(width: 24),
                      _buildSocialIcon(
                          FontAwesomeIcons
                              .line, // Phone is available in default Material Icons
                          () async {
                        await _launchUrl(
                            'https://line.me/ti/p/ffFXDB-E-B'); // opens phone dialer
                      }, 'Line'),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            '© 2025 Tin Yadanar. Created with Flutter 3.35.4',
            style: GoogleFonts.oxanium(
              color: Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon, Function onTap, String tip) {
    return IconButton(
      icon: Icon(icon, color: Colors.grey[400]),
      onPressed: () {
        onTap();
      },
      splashRadius: 24,
      tooltip: tip,
    );
  }
}

class AnimatedTimelineTile extends StatefulWidget {
  final Experience experience;
  final bool isFirst;
  final bool isLast;
  final bool isLeftAligned;
  final bool isNarrow;
  final AnimationController animationController;
  final Duration delay;

  const AnimatedTimelineTile({
    super.key,
    required this.experience,
    required this.isFirst,
    required this.isLast,
    required this.isLeftAligned,
    required this.isNarrow,
    required this.animationController,
    required this.delay,
  });

  @override
  State<AnimatedTimelineTile> createState() => _AnimatedTimelineTileState();
}

class _AnimatedTimelineTileState extends State<AnimatedTimelineTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _itemController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _itemController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _itemController, curve: Curves.easeInOut),
    );

    final slideBegin = widget.isLeftAligned
        ? const Offset(-0.5, 0) // From left
        : const Offset(0.5, 0); // From right

    _slideAnimation =
        Tween<Offset>(begin: slideBegin, end: Offset.zero).animate(
      CurvedAnimation(parent: _itemController, curve: Curves.easeOutCubic),
    );

    widget.animationController.addStatusListener((status) {
      if (status == AnimationStatus.forward) {
        Future.delayed(widget.delay, () {
          if (mounted) {
            _itemController.forward();
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _itemController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: TimelineTile(
          experience: widget.experience,
          isFirst: widget.isFirst,
          isLast: widget.isLast,
          isLeftAligned: widget.isLeftAligned,
          isNarrow: widget.isNarrow,
        ),
      ),
    );
  }
}

// Animated Education Tile for branching effect
class AnimatedEducationTile extends StatefulWidget {
  final EducationItem item;
  final bool isFirst;
  final bool isLast;
  final bool isLeftAligned;
  final Function onTapLinkUni, onTapLinkDegree;
  final AnimationController animationController;
  final Duration delay;

  const AnimatedEducationTile({
    super.key,
    required this.item,
    required this.isFirst,
    required this.isLast,
    required this.isLeftAligned,
    required this.onTapLinkUni,
    required this.onTapLinkDegree,
    required this.animationController,
    required this.delay,
  });

  @override
  State<AnimatedEducationTile> createState() => _AnimatedEducationTileState();
}

class _AnimatedEducationTileState extends State<AnimatedEducationTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _itemController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _itemController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _itemController, curve: Curves.easeInOut),
    );

    // Create branching effect - items slide in from periphery toward center
    final slideBegin = widget.isLeftAligned
        ? const Offset(-0.5, 0) // From left
        : const Offset(0.5, 0); // From right

    _slideAnimation =
        Tween<Offset>(begin: slideBegin, end: Offset.zero).animate(
      CurvedAnimation(parent: _itemController, curve: Curves.easeOutCubic),
    );

    // Start animation with delay when parent controller starts
    widget.animationController.addStatusListener((status) {
      if (status == AnimationStatus.forward) {
        Future.delayed(widget.delay, () {
          if (mounted) {
            _itemController.forward();
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _itemController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: EducationTile(
          onTapLinkDegree: widget.onTapLinkDegree,
          item: widget.item,
          isFirst: widget.isFirst,
          isLast: widget.isLast,
          isLeftAligned: widget.isLeftAligned,
          onTapLinkUni: widget.onTapLinkUni,
        ),
      ),
    );
  }
}
