# Granfield-Database

This project defines a relational database schema for managing software licenses, user data, and associated information within an institutional setting. The schema is designed to track software installations, licensing details, user requests, and personal information related to individuals and machines within the system. The database supports data integrity through foreign keys, unique constraints, and check constraints to ensure valid data entries.

## Database Tables
- **Ethnicity:** Contains ethnicity descriptions linked to users for demographic information.
- **Users:** Stores information about staff and instructors, including start and end dates of their roles.
- **RequestForms:** Tracks software requests submitted by users, linking each request to a user and response.
- **PersonalData:** Contains users' personal details such as name, phone number, email, and ethnicity.
- **License:** Manages software license details, including terms, pricing, and license duration.
- **Response:** Stores responses to software requests, including status and response descriptions.
- **Machine:** Details information about machines where software is installed, including location and retirement dates.
- **Software:** Lists available software packages, versions, and associated companies.
- **MachineUsers:** Relates machines to users who access them.
- **MachineSoftware:** Tracks which software packages are installed on specific machines.
Database Views
- **Department_receiving_Software:** Displays software details along with licensing information.
- **Response_Requests_for_users:** Provides a detailed view of users’ software requests and the corresponding responses.
- **everything_about_software:** Combines information about users, software details, machines, and licenses for comprehensive tracking.
- **PersonalInformation:** Displays demographic information for users, their access to machines, and software installation details.

## Data Integrity
- Foreign Keys: Ensure referential integrity between tables.
Check Constraints: Enforce valid data, such as ensuring dates are logically consistent (e.g., StartDate <= EndDate).
- Unique Constraints: Prevent duplicate entries in fields like email addresses and phone numbers.

## Example Data
The schema includes example inserts for users, machines, software, licenses, and their relationships, showcasing how the database manages different components of the software management system.

## Getting Started
To explore the database:

- Clone the repository and open softwaredatabase.db using your preferred SQLite client.
- Use .mode markdown to display outputs in markdown format.
- Query the database to view the various tables and views for a detailed understanding of the relationships.

This database schema is ideal for educational institutions or organizations seeking to manage software licenses, track software usage, and maintain user and machine information efficiently.
