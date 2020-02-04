CROSS JOIN 
dept 테이블과 emp 테이블을 조인을 하기 위해 FROM 절에 두개의 테이블을 기술
where 절에 두 테이블의 연결 조건을 누락;

SELECT *
FROM dept;
-->4건
SELECT *
FROM emp;
-->14건

SELECT dept.dname, emp.empno, emp.ename
FROM dept, emp;
--> 56건의 데이터가 나옴

SELECT dept.dname, emp.empno, emp.ename--, dept.deptno
FROM dept, emp
WHERE dept.deptno = 10;
--> 14건의 데이터가 나옴 (하지만 이렇게 하는 것보다 연결 조건을 명확히 명시하는 것이 낫다)


CROSS JOIN--> 카터션 프로덕트 (Cartesian product)
조인하는 두 테이블의 연결 조건이 누락되는 경우
가능한 모든 조합에 대해 연결(조인)이 시도,
dept(4건), emp(14)의 CROSS JOIN 의 결과는 4* 14 = 56건

dept 테이블과 emp 테이블을 조인을 하기 위해 FROM 절에 두개의 테이블을 기술;
-->데이터 자체를 쓰기보다는 응용, 데이터 복제 등을 위해 사용


 CROSS JOIN 실습1;

SELECT  *
FROM customer, product;

 SUBQUERY : 쿼리 안에 다른 쿼리가 들어가 있는 경우
    SUBQUERY가 사용된 위치에 따라 3가지로 분류
    - SELECT 절 : SCALA SUBQUERY --하나의 행, 하나의 컬럼만 리턴해야 에러가 발생하지 않음.
    - FROM 절 : INLINE - VIEW 
    - WHERE 절 : SUBQUERY 
SMITH가 속한 부서에 속하는 직원들의 정보를 조회
1. SMITH가 속하는 부서 번호를 구한다.
2. 1번에서 구한 부서 번호에 속하는 직원들의 정보를 조회한다.

1.;
SELECT deptno
FROM emp
WHERE ename = 'SMITH';

2. 1번에서 구한 부서번호를 이용하여 해당 부서에 속하는 직원 정보를 조회;
SELECT *
FROM emp
WHERE deptno = 20;
-->원하는 결과를 얻기 위해 두번의 쿼리를 작성하였다.

SUBQUERY를 이용하면 두개의 쿼리를 동시에 하나의 SQL로 실행이 가능하다;

SELECT *
FROM emp
WHERE deptno = (SELECT deptno
                FROM emp
                WHERE ename = 'SMITH');
                
                
SUBQUERY 실습 1;
1.평균 급여 구하기
2. 구한 평균 급여보다 높은 급여를 받는 사람;

SELECT COUNT(*)
FROM emp
WHERE sal > (SELECT AVG(sal)
             FROM emp);
-->WHERE 절에 서브쿼리로 급여 평균을 넣는다. 

SUBQUERY 실습 2;

SELECT empno,ename, job, mgr,hiredate, sal, comm, deptno
FROM emp
WHERE sal > (SELECT AVG(sal)
             FROM emp);
             
다중 행 연산자
IN : 서브쿼리의 여러 행 중 일치하는 값이 존재할 때
ANY (활용도는 다소 떨어짐) : 서브쿼리의 여러 행 중 한 행이라도 조건을 만족할 때
ALL (활용도는 다소 떨어짐) : 서브쿼리의 여러 행 중 모든 조건을 만족할 때

연습문제 - SMITH가 속하는 부서의 모든 직원을 조회
-->SMITH와 WARD 직원이 속하는 부서의 모든 직원을 조회

SELECT deptno
FROM emp
WHERE ename IN ('SMITH','WARD');

서브쿼리의 결과가 여러 행일 때는 = 연산자를 사용할 수 없다;

SELECT *
FROM emp
WHERE deptno IN (SELECT deptno
                 FROM emp
                 WHERE ename IN ('SMITH','WARD'));
                 
SMITH, WARD 사원의 급여보다 급여가 작은 직원을 조회
(SMITH, WARD의 급여 중 아무 것이나)
SMITH : 800
WARD : 1250
-->1250보다 작은 사원;
;
SELECT *
FROM emp
WHERE sal < ANY (800 , 1250);

SELECT sal
FROM emp
WHERE ename IN ('SMITH','WARD');

SELECT *
FROM emp
WHERE sal < ANY (SELECT sal
                 FROM emp
                 WHERE ename IN ('SMITH','WARD'));

SMITH, WARD 사원의 급여보다 급여가 높은 직원을 조회
(SMITH, WARD의 급여 2가지 모두에 대해 높을 때.);

SMITH : 800
WARD : 1250
-->1250보다 높은 사원;

SELECT *
FROM emp
WHERE sal > ALL (SELECT sal
                 FROM emp
                 WHERE ename IN ('SMITH','WARD'));

IN, NOT IN 의 NULL 과 관련된 유의 사항;


직원의 관리자 사번이 7566이거나(OR) null;
IN 연산자는 OR 연산자로 치환 가능하다.

SELECT *
FROM emp
WHERE mgr IN (7902, null); 

