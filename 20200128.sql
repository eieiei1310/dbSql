SELECT *
FROM emp
WHERE job = 'SALESMAN' 
OR hiredate > TO_DATE('1981/06/01','YYYY/MM/DD');

--emp 테이블에서 10번 부서(deptno) 혹은 30번 부서에 속하는 사람 중 
--급여(sal)가 1500이 넘는 사람들만 조회하고 이름으로 내림차순 정렬되도록 쿼리를 작성하세요. 
SELECT *
FROM emp
WHERE deptno IN(10,30) 
AND sal > 1500
ORDER BY ename DESC;

--tool에서 제공해주는 행의 번호를 컬럼으로 가질 수 있을까?
--ROWNUM : 행번호를 나타내는 컬럼
SELECT ROWNUM, empno, ename
FROM emp;

SELECT ROWNUM rn, empno, ename
FROM emp;
--일반적으로 as를 준다. rownum은 시스템네임이라서.

--ROWNUM을 WHERE 절에서도 사용 가능
--동작하는거 : = (1은 되고, 2는 안됨)
--동작하는거 : ROWNUM = 1, ROWNUM <= 2  --> ROWNUM =1, ROWNUM <= N
--동작하지 않는 것 : ROWNUM -2, ROWNUM > = 2 --> ROWENUM -N (N은 1이 아닌 정수), ROWNUM >- N (N은 1이 아닌 정수)
--ROWNUM 은 이미 읽은 데이터에다가 순서를 부여
--유의점1.  읽지 않은 상태의 값들(ROWNUM이 부여되지 않은 행)은 조회할 수가 없다. 
--사용용도: 페이징 처리
-- 테이블에 있는 모든 행을 조회하는 것이 아니라 우리가 원하는 페이지에 해당하는 행 데이터만 조회를 한다. 
--NAVER 게시글 페이지가 1, 2, 3, 4...로 나뉘어져 있는 것처럼

--페이징 처리시 고려사항 : 1페이지당 건수, 정렬 기준
--EMP 테이블 총 row 건수 : 14
--페이징당 5건의 데이터를 조회
-- 1page : 1~5
-- 2page : 6~10
-- 3page : 11~15
--유의점2. ORDER BY 절은 SELECT 절 이후에 실행이 된다. 

SELECT ROWNUM rn, empno, ename
FROM emp --일반적으로는 데이터를 입력한 순서대로 나온다...
ORDER BY ename; --> 순서가 뒤죽박죽이 됨. orderby는 select 이후에 실행되기 때문

--정렬된 결과에 rownum을 부여하기 위해서는 in line view를 사용한다.
--요점정리 : 1. 정렬 2. ROWNUM 부여

--SELECT절에 *을 기술할 경우 다른 EXPRESSION 을 표기하기 위해서
--테이블명.* 테이블명칭.* 로 표현해야한다.
SELECT ROWNUM, emp.*
FROM emp;

SELECT ROWNUM, e.*
FROM emp e;
--별칭을 줄 경우 별칭으로 넣어줄 수 있다. 

SELECT ROWNUM,a.*
FROM 
    (SELECT empno, ename
    FROM emp
    ORDER BY ename) a; --괄호 : 테이블, 이렇게 임의로 설정한 테이블은 이름이 뭘까?(인라인 테이블)
    --이름을 붙여줄 수 있다. 

SELECT *
    FROM (SELECT ROWNUM rn,a.*
        FROM 
            (SELECT empno, ename
            FROM emp
            ORDER BY ename) a )
WHERE rn = 2;
--한번 더 감싸주면 rn을 마치 컬럼인 것처럼 사용할 수 있다.

--페이징 처리시 고려사항: 1페이지당 건수, 정렬 기준
-- 1page : 1~5
-- 2page : 6~10
-- 3page : 11~15

--연습해보자!
--ROWNUM --> rn
--page size : 5, 정렬기준은 ename
-- 1page : 1~5
-- 2page : 6~10
-- 3page : 11~15
-- n page :rn (page-1)*pageSize + 1 ~ page * pageSize
SELECT *
    FROM (SELECT ROWNUM rn,a.*
        FROM 
            (SELECT empno, ename
            FROM emp
            ORDER BY ename) a )
