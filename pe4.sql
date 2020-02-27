DECLARE @Start DATETIME = GETDATE()
CREATE TABLE P_4 (
    ID INT IDENTITY(1, 1),
    A INT,
    B INT,
    Pal INT)

DECLARE @i INT = 100

WHILE (@i < 999)
BEGIN
    INSERT INTO P_4 (Pal) VALUES (@i * 1000 + REVERSE(@i));
    SET @i = @i + 1
END

SET @i = 100
WHILE (@i <= 999)
BEGIN
    UPDATE P_4
    SET
        A = @i,
        B = Pal / @i
    WHERE Pal % @i = 0
    SET @i = @i + 1
END

DELETE P_4
WHERE LEN(CAST(B AS VARCHAR(6))) <> 3 OR A IS NULL

SELECT MAX(Pal) AS 'Solution', (DATEDIFF(ms, @Start, GETDATE())) AS 'Time' FROM P_4;