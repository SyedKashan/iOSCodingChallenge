# Polestar iOS Technical assessment

Utilising the OpenLibrary API, please produce a simple book search engine that shows the top 10 book results for a given search term.
## Features
- [x] Landing Page with Search functionality
- [x] Search Result Page with Loading and Empty States
- [x] Local (coredata) And Remote Data Store - Fetch, store and retrieve data to and from disk
- [x] Basic Input validation implementation
- [x] Strings Localisation
## To-Dos
The following list contains features that were not included in the challenge requirements, and as such I left them given time constraints, but would definitely be something to consider for real world scenario.
- [ ] Unit tests
- [ ] Snapshot tests
- [ ] Complete API documentation
- [ ] Local Store error handling
- [ ] General UI/UX Improvements.
- [ ] Improve Validation by creating Validator object, rules enum and set of specific errors.
NOTE: By reading the challenge I initially (and probably mistakenly) had feeling two screens were required.
But ideally I would want to do the same challenge in only one screen.
The Landing page with following elements:
- UISearchBar on top
- Message inviting user to search in middle of the screen
- UITableView to display search results
- Empty view, Error View replacing the list when needed.
Nice to have would be a search autocompletion (although that's off the requirements :())
## Requirements
-  Please create a landing page where you can input the search term i.e. "Lord of the rings".
-  On clicking an OK button, the app will show the top 10 books (title, cover, author, year etc.) for that search.
-  We will leave the UI design of the app to the applicant but keep it simple as we do not expect our developers to be graphic designers too.
-  We expect to see some examples of error handling and input validation.
-  We would like the UI to be written with UIKit.
  ## Optional Requirements:
-  Store the API output in a local sqlite database
-  For the searches, search the local database first and then hit the API in case of no result
## Architecture
I have used uni-directional VIP architecture. The three main components of VIP are the view controller, interactor and presenter.
They act as input and output to one another, as shown in the following diagram.
![10-650x459](https://user-images.githubusercontent.com/43185459/177509320-22c9a540-7301-4c33-9c62-d43c07325501.png)



A few of the advantages are below:
- Follows SOLID principles
- Data flows in one direction making it easier to debug
- Testing becomes more straightforward as all the components abstract protocols and keep a reference to each other via protocol, which makes it easy to mock them while testing.
- The Router handles all the navigation-related code.
## Inception
I tried to stick to requirements as much as possible keeping time constraints always in mind.
After reading the assignment I sketched down on paper the app flow I had in mind:
- A landing page with a search input field and an 'ok' button.
- A page displaying the top 10 results (including some edge case view i.e. empty-no data)
After, I tried to break down (still on paper) the work in individual tasks, thinking it would help me to create a cleaner commit history.
I knew I would want to utilise the VIP Architecture as its very lightweight and it would suffice in this circumstance.
Soon after that I started building the project: boilerplate code, modules infrastructure, UI, networking, storage etc..
As a final step reviewed the code and removed, cleaned/changed unnecessary code.
## Meta
Syed Ali Kashan

[swift-url](https://swift.org/)

[license-image](https://img.shields.io/badge/License-MIT-blue.svg)
