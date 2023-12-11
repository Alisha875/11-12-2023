CREATE DATABASE ExerciseDb1
USE ExerciseDb1

-- Create Products table
IF OBJECT_ID('Products', 'U') IS NOT NULL
    DROP TABLE Products;

CREATE TABLE Products (
    PID INT PRIMARY KEY IDENTITY(1,1),
    PName NVARCHAR(255),
    PQty INT,
    PPrice DECIMAL(10, 2),
    DiscountPercent DECIMAL(5, 2),
    DateAdded DATE
);

-- Insert at least 5 records into Products table
INSERT INTO Products (PName, PQty, PPrice, DiscountPercent, DateAdded)
VALUES 
    ('ProductA', 10, 50.00, 10.00, '2023-01-01'),
    ('ProductB', 5, 30.00, 5.00, '2023-02-01'),
    ('ProductC', 20, 80.00, 15.00, '2023-03-01'),
    ('ProductD', 8, 45.00, 8.00, '2023-04-01'),
    ('ProductE', 15, 60.00, 12.00, '2023-05-01');

-- Create a function to calculate discounted value
IF OBJECT_ID('dbo.CalculateDiscount', 'FN') IS NOT NULL
    DROP FUNCTION dbo.CalculateDiscount;

GO
CREATE FUNCTION dbo.CalculateDiscount(
    @Price DECIMAL(10, 2),
    @DiscountPercent DECIMAL(5, 2)
)
RETURNS DECIMAL(10, 2)
AS
BEGIN
    DECLARE @DiscountedValue DECIMAL(10, 2);
    SET @DiscountedValue = @Price - (@Price * @DiscountPercent / 100);
    RETURN @DiscountedValue;
END;
GO

-- Show details using the function
SELECT 
    PID,
    PPrice AS Price,
    DiscountPercent AS Discount,
    dbo.CalculateDiscount(PPrice, DiscountPercent) AS PriceAfterDiscount
FROM Products;