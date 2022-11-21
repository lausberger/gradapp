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

Current our heroku deployment is automated through the CI/CD action pipeline on github. Changes that are merged to the main branch will automatically be deployed to the correct site based on the date the changes were merged to main. We associated these dates based on the sprints so in general our automatic deployment system takes care of most of the hassel. We do include steps for manual deployment if you so prefer,

1. Run `heroku create -a [NAME]` on your local repository
    - If you already have a live heroku app, you can just add that remote heroku repository with `heroku git:remote -a [APP_NAME]`
2. When you are ready to push your local git repository to heroku, run `git push heroku main` (or whatever you have named your remote heroku branch)
    - **NOTE:** You may get a message during the build/deployment of your app on Heroku mentioning an unsupported stack. This is because we use an older version of rails (2.6.6) which requires heroku stack 20 or earlier. You can change your heroku stack with `heroku stack:set heroku-20` then try pushing changes again.
3. Run `heroku run bundle exec rake db:migrate` to migrate DB to the latest version. (You can also seed if needed, but only do this once)

Your site should now be live on Heroku!

## Project Organization Tools

### Pull Requests
An open pull request can only be merged to develop once the following have occured:
1. Two other members of the team reviewed and approved the pull request
2. There are no merge conflicts with main
3. The branch is not failing any tests (new or old)
