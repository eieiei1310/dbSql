:dt ==> 202002;

SELECT DECODE(d,1, iw+1,iw) i,
       MIN(DECODE(d, 1, dt )) sun,
       MIN(DECODE(d, 2, dt )) mon,
       MIN(DECODE(d, 3, dt )) tue,
       MIN(DECODE(d, 4, dt )) wed,
       MIN(DECODE(d, 5, dt )) tur,
       MIN(DECODE(d, 6, dt )) fri,
       MIN(DECODE(d, 7, dt )) sat
FROM 
    (SELECT TO_DATE(:dt,'yyyymm') + (LEVEL - 1) dt,
             TO_CHAR(TO_DATE(:dt,'yyyymm') + (LEVEL - 1),'D') d,
             TO_CHAR(TO_DATE(:dt,'yyyymm') + (LEVEL - 1),'iw') iw
    FROM dual
    CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:dt ,'yyyymm')),'DD'))
    GROUP BY DECODE(d,1, iw+1,iw) 
    ORDER BY DECODE(d,1, iw+1,iw);
--tmi 이클립스 alt + shift + A ->세로편집모드

--실습--달력에 이전 달의 자료도 나오게 하시오

1. 해당 월의 1일자가 속한 주의 일요일 구하기
2. 해당 월의 마지막 일자가 속한 주의 토요일 구하기
3. 2-1을 하여 총 일수 구하기


달력에서 전 달, 다음 달 날짜도 나오게 하려면????
20200401 --> 20200329(일요일)
20200430 --> 20200502(토요일) 

--------------내가 해본 거1(틀렸음)
SELECT TO_DATE('20200401','YYYYMMDD') -3
FROM dual;
SELECT LAST_DAY(TO_DATE('20200401','YYYYMMDD')) + 2
FROM dual;


----------내가 해본 거 2(틀렸음)

:dt ==> 202002;

SELECT DECODE(d,1, iw+1,iw) i,
       MIN(DECODE(d, 1, dt )) sun,
       MIN(DECODE(d, 2, dt )) mon,
       MIN(DECODE(d, 3, dt )) tue,
       MIN(DECODE(d, 4, dt )) wed,
       MIN(DECODE(d, 5, dt )) tur,
       MIN(DECODE(d, 6, dt )) fri,
       MIN(DECODE(d, 7, dt )) sat
FROM 
    (SELECT TO_DATE(:dt,'yyyymm') + (LEVEL - 1) dt,
             TO_CHAR(TO_DATE(:dt,'yyyymm') + (LEVEL - 1),'D') d,
             TO_CHAR(TO_DATE(:dt,'yyyymm') + (LEVEL - 1),'iw') iw,
             TO_DATE('20200401','YYYYMMDD')-3 first,
             LAST_DAY(TO_DATE('20200401','YYYYMMDD')) + 2 second
    FROM dual
    CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:dt ,'yyyymm')),'DD'))
    GROUP BY DECODE(d,1, iw+1,iw) 
    ORDER BY DECODE(d,1, iw+1,iw);
--tmi 이클립스 alt + shift + A ->세로편집모드

-----------------선생님답-----------------

원본쿼리 1일~말일자;
SELECT DECODE(d, 1, iw+1, iw) i,
       MIN(DECODE(d, 1, dt)) sun,
       MIN(DECODE(d, 2, dt)) mon,
       MIN(DECODE(d, 3, dt)) tue,
       MIN(DECODE(d, 4, dt)) wed,
       MIN(DECODE(d, 5, dt)) tur,
       MIN(DECODE(d, 6, dt)) fri,
       MIN(DECODE(d, 7, dt)) sat
FROM 
(SELECT TO_DATE(:dt, 'yyyymm') + (level-1) dt,
        TO_CHAR(TO_DATE(:dt, 'yyyymm')  + (LEVEL-1), 'D') d,
        TO_CHAR(TO_DATE(:dt, 'yyyymm')  + (LEVEL-1), 'iw') iw
 FROM dual
 CONNECT BY LEVEL <=  TO_CHAR(last_day(to_date(:dt,'yyyymm')), 'DD'))
 GROUP BY DECODE(d, 1, iw+1, iw)
 ORDER BY DECODE(d, 1, iw+1, iw);
 

1일자가 속한 주의 일요일구하기
마지막일자가 속한 주의 토요일구 하기
일수 구하기; 
SELECT 
        TO_DATE(:dt, 'yyyymm') - ( TO_CHAR(TO_DATE(:dt, 'yyyymm'), 'D') -1) st,
        LAST_DAY(TO_DATE(:dt, 'yyyymm')) + (7- TO_CHAR(LAST_DAY(TO_DATE(:dt, 'yyyymm')), 'D')) ed,
        LAST_DAY(TO_DATE(:dt, 'yyyymm')) + (7- TO_CHAR(LAST_DAY(TO_DATE(:dt, 'yyyymm')), 'D'))
                      - ( TO_DATE(:dt, 'yyyymm') - ( TO_CHAR(TO_DATE(:dt, 'yyyymm'), 'D'))) daycnt
FROM dual;      


