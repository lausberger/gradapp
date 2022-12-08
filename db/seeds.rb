# frozen_string_literal: true

applications = [
  {
    first_name: 'Brandon',
    last_name: 'Egger',
    email: 'beggr@uiowa.edu',
    phone: '3196408865',
    dob: Date.new,
    status: 'submitted'
  },
  {
    first_name: 'Jack',
    last_name: 'Stockley',
    email: 'jack-stockley@uiowa.edu',
    phone: '8722214561',
    dob: Date.new,
    status: 'submitted'
  },
  {
    first_name: 'Caleb',
    last_name: 'Marx',
    email: 'caleb-marx@uiowa.edu',
    phone: '1234567890',
    dob: Date.new,
    status: 'withdrawn'
  }
]

applications.each do |application|
  GraduateApplication.create!(application)
end

acc = Account.create!(first_name: 'John', last_name: 'Doe', email: 'jdoe@gmail.com', password: '12345678', password_confirmation: '12345678',
                      account_type: 'Student')
acc2 = Account.create!(first_name: 'Jane', last_name: 'Doe', email: 'jadoe@gmail.com', password: '12345678', password_confirmation: '12345678',
                       account_type: 'Faculty')
Message.create!(to_id: acc.id, from_id: acc.id, to_email: 'jdoe@gmail.com', from_email: 'jdoe@gmail.com', subject: 'Hello', body: 'Hi. Hey.')
Message.create!(to_id: acc.id, from_id: acc2.id, to_email: 'jdoe@gmail.com', from_email: 'jadoe@gmail.com', subject: 'New Program',
                body: 'Hello, I was reaching out to you to see if you are interested in our new Graduate program that we have created.
                Its for new students looking to do Machine Learning. Please reply if you are interested and want to learn more.')

accounts = [
  {
    first_name: 'Jack',
    last_name: 'Stockley',
    email: 'jnstockley@uiowa.edu',
    password: 'Password123',
    password_confirmation: 'Password123',
    account_type: 'Student'
  },
  {
    first_name: 'Hans',
    last_name: 'Johnson',
    email: 'hans-johnson@uiowa.edu',
    password: 'iloveselt',
    password_confirmation: 'iloveselt',
    account_type: 'Faculty'
  },
  {
    first_name: 'San',
    last_name: 'John',
    email: 'San-john@uiowa.edu',
    password: 'iloveselt2',
    password_confirmation: 'iloveselt2',
    account_type: 'Faculty'
  },
  {
    first_name: 'Caleb',
    last_name: 'Marx',
    email: 'caleb-marx@uiowa.edu',
    password: 'pA55W0rd!',
    password_confirmation: 'pA55W0rd!',
    account_type: 'Student'
  },
  {
    first_name: 'Alex',
    last_name: 'Hammes',
    email: 'alex-hammes@uiowa.edu',
    password: 'password0987',
    password_confirmation: 'password0987',
    account_type: 'Faculty'
  },
  {
    first_name: 'Jonah',
    last_name: 'Terwilleger',
    email: 'jonah-terwilleger@uiowa.edu',
    password: 'iL0V3iowA',
    password_confirmation: 'iL0V3iowA',
    account_type: 'Department Chair'
  },
  {
    first_name: 'Kaitlynn',
    last_name: 'Fuller',
    email: 'Kaitlynn-Fuller@uiowa.edu',
    password: 'pA5sW0rd!',
    password_confirmation: 'pA5sW0rd!',
    account_type: 'Student'
  }
]

accounts.each do |account|
  Account.create! account
end

discussions = [
  { title: 'What\'s the best Graduate Program?',
    body: 'Hey guys, I\'m having a hard time picking a graduate program.',
    account_id: Account.find_by(first_name: 'Jack').id,
    root_discussion_id: -1 },
  { title: 'Contact Faculty',
    body: 'Hello, what\'s the best way to contact a faculty member?',
    account_id: Account.find_by(first_name: 'Alex').id,
    root_discussion_id: -1 },
  { title: 'Submit Application',
    body: 'How do I submit an application here?',
    account_id: Account.find_by(first_name: 'Hans').id,
    root_discussion_id: -1 },
  { title: '',
    body: 'I heard the CSE program is great',
    account_id: Account.find_by(first_name: 'Hans').id,
    root_discussion_id: 1 },
  { title: '',
    body: 'Email',
    account_id: Account.find_by(first_name: 'Jack').id,
    root_discussion_id: 2 },
  { title: '',
    body: 'Yea, CSE is great at Iowa!',
    account_id: Account.find_by(first_name: 'Jonah').id,
    root_discussion_id: 1 },
  { title: '',
    body: 'In the future, you can do it right here!',
    account_id: Account.find_by(first_name: 'Jack').id,
    root_discussion_id: 2 },
  { title: '',
    body: 'Right now you can\'t, it\'s a work in progress!',
    account_id: Account.find_by(first_name: 'Jack').id,
    root_discussion_id: 3 },
  { title: '',
    body: 'Thanks, Jack',
    account_id: Account.find_by(first_name: 'Hans').id,
    root_discussion_id: 3 },
  { title: '',
    body: 'You can\'t go wrong with any of their programs',
    account_id: Account.find_by(first_name: 'Alex').id,
    root_discussion_id: 1 }
]

discussions.each do |discussion|
  Discussion.create!(discussion)
end

stud_checklists = [
  {
    account_id: Account.find_by(first_name: 'Caleb').id,
    citizenship: true,
    ug_major: true,
    letter_recommendations: true,
    sop: true
  },
  {
    account_id: Account.find_by(first_name: 'Kaitlynn').id,
    degree_objective: true,
    ug_transcript: true,
    gre_scores: true
  }
]

stud_checklists.each do |checklist|
  StudentChecklist.create! checklist
end

research_areas = [
  {
    title: 'Applied Physics',
    summary: 'The application of physics to solve scientific or engineering problems. It is usually considered to be a
              bridge or a connection between physics and engineering.',
    detailed_overview: "Students majoring in ECE with an Applied Physics emphasis develop the devices, systems, and technologies
               used to implement modern electronics devices and systems. Further, they support research into new
               technologies that, for instance, could extend Moore's Law or allow for development of quantum scale
               devices beyond Moore's law."
  },
  {
    title: 'Bioinformatics',
    summary: 'The application of tools of computation and analysis to the capture and interpretation of biological data.
              It is an interdisciplinary field, which harnesses computer science, mathematics, physics, and biology',
    detailed_overview: "Bioinformatics is an emerging discipline that uses mathematics and computer engineering to help answer
               questions in bioscience, agriculture and medicine. Bioinformatics harnesses the power of recent
               developments in statistics, software engineering, high-performance computing, and artificial intelligence
               to sort through and prioritize vast datasets to find clues to the causes and cures of human disease."
  },
  {
    title: 'Computer Networks',
    summary: 'Interconnected computing devices that can exchange data and share resources with each other. These networked
              devices use a system of rules, called communications protocols, to transmit information over physical or wireless technologies.',
    detailed_overview: "Network engineers design, develop and configure, and maintain the high-speed wired and wireless digital
               networks that carry vast amounts of data, enabling the Internet, cell phones, television, and every other
               kind of electronic information exchange. This EFA combines a background in computer hardware and software
               (gained through the computer track of the curriculum) with additional knowledge of computer networks,
               communication theory, and computer security."
  },
  {
    title: 'Integrated Circuits',
    summary: 'A semiconductor wafer on which thousands or millions of tiny resistors, capacitors, diodes and transistors are fabricated.',
    detailed_overview: 'Integrated circuit engineers develop and design circuits that play a central role in countless modern
               electronic devices, appliances, and vehicles. These circuits add smarts and complex functionality to
               wide variety of devices including computers, phones, medical instruments and implants, automobiles,
                power generation and distribution systems, airplanes, consumer electronic devices, and home appliances.'
  },
  {
    title: 'Signal and Image Processing',
    summary: 'The field of signal and image processing encompasses the theory and practice of algorithms and hardware that
              convert signals produced by artificial or natural means into a form useful for a specific purpose.',
    detailed_overview: 'Depending on the courses selected, completion of signal and image processing area coursework can provide
               additional understanding of topics in signal sampling and compression, detection and estimation, signal
               feature extraction, time-frequency analysis, speech, audio, image and video processing, machine learning
               and data mining, biomedical signals, sensor networks, and the signal processing aspects of communication
               systems and networks.'
  }
]

research_areas.each do |research_area|
  ResearchArea.create! research_area
end


faculties = [
  {
    account_id: Account.find_by(first_name: 'Jack').id,
    research_area_id: ResearchArea.find_by(title: 'Applied Physics').id,
    approved: true
  },
  {
    account_id: Account.find_by(first_name: 'Hans').id,
    research_area_id: ResearchArea.find_by(title: 'Bioinformatics').id,
    approved: true
  },
  {
    account_id: Account.find_by(first_name: 'Alex').id,
    research_area_id: ResearchArea.find_by(title: 'Integrated Circuits').id,
    approved: false
  },
  {
    account_id: Account.find_by(first_name: 'San').id,
    research_area_id: ResearchArea.find_by(title: 'Integrated Circuits').id,
    approved: false
  }
]

faculties.each do |faculty|
  Faculty.create! faculty
end

