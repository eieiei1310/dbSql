
대전시에 있는 5개의 햄버거지수
(kfc + 버거킹 + 맥도날드) /롯데리아;

SELECT sido, count(*)
FROM fastfood
WHERE sido LIKE '%대전%'
GROUP BY sido;

대전광역시	중구	7
대전광역시	동구	4
대전광역시	유성구	4
대전광역시	서구	17
대전광역시	대덕구	2

분자(KFC, 버거킹, 맥도날드);

SELECT sido, sigungu, COUNT(*)
FROM fastfood
WHERE sido = '대전광역시'
AND gb IN ('KFC', '버거킹', '맥도날드')
GROUP BY sido, sigungu;

대전광역시	중구	6
대전광역시	동구	8
대전광역시	서구	12
대전광역시	유성구	8
대전광역시	대덕구	7

대전시 시군구별 롯데리아;

SELECT sido, sigungu, COUNT(*)
FROM fastfood
WHERE sido = '대전광역시'
AND gb IN ('롯데리아')
GROUP BY sido, sigungu;

구한 인자를 계산하는법;

SELECT a.sido, a.sigungu, ROUND(a.c1/b.c2, 2)hambuger_score
FROM
(SELECT sido, sigungu, COUNT(*)c1
FROM fastfood
WHERE /*sido = '대전광역시'
AND */gb IN ('KFC', '버거킹', '맥도날드')
GROUP BY sido, sigungu)a ,

(SELECT sido, sigungu, COUNT(*) c2
FROM fastfood
WHERE/* sido = '대전광역시'
AND*/ gb IN ('롯데리아')
GROUP BY sido, sigungu)b
WHERE a.sido = b.sido
AND a.sigungu = b.sigungu
ORDER BY hambuger_score DESC;

--시도시군구의 명확한 조건을 주지 않았기 때문에 다른사람들과 값이 다를 수 있다.

fastfood 테이블을 한번만 읽는 방식으로 작성하기;

SELECT sido, sigungu, ROUND((kfc + bugerking + mac)/lot  ,2) burger_score
FROM 
(SELECT sido, sigungu, 
       NVL(SUM(DECODE(gb, 'KFC',1)),0) kfc, 
       NVL(SUM(DECODE(gb, '버거킹', 1)),0) bugerking,
       NVL(SUM(DECODE(gb, '맥도날드',1)),0) mac, 
       NVL(SUM(DECODE(gb, '롯데리아', 1)),1) lot
       
FROM fastfood
WHERE gb IN ('KFC','버거킹','맥도날드','롯데리아')
GROUP BY sido, sigungu)
ORDER BY burger_score DESC;

햄버거지수, 개인별 근로소득 금액 순위가 같은 시도별로 [조인]
지수, 개인별 근로소득 금액으로 정렬 수 ROWNUM 을 통해 순위를 부여
같은 순위의 행끼리 조인

햄버거지수 시도, 햄버거지수 시군구, 햄버거지수 세금, 시도, 세금 시군구, 개인별 근로소득액
서울특별시 중구 5.67         서울특별시 강남구 70
서울특별시 도봉구 2          서울특별시 서초구 69
경기도 구리시 5             서울특별시 용산구 57
서울특별시 강남구 4.57       경기도 과천시 54
서울특별시 서추구 4          서울특별시 종로구 47

SELECT *
FROM fastfood
WHERE sido = '경기도'
AND sigungu = '구리시';

SELECT sido, sigungu, ROUND(sal/people) pri_sal
FROM tax
ORDER BY pri_sal DESC;

------------------------------------------
SELECT ROWNUM a, a. *
FROM
(SELECT sido, sigungu, ROUND((kfc + bugerking + mac)/lot  ,2) burger_score
FROM 
(SELECT sido, sigungu, 
       NVL(SUM(DECODE(gb, 'KFC',1)),0) kfc, 
       NVL(SUM(DECODE(gb, '버거킹', 1)),0) bugerking,
       NVL(SUM(DECODE(gb, '맥도날드',1)),0) mac, 
       NVL(SUM(DECODE(gb, '롯데리아', 1)),1) lot
       
FROM fastfood
WHERE gb IN ('KFC','버거킹','맥도날드','롯데리아')
AND sido IN ('서울특별시', '경기도')
GROUP BY sido, sigungu)
ORDER BY burger_score DESC)a;