1일자, 말일자가 속한 주차까지 표현한 달력
SELECT DECODE(d, 1, iw+1, iw) i,
       MIN(DECODE(d, 1, dt)) sun,
       MIN(DECODE(d, 2, dt)) mon,
       MIN(DECODE(d, 3, dt)) tue,
       MIN(DECODE(d, 4, dt)) wed,
       MIN(DECODE(d, 5, dt)) tur,
       MIN(DECODE(d, 6, dt)) fri,
       MIN(DECODE(d, 7, dt)) sat
FROM 
(SELECT TO_DATE(:dt, 'yyyymm') - ( TO_CHAR(TO_DATE(:dt, 'yyyymm'), 'D') -1) + (level-1) dt,
        TO_CHAR(TO_DATE(:dt, 'yyyymm') - ( TO_CHAR(TO_DATE(:dt, 'yyyymm'), 'D') -1)  + (LEVEL-1), 'D') d,
        TO_CHAR(TO_DATE(:dt, 'yyyymm') - ( TO_CHAR(TO_DATE(:dt, 'yyyymm'), 'D') -1)  + (LEVEL-1), 'iw') iw
 FROM dual
 CONNECT BY LEVEL <=  last_day(to_date(:dt,'yyyymm'))+(7-to_char(last_day(to_date(:dt,'yyyymm')),'D'))
                    -to_date(:dt,'yyyymm')-(to_char(to_date(:dt,'yyyymm'),'D')-1)  )
 GROUP BY DECODE(d, 1, iw+1, iw)
 ORDER BY DECODE(d, 1, iw+1, iw);

---------------------------------------------------

기존 : 시작일자 1일, 마지막날짜 : 해당월의 마지막 날짜 
SELECT TO_DATE('202002','YYYYMM') + (LEVEL-1)
FROM dual
CONNECT BY LEVEL <= 29;

변경 : 시작일자가 : 해당 월의 1일자가 속한 주의 일요일
       마지막날짜 : 해당 월의 마지막일자가 속한 주의 토요일
       
SELECT TO_DATE('20200126', 'YYYYMMDD') + (LEVEL-1)
FROM dual
CONNECT BY LEVEL <= 35;


-----------실습 CALENDAR1

---내답---
SELECT TO_CHAR(dt, 'MM') dt ,SUM(sales) salse
FROM sales 
GROUP BY TO_CHAR(dt, 'MM')
ORDER BY dt;


SELECT SUM(JAN) JAN, 
       SUM(FEB) FEB, 
       NVL(SUM(MAR),0) MAR, --> NVL이 밖으로 빠진 것이 더 합리적이다. 
       SUM(APR) APR, 
       SUM(MAY) MAY, 
       SUM(JUN) JUN
FROM
(SELECT 
       DECODE(TO_CHAR(dt, 'MM'),'01',SUM(sales)) JAN,
       DECODE(TO_CHAR(dt, 'MM'),'02',SUM(sales)) FEB,
       DECODE(TO_CHAR(dt, 'MM'),'03',SUM(sales)) MAR,
       DECODE(TO_CHAR(dt, 'MM'),'04',SUM(sales)) APR,
       DECODE(TO_CHAR(dt, 'MM'),'05',SUM(sales)) MAY,
       DECODE(TO_CHAR(dt, 'MM'),'06',SUM(sales)) JUN
       
FROM sales
GROUP BY TO_CHAR(dt, 'MM')
ORDER BY TO_CHAR(dt, 'MM'))


---------------계층쿼리
;

SELECT *
FROM dept_h;

오라클 계층형 쿼리 문법
SELECT ...
FROM ...
WHERE
START WITH 조건 : 어떤 행을 시작점으로 삼을지

CONNECT BY 행과 행을 연결하는 기준
        PRIOR : 이미 읽은 행
        "   " : 앞으로 읽을 행
        

하향식 : 상위에서 자식 노드로 연결(위 ==>아래);

XX회사(최상위 조직)에서 시작하여 하위 부서로 내려가는 계층 쿼리;

SELECT dept_h.*, level, lpad(' ', (LEVEL-1)*4, ' ') || deptnm
FROM dept_h 
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd; 

행과 행의 연결 조건(PRIOR XX회사 - 3가지 부(디자인부, 정보기획부, 정보시스템부));
PRIOR XX회사.deptno = 디자인부.p_deptcd
PRIOR 디자인부.deptcd = 디자인팀.p_deptcd
PRIOR 디자인팀.deptcd = .p_deptcd

PRIOR XX회사.deptno = 정보기획부.p_deptcd
PRIOR 정보기획부.deptcd = 기획팀.p_deptcd
PRIOR 기획팀.deptcd = 기획파트.p_deptcd
PRIOR 기획파트.deptcd = .p_deptcd

PRIOR XX회사.deptno = 정보시스템부.p_deptcd
PRIOR 정보시스템부.deptcd = 개발1팀.p_deptcd
PRIOR 정보시스템부.deptcd = 개발2팀.p_deptcd




----실습 h_2 ----과제-----------------
SELECT level, deptcd, lpad(' ', (LEVEL-1)*4, ' ') || deptnm deptno, p_deptcd
FROM dept_h 
START WITH deptcd = 'dept0_02'
CONNECT BY PRIOR deptcd = p_deptcd; 
