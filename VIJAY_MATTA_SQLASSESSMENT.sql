
--1. SQL SCRIPT
create database PetPals
use PetPals

--2. Create tables for pets, shelters, donations, adoption events, and participants.
      drop table Pets
	  create table Pets (PetId int primary key,
	  Name varchar(255),
	  Age int,
	  Breed varchar(255),
	  Type varchar(255),
	  AvailableforAdoption bit,
	  OwnerId int,
	  ShelterId int foreign key REFERENCES Shelters(ShelterId))

	  create table Shelters(ShelterId int primary key,
	  Name varchar(255),
	  Location varchar(255))

	  create table Donations(DonationId int primary key,
	  DonorName varchar(255),
	  DonationType varchar(255),
	  DonationAmount decimal,
	  DonationItem varchar(255),
	  DonationDate datetime )

	  create table AdoptionEvents (EventId int primary key,
	  EventtName varchar(255),
	  EventDate datetime ,
	  Location varchar(255))

	  create table Participants(ParticipantId int primary key,
	  ParticipantName varchar(255),
	  ParticipantType varchar(255),
	  Eventid int foreign key REFERENCES AdoptionEvents(EventId))


--INSETING DATA INTO TABLES--

       
      INSERT INTO Pets (PetID, Name, Age, Breed, Type, AvailableForAdoption,OwnerId, ShelterID) VALUES
       (1, 'Buddy', 3, 'Golden Retriever', 'Dog', 1,'', 1),
       (2, 'Whiskers', 2, 'Persian', 'Cat', 1, '',1),
       (3, 'Max', 5, 'Bulldog', 'Dog', 0, 1,2),
       (4, 'Rubby', 1, 'Siamese', 'Cat', 1,'', 2),
       (5, 'Charlie', 4, 'Beagle', 'Dog', 0, 1,3),
       (6, 'Sisi', 3, 'Golden Retriever', 'Dog', 1,'', 1)


	  alter table Pets
	  add ShelterID int foreign key REFERENCES Shelters(ShelterId)

      insert into Shelters (ShelterID, Name, Location)
      values 
      (1, 'Happy Tails Shelter', '123 Bark St, City A'),
      (2, 'Furry Friends', '456 Meow St, City B'),
      (3, 'Paws and Claws', '789 Woof Rd, City C'),
      (4, 'Haven', '101 Kitty St, City D'),
      (5, 'Home', '202 Puppy St, City E')
      
      insert into Donations (DonationID, DonorName, DonationType, DonationAmount, DonationItem, DonationDate)
      values
      (1, 'Vijay', 'Cash', 100.00, NULL, '2024-10-01 10:00:00'),
      (2, 'Raj', 'Item', NULL, 'Dog Food', '2024-10-02 11:30:00'),
      (3, 'Ram', 'Cash', 50.00, NULL, '2024-11-03 09:45:00'),
      (4, 'Shiv', 'Item', NULL, 'Cat Toys', '2024-10-03 14:15:00'),
      (5, 'Ravi', 'Cash', 75.00, NULL, '2024-11-04 16:00:00')

	  insert into AdoptionEvents (EventID, EventtName, EventDate, Location)
       values
       (1, 'Pet Adoption Fair', '2024-07-15 10:00:00', 'City A'),
       (2, 'Holiday Adoption', '2024-12-10 11:00:00', 'City B'),
       (3, 'Paws in the Park', '2024-08-20 09:30:00', 'City C'),
       (4, 'Adopt-a-Pet Day', '2024-09-25 12:00:00', 'City A'),
       (5, 'Rescue Rally', '2024-11-05 14:00:00', 'City D')

	   INSERT INTO Participants (ParticipantID, ParticipantName, ParticipantType, EventID)
        VALUES 
        (1, 'Happy Tails Shelter', 'Shelter', 1),
        (2, 'Vijay', 'Adopter', 1),
        (3, 'Furry Friends Rescue', 'Shelter', 2),
        (4, 'Raj', 'Adopter', 3),
        (5, 'Paws and Claws', 'Shelter', 4)
        
--4. Ensure the script handles potential errors, such as if the database or tables already exist.
     DROP TABLE IF EXISTS Participants
     DROP TABLE IF EXISTS AdoptionEvents
     DROP TABLE IF EXISTS Donations
     DROP TABLE IF EXISTS Pets
     DROP TABLE IF EXISTS Shelters
     
