# Looking for Talents

The goal of this project is to build a platform for disseminating job opportunities, where companies can search for
professionals to join their teams and interact with them during the application and hiring process.

## Requirements

This project have a Docker setup, but if you don't want to use it, this what you need to get it running:

`Ruby >= 3.2.2`

`node >= 13.12.0`

`Postgres >= 9.2`

## Setup

Clone the repo:

```
git clone https://github.com/yosh1tsune/looking-for-talents.git
```

Go to directory:

```
cd looking-for-talents
```

#### With Docker

To generate project images, install yarn and ruby dependencies, and setup de app database, run:

```
docker-compose build
```

To setup and fill the database with initial development data, run:

```
docker-compose run app rails db:setup
```

And to initiate the server, run:

```
docker-compose up
```

#### With local Ruby

Install node dependencies:

`yarn install`

Install ruby gems and setup database:

`bin/setup`

(Optional) This project have pre-built development data, to fill the database with then, run:

`rails db:seed`

Finally, to see the app running, run:

`rails server`

By default, server will run in http://localhost:3000

## Functionalities

### Headhunter

- A headhunter initiates the flow of the application, signing up providing an email, password, name and surname.

- To submit opportunities, headhunters must be linked with a company. Company profiles are created by headhunters, which will be their responsible. Only the responsible can link another headhunter to an existing company.

- Candidates can have their profiles highlighted and receive proposals based on their subscription.

- Headhunter can visualize only their companies opportunities; profiles of all candidates in the application are visible.

### Candidatos

- A candidate initiate signing up providing an email, password.

- After sign up, candidates must fill in personal and professional info before being able to submit application to opportunities.

- Candidates can visualize all opportunities submitted, but only their own profiles.

- After submit application for an opportunity, they'll receive feedback and, eventually, proposals, being able to accept or refuse it.