NULL 비교는 =연산자가 아니라 IS NULL 로 해야 하지만, IN연산자는 =로 계산한다;
--> NULL 데이터 누락
SELECT *
FROM emp
WHERE mgr = 7902
OR mgr = null;  

NOT IN (7902, NULL) ==> AND 로 해석
사원번호가 7902가 아니면서 (AND) NULL이 아닌 데이터;
SELECT *
FROM emp
WHERE empno NOT IN (7902, NULL);

SELECT *
FROM emp
WHERE empno !=7902
AND   empno != NULL; -->null에 대한 연산은 항상 null. 값이 안 나온다.

SELECT *
FROM emp
WHERE empno !=7902
AND   empno IS NOT NULL; --> IS로 바꾼다.

PAIRWISE(순서쌍)
순서쌍의 결과를 동시에 만족시킬 때 ;
(mgr, deptno);
(7698, 30), (7639, 10);

SELECT *
FROM emp
WHERE (mgr, deptno) IN 
                        (SELECT mgr, deptno
                        FROM emp
                        WHERE empno IN (7499,7782));

--non-pairwise는 순서쌍을 동시에 만족시키지 않는 형태로 작성
--mgr 값이 7698 이거나 7839 이면서
--deptno 가 10번이거나 30번이 직원.
MGR, DEPTNO
(7698,10), (7698, 30)
(7839,10), (7839, 30);

SELECT *
FROM emp
WHERE mgr IN (SELECT mgr
                FROM emp
                WHERE empno IN (7499,7782))
AND mgr IN (SELECT deptno
                FROM emp
                WHERE empno IN (7499,7782)); -->여기가 왜 이거지? 걍 다 이해 못한듯
                
                
스칼라 서브쿼리 : SELECT 절에 기술, 1개의 ROW, 1개의 COL을 조회하는 쿼리;
스칼라 서브쿼리는 MAIN 쿼리의 컬럼을 사용하는 게 가능하다. 


SELECT SYSDATE 
FROM dual;

SELECT (SELECT SYSDATE
        FROM dual), dept.*
FROM dept;

SELECT (SELECT SYSDATE FROM dual), dept.* --> 스칼라 서브쿼리에서는 그냥 한줄로 쓰기도 한다.
FROM dept;

SELECT empno, ename, deptno, 
       (SELECT dname 
        FROM dept 
        WHERE deptno = emp.deptno) dname--부서명
        --나중에 부담이 갈 수 있기 떄문에 그냥 조인을 하는 게 더 낫다.
FROM emp;

INLINE VIEW : FROM 절에 기술되는 서브쿼리;

MAIN 쿼리의 컬럼을 SUBQUERY 에서 사용 하는지 유무에 따른 분류
사용 할경우 : CORRELATEED SUBQUERY (상호 연관 쿼리), 서브쿼리만 단독으로 실행하는 것이 불가능하다.
            실행순서가 정해져있다(main - > sub)
사용하지 않을 경우 : non-correlated subquery(비 상호 연관 서브쿼리) , 서브쿼리만 단독으로 실행하는 것이 가능하다.
            실행순서가 정해져 있지 않다. (main -> sub, sub->main)
모든 직원의 급여 평균보다 급여가 높은 사람을 조회;

SELECT *
FROM emp
WHERE sal > ( SELECT AVG(sal)
              FROM emp );



직원이 속한 부서의 급여 평균보다 급여가 높은 사람을 조회;
부서의 급여 평균부터 구해보자
--내가 한거
SELECT *
FROM emp
WHERE sal > ( SELECT AVG(sal)
              FROM emp );
       
--부서의 급여 평균
SELECT AVG(sal)
FROM emp
GROUP BY deptno ; 난 왜 틀린거지????;
             
--직원이 속한 부서의 급여 평균보다 급여가 높은 사람을 조회
SELECT *
FROM emp m
WHERE sal > ( SELECT AVG(sal)
              FROM emp s
              WHERE s.deptno = m.deptno);
       

위의 문제를 조인을 이용해서 풀어보자
1. 조인 테이블 선정
   emp, 부서별 급여 평균(inline view)

SELECT emp.ename, sal, dept_sal.*
FROM emp, (SELECT deptno, ROUND(AVG(sal)) avg_sal
           FROM emp 
           GROUP BY deptno) dept_sal
WHERE emp.deptno = dept_sal.deptno
AND emp.sal > dept_sal.avg_sal;


--연습문제로 풀어보자

--실습 SUB4
데이터 추가;
INSERT INTO dept VALUES (99,'ddit','deajeon');
COMMIT;

--클라이언트의 개념 : 웹브라우저와 동일
INSERT 후
ROLLBACK; : 트랜잭션 취소
COMMIT; : 트랜잭션 확정

--실습 SUB4;

SELECT *
FROM dept;
SELECT *
FROM emp;


SELECT 
FROM NOT IN ;

SELECT emp.deptno, dname, loc
FROM emp JOIN dept ON(emp.deptno = dept.deptno);
--267을 join으로도 바꿀 수 있어야 한다.


