# Welcome to the Grad App Project
The ultimate graduate student application portal, social platform, and collective database for all your needs regarding graduate programs offered at the University of Iowa.

## Version Information
Below are details regarding the tech stack of the project and versions utilized by the team.

- *Ruby:* 2.6.6p146
- *Rails:* 4.2.10
- *Bundler:* 1.17.3

## Setup

### Local Environment

#### Install gem dependencies for dev environment
```bash
bundle install --without production
```

#### Setup the local DB
```bash
bundle exec rake db:migrate
bundle exec rake db:seed
```

### Run Local Rails Server
```bash
bundle exec rails server
```

You should now be able to navigate the SaaS app on your browser at localhost:3000/

### Deploying to Heroku
TODO

## Project Organization Tools

### Pull Requests
An open pull request can only be merged to develop once the following have occured:
1. Two other members of the team reviewed and approved the pull request
2. There are no merge conflicts with main
3. The branch is not failing any tests (new or old)

### Action Pipeline
We automate tests on github to ensure changes merged to our main branch are not breaking any existing or new features. Our pipeline does the following:

1. Ensure are all tests are passing in cucumber and rSpec. Prevents the pull request from being merged if any are not passing.
2. Check to ensure the changes meet our linting configuration ensuring consistency and good practice in code syntax.
3. Automatically deploy stable releases to our heroku dev site and production site at the end of sprints.
  - For changes merged to the main branch, we automatically deploy to our Heroku dev site - a live deployment where we can test upcomming features!
  - For tagged hashes in our main branch, our pipeline will deploy to the associated heroku app of that tag (signifying which sprint we are on)

This pipeline helps automate many previously manual tasks, allowing our team to continue integrating new features with out being bogged down by these redundant steps.
