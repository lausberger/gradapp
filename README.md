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
