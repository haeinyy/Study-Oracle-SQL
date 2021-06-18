-- madang 데이터 조작

SELECT  phone
FROM Customer
WHERE name='김연아'

SELECT publiser
FROM book

-- DISTINCT : 중복제거
SELECT DISTINCT publiser
FROM book

SELECT *
FROM book
WHERE price BETWEEN 10000 AND 20000

-- 집합연산자 : IN / NOT IN
SELECT *
FROM Book
WHERE publiser IN ('굿스포츠', '대한미디어')

SELECT *
FROM Book
WHERE publiser NOT IN ('굿스포츠', '대한미디어')
 
 -- LIKE : 문자열 비교 조건
 -- _ : 특정 위치 문자 일치여부
SELECT bookname, publiser
FROM Book
WHERE bookname LIKE '축구의 역사'

SELECT bookname, publiser
FROM Book
WHERE bookname LIKE '%축구%'

SELECT *
FROM Book
WHERE bookname LIKE '_구%'

-- AND / OR
SELECT *
FROM Book
WHERE bookname LIKE '%축구%' AND price >= 2000

SELECT *
FROM Book
WHERE publiser IN ('굿스포츠', '대한미디어')

SELECT *
FROM Book
WHERE publiser = '굿스포츠' OR publiser = '대한미디어'

-- ORDER BY : 제일 나중에 읽음
SELECT *
FROM Book
ORDER BY bookname

SELECT *
FROM Book
ORDER BY price, bookname

-- 집계함수 : 반드시 단일값으로 변경되어야 하기 때문에 SELECT절에 사용
-- SUM, AVG, COUNT, MAX, MIN
-- AS 별칭 : 별칭 설정
SELECT SUM(saleprice) AS 총주문액
FROM Orders
WHERE custid=2

SELECT SUM(saleprice) AS Total,
        AVG(saleprice) AS Average,
        MIN(saleprice) AS Minimum,
        MAX(saleprice) AS Maximum
FROM Orders

SELECT COUNT(*)
FROM Orders

-- GROUP BY : 속성별로 튜플을 묶음. 주의! GROUP BY 절에서 사용한 속성과 집계함수만 SELECT절에 정의가능
-- HAVING : GROUP BY 의 조건절. 검색조건에 집계함수가 나와야함
SELECT custid, COUNT(*) AS 총도서수량, SUM(saleprice) AS 총주문액
FROM Orders
GROUP BY  custid

SELECT custid, COUNT(*) AS 총도서수량
FROM Orders
WHERE saleprice >= 8000
GROUP BY custid
HAVING count(*) >= 2

-- 조인
/*
1) INNER JOIN (내부조인)
=> 두 테이블에서 공통적으로 존재하는 컬럼의 값 이 일치되는 행을 연결하여 결과를 생성하는 조인 방법
SELECT <속성들>
FROM 테이블 1, 테이블 2
WHERE <조인조건 > AND <검색조건>

SELECT <속성들>
FROM 테이블 1 INNER JOIN 테이블 2 ON <조인조건>
WHERE <검색조건>
*/
SELECT *
FROM Customer, Orders

-- 3 21. 고객과 고객의 주문에 관한 데이터를 모두 보이시오
SELECT *
FROM Customer, Orders
WHERE Customer.custid = orders.custid

-- 3 22. 고객과 고객의 주문에 관한 데이터를 고객번호 순으로 정렬하여 보이시오
SELECT *
FROM Customer, Orders
WHERE Customer.custid = orders.custid
ORDER BY customer.custid

-- 3 24. 고객별로 주문한 모든 도서의 총 판매액을 구하고 , 고객별로 정렬하시오
SELECT name, SUM(saleprice)
FROM Customer, Orders
WHERE customer.custid = orders.custid
GROUP BY customer.name
ORDER BY customer.name

-- 3 25. 고객의 이름과 고객이 주문한 도서의 이름을 구하시오
SELECT customer.name, book.bookname
FROM Customer, Orders, Book
WHERE customer.custid = orders.custid
      AND orders.bookid = book.bookid

-- 3 26. 가격이 20,000 원인 도서를 주문한 고객의 이름과 도서의 이름을 구하시오
SELECT customer.name, book.bookname
FROM Customer, Orders, Book
WHERE customer.custid = orders.custid
      AND orders.bookid = book.bookid
      AND book.price = 20000

/*
2) 외부조인
=> 상호 테이블간에 일치되는 값으로 연결되는 내부조인과 달리 어느 한 테이블에 공통 컬럼값이 없더라도 
해당 로우들이 조 결과에 포함되게 하는 조인이며 조회 조회건에서 (+) 기호를 사용하여 조인한다

SELECT <속성들>
FROM 테이블 1 {LEFT |RIGHT |FULL [OUTER]} JOIN 테이블2 ON <조인조건>
WHERE <검색조건>

SELECT <속성들>
FROM 테이블 1, 테이블 2
WHERE <조인조건(조건1=조건2(+))> AND <검색조건>
*/
-- 3 27. 도서를 구매하지 않은 고객을 포함하여 고객의 이름과 고객이 주문한 도서의 판
매가격을 구하시오
SELECT Customer.name, saleprice
FROM Customer LEFT OUTER JOIN Orders 
    ON Customer.custid Orders.custid


-- 부속질의
-- EXISTS / NOT EXISTS: 무조건 상관부속질의문
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