WHERE rn BETWEEN (:page - 1) * :pageSize  AND :page * :pageSize;

--실습 row_1
SELECT *
FROM (SELECT ROWNUM rn, a.*
    FROM
        (SELECT empno, ename
        FROM emp)a )
WHERE rn BETWEEN 1 AND 10;

--연습1

SELECT * 
FROM 
    (SELECT ROWNUM rn, a.*
    FROM
        (SELECT empno, ename
        FROM emp)a)
WHERE rn BETWEEN 1 AND 10;

--row_2 문제
SELECT *
FROM
    (SELECT ROWNUM rn, empno, ename
    FROM EMP)a
WHERE rn BETWEEN 11 AND 20;

--row_ 3 문제
SELECT *
FROM 
    (SELECT ROWNUM rn,a.* 
    FROM
        (SELECT empno, ename
        FROM emp
        ORDER BY ename)a)
WHERE rn BETWEEN 11 AND 14;

--row_ 1 재연습
SELECT *
FROM
    (SELECT ROWNUM rn,empno, ename
    FROM emp)
WHERE rn BETWEEN 1 AND 10;

--row 2 재연습
SELECT *
FROM 
    (SELECT ROWNUM rn,empno, ename
    FROM EMP)
WHERE rn BETWEEN 11 AND 14;

--row 3 재연습
SELECT *
FROM
    (SELECT ROWNUM rn, a.*
    FROM
        (SELECT empno, ename
        FROM emp
        ORDER BY ename)a)
WHERE rn BETWEEN 11 AND 14;

--함수 시작!
--single row, multi row

--trim :앞과 뒤에 화이트 스페이스가 있으면 빈 공간을 빼고 문자열만 돌려놓는다.
--중간에 있는 공백문자는 제거하지 못함.

--replace : 교체 -> 원하는 글자를 변형시킬 수 있음.
--함수들 굳이 외우려고 하지 않아도 됨

--DUAL 테이블 : 데이터와 함수를 테스트 해볼 목적으로 사용

SELECT LENGTH('TEST')
FROM dual;

--문자열 대소문자 : lower, upper, initcap
SELECT LOWER('Hello, World'), UPPER('Hello, World'), INITCAP('Hello, World')
FROM dual;
--lower->전부 소문자, upper ->전부대문자, inicap -> 첫번째만 대문자
--활용도는 쩜 떨어짐

SELECT LOWER('Hello, World'), UPPER('Hello, World'), INITCAP('Hello, World')
FROM emp;
--> 그냥 emp 테이블로 하면 emp 테이블의 껀수만큼 바뀌어서 나온다.

SELECT LOWER(ename), UPPER(ename), INITCAP(ename)
FROM emp;
--> 그냥 emp 테이블의 컬럼에 적용시켜도 된다. 


--함수는 where 절에서도 사용이 가능하다.
--사원 이름이 smith인 사람만 조회를 하세요

SELECT *
FROM emp
WHERE ename = 'SMITH';

SELECT *
FROM emp
WHERE ename = UPPER(:ename); -->바인딩변수로 치환하기
--> SMITH로 하면 되고 smith로 저장하면 안됨.

--SQL 작성시 아래 형태는 지양해야한다. 
SELECT *
FROM emp
WHERE LOWER(:ename) = :ename; 
--> LOWER라는 명령이 EMP테이블의 건수만큼 실행된다. 

--SQL 칠거지악-엔코아
--좌변을 가공하지 말라 (테이블쪽에 있는 컬럼을 가공하지 말아라.)
--좌변을 가공하면 속도문제가 존재, 

--
SELECT CONCAT('Hello','World') concat, --뒤에 concat은 왜넣는거지????? 아 이름이었네...
       SUBSTR('Hello, World', 1, 5) sub,--자바랑 다름..자바는 0부터 시작
       LENGTH('Hello, World') len,
       INSTR('Hello, World', 'o', 6)ins, -->해당되는 글자가 존재하는 위치를 리턴, ~부터 시작하게 함.
       LPAD('Hello, World', 15, '*') lp, --> 부족한 글자열을 ~로 채운다. LP-> 왼쪽에 채움
       RPAD('Hello, World', 15, '*') rp,
       REPLACE('Hello, World', 'H', 'T') rep, -->~문장에서 , ~단어를, ~로 바꿈
       TRIM('     Hello, World      ') trp,
       -->앞뒤공백이 제거된 채로 나옴
       --> 공백을 제거, 
       TRIM('d' FROM 'Hello, World') tr --> 공백이 아니라 특정 문자를 제거할수도 있다.
       
