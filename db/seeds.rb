# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

discussions = [
  { title: 'What\'s the best Graduate Program?',
    body: 'Hey guys, I\'m having a hard time picking a graduate program.',
    author: 'Jack Stockley',
    root_discussion_id: -1 },
  { title: 'Contact Faculty',
    body: 'Hello, what\'s the best way to contact a faculty member?',
    author: 'Joe Smith',
    root_discussion_id: -1 },
  { title: 'Submit Application',
    body: 'How do I submit an application here?',
    author: 'Hans Johnson',
    root_discussion_id: -1 },
  { title: '',
    body: 'I heard the CSE program is great',
    author: 'Hans Johnson',
    root_discussion_id: 1 },
  { title: '',
    body: 'Email',
    author: 'Jack Stockley',
    root_discussion_id: 2 },
  { title: '',
    body: 'Yea, CSE is great at Iowa!',
    author: 'Alberto Segre',
    root_discussion_id: 1 },
  { title: '',
    body: 'In the future, you can do it right here!',
    author: 'Jack Stockley',
    root_discussion_id: 2 },
  { title: '',
    body: 'Right now you can\'t, it\'s a work in progress!',
    author: 'Jack Stockley',
    root_discussion_id: 3 },
  { title: '',
    body: 'Thanks, Jack',
    author: 'Hans Johnson',
    root_discussion_id: 3 },
  { title: '',
    body: 'You can\'t go wrong with any of their programs',
    author: 'Julie Maxwell',
    root_discussion_id: 1 }
]

discussions.each do |discussion|
  Discussion.create!(discussion)
end

applications = [
  {
    first_name: 'Brandon',
    last_name: 'Egger',
    email: 'beggr@uiowa.edu',
    phone: '3196408865',
    dob: Date.new,
    status: 'submitted'
  }
]

applications.each do |application|
  GraduateApplication.create!(application)
end

accounts = [
  {
    first_name: 'Jack',
    last_name: 'Stockley',
    email: 'jnstockley@uiowa.edu',
    password_digest: 'Password123',
    account_type: 'Faculty'
  },
  {
    first_name: 'Hans',
    last_name: 'Johnson',
    email: 'hans-johnson@uiowa.edu',
    password_digest: 'i<3SelT',
    account_type: 'Faculty'
  },
  {
    first_name: 'Caleb',
    last_name: 'Marx',
    email: 'caleb-marx@uiowa.edu',
    password_digest: 'pA55W0rd!',
    account_type: 'Student'
  }
]

accounts.each do |account|
  Account.create! account
end

faculties = [
  {
    account_id: Account.first.id,
    topic_area: 'CSE'
  },
  {
    account_id: Account.second.id,
    topic_area: 'math'
  }
]

faculties.each do |faculty|
  Faculty.create!(faculty)
end
