# App Name: Posi Life

# Team Member: 

- Yiwei Zha
- Zhen Sun
- Zhenziye Lin

## 1 Purpose

The "PosiLife" Healthy Lifestyle Mobile App aims to redefine how women approach and manage their personal health. In a world increasingly focused on physical and mental well-being, the application offers an integrated solution that not only tracks health metrics but also ensures sustained motivation through positive reinforcement and personalized insights. Also, the menstrual cycle period may always be a big problem for females. The applications are able to support females with period tracking and reminders to help them better organize the period. By leveraging the Flutter framework, the app promises a seamless experience across different devices, allowing users to monitor and enhance their health trajectory.

### 1.1 Definitions:

PosiLife: A state-of-the-art Healthy Lifestyle Mobile App designed for health-conscious individuals.

User: A person who has installed and actively engages with the PosiLife app to monitor and improve their health.

User Profile: A digital representation within the app that encapsulates the user's demographic details, health metrics, and set targets.

Health Indicators: Quantifiable metrics such as weight, sugar levels, heart rate, and blood pressure that provide insights into the user's health.

Positive Reminders: Proactive notifications encouraging users to maintain or improve their health metrics, remember appointments, or celebrate milestones.

Data Security: An inherent app feature that guarantees the privacy and safety of the user's health information from potential threats or unauthorized access.

### 1.2 Background:

In recent years, the surging interest in personal health management has resulted in an abundance of health-tracking apps. However, many lack a holistic approach, often concentrating solely on data accumulation without providing actionable insights or motivation. The PosiLife app emerges as a beacon in this space, uniquely integrating health data tracking, user-specific goal setting, daily habit cultivation, and, most notably, positive reinforcement. Recognizing that consistent motivation is key to health improvement, PosiLife offers female users an interactive platform that not only monitors but also celebrates every step in their health journey. Through this comprehensive approach, the app addresses lifestyle-related health challenges and female-targeting features, ensuring that users remain engaged and inspired in their quest for better health.


## 2 Overall Description

### 2.1 User Characteristics:

Age: 12- 50 

Gender: female.

Mainly focus on females who have their body health pursuit and want to have an integrated health-tracking app to track their health status.

### 2.2 User Stories:

User stories describe the functionality from the user's perspective. Here are some user stories for the PosiLife app:

As a user, I allow the application to store my health data.

As a user, I want to create a profile with my personal information, health conditions, and goals.

As a user, I want to track my health indicators, such as weight, height, BMR and see their treadings.

As a user, I want to record my daily meal and calories plan.

As a user, I want to record my daily water intake.

As a user, I want to track my sleep duration.

As a user, I want to track my Menstrual Cycle.

As a user, I want to receive positive reminders for water intake, BMI fluctuations, sleep duration and menstrual cycle.

As a user, I want the option to manually input health data and control data sharing for privacy.

As a user, I want the option to just quickly check-in for the water intake module and sleeping time module..

As a user, I want to have my data entered in each module to generate a report for viewing.

As a user, I want my data to be stored securely and not vulnerable to breaches.

### 2.3 App Workflow (Flowchart):

