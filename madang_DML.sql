-- madang ������ ����

SELECT  phone
FROM Customer
WHERE name='�迬��'

SELECT publiser
FROM book

-- DISTINCT : �ߺ�����
SELECT DISTINCT publiser
FROM book

SELECT *
FROM book
WHERE price BETWEEN 10000 AND 20000

-- ���տ����� : IN / NOT IN
SELECT *
FROM Book
WHERE publiser IN ('�½�����', '���ѹ̵��')

SELECT *
FROM Book
WHERE publiser NOT IN ('�½�����', '���ѹ̵��')
 
 -- LIKE : ���ڿ� �� ����
 -- _ : Ư�� ��ġ ���� ��ġ����
SELECT bookname, publiser
FROM Book
WHERE bookname LIKE '�౸�� ����'

SELECT bookname, publiser
FROM Book
WHERE bookname LIKE '%�౸%'

SELECT *
FROM Book
WHERE bookname LIKE '_��%'

-- AND / OR
SELECT *
FROM Book
WHERE bookname LIKE '%�౸%' AND price >= 2000

SELECT *
FROM Book
WHERE publiser IN ('�½�����', '���ѹ̵��')

SELECT *
FROM Book
WHERE publiser = '�½�����' OR publiser = '���ѹ̵��'

-- ORDER BY : ���� ���߿� ����
SELECT *
FROM Book
ORDER BY bookname

SELECT *
FROM Book
ORDER BY price, bookname

-- �����Լ� : �ݵ�� ���ϰ����� ����Ǿ�� �ϱ� ������ SELECT���� ���
-- SUM, AVG, COUNT, MAX, MIN
-- AS ��Ī : ��Ī ����
SELECT SUM(saleprice) AS ���ֹ���
FROM Orders
WHERE custid=2

SELECT SUM(saleprice) AS Total,
        AVG(saleprice) AS Average,
        MIN(saleprice) AS Minimum,
        MAX(saleprice) AS Maximum
FROM Orders

SELECT COUNT(*)
FROM Orders

-- GROUP BY : �Ӽ����� Ʃ���� ����. ����! GROUP BY ������ ����� �Ӽ��� �����Լ��� SELECT���� ���ǰ���
-- HAVING : GROUP BY �� ������. �˻����ǿ� �����Լ��� ���;���
SELECT custid, COUNT(*) AS �ѵ�������, SUM(saleprice) AS ���ֹ���
FROM Orders
GROUP BY  custid

SELECT custid, COUNT(*) AS �ѵ�������
FROM Orders
WHERE saleprice >= 8000
GROUP BY custid
HAVING count(*) >= 2

-- ����
/*
1) INNER JOIN (��������)
=> �� ���̺��� ���������� �����ϴ� �÷��� �� �� ��ġ�Ǵ� ���� �����Ͽ� ����� �����ϴ� ���� ���
SELECT <�Ӽ���>
FROM ���̺� 1, ���̺� 2
WHERE <�������� > AND <�˻�����>

SELECT <�Ӽ���>
FROM ���̺� 1 INNER JOIN ���̺� 2 ON <��������>
WHERE <�˻�����>
*/
SELECT *
FROM Customer, Orders

-- 3 21. ���� ���� �ֹ��� ���� �����͸� ��� ���̽ÿ�
SELECT *
FROM Customer, Orders
WHERE Customer.custid = orders.custid

-- 3 22. ���� ���� �ֹ��� ���� �����͸� ����ȣ ������ �����Ͽ� ���̽ÿ�
SELECT *
FROM Customer, Orders
WHERE Customer.custid = orders.custid
ORDER BY customer.custid

-- 3 24. ������ �ֹ��� ��� ������ �� �Ǹž��� ���ϰ� , ������ �����Ͻÿ�
SELECT name, SUM(saleprice)
FROM Customer, Orders
WHERE customer.custid = orders.custid
GROUP BY customer.name
ORDER BY customer.name

-- 3 25. ���� �̸��� ���� �ֹ��� ������ �̸��� ���Ͻÿ�
SELECT customer.name, book.bookname
FROM Customer, Orders, Book
WHERE customer.custid = orders.custid
      AND orders.bookid = book.bookid

-- 3 26. ������ 20,000 ���� ������ �ֹ��� ���� �̸��� ������ �̸��� ���Ͻÿ�
SELECT customer.name, book.bookname
FROM Customer, Orders, Book
WHERE customer.custid = orders.custid
      AND orders.bookid = book.bookid
      AND book.price = 20000

/*
2) �ܺ�����
=> ��ȣ ���̺��� ��ġ�Ǵ� ������ ����Ǵ� �������ΰ� �޸� ��� �� ���̺� ���� �÷����� ������ 
�ش� �ο���� �� ����� ���Եǰ� �ϴ� �����̸� ��ȸ ��ȸ�ǿ��� (+) ��ȣ�� ����Ͽ� �����Ѵ�

SELECT <�Ӽ���>
FROM ���̺� 1 {LEFT |RIGHT |FULL [OUTER]} JOIN ���̺�2 ON <��������>
WHERE <�˻�����>

SELECT <�Ӽ���>
FROM ���̺� 1, ���̺� 2
WHERE <��������(����1=����2(+))> AND <�˻�����>
*/
-- 3 27. ������ �������� ���� ���� �����Ͽ� ���� �̸��� ���� �ֹ��� ������ ��
�Ű����� ���Ͻÿ�
SELECT Customer.name, saleprice
FROM Customer LEFT OUTER JOIN Orders 
    ON Customer.custid Orders.custid


-- �μ�����
-- EXISTS / NOT EXISTS: ������ ����μ����ǹ�
SELECT name, address
FROM Customer cs
WHERE EXISTS (SELECT * 
                FROM Orders od
                WHERE cs.custid = od.custid)

SELECT name, address
FROM Customer cs
WHERE NOT EXISTS (SELECT *
                    FROM Orders od
                    WHERE cs.custid = od.custid)