SELECT ROWNUM b , b.*
FROM
(SELECT sido, sigungu, ROUND(sal/people) pri_sal
FROM tax
WHERE sido IN ('서울특별시', '경기도')

ORDER BY pri_sal DESC)b;

--버거지수 ROWNUM 과 근로소득 ROWNUM을 조인하기
SELECT *
FROM  
    --버거지수 
    (SELECT ROWNUM anm, a. *
        FROM
        (SELECT sido, sigungu, ROUND((kfc + bugerking + mac)/lot  ,2) burger_score
        FROM 
        (SELECT sido, sigungu, 
               NVL(SUM(DECODE(gb, 'KFC',1)),0) kfc, 
               NVL(SUM(DECODE(gb, '버거킹', 1)),0) bugerking,
               NVL(SUM(DECODE(gb, '맥도날드',1)),0) mac, 
               NVL(SUM(DECODE(gb, '롯데리아', 1)),1) lot
               
        FROM fastfood
        WHERE gb IN ('KFC','버거킹','맥도날드','롯데리아')
        AND sido IN ('서울특별시', '경기도')
        GROUP BY sido, sigungu)
        ORDER BY burger_score DESC)a)a , 
        
    --근로소득 금액
        (SELECT ROWNUM bnm , b.*
            FROM
            (SELECT sido, sigungu, ROUND(sal/people) pri_sal
            FROM tax
            WHERE sido IN ('서울특별시', '경기도')
            
            ORDER BY pri_sal DESC)b)b
WHERE a.anm = b.bnm;
--> 이 쿼리를 작성할 때 필요한 것들
ROWNUM, ORDER BY, ROUND, GROUP BY, SUM, JOIN, DECODE, NVL, IN;

ROWNUM 사용시 주의
1. SELECT --> ORDER BY
    정렬된 결과에 ROWNUM 을 적용하기 위해서는 INLINE-VIEW 이용
2. 1번부터 순차적으로 조회가 되는 조건에 대해서만 WHERE 절에서 기술할 수 있다.
    ROWNUM = 1(O)
    ROWNUM = 2(X)
    ROWNUM < 10(O)
    ROWNUM > 10(X)
    


SELECT 절 끝--------------------------------------------------------------------------------------;

-->[]대괄호 란? 옵션. 나올수도 있고 나오지 않을 수도 있다.;
;
DESC emp;

ppt 291 실습;

empno 컬럼은 NOT NULL 제약 조건이 있다 - INSERT 시 반드시 값이 존재해야 정상적으로 입력된다.
empno 컬럼을 제외한 나머지 컬럼은 NULLABLE 이다. (NULL 값이 저장될 수 있다. )
INSERT INTO emp (empno, ename, job)
VALUES (9999, 'brown', NULL);

SELECT *
FROM emp;
--> 맨 마지막에 값이 하나 늘어나 있다. 

INSERT INTO emp (ename, job)
VALUES ('sally', 'SALESMAN');
--> empno 가 값이 없으면 넣을 수 없다. 

문자열 : '문자열' ==> "문자열" 
숫자 : 10
날짜 : TO_DATE('20200206','YYYYMMDD') ,SYSDATE;

emp 테이블의 hiredate 컬럼은 date 타입
emp 테이블의 8개의 컬럼에 값을 입력;

DESC emp;

INSERT INTO emp VALUES (9998, 'sally','SALESMAN',NULL, SYSDATE, 1000, NULL, 99 );
ROLLBACK;

여러건의 데이터를 한번에 INSERT 
INSERT INTO 테이블명 (컬럼명1, 컬럼명2.....)
SELECT ....
FROM ; --> SELECT 한 결과물을 바로 INSERT 한다.

INSERT INTO emp 
SELECT 9998, 'sally','SALESMAN',NULL, SYSDATE, 1000, NULL, 99 
FROM dual
    UNION ALL
SELECT 9999, 'brown','CLEAK',NULL,TO_DATE('20200205','YYYYMMDD'), 1100, NULL, 99 
FROM dual;


