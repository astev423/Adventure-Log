# Adventure Log
An app semi-inspired by Yelp. Users can see reviews of places and add their own review. Google Maps integration is used to display reviews as markers on a map. Reviews can also be viewed as a list and users have many filter options to specify which reviews they want to see. 
<img width="1782" height="955" alt="Screenshot_20260325_035742" src="https://github.com/user-attachments/assets/62508312-40d1-49f0-ab83-b685fbcdf9bd" />
<img width="1848" height="955" alt="Screenshot_20260325_035810" src="https://github.com/user-attachments/assets/e77e0d19-d15d-4533-9ba3-8874c0f132b4" />
<img width="1848" height="955" alt="Screenshot_20260325_035830" src="https://github.com/user-attachments/assets/b154e348-c484-4e4e-b806-0a8f642ba60d" />

# Project progress update #2

## What I've worked on
-Saving reviews, adding the firestore query functionalities for working with that data and also
utilizing and showing that data in the UI.

-Hidden reviews, similar to saved reviews

## Challenges
-I found it challenging working with NoSQL and firestore which doesn't like foreign keys and instead focuses 
on denormalizing data. Coming from SQL this is tricky to get used to. Also the document id is handled
differently than a normal field which caused me some confusion, especially when working with data that 
has both id fields and a non field id.

-My review code is a bit intertangled and I have to be careful not to make breaking changes or else it might
affect all my pages that use reviews.

-Taking a short break from the project then coming back to a giant code base and having to relearn it a bit.


## Goals for next time

## Resources used
-Gemini for error messages

-I had to reference the firestore documentation here: https://firebase.flutter.dev/docs/firestore/usage/
but thankfully, I feel like I wrote decent code and was able to reference a lot of my own code for 
re-remembering how to do things like CRUD operations.