FROM dual;
--숫자 함수
--round :반올림(10.6을 소수점 첫번째 자리에서 반올림 > 11)
--trunc :절삭(버림)(10.6을 소수점 자리에서 절삭 --> 10)
--round, trunc 같은 경우 몇번째자리에서 반올림/절삭할것인지 정한다. -> 인자 2 개
--☆위에서 배운 문자함수들보다 훨 중요함
--mod : 나눗셈의 나머지(구하고 싶은 것이 몫이 아니라 나뉙 연산을 한 나머지 값)(13/5 -> 몫 2, 나머지 3)


--ROUND(대상 숫자, 최종 결과 자리)
SELECT ROUND(105.54, 1) AS a, --반올림 결과가 소수점 첫번째자리까지 나오게 함(두번째 자리에서 반올림)
       ROUND(105.55, 1) AS a,
       ROUND(105.55, 0) AS a, --반올림 결과가 정수부분만 나오게 한다.(첫번째 자리에서 반올림)
       ROUND(105.55, -1) AS a, --반올림 결과가 십의 자리까지 나오게 함(일의 자리에서 반올림)
       ROUND(105.55) AS a --인자가 1개일 때는 인자가 0인 것과 동일. 정수부분만 나오게 된다. 
FROM dual;
--> 1은 소수점 첫번째를 기준으로 함.

SELECT TRUNC(105.54, 1) AS a, --절삭의 결과가 소수점 첫번쨰 자리까지 나오도록->두번쨰 자리에서 절삭
       TRUNC(105.55, 1) AS a,--절삭이기 때문에 수가 바뀌어도 상관 X
       TRUNC(105.55, 0) AS a, --절삭의 결과가 정수부(일의 자리)까지 나오도록 > 소수점 첫번째 자리에서 절삭
       TRUNC(105.55, -1) AS a, --절삭의 결과가 10의자리까지 나오도록 --> 일의자리에서 절삭
       TRUNC(105.55) AS a -- 인자를 0으로 준 것과 동일
FROM dual;

--EMP 테이블에서 사원의 급여를 (sal)를 1000으로
--나누었을 때 몫을 구해보자

SELECT ename,sal, sal/1000, TRUNC(sal/1000,0),
       MOD(sal, 1000) --mod 의 결과는 divisdor 보다 항상 작다. 0 ~999까지로 정해져있음.       
FROM EMP;

DESC emp; 
--테이블의 구조를 알고 싶을 때 사용하는 명령어
--null이 들어가는지 아닌지 확인할 수 있음.

--년도 2자리/ 월 2자리/일자 2자리 가 나옴.
--이것은 tool 에 의존하는것. 설정을 바꾸면 조회 결과를 바꿀 수도 있다. 
--도구- 환경설정 - 데이터베이스 NLS 에서 RR/MM/DD를 YYYY/MM/DD로 바꿀 수 있다.
SELECT ename, hiredate
FROM emp;

--토드,오렌지 등 유료 툴은 다운되지 않음. 우리가 쓰는 건 공짜라서 다운될수도 있다.
--SYSDATE : 현재 오라클 서버의 시, 분 초가 포함된 날짜 정보를 리턴하는 특수함수
--함수명(인자1, 인자2) 함수명만 가지고도 실행을 한다.
--date + 정수 = 일자 연산

SELECT SYSDATE
FROM dual;
--형식을 바꾸면 시분초도 보이게 할 수 있음. tool에서 고정되있어서 지금은 안나옴.
--2020/01/28 + 5
SELECT SYSDATE +5
FROM dual;
-- => 정수 1= 하루
-- => 1/24 = 1시간

--숫자 표기: 숫자
--문자 표기: ''
--날짜 표기: TO_DATE('문자열 날짜값','문자열 날짜값의 표기형식') ex) TO_DATE('2020-01-28','YYYY-MM-DD')


SELECT SYSDATE +5, SYSDATE + 1/24
FROM dual;