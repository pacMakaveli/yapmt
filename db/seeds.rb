User.create(name: 'Admin', uid: SecureRandom.hex(4))
User.create(name: 'Project Manager', uid: SecureRandom.hex(4))
User.create(name: 'User', uid: SecureRandom.hex(4))

projects = [
  {
    name: 'NinaCRM',
    description: 'CRM tool designed specifically, with a range of powerful features, for independent freelancers to manage their clients, create invoices, and manage their project pipeline all in one place.'
  },
  {
    name: 'BetterSheets',
    description: 'Comprehensive learning platform designed to revolutionize the way you learn Google Sheets.',
  },
  {
    name: 'Zapex',
    description: 'Automatically sync experiences to any Booking software.',
  },
  {
    name: 'Splash!',
    description: 'With more than 1 billion images and videos available for free, Splash! is the only place to find the perfect image for your gaming needs.',
  },
  {
    name: 'Copy',
    description: 'The power of A.I. and games.directory at your fingertips! With Copy, you are able to write with style and ease thanks to our inline tools that offer embedded content for Games, Achievements, Media, News and more'
  }
]

Project.create(projects)

15.times do
  Comment.create(
    project_id: Project.all.sample.id,
    user_id: User.all.sample.id,
    body: Faker::Lorem.paragraph
  )
end

3.times do |i|
  status  = Project.statuses.keys.sample
  project = Project.all.sample
  project.update(status: status)
  project.reload.update(status: Project.statuses.keys.sample)

  changes = project.previous_changes['status']

  Change.create(
    user_id: User.all.sample.id,
    project_id: project.id,
    from: changes.try(:[], 0),
    to: changes.try(:[], 1),
  )
end

3.times do |i|
  status  = Project.statuses.keys.sample
  project = Project.all.sample
  user    = User.all.sample

  project.update(status: status)
  project.reload.update(status: Project.statuses.keys.sample)

  changes = project.previous_changes['status']

  Change.create(
    user_id: user.id,
    project_id: project.id,
    from: changes.try(:[], 0),
    to: changes.try(:[], 1),

    comment_attributes: {
      comment_type: :change,
      user_id: user.id,
      project_id: project.id,
      body: Faker::Lorem.paragraph
    }
  )
end