-- The event runs once daily (EVERY 1 DAY).
-- It deletes orders where:
-- Status is Cancelled.
-- OrderDate is older than 30 days.

DELIMITER //
CREATE EVENT CleanupOldCanceledOrders
ON SCHEDULE EVERY 1 DAY
STARTS CURRENT_TIMESTAMP
DO
BEGIN
    DELETE FROM Orders
    WHERE Status = 'Cancelled' AND OrderDate < (CURRENT_DATE - INTERVAL 30 DAY);
END;
//
DELIMITER ;
