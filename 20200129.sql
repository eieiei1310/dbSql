SELECT TO_DATE('2019/12/31','YYYY/MM/DD') AS "LASTDAY", 
        TO_DATE('2019/12/31','YYYY/MM/DD') -5 AS "LASTDAY_BEFORE5",
        SYSDATE AS "NOW",
        SYSDATE -3 AS "NOW_BEFORE3" 
FROM dual;

SELECT TO_DATE('2019/12/31','YYYY/MM/DD')
FROM dual;

--DATE : TO_DATE 문자열->날짜(DATE)
--       TO_CHAR 날짜 -> 문자열(날짜 포맷 지정)
--> TO CHAR 을 사용하면 날짜 지정 포맷을 자기가 정할 수 있다. (환경설정 창 들어가지 않아도.)
--> JAVA에서는 날짜 포맷의 대소문자를 가린다(MM/mm-> 월, 분)
--> SQL에서는 월MM 분 MI 임.
--> 주간일자(1~7) : 일요일은 1, 월요일은 2....토요은 7
-->주차 IW : ISO 표준 - 해당 주의 목요일을 기준으로 주차를 선정함
--              2019/12/31 화요일 --> 2020/01/02(목요일) -- > 그렇기 때문에 1주차로 선정

SELECT TO_CHAR(SYSDATE, 'YYYY-MM/DD HH24:MI:SS') AS "TIME"-->12시간 포맷을 주기도 하고 24 포맷을 주기도 함
FROM dual;

SELECT TO_CHAR(SYSDATE, 'YYYY-MM/DD HH24:MI:SS') "ALL",
       TO_CHAR(SYSDATE,'D') "DAY",
       TO_CHAR(SYSDATE, 'IW') "WEEK",
       TO_CHAR(TO_DATE('2019/12/31','YYYY/MM/DD'),'IW' )"WEEK"
FROM dual;

--emp 테이블의 hiredate(입사일자)컬럼의 년월일 시:분:초

SELECT ename,hiredate,
       TO_CHAR(hiredate,'YYYY-MM-DD HH24:MI:SS') 특정날짜,
       TO_CHAR(hiredate + 1,'YYYY-MM-DD HH24:MI:SS') "특정날짜+1일",
       TO_CHAR(hiredate + 1/24,'YYYY-MM-DD HH24:MI:SS') "특정날짜+1시간",
       --hiredate에 30분을 더하여 TO_CHAR로 표현하기
       TO_CHAR(hiredate + (1/24)/2,'YYYY-MM-DD HH24:MI:SS')"특정날짜+30분"
       --선생님이 한다면 좀 더 직관적으로 표현할 수 있을것 같다고 함.
       TO_CHAR(hiredate + (1/24/60)*30,'YYYY-MM-DD HH24:MI:SS')"특정날짜+30분"
       -->60으로 나눈 뒤에 30을 곱해서 분이라는 게 좀 더 잘 보이게 만듦.
FROM EMP;

--> 시분초 정보가 00000으로 나옴.. 정보가 없다는 뜻


SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD') "DT_DASH",
       TO_CHAR(SYSDATE,'YYYY-MM-DD HH24-MI-SS') "DT_DASH_WHIT_TIME",
       TO_CHAR(SYSDATE,'DD-MM-YYYY') "DT_DD_MM_YYYY"
FROM dual;

-- 날짜 타입에서도 반올림을 할 수 있다. 

--날짜 조작 함수 첫번째 빼고 매우 잘 씀 

--MONTHS_BETWEEN(DATE, DATE)
--인자로 들어온 두 날짜 사이의 개월수를 리턴

SELECT ename, hiredate,
       MONTHS_BETWEEN(sysdate, hiredate) "SYSDATE에서 근속년수",
       MONTHS_BETWEEN(TO_DATE('2020-01-17','YYYY-MM-DD'),hiredate) "TO_DATE에서 근속연수",
       469/12
FROM emp
WHERE ename = 'SMITH';

--ADD MONTH(DATE, 정수-더하거나 뺄(가감할) 개월수)
SELECT ADD_MONTHS(SYSDATE, 5)
FROM dual;

