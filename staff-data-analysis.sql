CREATE DATABASE staff;
USE staff;

-- Load the data from the CSV file

-- Retrieve all records from the table.
SELECT * 
FROM staff;

-- Select only the names and ages of all individuals.
SELECT Name, Age 
FROM staff;

-- Retrieve all records where the city is 'Chicago'.
SELECT * 
FROM staff
WHERE City = "Chicago";

-- Select the names and favorite foods of individuals who prefer 'Beer'.
SELECT Name, Food, Drinks
FROM staff
WHERE Drinks = "Beer";

-- List all individuals sorted by age in ascending order.
SELECT * 
FROM staff
ORDER BY Age;

-- List all individuals sorted by salary in descending order.
SELECT * 
FROM staff
ORDER BY Salary DESC;

-- Calculate the average salary of all individuals.
SELECT AVG(Salary) AS AverageSalary 
FROM staff;

-- Find the total expense of all individuals combined.
SELECT SUM(Expense) AS TotalExpense 
FROM staff;

-- Group individuals by their city and count the number of individuals in each city.
SELECT City, COUNT(Name) AS CountOfIndividuals
FROM staff
GROUP BY City;

-- Group individuals by their preferred drink and find the average salary for each group.
SELECT Drinks, AVG(Salary) AS AverageSalary
FROM staff
GROUP BY Drinks;

-- Retrieve the names and hobbies of individuals who earn more than 60,000.
SELECT Name, Hobbies, Salary
FROM staff
WHERE Salary > 60000;

-- Select all individuals who use a MacBook.
SELECT Name, Laptop
FROM staff
WHERE Laptop = "MacBook";

-- Retrieve the names of individuals who have a salary greater than the average salary.
SELECT Name, Salary
FROM staff
WHERE Salary > (SELECT AVG(Salary) FROM staff);

-- List the names of individuals who live in either 'Los Angeles' or 'New York' and prefer 'Tea'.
SELECT Name, City, Drinks
FROM staff
WHERE 
City IN ("Los Angeles", "New York")
AND 
Drinks = "Tea";

-- Create another table department to use JOIN QUERY
CREATE TABLE department(
    DepartmentId INT AUTO_INCREMENT PRIMARY KEY,
    DepartmentName VARCHAR(255),
    Name VARCHAR(255)
);

INSERT INTO department (DepartmentName, Name) VALUES
('Graphics Design', 'Bob'),
('Database Engineering', 'Charlie'),
('Front Desk', 'Danie'),
('UX Design', 'David'),
('AI Engineering', 'Dom'),
('Cloud Engineering', 'Jack'),
('System Analysis', 'John'),
('Software Engineering', 'Lina'),
('Software Engineering', 'Luther'),
('Graphics Design', 'Tina'),
('Marketing', 'Ariana');

-- Retrieve the common details from staff and department table ordered by name alphabetically
SELECT *
FROM staff
INNER JOIN department
ON staff.Name = department.Name
ORDER BY staff.Name;

-- List all staff who have a salary greater than $60,000 along with their department names.
SELECT staff.Name, department.DepartmentName
FROM staff
LEFT JOIN department
ON staff.Name = department.Name
WHERE Salary > 60000;

-- List all departments along with the count of staff in each department.
SELECT DepartmentName, COUNT(staff.Name) AS CountOfStaff
FROM department
LEFT JOIN staff
ON department.Name = staff.Name
GROUP BY DepartmentName;

-- Display all staff along with their departments. If a department doesn't have any staff, show the department details with a NULL staff.
SELECT *
FROM department
LEFT JOIN staff
ON department.Name = staff.Name;

-- List all staff and departments. If a staff doesn't have a department or a department doesn't have any staff, show their details with NULL values.
SELECT staff.Name, department.DepartmentName
FROM staff
LEFT JOIN department
ON staff.Name = department.Name
UNION
SELECT staff.Name, department.DepartmentName
FROM department
LEFT JOIN staff
ON department.Name = staff.Name;

-- Is there any person from staff table not in department table?
SELECT *
FROM staff
LEFT JOIN department
ON staff.Name = department.Name
WHERE department.Name IS NULL;

-- Is there any person from department table not in staff table?
SELECT *
FROM department
LEFT JOIN staff
ON department.Name = staff.Name
WHERE staff.Name IS NULL;

-- CASE Study
SELECT Salary, Name,
CASE
    WHEN Salary > 80000 THEN "High Salary"
    WHEN Salary > 50000 THEN "Medium Salary"
    ELSE "Low Salary"
END AS SalaryStatus
FROM staff
ORDER BY Salary DESC;
