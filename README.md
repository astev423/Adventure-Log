# Adventure Log
An app semi-inspired by Yelp. Users can see reviews of places and add their own review. Google Maps integration is used to display reviews as markers on a map. Reviews can also be viewed as a list and users have many filter options to specify which reviews they want to see. 
<img width="1782" height="955" alt="Screenshot_20260325_035742" src="https://github.com/user-attachments/assets/62508312-40d1-49f0-ab83-b685fbcdf9bd" />
<img width="1848" height="955" alt="Screenshot_20260325_035810" src="https://github.com/user-attachments/assets/e77e0d19-d15d-4533-9ba3-8874c0f132b4" />
<img width="1848" height="955" alt="Screenshot_20260325_035830" src="https://github.com/user-attachments/assets/b154e348-c484-4e4e-b806-0a8f642ba60d" />


## What I've worked on
- I finished the profile stats page for displaying review related stats for a user's account. I also added a mobile view to the profile page so it works on different screen sizes.

- I also fixed a tricky bug where ignored reviews were still visible even though they shouldn't be

- I finished my presentation and deployed my site on github pages so I am now ready to present.

## Challenges
- I find adding mobile views difficult. I usually just copy and paste my computer view code but change some things around, but that means there is a lot of duplicated code. I am not sure how to avoid all this duplication.

## Goals for next time
- I feel like the project is complete and I am happy with it and ready to turn it in

## Resources used
- I had to reference how to use features of the future type, I used these resources: 
https://dart.dev/libraries/async/async-await
https://api.flutter.dev/flutter/dart-async/Future-class.html

- I used Gemini AI to help make the GitHub pages deploy.yml file. Prompt asked: How to make a yml file for GitHub pages deployment with a flutter app 

- I ran into several error messages in the GitHub pages actions console while trying to deploy the app and I copy and pasted the error message into Gemini AI to try to see what was wrong. The problems were that I wasn't including enough files. For example, I needed my web/ folder but that was in gitignore and I needed the firebase options file so I had to include both of those and remove them from gitignore