--ADD MONTH(5개월 전이 궁금하면 빼면 됨)
SELECT ADD_MONTHS(SYSDATE, -5)
FROM dual;

-- NEXT_DAY(DARE, 주간일자), ex: NEXT_DAY(SYSDATE, 5) -->SYSDATE 이후 처음 등장하는 주간일자 5에 해당하는 일자
--                              SYSDATE 2020/01/29(수) 이후 처음으로 등장하는 5(목)요일 --> 2020/01/30(목)

SELECT NEXT_DAY(SYSDATE, 5)
FROM dual;

-- LAST_DAY(DATE) DATE가 속한 월의 마지막 일자를 리턴
SELECT LAST_DAY(SYSDATE) --SYSDATE : 2020/01/29 --> 2020/01/31을 리턴함
FROM dual;

--LAST_DAY를 통해 인자로 들어온 date가 속한 월의 마지막 일자를 구할 수 있는데
--date의 첫번째 일자는 어떻게 구할까?

SELECT SYSDATE,
       LAST_DAY(SYSDATE),
       TRUNC(SYSDATE,'MM'),
       TRUNC(TO_DATE('1994/07/06','YYYY/MM/DD'), 'MM'),
       
       ADD_MONTHS(TO_CHAR(LAST_DAY(SYSDATE)+1,'YYYY/MM/DD'),-1) nn,
       -->마지막 날짜에 1을 더하면 무조건 다음 달 1일
       -->ADD_MONTHS로 감싸서 1을 뺌
       
       TO_DATE('01','DD'),
       --ADD_MONTH(LAST_DAY(SYSDATE)+1,-1)
       TO_CHAR(SYSDATE, 'YYYY-MM'),
       TO_DATE(TO_CHAR(SYSDATE,'YYYY-MM') || '01','YYYY-MM-DD')
       
FROM dual;

--hiredate 값을 이용하여 해당 월의 첫번째 일자로 표현
SELECT ename, hiredate,
       ADD_MONTHS(TO_CHAR(LAST_DAY(hiredate)+1,'YYYY/MM/DD'),-1) nn,
       TO_DATE(TO_CHAR(hiredate,'YYYY-MM') || '01','YYYY-MM-DD')
       --두번째거 이해를 못했어....
       --아 이해했다! 01 더한다음에 TODATE로 날짜로 바꿔줌
       
FROM emp;


--지금까지 한 것은 명시적 형변환... 함수를 이용해서 바꾸었다.
--묵시적 형변환도 가능하긴 함.(자동)

-->empno는 NUMBER타입, 인자는 문자열
--타입이 맞지 않기 때문에 묵시적 형변환이 일어남.
--테이블 컬럼의 타입에 맞게 올바른 인자 값을 주는 게 중요하다.
SELECT *
FROM emp
WHERE empno = '7369';
-->7369 문자열로 검색해도 자동 치환되서 검색됨.
-->이렇게 하지 마! 정확히 타입을 명시하자

SELECT *
FROM emp
WHERE empno = 7369;
-->이렇게 바꾸자!


SELECT *
FROM emp
WHERE hiredate = '80/12/17';
-->지금은 작동 안되는 이유: YYYY로 바꿨기 때문.
--> 1980으로 바꾸면 작동 된다.

-->hiredate의 경우 DATE타입, 인자는 문자열로 주어졌기 때문에 묵시적 형변환이 발생,
--날짜 문자열 보다 날짜 타입으로 명시적으로 기술하는 것이 좋음. 

SELECT *
FROM emp
WHERE hiredate = TO_DATE('1980/12/17', 'YYYY/MM/DD');

-->형변환을 해주는 게 헷갈리지 않을 수 있다.

EXPLAIN PLAN FOR -->2단계, 어떤 것을 설명할지 지정하고
SELECT *
FROM emp
WHERE empno = '7369';
--   1 - filter("EMPNO"=7369) --> 필터를 보면 7369로 되어 있다 --> 자동적 형변환