![flowchart](https://github.com/CS5520-Seattle-Fall23/finalproject-guardians-of-the-galaxy/assets/109750971/04c8f0b0-ad8b-4d10-b9ff-e38cc4eb0f2b)


## 3 Requirements:

### 3.1 Functional:

User Registration:

- Users can create accounts with personal information, health conditions, and goals.

- Users can log  in and out of their accounts.

- Users have the notification for consenting storing data privacy.

Health Monitoring:

- Wellness (weight, height, BMI, BMR).

- Users can see their BMI and BMR through the basic information we collected from registration.

- Users are able to update their weight.

- Users can see the generated summary for last and current records comparison.

Water Intake 

- Users can record daily water intake.

- Users can view the water intake calendar that checks the date she accomplished the goal

- Users can set notifications for the hydrating period.

- Users can see today’s water intake amount

- Users can see the report for water intake

Sleep Duration: 

- Users can manually enter their sleeping time and duration

- Users can view the sleep duration calendar that checks the date she accomplished the goal

- Users can set notifications for sleeping time.

- Users can see today’s sleeping duration.

- Users can see the report for sleeping duration.

Diet(Calories Consumption): 

- Users can manually enter their calories consumed.

- Users can set notifications for calories consumption..

- Users can view the calories calendar that checks the date she accomplished the goal

- Users can set notifications for calories consumption.

- Users can see today’s calories consumption.

Menstrual Cycle Tracking: 

- Users can track their menstrual cycles.

- Users can set notifications for upcoming periods.

- Users can view the period calendar to know their period for last month.

- Users can see the summary of their average period of menstrual cycle.

Switch Page:

- Using a hamburger button to let Users switch from one module to another.

Manual Data Input:

- Users can manually input health data.

- Users have control over data sharing for privacy.

Positive Reminders:

- App sends timely positive reminders for health assessments, appointments, water intake notification and milestones achieved.

Health Trending Report Generation:

- Users can generate trending reports according to their manually entered health data for all four modules(water, sleep, diet, , wellness).

Data Security:

User data is stored securely and protected from breaches.

### 3.2 Non-functional Requirements:

Scalable Database:

Implement a scalable database system to store user profiles, health data, and chat records.

Secure Authentication:

Implement a secure authentication system to safeguard user accounts and data.

Usability:

The app must have an intuitive and user-friendly interface.

Compatibility:

The app should be compatible with iOS and Android devices.

Privacy:

The app must comply with privacy regulations and provide clear data-sharing controls to users.

Localization:

The app should support multiple languages to cater to a global audience.

Reliability:

The app should operate reliably without frequent crashes or downtime.

Security:

The app must implement robust security measures to protect user data.

Accessibility:

The app should be accessible to users with disabilities.

Data Backup:

Implement regular data backup mechanisms to prevent data loss.

Performance Optimization:

Optimize the app's performance for varying network conditions.

This software development specification outlines the key requirements and specifications for the development of the PosiLife Healthy Lifestyle Mobile App. These requirements will serve as the foundation for the development process, ensuring the successful creation of a user-friendly, motivating, and secure health management app.


## 4 App pain point and solution

### 4.1 Summary of Pain Points

The PosiLife app is an ambitious project that seeks to integrate various health metrics into a seamless user experience. The primary pain points identified in the backend design document revolve around real-time data synchronization, secure and efficient data processing, user experience consistency, and unit conversions across different health categories.

### 4.2 Pain Point Analysis

4.2.1 Data Structure and Retrieval:
  
- Complex Firestore Structure: The app's reliance on Firestore necessitates a well-organized database structure. This is challenging because it requires foresight into how data might scale and how users might interact with it. Poorly   structured data can lead to slow queries and higher costs.

- User Authentication Integration: Integrating Firebase Authentication with Firestore is non-trivial. It must be done in a way that maintains security without sacrificing user convenience.
  
4.2.2 Real-Time Updates:

  - Performance Risks: Implementing listeners for real-time updates could potentially lead to performance issues, especially with a growing number of users. Efficient data fetching strategies and judicious use of listeners are crucial.

4.2.3 Data Processing and Functionality:

- Handling Incomplete Data: Users may not always input data consistently. The app must handle this gracefully, ensuring that incomplete data doesn't lead to a poor user experience or incorrect health advice.
  
- Concurrency in Updates: The ability to handle multiple concurrent updates without losing data integrity or causing user conflicts is important, particularly for features like water intake records.
  
4.2.4 User Experience Consistency:

- Unit Conversions and Preferences: Given that the app deals with various units of measurement, ensuring accurate conversions and respecting user preferences across all screens is essential for a consistent user experience.
  
- Calendar Integration: The calendar feature must be intuitive and user-friendly. Displaying historical data in an easy-to-understand format without cluttering the UI is a design challenge.

4.2.5 Scalability and Future Growth:
- Growth Management: As the user base grows, the backend must scale accordingly. This includes scaling the database structure, optimizing query performance, and ensuring that the real-time update system remains efficient.

### 4.3 Pain Point Solution

4.3.1 User Data Storage and Retrieval

(1)Firestore Structure Design
Designing an optimal document and collection structure to ensure efficient queries and updates.

(2)User Authentication
Leveraging Firebase Authentication for secure password handling and integrating it with Firestore for user data management.

4.3.2 Real-Time Data Syncing

(1)Firestore Real-time Updates
Implementing listeners for real-time data synchronization while managing potential performance bottlenecks.

4.3.3 Data Processing and Functionality Implementation

(1)HomeScreen Data Retrieval
Ensuring efficient fetching and rendering of user's name from Firestore on the HomeScreen.

(2)Water Intake Functionality
Display Water Intake and Goals: Accurately fetching and displaying daily water intake and goals, handling the possibility of missing or incomplete data.
Water Intake Record Management: Securely updating user's water intake records and handling potential concurrent updates.

(3)Reminder Setup
Setting up reliable reminders for water intake, considering various user time zones and preferences.

(4)Calendar Integration
Integrating a user-friendly calendar to display water intake history and status.

4.3.4 Diet Management

(1)Diet Intake Tracking
Accurate tracking and representation of diet intake and goals, with a focus on user experience and data accuracy.

(2)Diet Record and Reminder Management
Securely updating diet records and managing diet reminders for users, taking into account user-specific settings.

4.3.5 Sleep Tracking
(1)Sleep Data Retrieval
Fetching and displaying sleep time accurately, considering user's timezone and preferences.

(2)Sleep Record Management
Efficiently updating sleep records and managing reminders, ensuring a smooth user experience.

4.3.6 Wellness Management

(1)Weight Data Processing
Accurate retrieval and display of weight data, including unit conversions and historical data comparison.

(2)Weight Record and Reminder Management
Ensuring secure updates to weight records and managing wellness reminders effectively.


## 5 Accessibility

5.1 Handling Unit Conversions

- Implementing accurate and efficient unit conversion functions for water (mlToOz), diet (convertUnitsInDiet), and weight (kgToLb) to cater to users' diverse health habits.

5.2 Cognitive Accessibility

- Clear Instructions and Labels: Use simple and clear language with an intuitive interface design.
  
- Consistent Layout and Navigation: Maintain consistency in interface elements and navigation to reduce cognitive load for users and respect users’ preference
  
5.3 Simplified Interactions

- Reduce operations that require fine motor control, such as avoiding too small click targets.

5.4 Color Contrast and Usage:

- Use high-contrast color combinations to ensure that users with color blindness or limited vision can distinguish elements.


## 6 Wireframe

https://www.figma.com/file/IsqiHW9wOqp7rV9W8Is3L1/PosiLife?type=design&node-id=0%3A1&mode=design&t=zeqIKPNi0dxjL560-1

## 7 UML Class Diagram 

![classDiagram_dec](https://github.com/CS5520-Seattle-Fall23/finalproject-guardians-of-the-galaxy/assets/109750971/f9dbbe3d-8e07-4378-a33c-321cf35c2857)


https://www.mermaidchart.com/app/projects/bf810f01-1cb7-4daa-b08b-b9954629bffe/diagrams/c4189db9-ca16-4b99-8b9b-52c1bf893bcf/version/v0.1/edit

## 8 Gantt Diagram

![GanttChat_Dec](https://github.com/CS5520-Seattle-Fall23/finalproject-guardians-of-the-galaxy/assets/109750971/8825d0fe-2e95-4bae-a9fc-b7be0e2f3b48)


## 9 Traceability Matrix

| ID | Ass.ID | Requirements Description | Justification | Project Objective | Priority | Test Cases |
|----|--------|--------------------------|---------------|-------------------|----------|------------|
| 1  | 1.1    | User Registration        | Facilitate secure user onboarding | User Management | High | TC-01, TC-02 |
| 1  | 1.2    | Login Functionality      | Ensure user can access their account | Access Control | High | TC-03 |
| 2  | 2.1    | Password Management      | Allow users to reset and change passwords | Account Security | Medium | TC-04 |
| 3  | 3.1    | Account Creation         | Streamline account setup process | User Experience | Medium | TC-05 |
| 4  | 4.1    | Water Intake Tracking    | Help users monitor hydration | Health Tracking | High | TC-06 |
| 4  | 4.2    | Water Intake Goal Set    | Enable users to set daily water intake goals | Health Tracking | High | TC-07 |
| 4  | 4.3    | Water Intake Calendar    | Provide a visual representation of users' hydration over time | Health Tracking | Medium | TC-08 |
| 4  | 4.4    | Water Intake Report      | Generate reports on water intake for users | Data Analysis |  Low | TC-09 |
| 5  | 5.1    | Sleep Time Tracking      | Enable tracking of sleep patterns | Health Tracking | High | TC-10 |
| 5  | 5.2    | Sleep Time Goal Set      | Allow users to set sleep duration goals | Health Tracking | High | TC-11 |
| 5  | 5.3    | Sleep Time Calendar      | Provide a visual representation of users' sleep time | Health Tracking | Medium | TC-11 |
| 5  | 5.4    | Sleep Time Report        | Generate reports on sleep time for users  | Data Analysis | Low | TC-12 |
| 6  | 6.1    | Diet Tracking            | Assist users in managing caloric intake | Health Tracking | High | TC-13 |
| 6  | 6.1    | Diet Goal Set            | Facilitate users in setting dietary goals | Health Tracking | High | TC-14|
| 6  | 6.1    | Diet Calendar            | Create a daily log of dietary intake | Health Tracking | Medium | TC-15 |
| 6  | 6.1    | Diet Report              | Provide a visual representation of users' sleep time | Data Analysis| Low | TC-16 |
| 7  | 7.1    | Wellness Tracking        | Assist users tracking weights | Health Tracking | High | TC-17 |
| 7  | 7.2    | Wellness Calculation     | Compute BMI and BMR for users | Data Analysis | Medium | TC-18 |
| 7  | 7.3    | Wellness Comparison      | Compare user's weight with last | record Data Analysis| High | TC-19 |
| 8  | 8.1    | Generate Health Report   | Provide users with health trend insights | Data Analysis | High | TC-20, TC-21, TC-22, TC-23 |
| 9  | 9.1    | Menstrual Cycle Tracking | Help users tracking period cycles | Health Tracking | High | TC-24 |
| 9  | 9.2    | Period Cycle Set         | Allow users to track menstrual cycles | Health Tracking | High | TC-25 |
| 10 | 10.1   | Notification System      | Inform users of reminders | User Engagement | Medium | TC-26 |
| 11 | 11.1   | Data Security            | Ensure user data is protected | Security | High | TC-27 |


## 10 Project Backlog

- Complete first round user study by 9/19.
  
- Finish the general layout of the Software Requirements Specification by 9/20. 

- Finished the main technical requirements for our application and completed the software requirement specification by 9/26.

- Discussed the design of the Lo-Fi wireframe by 10/2. Yiwei Zha sketched the initial version by hand.

- Finalized the wireframe based on our requirements by Yiwei Zha 10/3.

- User Feedback: Compile and prioritize adjustments based on user feedback by all team members.

- Polishing the Software Requirements Specification to 2.0v by 10/7.

- Completed the wireframe modifications and added detailed descriptions for each page in Lo-Fi wireframe by 10/12.

- Makoya generated the sprint report2 by 10/23.

- Develop the Sign in/Sign up(User Registration) part by Yiwei Zha by 10/25.

- Completed another version of SRS by all team members and Yiwei Zha also updated it in README by 10/18

- Zhen Sun completed the Hi-Fi wireframe in Figma by 10/22.

- Finalized all app functionalities based on the wireframe's final version by 10/25.

- Start to work on frontend Feature in 11/1

- Makoya generated the sprint report3 by 11/4.

- Started work on frontendcode.Yiwei Zha worked on user login , water and period sreen. Makoya and Zhen Sun worked on the Sleep, Diet and Wellness Screen. while some of the frontend features that they built looked differently from our high fidelity wireframe by 11/13.

- Yiwei Zha finish user login and Firebase authentication integration by 11/15.

- Yiwei Zha rebuilt Sleep,Diet and Wellness Modules to make the style consistent by 11/20.

- All Frontend Features Done by 11/27.

- Finished the 1st version of  data collection design in firestore by Zhen Sun by 11/28, Yiwei Zha reviewed and  redesigned by 12/1.

- The  backend logic design in water and wellness screen done by Yiwei Zha finished by 11/29 and the backend logic design Sleep and Diet screen done by Zhen Sun finished by 11/29.

- Reorganized the structure to make it a MVC design pattern and made all the style of screens of waterIntake, Diet, Wellness, and sleeptime modules consistent by Yiwei Zha by11/30.

- Complete the reminder and record backend functionality for the water module and record tutorial video for team by Yiwei Zha by 12/1.

- Finished the reminder and record backend functionality for the sleep and diet module by Zhen Sun by 12/2.

- Finished the wellness backend logic by Yiwei Zha by 12/3.

- Finished the period backend logic by Zhen Sun by 12/5.

- Updated project board and organized project file by Makoya by 12/6.
- 
- Polished the backend logic in user account by Yiwei Zha by 12/6.

- Finalized the update in class diagram, SRS, wireframe, matrix and all the doc by Makoya, Zhen Sun and Yiwei Zha by 12/7.

- Finalized, checked and polished the project by Yiwei Zha by 12/8.
