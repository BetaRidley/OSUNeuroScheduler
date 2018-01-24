# Neurosurgery Appointment Booking System (NABS)

## Team

### Members
[Team Materials AU17](https://drive.google.com/open?id=0B6ddZznZSupMM19RbEp4TGNwT0E)
[Team Materials SP18](https://drive.google.com/open?id=1AZRpi3Pc6Q2DraqHKlJkvcFmP0j3AjfT)

# Autumn 2017
- Leah Musie, PM, Front End
	- musie.1@osu.edu
- Tavish Wille, Secondary PM, Backend
	- wille.16@osu.edu
- Ryan Conley, Documentation, Backend
	- conley.497@osu.edu
- Adrien Lindner, Architecture, Backend
	- lindner.54@osu.edu
- Melissa Sjostrom, Sponsor Contact, Testing, Front End
	- sjostrom.7@osu.edu

# Spring 2018
- Erin George
	- george.730@osu.edu
- Jeremy Clark
	- clark.2711@osu.edu
- KC Miller
	- miller.7532@osu.edu
- Ricky Renner
	- renner.163@osu.edu

### Sponsor 
- Doctor Patrick Youssef, Neurosurgeon @ OSU Wexner Medical Center
	- Doan Hall, N1014

### Timeline
- August 22: Project started; initially tried to proceed individually until it was revealed that an official team, Ontoborn, primarily based in India, was in negotiations to take over the project
- September 13: Interfaced with Ontoborn and began collaboration
- October 30: Informed by Ontoborn that funding was halted, explicit plan/outline for the remaining sprints was created

### Meeting Notes
[Meeting Notes](https://drive.google.com/open?id=0B6ddZznZSupMaEVzZExYR0pxbDQ)
- Ontoborn Directory: Contains meeting notes during Hangouts w/ Ontoborn Members
- Team Directory: Contains meeting notes between team members
- Sponsor: Contains meeting notes with sponsor, collecting requirements and information

### Documentation
[LucidChart Links](https://docs.google.com/document/d/1IowPOq2anCaHvJUG5TfFN3ibl4_TieGXR8eaiDRXotQ/edit?usp=sharing)

## Project

### Overview
- Mission: to create a Web and eventually Mobile app for directing referrals from physicians to the OSU Wexner Medical Center Department of Neurosurgery
- This is the Web app prototype, written in Ruby on Rails
- The Web app prototype will be passed to Ontoborn Technologies LLC, who may continue development
- Aims to modernize the archaic external appointment scheduling system that is currently in place

### Tools, Packages, Software Used
- [Rails 5 (Web Framework & JQuery)](https://github.com/rails/rails)
- [PostgreSQL (Database Management System)](https://www.postgresql.org/download/)
- [Devise (Authentication)](https://github.com/plataformatec/devise)
- [RSpec (Unit and Functional Testing)](https://github.com/rspec/rspec-rails)
- [FactoryBot (testing fixtures)](https://github.com/thoughtbot/factory_bot_rails)
- [Shoulda (rails rspec helpers)](https://github.com/thoughtbot/shoulda)
- [Database Cleaner (testing cleanup)](https://github.com/DatabaseCleaner/database_cleaner)
- [Postgres Adapter](https://github.com/ged/ruby-pg)
- [Semantic CSS](https://semantic-ui.com) [(rails LESS version)](https://github.com/Semantic-Org/Semantic-UI-Rails-LESS)

### Installation/Running Procedure
Run Locally on a Unix-based machine (or in a VM):

- Ensure that the latest versions of Ruby and Rails are installed on your machine
- Run the Ruby `bundle install` command to resolve gem dependencies
- Depending on your machine, follow the instructions [here](https://www.postgresql.org/docs/9.1/static/server-start.html) to start your postgres server
- run , in the root rails folder, `bundle exec rake db:create db:migrate` in order to create your database the first time 
- Run the app with Rails by entering `rails s` in the terminal from within the app root folder
- Visit `0.0.0.0:3000` on your browser to visit the app

### Example Use-Cases
- Referring physicians enter patient information and schedule them
- Referred physicians may view referral requests, and may accept or reject them
- Staff may act on behalf of physicians, given permission by them
- Admins have access to account management and stored personal information

### New Users' Guide
- Enter your valid Email address and Password at the login screen
- Upon successful login, you will be granted certain permissions depending on your account type
    - Referring physicians: navigate to "Create" to begin creating a referral
    - Referred physicians: navigate to "Pending" to view and accept or reject referral requests
    - Admins: navigate to "View Users" or "View Clinics" for account and clinic management tools

### Administration and Maintenance Procedures
- Those granted Admin accounts have unique privileges for maintaining and running the system
    - Navigate to "View Users" while signed into an Admin account for user account management tools
        - View personal information and account details
        - Create new accounts ("New User" button)
        - Edit or delete accounts
    - Navigate to "View Clinics" while signed into an Admin account for clinic data management tools
        - View clinic information
        - Add clinics to the system ("New Office" button)
        - Edit or delete clinics from the system
    
## Reference Materials

### Screens
![Before Sign In](/screens/before_sign_in.png?raw=true "Before Signing In")
![After Sign In](/screens/after_sign_in.png?raw=true "After Signing In")
![Landing Page](/screens/landing_page.png?raw=true "Plain Landing Page")

![Logout](/screens/logout.png?raw=true "Logout")

![Account Page](/screens/account_page.png?raw=true "Account Page")
![Create Referral](/screens/create_referral.png?raw=true "Create Referral")
![Pending Referrals](/screens/pending_referrals.png?raw=true "Pending Referrals")
![Patient Information](/screens/send_referral.png?raw=true "Patient Information")

![Sent Requests](/screens/sent_requests.png?raw=true "Sent Requests")

![Admin User List](/screens/admin_user_list.png?raw=true "Admin User Listing")
![Admin Clinic List](/screens/admin_clinic_list.png?raw=true "Admin Clinic Listing")

![New Clinic](/screens/new_clinic.png?raw=true "New Clinic")
![New User](/screens/new_user.png?raw=true "New User")
