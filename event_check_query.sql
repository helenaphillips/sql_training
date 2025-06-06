-- Insert sample data with a canceled order older than 30 days:

INSERT INTO Orders (CustomerID, OrderDate, DeliveryDate, Status, PaymentStatus, TotalAmount)
VALUES (3, '2024-09-15', NULL, 'Cancelled', 'Refunded', 0.00);



-- Manually trigger the event
CALL CleanupOldCanceledOrders();
