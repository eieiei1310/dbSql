--WHERE2
--WHERE 절에 기술하는 조건에 순서는 조회 결과에 영향을 미치지 않는다.
--SQL은 집합의 개념을 갖고 있다. (절차 개념이 없다.)
--집합 : 키가 185 이상이고 몸무게가 70kg 이상인 사람들의 모임
--  --> 몸무게가 70kg 이상이고 키가 185cm 이상인 사람들의 모임
-- 집합의 특징: 집합에는 순서가 없다.
-- (1, 5, 10) --> (10, 5, 1) : 두 집합은 서로 동일하다
-- 테이블에는 순서가 보장되지 않음
--SEKECT 결과가 순서가 다르더라도 값이 동일하면 정답
--> 정렬기능 제공(ORDER BY)
--  잘생긴 사람의 모임 --> 집합x 

SELECT ename, hiredate
FROM EMP
WHERE hiredate >= TO_DATE('19820101','YYYYMMDD')
AND hiredate <= TO_DATE('19830101','YYYYMMDD');

--IN 연산자
-- 특정 집합에 포함되는지 여부를 확인
-- 부서번호가 10번 혹은 20번에 속하는 직원 조회하기

SELECT empno, ename, deptno
FROM emp
WHERE deptno >= 10
AND deptno <= 20; --만일 부서번호가 15번인 게 있다면?
--여태까지 배운 것으로는 정확한 답을 찾을 수 없다.
--그래서 필요한 게 IN!

SELECT empno, ename, deptno
FROM emp
WHERE deptno IN (10, 20);

--IN 연산자를 사용하지 않고 OR 연산자 사용

SELECT empno, ename, deptno
FROM emp
WHERE deptno = 10
OR deptno = 20;

-- emp 테이블에서 사원 이름이 SMITH, JONES인 직원만 조회(empno, ename, deptno)
SELECT empno, ename, deptno
FROM emp
WHERE ename IN ('SMITH', 'JONES');

SELECT empno, ename, deptno
FROM emp
WHERE ename = 'SMITH'
OR ename = 'JONES';


--전체 데이터를 조회하는 것과 같은 결과가 나온다. 
SELECT *
FROM users
WHERE userid = userid;

SELECT userid AS 아이디, usernm AS 이름
FROM users
WHERE userid = 'brown'
OR userid = 'cony'
OR userid = 'sally';
--where3
--users 테이블에서 userid가 brown, cony, sally인 데이터를 다음과 같이 조회하시오.

SELECT userid AS 아이디, usernm AS 이름, alias AS 별명
FROM users
WHERE userid IN ('brown', 'cony' , 'sally');

SELECT *
FROM users;

--문자열 매칭 연산자: LIKE, %
--위에서 연습한 조건은 문자열 일치에 대해서 다룸
--이름이 BR로 시작하는 사람만 조회
--이름에 R 문자열이 들어가는 사람만 조회

SELECT *
FROM emp;

--사원 이름이 S로 시작하는 사원을 조회해보자
--SMITH, SCOTT
--% => 어떤 문자열(한글자, 글자가 없을수도 있고, 여러 문자열이 올 수도 있다.)

SELECT *
FROM emp
WHERE ename LIKE 'S%';

--글자수를 제한한 매턴 매칭
-- 정확히 한문자
-- ex직원 이름이 s로 시작하고 이름의 전체 길이가 5글자 인 직원
--S____

SELECT *
FROM emp
WHERE ename LIKE 'S____';


--사원 이름에 S글자가 들어가는 사원 조회
-- ename LIKE '%S%';
SELECT *
FROM emp
WHERE ename LIKE '%S%';

--where 실습 4

SELECT mem_id, mem_name
FROM MEMBER
WHERE mem_name LIKE '신%';

--where 실습 5

SELECT mem_id, mem_name
FROM MEMBER
WHERE mem_name LIKE '%이%';

--NULL 비교 연산 (IS)
--COMM 칼럼의 값이 NULL인 데이터를 조회(WHERE COMM = NULL)
SELECT *
FROM EMP
WHERE comm = null;

SELECT *
FROM EMP
WHERE comm = '';
-->둘 다 안됨. null값을 조회할 때는 IS라고 하는 특수 연산자를 이용해야 함.

SELECT *
FROM EMP
WHERE comm IS null;

-- is null where 실습 6
--null값이 있는 것을 조회해보시오
SELECT *
FROM EMP
WHERE comm IS NULL;

--null값이 없는 것을 조회해보시오
SELECT *
FROM EMP
WHERE comm >= 0
OR comm <= 0;