SELECT *
FROM table(dbms_xplan.display);
-->실행계획을 본다. 
--> 위에서 아래로 본다. 
--> 들여쓰기가 되어있으면 : 바로 위에 것이 부모라는 뜻
--> 자식이 있으면 자식부터 읽는다.


EXPLAIN PLAN FOR 
SELECT *
FROM emp
WHERE TO_CHAR(empno) = '7369';
--   1 - filter(TO_CHAR("EMPNO")='7369') 로 바뀌어있다.


SELECT *
FROM table(dbms_xplan.display);

--숫자를 문자열로 변경하는 경우 : 포멧
--천단위 구분자
--1000 이라는 숫자를 
--한국: 1,000.50
--독일: 1.000,50 (소수점표시와 천단위 표시자를 서로 바꾸어 씀)



--EMP sal 컬럼(NUMBER 타입)을 포맷팅
-- 9 :숫자
-- 0 :강제 자리 맞춤(0으로 표기)
-- L :통화 단위

SELECT ename, sal, TO_CHAR(sal,'L09,999') AS a -->00은 강제로 0을 삽입, 999...는 자릿수 표시
FROM emp;

--사용 빈도가 그렇게 높진 않습니다. 


--NULL에 대한 연산의 결과는 항상 NULL
--emp 테이블의 sal 컬럼에는 null 데이터가 존재하지 않음.
--emp 테이블의 comm 컬럼에는 null 데이터가 존재 (14건의 데이터에 대해)
--sal + comm --> comm 인 null 행에 대해서는 결과 null로 나온다.

--요구사항이 comm이 null이면 sal 컬럼의 값만 조회
--요구사항이 충족 시키지 못한다 -> sw에서는 [결함]

--> NVL(타겟, 대체값)이라는 함수 사용
-- 타겟의 값이 NULL이면 대체값을 변환하고
-- 타겟의 값이 NULL이 아니면 타겟 값을 반환
--자바라면:
--\if( 타겟 == null ) 
--      return 대체값;
-- else
--      return 타겟;

SELECT ename, sal, comm, sal+comm
FROM emp;

SELECT ename, sal, comm, NVL(comm,0),sal+NVL(comm,0) -->nvl함수에 의해 null값이0으로 치환되었다.
FROM emp;

SELECT ename, sal, comm, NVL(comm,0),
    sal+comm,
    sal+NVL(comm,0),
    NVL(sal+comm,0) -->위와 아래는 서로 다른 것! 계산 제대로 안됨
FROM emp;


--NVL2 함수
--NVL2(expr1, expr2, expr3) --인자가 세 개가 들어감.
--if(expr1 ! = null)
--      return expr2; -->널이 아니면 2번째인자
--else
--      return expr3; -->널이면 3번째 인자



SELECT ename, sal, comm, NVL2(comm, 10000, 0)
FROM emp;

-->NULLIF(expr1, expr2)
-->if(expr1 == expr2)
--      return null;
--else
--      return expr1;

SELECT ename, sal, comm, NULLIF(sal, 1250) a-- sal 1250인 사원은 null을 리턴받고, 1250이 아닌 사람은 sal을 리턴받음
FROM emp;

--☆mvl은 꼭 외워야 함!! 많이 나옴. 

--가변인자, 메소드 인자 수가 정해져있지 않음. 
--COALESS 인자 중에 가장 처음으로 등장하는 null이 아닌
--인자를 반환한다. 

--COALESS(expr1, expr2....)
--if (expr !=  )
--  return expr1;
--else
--  return COALECE(expr2, expr3....);

--COALESCE(comm, sal) : comm이 null이 아니면 comm
--                      comm 이 null이면 sal(단, sal컬럼의 값이 NULL이 아닐 때.)
SELECT ename, sal, comm, COALESCE(comm, sal)
FROM emp;

--ppt 159번 풀어보기

SELECT empno, ename, mgr,
       NVL(mgr, 9999) mgr,
       NVL2(mgr, mgr, 9999) mgr,
       COALESCE(mgr,9999) mgr
FROM emp;