SELECT *
FROM emp;
-->insert 두번 할 걸 한번 함 -> 원 쿼리



UPDATE 쿼리
UPDATE 테이블명 컬럼명1 = 갱신할 컬럼 값1,컬럼명2 = 갱신할 컬럼 값2 ....
WHERE 행 제한 조건;

업데이트 쿼리 작성시 WHERE 절이 존재하지 않으면 해당 테이블의
모든 행을 대상으로 업데이트가 일어난다.
UPDATE, DELETE 절에 WHERE 절이 없으면 의도한 게 맞는지 다시 한번 확인한다.
WHERE 절이 있다고 하더라도 해당 조건으로 해당 테이블을 SELECT 하는 쿼리를 작성하여 실행하면
UPDATE 대상 행을 조회할 수 있으므로 확인하고 실행하는 것도 사고 발생 방지에 도움이 된다;

99번 부서번호를 갖는 부서 정보가 DEPT 테이블에 있는 상황
INSERT INTO dept VALUES (99, 'ddit', 'deajeon');
COMMIT;

SELECT *
FROM dept;

99번 부서번호를 갖는 부서의 dname 컬럼의 값을 '대덕IT', loc 컬럼의 값을 '영민빌딩' 으로 업데이트

UPDATE  테이블명 SET 컬럼명1 = 갱신할 컬럼 값1,컬럼명2 = 갱신할 컬럼 값2 ....
WHERE 행 제한 조건;

UPDATE dept SET dname = '대덕IT', loc = '영민빌딩'
WHERE deptno = 99;

SELECT *
FROM dept;
ROLLBACK;

실수로 WHERE 절을 기술하지 않았을 경우
UPDATE dept SET dname = '대덕IT', loc = '영민빌딩';
/*WHERE deptno = 99;*/ --> WHERE절로 제한하지 않았으므로 모든 행이 업데이트된다. 
ROLLBACK;

SELECT *
FROM dept;

여사님 시스템 번호를 잊어먹음 ==> 한달에 한번씩 모든 여사님을 대상으로
                                본인 주민번호 뒷자리로 비밀번호를 업데이트
시스템 사용자 : 여사님(12,000명), 영업점(550), 직원(1,300)
UPDATE 사용자 SET 비밀번호 = 주민번호뒷자리;
WHERE 사용자 구분 = '여사님'; -->이렇게 했어야 함. 
--> WHERE 절을 넣지 않을 경우 : WEHER 절로 제한하지 않았으므로 모든 행이 바뀜

10 --> SUBQUERY ;
SMITH, WARD가 속한 부서에 소속된 직원 정보;

SELECT *
FROM emp
WHERE deptno IN (20,30);

SELECT *
FROM emp
WHERE deptno IN (SELECT deptno
                 FROM emp
                 WHERE ename IN ('SMITH','WARD'));
                 
            
UPDATE 시에도 서브 쿼리 사용이 가능;
SELECT *
FROM emp;

INSERT INTO emp (empno, ename) VALUES (9999, 'brown');
9999번 사원 deptno, job 정보를 SMITH 사원이 속한 부서정보, 담당업무로 업데이트;

UPDATE emp SET deptno = (SELECT deptno FROM emp WHERE ename = 'SMITH'), 
                job = (SELECT job FROM emp WHERE ename = 'SMITH')
WHERE empno = 9999;
ROLLBACK;


DELETE SQL :  특정 행을 삭제
DELCTE [FROM] 테이블명
WHERE 행 제한 조건;


SELECT *
FROM dept;

99번 부서번호에 해당하는 부서 정보 삭제
DELETE dept
WHERE deptno = 99;
COMMIT;

SUBQUERY 를 통해서 특정 행을 제한하는 조건을 갖는 DELETE ;
매니저가 76978 사번인 직원을 삭제하는 쿼리를 작성;

DELETE emp
WHERE empno IN (7499, 7521, 7654, 7844, 7900);

위랑 아래랑 같은 뜻;

DELETE emp
WHERE empno IN (SELECT empno
                FROM emp
                WHERE mgr = 7698);
ROLLBACK;

SELECT *
FROM emp;