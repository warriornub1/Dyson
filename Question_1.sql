SELECT 
    p.Category, 
    SUM(s.Revenue) AS TotalRevenue, -- Calculate total revenue for each category
    (SUM(s.Revenue) * 100.0) / 
    (SELECT SUM(Revenue) 
     FROM Sales 
     WHERE YEAR(SaleDate) = YEAR(GETDATE()) - 1) AS PercentageContribution -- Compute percentage contribution
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID -- Join Sales table with Products table to get category information
WHERE YEAR(s.SaleDate) = YEAR(GETDATE()) - 1 -- Filter only records from last year
GROUP BY p.Category -- Aggregate data by category
HAVING SUM(s.Revenue) > 0 -- Ensure categories with no sales are excluded
ORDER BY TotalRevenue DESC; -- Sort the results in descending order of total revenue