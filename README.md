# Adventure Log
An app semi-inspired by Yelp. Users can see reviews of places and add their own review. Google Maps integration is used to display reviews as markers on a map. Reviews can also be viewed as a list and users have many filter options to specify which reviews they want to see. 
<img width="1782" height="955" alt="Screenshot_20260325_035742" src="https://github.com/user-attachments/assets/62508312-40d1-49f0-ab83-b685fbcdf9bd" />
<img width="1848" height="955" alt="Screenshot_20260325_035810" src="https://github.com/user-attachments/assets/e77e0d19-d15d-4533-9ba3-8874c0f132b4" />
<img width="1848" height="955" alt="Screenshot_20260325_035830" src="https://github.com/user-attachments/assets/b154e348-c484-4e4e-b806-0a8f642ba60d" />

# Challenges
-Building responsive UI that works on both desktop and mobile, logic pixels vs physical pixels, working
with layout, etc

-Dealing with the unique quirks and functionalities of all the dependancies

# Project progress update #2

## What I've worked on
-Showing user profile pictures on their review posts

-Added delete button + modal popup for deletion confirmation, and reloading posts upon deletion (tricky)

## Challenges

-Working with google cloud which has lots of updates meaning old methods for doing things don't work
anymore and having to find up to date documentation

-Upgrading packages and finding out functions I once used don't work anymore

-Refetching posts upon deletion, required me to think deeply about how i structure my project and 
it needed a lot of prop drilling, some kind of global state management would help

## Goals for next time

## Resources used
-I asked ChatGPT for help debugging outdated functions when I upgraded my packages, one prompt I asked
was "why can't i see the google map?" and then the error message + my code for displaying the google map