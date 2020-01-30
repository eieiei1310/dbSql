
--DECODE 안에 CASE나 DECODE 구문이 중첩이 가능하다.

--선생님 풀이
SELECT ename, job, sal,
        DECODE(job, 'SALESMAN', CASE
                                    WHEN sal > 1400 THEN sal * 1.05
                                    WHEN sal < 1400 THEN sal * 1.1
                                    END,
                    'MANADER', sal * 1.1,
                    'PRESIDENT', sal * 1.2, sal) bonus_sal
FROM emp;

--내 풀이
SELECT ename, job, sal,
       DECODE(job, 'PRESIDENT', sal * 1.2, 
                   'MANAGER',sal * 1.1,
                        CASE 
                            WHEN job = 'SALESMAN' AND sal >= 1400 THEN sal * 1.05
                            WHEN job = 'SALESMAN' AND sal <= 1400 THEN sal * 1.1
                            ELSE sal
                        END 
                )AS "BONUS_SAL"
FROM emp; 

--칠거지악--> DECODE 또는 CASE 사용시에 3개 이상 중첩하지 마라.. 복잡해짐


--실습 cond1 //decode

SELECT empno, ename,
DECODE(deptno, 10, 'ACCOUNTING',
               20, 'RESEARCH',
               30, 'SALES',
               40, 'OPERARTION',
               'DDIT')dname
FROM emp;

--실습 cond1 //case

SELECT empno, ename,
    CASE
        WHEN deptno = 10 THEN 'ACCOUNTING'
        WHEN deptno = 20 THEN 'RESEARCH'
        WHEN deptno = 30 THEN 'SALES'
        WHEN deptno = 40 THEN 'OPERARTION'
        ELSE 'DDIT'
    END dname
FROM emp;

--hiredate가 짝수 : 건강검진 , 홀수: 건강검진 x

--내가 풀은 개 노가다 방법

SELECT empno, ename, hiredate,
    CASE 
        WHEN hiredate > TO_DATE('1980/01/01','YYYY/MM/DD') AND hiredate < TO_DATE('1980/12/31','YYYY/MM/DD') THEN '건강검진 대상자'
        WHEN hiredate > TO_DATE('1982/01/01','YYYY/MM/DD') AND hiredate < TO_DATE('1982/12/31','YYYY/MM/DD') THEN '건강검진 대상자'
        
        WHEN hiredate > TO_DATE('1981/01/01','YYYY/MM/DD') AND hiredate < TO_DATE('1981/12/31','YYYY/MM/DD') THEN '건강검진 비대상자'
        WHEN hiredate > TO_DATE('1983/01/01','YYYY/MM/DD') AND hiredate < TO_DATE('1983/12/31','YYYY/MM/DD') THEN '건강검진 비대상자'
        
    END AS "CONTACT_TO_DOCTOR"
FROM emp;

--선생님 풀이
--올해년도가 짝수일 때 건강검진 대상자
--      입사년도가 짝수일 때 검강검진 대상자
--      입사년도가 홀수일 때 검강검진 비대상자
--올해년도가 홀수이면
--      입사년도가 짝수일 때 검강검진 비대상자
--      입사년도가 홀수일 때 검강검진 대상자

--올해년도가 짝수인지 홀수인지 확인
--DATE타입 - > 문자열(여러가지 포맷, yyyy-mm-dd hh24:mi:ss)
--짝수 -> 2로 나눴을 때 나머지 0
--홀수 -> 2로 나눴을 때 나머지 1
-- % 2 <한사람 많은데... 오라클엔 없음 -> MOD 함수를 사용하자!

