------------------------------------선생님
(실습 GROUP_AD2-1); 사람들 : 2중 decode, case
DECODE (인자 (조건X);


SELECT DECODE(GROUPING(job) || GROUPING(deptno) , '11', '총',
                                                  '00', job,
                                                  '01', job) job,
       DECODE(GROUPING(job) || GROUPING(deptno) , '11','계',
                                                  '00', deptno,
                                                  '01','소계')deptno,
        SUM(sal + NVL(comm,0)) sal
        
FROM emp
GROUP BY ROLLUP (job, deptno);


----------------------------
복습;
MERGE : SELECT 하고 나서 데이터가 조회되면 UPDATE
        SELECT 하고 나서 데이터가 조회되지 않으면 INSERT
        
SELECT + UPDATE / SELECT + INSERT ==> MERGE;

REPORT GROUP FUNCTION
1. ROLLUP
    -GROUP BY ROLLUP (컬럼1, 컬럼2)
    -ROLLUP 절에 기술한 컬럼을 오른쪽에서 하나씩 제거한 컬럼으로 SUBGROUP
    -GROUP BY 컬럼1, 컬럼2
     UNION
     GROUP BY 컬럼1
     UNION
     GROUP BY
2. CUBE
3. GROUPING SETS;

GROUP_AD3

SELECT deptno, job, SUM(sal + NVL(comm,0)) sal
FROM emp
GROUP BY ROLLUP (deptno, job);

--선생님이 다른 방식으로도 풀어보라고 함 :
SELECT a.deptno, a.job, a.c
FROM
(SELECT deptno, job , SUM(sal + NVL(comm, 0)) c
 FROM emp 
 GROUP BY ROLLUP (deptno, job)) a, dept b
WHERE a.deptno = b.deptno(+);      
--->테이블끼리 조인했을 때 조인에 실패하더라도 결과물이 나오게 하는 조인-> outer 조인


GROUP_AD4

SELECT dname, job , SUM(sal + NVL(comm, 0)) sal
FROM emp JOIN dept ON (emp.deptno = dept.deptno)
GROUP BY ROLLUP (dname, job)
ORDER BY dname, job DESC;      


GROUP_AD5
--1 CASE 문
SELECT  CASE 
            WHEN(GROUPING (dname) = 1) AND (GROUPING (job) = 1)
            THEN '총합'
            ELSE dname
        END dname,
       job, 
       SUM(sal + NVL(comm, 0)) sal
FROM emp JOIN dept ON (emp.deptno = dept.deptno)
GROUP BY ROLLUP (dname, job)
ORDER BY dname, job DESC;

--1 CASE 문 소계도 넣어보기.

SELECT  CASE 
            WHEN(GROUPING (dname) = 1) AND (GROUPING (job) = 1)
            THEN '총합'
            ELSE dname
        END dname,
        CASE 
            WHEN(GROUPING (dname) = 0) AND (GROUPING (job) = 1)
            THEN '소계'
            WHEN(GROUPING (dname) = 1) AND (GROUPING (job) = 1)
            THEN '계'
            ELSE job
        END job,
       SUM(sal + NVL(comm, 0)) sal
FROM emp JOIN dept ON (emp.deptno = dept.deptno)
GROUP BY ROLLUP (dname, job)
ORDER BY dname, job DESC;

--2 DECODE 문

SELECT DECODE(GROUPING(dname) || GROUPING(job) , '11', '총합',
                                                  '00', dname,
                                                  '01', dname) dname,
       job, 
       SUM(sal + NVL(comm, 0)) sal
FROM emp JOIN dept ON (emp.deptno = dept.deptno)
GROUP BY ROLLUP (dname, job)
ORDER BY dname, job DESC;


--2 DECODE 문 소계도 넣어 보기

SELECT DECODE(GROUPING(dname) || GROUPING(job) , '11', '총합',
                                                  '00', dname,
                                                  '01', dname) dname,
       DECODE(GROUPING(dname) || GROUPING(job) , '11', '계',
                                                  '00', job,
                                                  '01', '소계') job, 
       SUM(sal + NVL(comm, 0)) sal
FROM emp JOIN dept ON (emp.deptno = dept.deptno)
GROUP BY ROLLUP (dname, job)
ORDER BY dname, job DESC;


REPORT GROUP FUNCTION
1. ROLLUP
2. CUB
3. GROUPING SETS

활용도:
3,1 >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>CUBE;


GROUPING SETS
순서와 관계없이 서브그룹을 사용자가 직접 선언
사용방법 : GROUP BY GROUPING SETS(co1, col2...)
GROUP BY GROUPING SETS(co1, col2)
==>
GROUP BY col1
UNION ALL
GROUP BY col2

GROUP BY GROUPING SETS((co1, col2), col3, col4)
==>
GROUP BY co1, col2
UNION ALL
GROUP BY col3
UNION ALL
GROUP BY col4


GROUP BY GROUPING SETS(co1, col2)
GROUP BY GROUPING SETS(co2, col1)
==> 순서가 바뀌어도 둘은 동일. GROUPING SETS의 경우 컬럼 기술 순서가 영향을 미치지 않는다.
    ROLLUP은 컬럼 기술 순서가 결과에 영향을 미친다.




SELECT job, deptno, SUM(sal) sal
FROM emp
GROUP BY GROUPING SETS(job, deptno);

GROUP BY GROUPING SETS(job, deptno)
==>
GROUP BY  job
UNION ALL
GROUP BY deptno;

--UNION ALL을 하는지 UNION을 하는지 어떻게 아나요?
SELECT job, SUM(sal) sal
FROM emp
GROUP BY GROUPING SETS(job, job);
--> 같은 걸로 해서 결과를 보세욤......다시 확인해봐야 할듯 이해 잘 못함


job, deptno 로 GROUP BY 한 결과와
mgr 로 GROUP BY 한 결과를 조회하는 SQL을 GROUPING SETS로 급여합 SUM(sal)작성;


SELECT job, deptno, mgr , SUM(sal) sal
FROM emp
GROUP BY GROUPING SETS((job, deptno),mgr );


CUBE
가능한 모든 조합으로 컬럼을 조합한 SUB GROUP 을 생성한다.
단 기술한 컬럼의 순서는 지킨다.

EX : GROUP BY CUBE (col1, col2);

(col1, col2) == > 
(null, col2) == GROUP BY col2
(null, null) == GROUP BY 전체
(col1, null) == GROUP BY col1
(col1, col2) == GROUP BY col1, col2;

만약 컬럼 3개를 CUBE 절에 기술한 경우, 나올 수 있는 가짓수는??
8가지

SELECT job, deptno, SUM(sal) sal
FROM emp
GROUP BY CUBE(job, deptno);



혼종-------------------------------------------


SELECT job, deptno, SUM(sal) sal
FROM emp
GROUP BY job , ROLLUP(deptno), CUBE(mgr);


GROUP BY job, deptno, mgr = GROUP BY job, deptno, mgr
GROUP BY job, deptno = GROUP BY job, deptno
GROUP BY job, null, mgr = GROUP BY job, mgr
GROUP BY job, null, null = GROUP BY job


서브쿼리 UPDATE
1. emp_test 테이블을 drop
2. emp 테이블을 이용해서 emp_test 테이블 생성(모든 행에 대해 ctas)
3. emp_test 테이블에 dname VARCHAR2(14)컬럼 추가
4. emp_test.dname 컬럼을 dept 테이블을 이용해서 부서명을 업데이트;

DROP TABLE emp_test;

CREATE TABLE emp_test AS
SELECT *
FROM emp;

ALTER TABLE emp_test ADD (dname VARCHAR2(14));

SELECT * 
FROM emp_test;

UPDATE emp_test SET dname = (SELECT dname
                             FROM dept
                             WHERE dept.deptno = emp_test.deptno);
SELECT * 
FROM emp_test;

COMMIT;

서브쿼리 실습 sub_a1;

DROP TABLE dept_test;

CREATE TABLE dept_test AS
SELECT *
FROM dept;

ALTER TABLE dept_test ADD (empcnt NUMBER);

SELECT *
FROM dept_test;

UPDATE dept_test SET empcnt = 0; --만약 이렇게 한다면?

SELECT deptno, COUNT(*) cmt
FROM emp
GROUP BY deptno;


--내답(틀렸음)--
UPDATE dept_test SET empcnt = (SELECT COUNT(dept.deptno)
                               FROM dept LEFT OUTER JOIN emp ON (dept.deptno = emp.deptno)
                               GROUP BY dept.deptno);


--선생님 풀이

UPDATE dept_test SET empcnt = NVL((SELECT COUNT(*) cnt
                                FROM emp
                                WHERE deptno = dept_test.deptno
                                GROUP BY deptno),0);
                                
SELECT *
FROM dept_test;  


실습sub_a2;

dept_test 테이블에 있는 부서 중에 직원이 속하지 않은 부서 정보를 삭제
*dept_test.empcnt 컬럼은 사용하지 않고
emp 테이블을 이용하여 삭제;

INSERT INTO dept_test VALUES (99,'it1','daejeon',0);
INSERT INTO dept_test VALUES (99,'it2','daejeon',0);
COMMIT;


SELECT *
FROM dept_test;

-->(내 풀이, 틀렸음) 직원이 속하지 않은 부서의 번호
SELECT d.deptno
FROM emp e RIGHT OUTER JOIN dept d ON (e.deptno = d.deptno) 
WHERE e.deptno IS NULL ;

DELETE dept_test
WHERE(SELECT d.deptno
        FROM emp e RIGHT OUTER JOIN dept d ON (e.deptno = d.deptno) 
        WHERE e.deptno IS NULL );
------------------------선생님 풀이
직원이 속하지 않은 부서 정보 조회?
직원 있다 없다?
10번 부서에 직원이 있다 없다?

SELECT COUNT(*)
FROM emp
WHERE deptno = 40;

SELECT *
FROM dept_test
WHERE 0 = (SELECT COUNT(*)
           FROM emp
           WHERE deptno = dept_test.deptno);


DELETE dept_test
WHERE 0 = (SELECT COUNT(*)
           FROM emp
           WHERE deptno = dept_test.deptno);
           
SELECT *
FROM dept_test;

-----------------------실습 sub_a3-------------

본인이 속한 부서의 평균 급여보다 급여자가 작은 직원의 급여 <<를 먼저 구할 것.

UPDATE emp_test a SET sal = sal + 200
WHERE sal > (SELECT AVG(sal)
             FROM emp_test b
             WHERE a.deptno = b.deptno);
             
SELECT *
FROM emp_test;             
ROLLBACK;

---------------------------------
WITH 절
하나의 쿼리에서 반복되는 SUBQUERY가 있을 때
해당 SUBQUERY를 별도로 선언하여 재사용
MAIN 쿼리가 실행될 대 WITH 선언한 쿼리 블럭이 메모리에 임시적으로 저장
==>MAIN 쿼리가 종료되면 메모리 해제

SUBQUERY 작성시에는 해당 SUBQUERY의 결과를 조회하기 위해서 I/O 반복적으로 일어나지만
WTIH절을 통해 선언하면 한번만 SUBQUERY가 실행되고 그 결과를 메모리에 저장해 놓고 재 사용 한다.
단, 하나의 쿼리에서 동일한 SUBQUERY가 반복적으로 나오는 것은 잘못 작성한 SQL일 확률이 높다.

WITH 쿼리블록이름 AS (
    서브쿼리
)

SELECT *
FROM 쿼리블록이름;

직원의 부서별 급여 평균을 조회하는 쿼리블록을 WITH절을 통해 선언;

WITH sal_avg_dept AS (
    SELECT deptno, ROUND(AVG(sal),2) sal
    FROM emp
    GROUP BY deptno
),
    dept_empcnt AS (
    SELECT deptno, COUNT(*) empcnt
    FROM emp
    GROUP BY deptno )

SELECT *
FROM sal_avg_dept a, dept_empcnt b
WHERE a.deptno = b.deptno; 


inline view 와 with절의 차이점:
후자는 한번 올려 놓으면 데이터를 한번만 ㅣㅇㄺ는다.
전자는 같은 쿼리라도 두 번 읽어야 한다.


WITH 절을 이용한 테스트 테이블 작성;
WITH temp AS (
    SELECT sysdate - 1 FROM dual UNION ALL
    SELECT sysdate - 2 FROM dual UNION ALL
    SELECT sysdate - 3 FROM dual)
SELECT *
FROM temp;


--> 이걸 인라인 뷰로 만들시

SELECT *
FROM (SELECT sysdate - 1 FROM dual UNION ALL
     SELECT sysdate - 2 FROM dual UNION ALL
        SELECT sysdate - 3 FROM dual);
로 해야 하는데 그럼 너무 길고 귀찮아짐... 그래서 WITH 절을 쓴다.


달력만들기;
CONNECT BY LEVEL <[=] 정수
해당 테이블의 행을 정수만큼 복제하고, 복제된 행을 구별하기 위해서 LEVEL을 부여
LEVEL은 1부터 시작;

SELECT dummy, LEVEL
FROM dual
CONNECT BY LEVEL <= 10;

SELECT dept.*, LEVEL
FROM dept
CONNECT BY LEVEL <= 5;

일반적으로는 dual 테이블에다 합니다.;

2020년 2월의 달력을 생성
:dt = 202002, 202003
1. 
달력
일 월 화 수 목 금 토

SELECT TO_DATE('202002','YYYYMM') + (LEVEL -1) "날짜",
     TO_CHAR ((TO_DATE('202002','YYYYMM') + (LEVEL -1)),'D') "요일",
     DECODE (TO_CHAR ((TO_DATE('202002','YYYYMM') + (LEVEL -1)),'D'),
             1, TO_DATE('202002','YYYYMM') +  (LEVEL -1)) s,
     DECODE (TO_CHAR ((TO_DATE('202002','YYYYMM') + (LEVEL -1)),'D'),
             2, TO_DATE('202002','YYYYMM') +  (LEVEL -1)) m,
     DECODE (TO_CHAR ((TO_DATE('202002','YYYYMM') + (LEVEL -1)),'D'),
             3, TO_DATE('202002','YYYYMM') +  (LEVEL -1)) t,
     DECODE (TO_CHAR ((TO_DATE('202002','YYYYMM') + (LEVEL -1)),'D'),
             4, TO_DATE('202002','YYYYMM') +  (LEVEL -1)) s,
     DECODE (TO_CHAR ((TO_DATE('202002','YYYYMM') + (LEVEL -1)),'D'),
             5, TO_DATE('202002','YYYYMM') +  (LEVEL -1)) t2,
     DECODE (TO_CHAR ((TO_DATE('202002','YYYYMM') + (LEVEL -1)),'D'),
             6, TO_DATE('202002','YYYYMM') +  (LEVEL -1)) f,
     DECODE (TO_CHAR ((TO_DATE('202002','YYYYMM') + (LEVEL -1)),'D'),
             7, TO_DATE('202002','YYYYMM') +  (LEVEL -1)) s2        
FROM dual
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE('202002','YYYYMM')),'DD');

-->월의 마지막 날짜만 불러오는 쿼리
SELECT TO_CHAR(LAST_DAY(TO_DATE('202002','YYYYMM')),'DD')
FROM dual;


