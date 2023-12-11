# pending payment

with compiledorder as 
(select *, sum(quantityOrdered * priceEach) as orderamount 
from orderdetails
inner join orders using(orderNumber)
group by customerNumber)
select orderNumber, customerNumber, customerName, orderamount, sum(amount) as payment_amount, (orderamount - sum(amount)) as pendingpayment
from payments 
inner join compiledorder using (customerNumber)
inner join customers using (customerNumber)
group by customerNumber
having pendingpayment > 0;


# Top selling products

SELECT p.productName, pl.productLine, SUM(od.quantityOrdered) AS totalQuantity
FROM orderdetails od
INNER JOIN products p ON od.productCode = p.productCode
INNER JOIN productlines pl ON p.productLine = pl.productLine
GROUP BY p.productCode
ORDER BY totalQuantity DESC
LIMIT 10;
