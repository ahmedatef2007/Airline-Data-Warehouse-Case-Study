# Airline Data Warehouse Case Study

## Analyze And Model Data Warehouse for Airline System Project

The purpose of this project is to analyze the flight activities of airline companies and their frequent flyers, and model its data warehouse schema.

### Prepared by:
- Ahmed Atef Mahmoud
- Donia Ayman
- Mariam Maged

## Dimensional Modeling Process

### 1. Business Process
- Reservation
- Flights Activity
- Frequent Flyers
- Customer Care

### 2. Grain Level
- Reservation Fact: One row per reservation.
- Segment Flight Activity Fact: Per Segment Level
- Trip Flight Activity Fact: Per Trip Level
- Frequent Flyer Fact:
- Customer Care Fact: Per Customer Interaction Level

### 3. Dimension Tables
- Passenger Dimension
- Passenger Profile Dimension
- Flight Dimension
- Airport Dimension
- Aircraft Dimension
- Booking Channel Dimension
- Fare Basis Dimension
- Class Upgrade Dimension
- Payment Method Dimension
- Interaction Type Dimension
- Problem Severity Dimension
- Redeem Dimension 
- Customer Experience Dimension
- Date Dimension
- Time Dimension 

### 4. Fact Tables
- Reservation Fact
- Segment Flight Activity Fact
- Trip Flight Activity Fact
- Frequent Flyer Fact
- Customer Care Fact

## Business Processes:

### 1. Passenger Registration and Profile Creation:
- Passengers register and provide personal information.
- Passenger profiles are created with details such as status, club membership type, mileage tier, and membership status.

### 2. Flight Reservation:
- Passengers make flight reservations through various booking channels.
- Each reservation includes details like confirmation number, ticket number, departure airport, arrival airport, scheduled departure date, and flight type.

### 3. Flight Activity Tracking:
- Tracking of flight activities involves recording data related to each flight segment.
- This includes information such as aircraft details, departure, and arrival airport keys, scheduled and actual departure and arrival dates and times, fare price, taxes, luggage, and any upgrades.

### 4. Customer Care Interaction:
- Customers interact with customer service agents for problem resolution and feedback.
- Interactions are logged with details like interaction type, problem severity, flight type, date, time, and customer information.

### 5. Frequent Flyer Program:
- Members earn and redeem frequent flyer miles based on flight activities.
- Frequent flyer facts capture member details, flight information, miles earned and redeemed, and any upgrades.

### 6. Fare Basis and Payment:
- Fare basis details are recorded, including fare type, code, and promotional status.

## Tables Identifications

### 1. Passenger Dimension
- Includes passenger details (e.g., frequent flyer status, age group, gender).

### 2. Passenger Profile Dimension
- A status, club membership, and mileage tier.

### 3. Flight Type Dimension
- Describes Flight Zone and Type 

### 4. Airport Dimension
- Describes airports.

### 5. Aircraft Dimension
- Describes the model, capacity, and manufacturer of each Aircraft.

### 6. Booking Channel Dimension
- Represents reservation channels (e.g., online, phone, travel agents).

### 7. Fare Basis Dimension
- Holds fare basis codes and related information.

### 8. Class Upgrade Dimension
- Represents class upgrades including purchased class, actual class, and change indicator.

### 9. Payment Method Dimension
- Describes The Payment Method Used for Reserving a Flight

### 10. Interaction Type Dimension
- Contains data about different types of interactions, like channel and stage.

### 11. Problem Severity Dimension
- Stores severity levels for problems encountered, along with resolution status and description.

### 12. Redeem Dimension 
- Stores information about redemption, including redemption type, category, and description.

### 13. Customer Experience Dimension
- Contains data related to customer experience, such as priority check-in, boarding, and baggage.

### 14. Date Dimension
- Contains Date and related attributes (e.g. Year, Quarter, Month, Day).
- Role-playing dimension: We used the same date dimension for different purposes (e.g., flight departure time, flight arrival time).

### 15. Time Dimension 
- Contains time and related attributes (e.g. Hour of Day, Time Slot).
- Role-playing dimension: We used the same time dimension for different purposes (e.g., flight departure time, flight arrival time).

### 16. Reservation Fact
- Stores reservation-related information like passenger details, booking channel, price, etc.

### 17. Segment Flight Activity Fact
- Records details about flight segments, including passenger details, flight information, prices, etc.

### 18. Trip Flight Activity Fact
- Stores reservation-related information like passenger details, booking channel, price, etc.

### 19. Frequent Flyers Fact
- Records data about frequent flyers, including member details, flight information, miles earned, etc.

### 20. Customer Care Fact
- Stores information about interactions between customers and customer care, including problem severity, interaction type, etc.

## Why we Choose This Model
We chose this data model design because it aligns with the Kimball method, which emphasizes simplicity, flexibility, and usability in data warehousing projects. Our approach involved breaking down the data into separate tables, each focusing on a specific aspect of the business processes involved in airline operations.

1. Simplicity: By breaking down the data into separate tables for each business process, we ensure simplicity in data management and querying. Each table represents a distinct entity or aspect of the business, making it easier to understand and work with the data.

2. Flexibility: The modular design of our data model allows for easy modification and expansion as business requirements evolve. New tables can be added to accommodate additional business processes or data sources without disrupting existing structures.

3. Focus on Business Processes: Each table in our data model represents a specific business process or entity relevant to airline operations. For example, we have tables for passenger information, flight details, reservations, customer care interactions, and frequent flyer programs.

## Physical Model
Attached All The SQL Files To Generate The Physical Model: [Physical Model](link)

## Business Questions
- What flights the company’s frequent flyers mostly take?
- Analyze fare basis paid by frequent flyers.
- Calculate frequency of upgrades by frequent flyers' Silver Club.
- Calculate frequency of upgrades by frequent flyers 'Gold Club'.
- Responses to special fare promotions by frequent flyers.
- The portion of passengers in the different club memberships.
- Most departured from.
- Most arrived airport.
- Number of Resolved Complaints.
- Total number of interactions per severity level.
- Number of interactions by interaction type and channel.
- What are the preferred booking channels for reservations?
- Which flights are preferred by frequent flyers?
- How often do frequent flyers upgrade their class?
- How do frequent flyers earn and redeem their miles?
- What is the total net price earned from reservations for each quarter of a specific year?

## Assumptions
1. To be a frequent flyer you must exceed 100,000 miles and travel 5 times per year.
2. Feedback from a customer is divided into 2 categories (inquiry or complaint) which may happen before, within, or after the trip, and we keep track of the status which may be resolved, pending, or escalated.
3. Passengers can upgrade their class.
4. Passengers can redeem their points for various rewards such as free flights, cash back rewards, seat upgrades, gift cards, and free hotel status.
