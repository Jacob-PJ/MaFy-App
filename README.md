A half-finished app inspired by Khan Academy and HPguiden that I worked on after becoming frustrated with how difficult it was to study for the Matematik -och Fysikprovet (A type of entrance exam contianing math and pysics questions). The app is built using Google's programming language Dart and the cross-platform framework Flutter.

Currently, the database is shut down, so the app is not functional. However, there are some images in the PHOTOS folder. The main reason I didn’t finish the app was that I realized how long it would take to create all the questions. I wanted most of the questions to be generated dynamically when selected, which isn’t overly complex but is extremely time-consuming if it needs to cover all the math and physics topics for the exam.

App Structure
Home Page
Displays important dates.
A link to practice previous exams.
Recently practiced topics.
Recommended practice areas.
Explore/Practice
Divided into three sections: Mathematics, Physics, and Exams.

At the top of each section, there is a progress bar for the entire subject.
Below that, a quick access button leads to the last practiced topic.
All subject areas are listed below (e.g., "Numbers" and "Trigonometry" in Mathematics).
Clicking on a subject opens a subpage structured similarly but focused on that topic, further divided into subtopics with explanatory texts and exercises. Each subtopic has its own progress bar.
Back on the subject page, there is a link to a mock test that includes questions from all parts of the subject.
Profile
Displays progress bars for mathematics and physics.
Shows the highest score from completed tests.
Below, notifications are listed.
A section for bookmarked topics is also available.
