-- PROD 테이블의 모든 컬럼의 자료 조회

SELECT *
FROM PROD;

--PROD 테이블에서 PROD_ID, PROD_NAME 컬럼의 자료만 조회
SELECT prod_id, prod_name
FROM PROD;

--1prod 테이블에서 모든 데이터를 조회하는 쿼리를 작성하세요

SELECT *
FROM LPROD;

--buyer 테이블에서 모든 데이터를 조회하는 쿼리를 작성하세요

SELECT buyer_id, buyer_name
FROM BUYER;

--cart 테이블에서 모든 데이터를 조회하는 쿼리를 작성하세요

SELECT *
FROM CART;

--member 테이블에서 mem_id, mem_pass, mem_name 조회하는 쿼리를 작성하세요

SELECT mem_id, mem_pass, mem_name
FROM MEMBER;

--users 테이블 조회

SELECT *
FROM users;

--테이블에 어떤 칼럼이 있는지 확인하는 방법
1. SELECT * 해서 전부 조회해본다.
2. TOOL의 기능 (사용자 -TABLES )
3. DESC 테이블명 (DESC - DESCRIBE의 약자)
DESC users

--users 테이블에서 userid, usernm, reg_dt 칼럼만 조회하는 sql을 작성하세요.
-- 날짜 연산(reg_dt 컬럼은 date 정보를 담을 수 있는 타입)
-- SQL 날짜 칼럼 + (더하기 연산) : 
-- 수학적인 사칙연산이 아닌것들 (5 + 5)
-- String h = "hello";
-- String w = "world";
-- String hw = h+w; --자바에서는 두 문자열을 결합해라 라는 뜻
-- SQL 에서 정의된 날짜 연산 : 날짜 + 정수 = 날짜에서 정수를 일자로 취급하여 더한 날짜가 된다.
-- ex) (2019/01/28 + 5 = 2019/02/02)
--reg_dt : 등록일자 컬럼

--null : 값을 모르는 상태
--null에 대한 연산 결과는 항상 null 이다.


SELECT userid u_id, usernm, reg_dt,
       reg_dt + 5 AS reg_dt_atter_5day
FROM users;

--prod 테이블에서 prod_id, prod_name 두 칼럼을 조회하는 쿼리를 작성하시오. 
SELECT prod_id AS id, prod_name AS name
FROM PROD;


--lprod 테이블에서 lprod_gu, lprod_nm 두 칼럼을 조회하는 쿼리를 작성하시오. 
SELECT lprod_gu AS gu, lprod_nm AS nm
FROM LPROD;

--buyer 테이블에서 buyer_id, buyer_name 두 칼럼을 조회하는 쿼리를 작성하시오. 
SELECT buyer_id AS 바이어아이디, buyer_name AS 이름
FROM BUYER;


--문자열 결합
-- 자바 언어에서 문자열 결합 : ("Hello + "World")
-- SQL에서는 : ||  ('Hello' || 'world')
-- SQL에서는 : concat('Hello','world')

--userid, usernm 컬럼을 결합, 별칭은 id_name을 해보자. 

SELECT userid || usernm AS id_name,
CONCAT (userid, usernm) AS concat_id_name
FROM users;



--변수, 상수
--int a = 5; String msg = "Hello, World";
--System.out.println(msg); //상수를 이용한 출력
--System.out.println("Hello, World"); //변수를 이용한 출력

--SQL에서의 변수는 없음(컬럼이 비슷한 역할,pl/sql 변수 개념이 존재)
--SQL에서 문자열 상수는 싱글 쿼테이션으로 표현
-- "Hello, World" --> 'Hello, World'

-- 문자열 상수와 컬럼간의 결합
--user id: brown
--user id: cony

SELECT 'user id : ' || userid AS "use rid"
FROM USERS;

SELECT 'SELECT * FROM ' || table_name || ';' AS "QUREY"
FROM USER_TABLES;

-- || --> CONCAT

SELECT CONCAT(CONCAT('SELECT * FROM ' ,table_name ),';')AS "QUREY"
FROM USER_TABLES;

--users의 테이블의 모든 행에 대해서 조회
--users에는 5건의 데이터가 존재

SELECT *
FROM users;

--WHERE 절 : 테이블에 데이터를 조회할 때 조건에 맞는 행만 조회
--ex: userid 컬럼의 값이 brown인 행만 조회
--brown, 'brown' 구분 잘 하기!
--컬럼
SELECT *
FROM users
WHERE userid != 'brown';
DESC USERS;

--emp 테이블에 존재하는 컬럼을 확인 해보세요.
SELECT *
FROM EMP;

--emp 테이블에서 ename 컬럼 값이 JONES인 행만 조회 

SELECT *
FROM EMP
WHERE ename = 'JONES';

SELECT *
FROM emp;
DESC emp;

-- emp 테이블에서 deptno(부서번호) 가 30보다 크거나 같은 사원들만 조회

SELECT *
FROM emp
WHERE deptno >= 30;

--문자열 : '문자열'
--숫자열 : 50
--날짜 : ??? --> 함수와 문자열의 결합으로 표현함. 문자열만 이용해도 표현이 가능하지만 권장하지 않음
--(국가별로 날짜 표기 방법이 다름)
--한국: 년도 4자리-월2자리-일2자리
--미국:월2자리-일2자리-년4자리
--입사일자가 1980년 12월 17일 직원만 조회하기

SELECT *
FROM emp
WHERE hiredate = '80/12/17';

--TO_DATE : 문자열을 date 타입으로 변경하는 함수
--TO_DATE(날짜형식 문자열, 첫번째, 인자의 형식)
--'1980/02/03'

SELECT *
FROM emp
WHERE hiredate = TO_DATE('19801217','YYYYMMDD');
--WHERE hiredate = TO_DATE(1980/12/17, 'YYYY/MM/DD')로 표현해주어야 함. 


--sal 컬럼의 값이 1000에서 2000사이인 사람

SELECT *
FROM emp
WHERE sal >= 1000 
AND sal <= 2000;

--범위연산자를 부등호 대신에 BETWEEN AND 연산자로 대체
SELECT * 
FROM emp
WHERE sal BETWEEN 1000 AND 2000;

--WHERE절 문제 풀어보기

SELECT hiredate, ename
FROM emp
WHERE hiredate BETWEEN TO_DATE('19820101','YYYYMMDD') AND TO_DATE('19830101','YYYYMMDD');