--사원의 관리자가 7698, 7839 그리고 null이 아닌 직원만 조회

SELECT *
FROM EMP
WHERE mgr NOT IN (7698, 7839 ,NULL);

--NOT IN 연산자에는 NULL 값을 포함 시키면 안된다.
--> -->

SELECT *
FROM EMP
WHERE mgr NOT IN (7698, 7839)
AND mgr IS NOT NULL;

--  where 실습 7

SELECT *
FROM EMP
WHERE job = 'SALESMAN'
AND hiredate >= TO_DATE('19810601','YYYYMMDD');

--  where 실습 8

SELECT *
FROM EMP
WHERE hiredate >= TO_DATE('19810601','YYYYMMDD')
AND deptno <> 10;

-- where 실습 9

SELECT *
FROM EMP
WHERE hiredate >= TO_DATE('19810601','YYYYMMDD')
AND deptno NOT IN (10);

-- where 실습 10

SELECT *
FROM EMP
WHERE deptno IN (20, 30)
AND hiredate >= TO_DATE('19810601','YYYYMMDD');

-- where 실습 11

SELECT *
FROM EMP
WHERE job = 'SALESMAN'
OR hiredate >= TO_DATE('19810601','YYYYMMDD');

-- where 실습 12

SELECT *
FROM EMP
WHERE job = 'SALESMAN'
OR empno LIKE '78%';

-- where 실습 13

SELECT *
FROM EMP
WHERE job = 'SALESMAN'
OR empno >= 7800 AND empno < 7900;

--연산자 우선순위
-- *,/ 연산자가 +,-보다 우선순위가 높다.
-- 우선순위 변경 : ()
-- AND > OR 

--emp 테이블에서 사원 이름이 SMITH 이거나 사원 이름이 ALLEN 이면서 담당업무가 SALESMAN 인 사원 조회
        
SELECT *
FROM EMP
WHERE ename = 'SMITH' 
OR( ename = 'ALLEN' AND job = 'SALESMAN');

--사원 이름이 SMITH 이거나 ALLEN 이면서 
--담당업무가 SALSMAN인 직원을 조회

SELECT *
FROM EMP
WHERE (ename = 'SMITH' OR ename = 'ALLEN')
AND job = 'SALESMAN';

--WHERE 실습 14

SELECT *
FROM EMP
WHERE job = 'SALESMAN' 
OR empno LIKE '78%' AND hiredate > TO_DATE('1981/06/01','YYYY/MM/DD');

--정렬
--SELECT *
--FROM table
--ORDER BY (컬럼|별칭 [ASC | DESC], .....)

-- emp 테이블의 모든 사원을 ename 컬럼 값을 기준으로 오름차순 정렬한 결과를 조회하세요.

SELECT *
FROM EMP
ORDER BY ename ASC; --(ASC가 기본이므로 안써도 된다.)

-- emp 테이블의 모든 사원을 ename 컬럼 값을 기준으로 내림차순 정렬한 결과를 조회하세요.

SELECT *
FROM EMP --DESC : DESCRIBE (설명하다)
ORDER BY ename DESC; -- DESC : DESCENDING (내림차순)

--EMP 테이블에서 사원 정보를 ename 컬럼으로 내림차순, ename 값이 같을 경우 mgr 컬럼으로 오름차순 정리하기

SELECT *
FROM EMP 
ORDER BY ename DESC, mgr ; 


--정렬시 별칭을 사용

SELECT empno, ename nm , sal*12 year_sal
FROM EMP 
ORDER BY year_sal;

--정렬시 별칭을 사용(2)

--오더바이는 정렬일 뿐이지 컬럼의 갯수와는 상관x 
--순차적으로 순서를 매기자면 enpno - 1, nm 은 2, ye..는 3이다.
--sql column index : 1부터 시작함(자바랑 달라!)

SELECT empno, ename nm , sal*12 year_sal
FROM EMP 
ORDER BY 3; --year_sal 을 기준으로 정렬한다.

--orderby 실습1

SELECT *
FROM DEPT 
ORDER BY dname;

SELECT *
FROM DEPT 
ORDER BY loc DESC;

--orderby 실습2

SELECT *
FROM EMP
WHERE comm > 0 
ORDER BY comm DESC, empno ASC;

SELECT *
FROM EMP
WHERE comm NOT IN (0) --NOT IN 써보기
ORDER BY comm DESC, empno ASC;


--orderby 실습3

SELECT *
FROM EMP
WHERE mgr IS NOT NULL
ORDER BY job , empno DESC;