--pair programing 
--2인 1조로 컴퓨터를 하나씩만 쓰고 돌려가며 코딩하기...실력이 비슷한 사람끼리 모여야 좋음

SELECT userid, usernm, reg_dt,
       NVL(reg_dt, sysdate) AS n_reg_dt
FROM USERS
WHERE userid NOT IN ('brown');

--이제 진짜 좀 어려워질수도 있음!
--비전공자들은 각오를 해두자

--오라클의 CASE문은 ELSE IF에 가깝다.

-- CONDITION : 조건절
-- CASE : JAVA의 if - else if - else 

-- CASE 
--      WHEN 조건1 TEHN 리턴값1:
--      WHEN 조건2 THEN 리턴값2:
--      ELSE 기본값
-- END


--emp 테이블에서 job 컬럼의 값이 SALESMAN SAL * 1.05 리턴
--                            MANAGER 이면 SAL * 1.1 리턴
--                             PRESIDENT 이면 SAL * 1.2 리턴
--                              그밖의 사람들은 SAL을 리턴 해주기

SELECT ename, job, sal,
        CASE 
            WHEN job = 'SALEMAN' THEN sal * 1.05
            WHEN job = 'MANAGER' THEN sal * 1.1
            WHEN job = 'PRESIDENT' THEN sal * 1.2
            ELSE sal
        END AS "BONUS_SAL"            
        -->이만큼 기술한 게 컬럼 하나임!!!
FROM emp;


--DECODE 함수 : CASE 절과 유사함 
--(다른점 CASE 절 : WHEN 절에 조건비교가 자유롭다.
--      DECODE 함수 : 하나의 값에 대해서 = 비교만 허용
--DECODE 함수 : 가변인자(인자의 개수가 상황에 따라서 늘어날 수가 있음.)
--DECODE(collexpr, 첫번째 인자와 비교할 값1, 첫번째 인자와 두번째 인자가 같을 경우 반환 값, 
--                 첫번째 인자와 비교할 값2, 첫번째 인자와 네번째 인자가 같을 경우 반환 값.....
--                 option - else 최종적으로 반환할 기본값)

SELECT ename, job, sal,
       DECODE(job, 'SALESMAN', sal * 1.05,
                    'MANAGER', sal * 1.1,
                    'PRESIDENT', sal * 1.2, sal)AS "BONUS_SAL"
FROM emp;


--emp 테이블에서 job 컬럼의 값이 SALESMAN 이면서 sal이 1400보다 크면  SAL* 1.05 리턴
--                            SALESMAN 이면서 sal이 1400보다 작으면  SAL* 1.1 리턴
--                            MANAGER 이면 SAL* 1.1 리턴
--                             PRESIDENT 이면 SAL * 1.2 리턴
--                              그밖의 사람들은 SAL을 리턴 해주기

-- 1. CASE만 이용해서
-- 2. DECODE, CASE 혼용해서.

--CASE만 이용해 풀기

SELECT ename, job, sal,
        CASE 
            WHEN job = 'SALESMAN' AND sal >= 1400 THEN sal * 1.05
            WHEN job = 'SALESMAN' AND sal <= 1400 THEN sal * 1.1
            WHEN job = 'MANAGER' THEN sal * 1.1
            WHEN job = 'PRESIDENT' THEN sal * 1.2
            ELSE sal
        END AS "BONUS_SAL"            
FROM emp;

-- DECODE, CASE 혼용해서 풀기

SELECT ename, job, sal,
       DECODE(job, 'SALESMAN',  DECODE(job, 'SMITH', 'STOUTHHHH'),
                    'MANAGER', sal * 1.1,
                    'PRESIDENT', sal * 1.2, sal)AS "BONUS_SAL"
FROM emp; --다중 DECODE 성공함!!!


-------------------풀었다!!!!!!!!!!!!!!!!!!!----------------------

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




--해당 데이타 컬럼에 맞는 현을 써라...
--숫자함수는 사실 중요X
--NULL 처리 중요, NVL 하나정도는 익히기
--CONDTION은 오늘 배운거 중요!

