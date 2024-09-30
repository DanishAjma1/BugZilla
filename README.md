# Bug Tracking System (Phase 1)

## Overview

The Bug Tracking System is a web application designed to facilitate the management and tracking of bugs within various projects. This system allows users to sign up, log in, and interact with different roles—Manager, Developer, and QA—each with distinct permissions and functionalities.

## Features

### User Authentication

- **Sign Up, Login, and Logout**: Users can create accounts with the following details:
  - Name
  - Email
  - Password
  - User Type (Developer, Manager, QA)

### Project Management

1. **Manager**:
   - Can create multiple projects.
   - Can edit and delete projects they create.
   - Can add or remove Developers and QA to the projects.

2. **Developer**:
   - Can assign bugs to themselves from the list of bugs in their projects.
   - Can only see projects they are part of.
   - Can mark bugs as resolved.
   - Cannot see other projects, report bugs, delete bugs, or join any project.

3. **QA**:
   - Can report bugs for all projects.
   - Can see all projects.
   - Cannot edit, delete, or create any project.

### Bug Management

- A bug is associated with:
  - A creator (the user who reports the bug).
  - A developer assigned to resolve the bug.
  - A project it belongs to.
  
- Each bug includes:
  - Descriptive title (unique within a project).
  - Deadline.
  - Optional description.
  - Status (with specific dropdown values based on the type).
  - Type (either 'feature' or 'bug').
  - Screenshot (only .png or .gif formats are allowed).

### Additional Features

- **Live Search**: Implement a live search option for selecting projects.
- **Email Notifications**: Send notifications to developers and QA for important actions (e.g., bug assignments, project updates) using Sidekiq.
- **Search Functionality**: Implement filters for bugs based on criteria such as project, status, and type.

## Technical Stack

- **Ruby on Rails**: The framework used to build the application.
- **Pundit Gem**: Used for role-based authorization.
- **CarrierWave**: For handling file uploads.
- **Sidekiq**: For background job processing (e.g., sending email notifications).

## Installation

1. Clone the repository:
   git clone https://github.com/your_username/bug_tracking_system.git
   cd bug_tracking_system
Install dependencies:

bundle install
Set up the database:

rails db:create
rails db:migrate
rails db:seed # if you have seeds
Start the Rails server:

rails server
Access the application at http://localhost:3000.

file:///home/danish/Documents/Language/RAR/Tasks/Bugzilla/Media/Screenshot%20from%202024-09-27%2014-49-44.png
file:///home/danish/Documents/Language/RAR/Tasks/Bugzilla/Media/Screenshot%20from%202024-09-27%2014-51-41.png
file:///home/danish/Documents/Language/RAR/Tasks/Bugzilla/Media/Screenshot%20from%202024-09-27%2014-53-29.png
file:///home/danish/Documents/Language/RAR/Tasks/Bugzilla/Media/Screenshot%20from%202024-09-27%2014-54-02.png
file:///home/danish/Documents/Language/RAR/Tasks/Bugzilla/Media/Screenshot%20from%202024-09-27%2014-54-29.png
file:///home/danish/Documents/Language/RAR/Tasks/Bugzilla/Media/Screenshot%20from%202024-09-27%2014-54-44.png
file:///home/danish/Documents/Language/RAR/Tasks/Bugzilla/Media/Screenshot%20from%202024-09-27%2014-55-13.png

file:///home/danish/Documents/Language/RAR/Tasks/Bugzilla/Media/Screencast%20from%2009-30-2024%2003:25:43%20PM.webm