--5. Write an SQL query that retrieves a list of available pets (those marked as available for adoption) from the "Pets" table. Include the pet's name, age, breed, and type in the result set. Ensure that
--the query filters out pets that are not available for adoption.
    
	select * from Pets where AvailableforAdoption = 1

--6. Write an SQL query that retrieves the names of participants (shelters and adopters) registered
--for a specific adoption event. Use a parameter to specify the event ID. Ensure that the query
--joins the necessary tables to retrieve the participant names and types.

   select * from Participants
   select * from AdoptionEvents

   select ParticipantId, ParticipantName, ParticipantType,p.EventId, EventtName,EventDate from Participants p join AdoptionEvents e on p.Eventid = e.EventId order by Eventid



--7. Create a stored procedure in SQL that allows a shelter to update its information (name and
--location) in the "Shelters" table. Use parameters to pass the shelter ID and the new information.
--Ensure that the procedure performs the update and handles potential errors, such as an invalid
--shelter ID.

   

--8. Write an SQL query that calculates and retrieves the total donation amount for each shelter (by
--shelter name) from the "Donations" table. The result should include the shelter name and the
--total donation amount. Ensure that the query handles cases where a shelter has received no
--donations.

   select s.name as sheltername, sum(d.donationamount) as totaldonationamount from 
    shelters s left join donations d on s.shelterid = d.shelterid group by s.shelterid, s.name order by s.name


--9. Write an SQL query that retrieves the names of pets from the "Pets" table that do not have an
--owner (i.e., where "OwnerID" is null). Include the pet's name, age, breed, and type in the result
--set.
   select * from Pets  where OwnerId='0'


--10. Write an SQL query that retrieves the total donation amount for each month and year (e.g.,
--January 2023) from the "Donations" table. The result should include the month-year and the
--corresponding total donation amount. Ensure that the query handles cases where no donations
--were made in a specific month-year.
  
  select format(DonationDate,'MM YYYY'), sum(DonationAmount) as TotalDonations from Donations group by DonationDate 
   

--11. Retrieve a list of distinct breeds for all pets that are either aged between 1 and 3 years or older
--than 5 years.
  

   select distinct Breed from Pets where Age<=3 or Age >5
  


--12. Retrieve a list of pets and their respective shelters where the pets are currently available for
--adoption.

    
	select p.Name, Age, Breed, Type, p.ShelterId, s.Name, Location from Pets p join Shelters s on p.ShelterId = s.ShelterId order by p.ShelterID

--13. Find the total number of participants in events organized by shelters located in specific city.
--Example: City=Chennai
   

	  select e.EventtName, count(ParticipantId) as TotalParticipant, e.Location from Participants p 
	  join AdoptionEvents e on p.Eventid = e.EventId 
	  join Shelters s on s.Name = p.ParticipantName where p.ParticipantType = 'Shelter' and s.Location = 'Chennai' group by e.EventtName, e.Location

--14. Retrieve a list of unique breeds for pets with ages between 1 and 5 years.
      select distinct Breed from Pets where Age between 1 and 5 


--15. Find the pets that have not been adopted by selecting their information from the 'Pet' table.
     
	 select * from Pets where AvailableforAdoption = 1


--16. Retrieve the names of all adopted pets along with the adopter's name from the 'Adoption' and
--'User' tables.
    

--17. Retrieve a list of all shelters along with the count of pets currently available for adoption in each
--shelter. 
    select * from Shelters

	select s.Name, s.Location, count (p.ShelterID) as ToatalPets from Pets p join Shelters s on p.ShelterID = s.ShelterId group by s.Name, s.Location
  
--18. Find pairs of pets from the same shelter that have the same breed.
      select Name  from PetPals


--19. List all possible combinations of shelters and adoption events.
      select * from Shelters
	  select * from AdoptionEvents

	  select * from Shelters s cross join AdoptionEvents 

--20. Determine the shelter that has the highest number of adopted pets.
      
	  select s.shelterid, s.name as sheltername from shelters s where s.shelterid in (select p.shelterid from pets p where p.availableforadoption = 1 group by p.shelterid having count(p.petid) = (select max(pet_count) from (select p2.shelterid, count(p2.petid) as pet_count from pets p2 where p2.availableforadoption = 1 group by p2.shelterid) as pet_counts));