SELECT MOD(TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')),2)
FROM dual; --> 올해년도는 짝수이다.

---------------------------------------------------------------------아래부터 틀렸음--------
--CASE로 풀기
SELECT empno, ename, hiredate,
    CASE 
        WHEN MOD(TO_NUMBER(TO_CHAR(hiredate,'YYYY')),2) = 0 THEN '건강검진 대상자'
        WHEN MOD(TO_NUMBER(TO_CHAR(hiredate,'YYYY')),2) = 1 THEN '건강검진 비대상자'
    END AS "CONTACT_TO_DOCTOR"
FROM emp;


--DECODE로 풀기
SELECT empno, ename, hiredate,
DECODE(MOD(TO_NUMBER(TO_CHAR(hiredate,'YYYY')),2), 0, '건강검진 대상자',
                                                   1, '건강검진 비대상자'
            )AS "CONTACT_TO_DOCTOR"
FROM emp;

--DECODE로 풀기 - TO_NUMBER 지워보기-> 묵시적 형변환
SELECT empno, ename, hiredate
DECODE(MOD(TO_CHAR(hiredate,'YYYY'),2), 0, '건강검진 대상자',
                                        1, '건강검진 비대상자'
            )AS "CONTACT_TO_DOCTOR"
FROM emp;

--선생님 답--

--DECODE로 풀기 - TO_NUMBER 지워보기-> 묵시적 형변환
SELECT empno, ename, hiredate,
        MOD(TO_NUMBER(TO_CHAR(hiredate,'YYYY')), 2) hire,
        MOD(TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')), 2),
        CASE
            WHEN MOD(TO_NUMBER(TO_CHAR(hiredate,'YYYY')),2) = MOD(TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')),2)
                    THEN '건강검진 대상자'
                ELSE '건강검진 비대상자'
            END CONTACT_TO_DOCTOR,
            DECODE(MOD(TO_NUMBER(TO_CHAR(hiredate, 'YYYY')), 2),
                MOD(TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')),2),'건강검진 대상자', '건강검진 비대상자') con2
FROM emp;

--선생님 답을 내가 수정

--DECODE로 풀기 - TO_NUMBER 지워보기-> 묵시적 형변환
SELECT empno, ename, hiredate,
        CASE
            WHEN MOD(TO_NUMBER(TO_CHAR(hiredate,'YYYY')),2) = MOD(TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')),2)
                    THEN '건강검진 대상자'
                ELSE '건강검진 비대상자'
            END CONTACT_TO_DOCTOR
FROM emp;

---------------------------------------------------------------------위까지 틀렸음--------다시풀어볼것!!

SELECT *
FROM emp;

SELECT *
FROM dept;

--GROUP BY 행을 묶을 기준
--부서번호 같은 ROW 끼리 묶는 경우: GROUP BY deptno
--담당업무가 같은 ROW 끼리 묶는 경우: GROUP BY job
--MGR이 같고 담당업무가 같은 ROW끼리 묶는 경우: GROUP BY mgr, job

--그룹함수의 종류
--SUM :합계
--COUNT : 갯수 - NULL값이 아닌 ROW의 갯수
--MAX : 최대값
--MIN : 최소값
--AVE : 평균


--그룹함수의 특징
--해당 컬럼에 Null 값을 찾는 Row가 존재할 경우 해당 값을 무시하고 계산한다. (NULL 연산의 결과는 null)
--부서별 급여 합
SELECT deptno,SUM(sal) sum_sal, MAX(sal) max_sal, MIN(sal), ROUND(AVG(sal),2), COUNT(sal)
FROM emp
GROUP BY deptno;

--그룹함수 주의점
--GROUP BY 절에 나온 컬럼 이외의 다른 컬럼이 SELECT절에 표현되면 에러가 나온다. 중요!!

SELECT deptno,ename, SUM(sal) sum_sal, MAX(sal) max_sal, MIN(sal), ROUND(AVG(sal),2), COUNT(sal)
FROM emp
GROUP BY deptno;



--GROUP BY 절이 없는 상태에서 그룹함수를 사용한경우
--전체 행을 하나 행으로 묶는다. 
SELECT SUM(sal) sum_sal, MAX(sal) max_sal, MIN(sal), ROUND(AVG(sal),2), 
       COUNT(sal), --sal 컬럼의 값이 null 이 아닌 row의 갯수
       COUNT(comm), --comm 컬럼의 값이 null 이 아닌 row의 갯수
       COUNT(*) --몇건의 데이터가 있는지(count 만 특이하게 * 가 들어갈 수 있다. )
FROM emp;

--GROUP BY 기준이 empno 이면 결과수가 몇건?? --사번은 중복되는 것이 없으므로 모두 같게 나온다. 
SELECT SUM(sal) sum_sal, MAX(sal) max_sal, MIN(sal), ROUND(AVG(sal),2), 
       COUNT(sal) cn, --sal 컬럼의 값이 null 이 아닌 row의 갯수
       COUNT(comm) cn, --comm 컬럼의 값이 null 이 아닌 row의 갯수
       COUNT(*) cn--몇건의 데이터가 있는지(count 만 특이하게 * 가 들어갈 수 있다. )
FROM emp
GROUP BY empno;

--이렇게 바꿔 보면? 그룹바이절에 나오지 않는 절이 SELECT 절에 나오면 오류라고 했는데. 왜 오류가 아닐까?
--그룹화와 관련없는 임의의 문자열, 함수, 숫자 등은 SELECET 절에 나오는 것이 가능
SELECT 1, SYSDATE,'ACCOUNTNG', SUM(sal) sum_sal, MAX(sal) max_sal, MIN(sal), ROUND(AVG(sal),2), 
       COUNT(sal) cn, --sal 컬럼의 값이 null 이 아닌 row의 갯수
       COUNT(comm) cn, --comm 컬럼의 값이 null 이 아닌 row의 갯수
       COUNT(*) cn--몇건의 데이터가 있는지(count 만 특이하게 * 가 들어갈 수 있다. )
FROM emp
GROUP BY empno;


-- SINGLE ROW FUNCTION의 경우 WHERE 절에서 사용하는 것이 가능하나
-- MULTI ROW FUNCTION 의 경우 WHRER 절에서 사용하는 것이 불가능 하고
-- HAVING 절에서 조건을 기술한다.
-- 부서별 급여 합 조회

--deptno, 급여합, 단 급여합이 9000이상인 row 만 조회

SELECT deptno, SUM(sal) sum_sal
FROM emp
GROUP BY deptno
HAVING SUM(sal) > 9000;

------실습 grp1
SELECT MAX(sal)AS "MAX_SAL",
       MIN(sal)AS "MIN_SAL", 
       ROUND(AVG(sal),2)AS "AVG_SAL", 
       SUM(sal)AS "SUM_SAL", 
       COUNT(sal)AS "COUNT_SAL", 
       COUNT(mgr)AS "COUNT_MGR",
       COUNT(*)AS "COUNT_ALL"
FROM emp;


------실습 grp2

SELECT 
       deptno, --이걸 누락을 하면 어떤 정보인지 알기 힘드니까 일반적으로는 꼭 넣는다. 
       MAX(sal)AS "MAX_SAL",
       MIN(sal)AS "MIN_SAL", 
       ROUND(AVG(sal),2)AS "AVG_SAL", 
       SUM(sal)AS "SUM_SAL", 
       COUNT(sal)AS "COUNT_SAL", 
       COUNT(mgr)AS "COUNT_MGR",
       COUNT(*)AS "COUNT_ALL"
FROM emp
GROUP BY deptno;

------실습 grp3


SELECT 
       DECODE(deptno, 10, 'ACCOUNTING',
                      20, 'RESEARCH',
                      30, 'SALES'
                      )dname , --이걸 누락을 하면 어떤 정보인지 알기 힘드니까 일반적으로는 꼭 넣는다. 
       MAX(sal)AS "MAX_SAL",
       MIN(sal)AS "MIN_SAL", 
       ROUND(AVG(sal),2)AS "AVG_SAL", 
       SUM(sal)AS "SUM_SAL", 
       COUNT(sal)AS "COUNT_SAL", 
       COUNT(mgr)AS "COUNT_MGR",
       COUNT(*)AS "COUNT_ALL"
FROM emp
GROUP BY deptno --> 여기에 DECODE를 넣기도 함...
ORDER BY deptno; --< ORDER BY는 여기다 쓰면 되네!!!
------다른 방식으로 풀어보기
SELECT  --이걸 누락을 하면 어떤 정보인지 알기 힘드니까 일반적으로는 꼭 넣는다. 
       MAX(sal)AS "MAX_SAL",
       MIN(sal)AS "MIN_SAL", 
       ROUND(AVG(sal),2)AS "AVG_SAL", 
       SUM(sal)AS "SUM_SAL", 
       COUNT(sal)AS "COUNT_SAL", 
       COUNT(mgr)AS "COUNT_MGR",
       COUNT(*)AS "COUNT_ALL"
FROM emp
GROUP BY DECODE(deptno, 10, 'ACCOUNTING',20, 'RESEARCH',30, 'SALES');


-------------
---grp4 실습
--ORACLE 9i이전까지는 GROUP BY 절에 기술한 컬럼으로 정렬을 보장
--ORACLE 10i이전까지는 GROUP BY 절에 기술한 컬럼으로 정렬을 보장하지 않는다(GROUP BY 연산시 속도 UP)

SELECT TO_CHAR(hiredate,'YYYYMM')AS "HIRE_YYYY" ,
      COUNT(*) AS CNT
FROM emp
GROUP BY TO_CHAR(hiredate, 'YYYYMM')
ORDER BY TO_CHAR(hiredate, 'YYYYMM');

---grp5 실습

SELECT TO_CHAR(hiredate,'YYYY')AS "HIRE_YYYY" ,
      COUNT(*) AS CNT
FROM emp
GROUP BY TO_CHAR(hiredate, 'YYYY');

---grp6 실습

SELECT COUNT(*)
FROM dept;
-------????????


---grp7 실습
--선생님 답
SELECT COUNT(*)
FROM  
    (SELECT deptno
       FROM emp
       GROUP BY deptno);
  

--내가 풂

SELECT COUNT(COUNT(deptno)) CNT
FROM emp
GROUP BY deptno;

--C언어에서 포기 포인트: 배열, 포인터, 파일 입출력
--데이터베이스에서의 포인트: GROUP BY(오늘배운거), JOIN (내일배울거)
