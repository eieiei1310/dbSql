SUB4:-------------------------------------------------------------------------------------------
dept 테이블에는 5건의 데이터가 존재
emp 테이블에는 14명의 직원이 있고, 직원은 하나의 부서에 속해 있다. (deptno)
부서 중 직원이 속해 있지 않은 부서 정보를 조회;

서브쿼리에서 데이터의 조건이 맞는지 확인자 역할을 하는 서브쿼리 작성; 

SELECT *
FROM dept 
WHERE deptno NOT IN (SELECT deptno
                     FROM emp);

SELECT DISTINCT deptno
FROM emp; --DISTINCT는 나열되있는 컬럼에 대해 중복을 제거한다,
         --GROUP BY 와 비슷한 효과
         
SUB5:;
SELECT *
FROM cycle; --cycle 전체

SELECT *
FROM product; --product 전체

SELECT pid
FROM cycle
WHERE cid = 1; --cid가 1인 고객이 애음하는 제품

SELECT *
FROM product
WHERE pid NOT IN (SELECT pid
                  FROM cycle
                  WHERE cid = 1); --답
         
SUB6:; -------------------------------------------------------------------------------------------   
cid = 2인 고객이 애음하는 제품 중 cid = 1인 고객도 애음하는 제품의 애음정보를 조회하는 쿼리 작성;

SELECT *
FROM cycle; --cycle 전체

SELECT *
FROM product; --product 전체

--cid= 1인 고객의 애음정보 ==> 100, 400번 제품을 애음중
SELECT pid
FROM cycle
WHERE cid = 1; --1번고객이 애음하는 제품


--cid =2인 고객의 애음제품 - > 100, 200번 제품을 애음중
SELECT pid
FROM cycle
WHERE cid = 2;

--cid = 1, cid2인 고객이 동시에 애음하는 제품은 100번제품

SELECT *
FROM cycle
WHERE cid = 1 
and pid IN (SELECT pid
            FROM cycle
            WHERE cid = 2);
            
SUB7:; -------------------------------------------------------------------------------------------   

SELECT *
FROM cycle; --cycle 전체

SELECT *
FROM product; --product 전체

SELECT *
FROM customer;

--내가 만든 값. 
SELECT cycle.cid, cnm, cycle.pid, pnm, day, cnt
FROM cycle JOIN product on (cycle.pid = product.pid)
           JOIN customer on (cycle.cid = customer.cid)
WHERE cycle.cid = 1 
and cycle.pid IN (SELECT cycle.pid
                   FROM cycle
                    WHERE cycle.cid = 2);
--선생님 값

SELECT *
FROM 
      ( SELECT *
        FROM cycle
        WHERE cid = 1 
        and pid IN (SELECT pid
                    FROM cycle
                    WHERE cid = 2)) a, customer, product
WHERE a.cid = customer.cid
AND a.pid = product.pid;

--스칼라 서브쿼리를 이용하는 것도 가능하다. 이용하면 조인할 필요 없음. 
--그러나 별로 좋은 방법이 아님. 권장x 

--EXISTS 연산자

매니저가 존재하는 직원 조회
실습8;

SELECT *
FROM emp
WHERE mgr IS NOT NULL;  -->EXISTS 연산자를 이용하지 않고 작성해보세요.

SELECT *
FROM emp a
WHERE EXISTS (SELECT 'x'
              FROM emp b
              WHERE b.empno = a.mgr); 
              
EXSITS 조건에 만족하는 행이 존재 하는지 확인하는 연산자
다른 연산자와 다르게 WHERE 절에 컬럼을 기술하지 않는다. --다른 연산자와 다르게 조건을 안 쓴다는 뜻이다...
 - WHERE empno = 7369
 - WHERE EXISTS (SELECT 'X'
                 FROM .....)

매니저가 존재하는 직원을 EXISTS 연산자를 통해 조회;
매니저도 직원이다.
SELECT empno, ename, mgr
FROM emp e
WHERE EXISTS (SELECT 'X'
              FROM emp m
              WHERE e.mgr = m.empno);


실습9;
SELECT *
FROM product
WHERE EXISTS (SELECT 'X'
              FROM cycle
              WHERE cycle.pid = product.pid AND cycle.cid = 1);



실습10;
SELECT *
FROM product
WHERE NOT EXISTS (SELECT 'X'
                  FROM cycle
                  WHERE cycle.pid = product.pid AND cycle.cid = 1);
                  
SELECT *
FROM product
WHERE EXISTS (SELECT 'X'
                  FROM cycle
                  WHERE cycle.pid = product.pid AND cycle.cid IN(2,3)); --> 왜 이건 안돼???
                  

집합연산
합집합: UNION - 중복제거 (집합개념) /UNION ALL - 중복을 제거하지 않음(속도 향상)
교집합: INTERSECT (집합개념)
차집합: MINUS (집합개념);
집합연산 공통사항
두 집합의 컬럼의 개수, 타입이 일치해야한다. 

SELECT empno, ename
FROM emp 
WHERE empno IN(7566,7698)

UNION

SELECT empno, ename
FROM emp 
WHERE empno IN(7566,7698); 
--> 동일한 집합을 합집하기 때문에 중복되는 데이터는 한번만 적용된다.

SELECT empno, ename
FROM emp 
WHERE empno IN(7566,7698)

UNION ALL 

SELECT empno, ename
FROM emp 
WHERE empno IN(7566,7698); 
--> 합집합, 일반적 집합의 개념에서 중복을 제거하지 않음.
--> 위아래 집합을 단순 연결한다. 

-->UNION ALL연산자는 UNION연산자와 다르게 중복을 허용한다.


INTERSECT(교집합) : 위, 아래 집합에서 값이 같은 행만 조회;

SELECT empno, ename
FROM emp 
WHERE empno IN(7566,7698,7369)

INTERSECT

SELECT empno, ename
FROM emp 
WHERE empno IN(7566,7698); 

MINUS(차집합) : 위 집합에서 아래 집합의 데이터를 제거한 나머지 집합;

SELECT empno, ename
FROM emp 
WHERE empno IN(7566,7698,7369)

MINUS

SELECT empno, ename
FROM emp 
WHERE empno IN(7566,7698); 

집합의 기술 순서가 영향이 가는 집합연산자
A UNION B                    B UNION A ==> 갑음
A UNION ALL B                B UNION ALL A ==> 같음 
A INTERSECT B                B INTERSECT A ==> 같음
A MINUS B                    B MINUS A ==> 다름;

집합연산의 결과 컬럼 이름은 첫번째 집합의 컬럼명을 따른다;

SELECT 'X' ,'B' sec 
FROM dual

UNION

SELECT 'Y' ,'A'
FROM dual;

정렬(ORDER BY)는 집합연산 가장 마지막 집합 다음에 기술;

SELECT deptno, dname, loc
FROM dept
WHERE deptno IN (10,20)

UNION 

SELECT deptno, dname, loc --> *가 아니라 전체 행을 다썼다...?
FROM dept
WHERE deptno IN (30, 40)
ORDER BY dname; -->이곳에 적어야 한다. 


-----------------


SELECT deptno, dname, loc
FROM (SELECT deptno, dname, loc
      FROM dept
      WHERE deptno IN (10,20)
      ORDER BY deptno DESC)

UNION ALL

SELECT deptno, dname, loc --> *가 아니라 전체 행을 다썼다...?
FROM (SELECT deptno, dname, loc
      FROM dept
      WHERE deptno IN (30,40)
      ORDER BY deptno);

햄버거 도시 발전지수;
전체:;
SELECT sido, sigungu, gb
FROM fastfood
WHERE gb NOT IN ('맘스터치');

--전체 시도와 시군구의 정보


--뭘 찾고 싶은거지? ~시군구의 버거킹 정보.
SELECT sido, sigungu , count(*)
FROM fastfood
GROUP BY sido, sigungu;


SELECT *
FROM fastfood
WHERE sido = '강원도'
AND sigungu = '춘천시';



시도, 시군구, 버거지수
--햄버거 도시 발전지수
--(버거킹, 맥도날드, kfc의 개수)/롯데리아의 개수

--시도, 시군구를 그룹으로 묶음
SELECT sido, sigungu , count(*)
FROM fastfood
GROUP BY sido, sigungu;





--대전시 대덕구 버거지수 :0.28
--대전시 중구 버거지수   :1.66
--대전시 서구 버거지수   :1.41
--대전시 유성구 버거지수 :0.5
--대전시 동구 버거지수   :0.5



SELECT count(*)
FROM fastfood
WHERE sido = '대전광역시'
AND sigungu = '대덕구'
AND gb = '버거킹'; --0

SELECT count(*)
FROM fastfood
WHERE sido = '대전광역시'
AND sigungu = '대덕구'
AND gb = '맥도날드'; --2

SELECT count(*)
FROM fastfood
WHERE sido = '대전광역시'
AND sigungu = '대덕구'
AND gb = 'KFC'; --0

SELECT count(*)
FROM fastfood
WHERE sido = '대전광역시'
AND sigungu = '대덕구'
AND gb = '롯데리아'; --7

--대전시 대덕구의 버거지수 : 2/7 = 0.28

---------
SELECT count(*)
FROM fastfood
WHERE sido = '대전광역시'
AND sigungu = '중구'
AND gb = '버거킹';  --2

SELECT count(*)
FROM fastfood
WHERE sido = '대전광역시'
AND sigungu = '중구'
AND gb = '맥도날드'; --4

SELECT count(*)
FROM fastfood
WHERE sido = '대전광역시'
AND sigungu = '중구'
AND gb = 'KFC'; --1

SELECT count(*)
FROM fastfood
WHERE sido = '대전광역시'
AND sigungu = '중구'
AND gb = '롯데리아'; --6

--대전시 중구의 버거지수 : 7/6 = 1.66

---------

SELECT count(*)
FROM fastfood
WHERE sido = '대전광역시'
AND sigungu = '서구'
AND gb = '버거킹'; --6

SELECT count(*)
FROM fastfood
WHERE sido = '대전광역시'
AND sigungu = '서구'
AND gb = '맥도날드'; --7

SELECT count(*)
FROM fastfood
WHERE sido = '대전광역시'
AND sigungu = '서구'
AND gb = 'KFC'; --4

SELECT count(*)
FROM fastfood
WHERE sido = '대전광역시'
AND sigungu = '서구'
AND gb = '롯데리아';  --12

--대전시 서구의 버거지수 17/12 --> 1.41



SELECT count(*)
FROM fastfood
WHERE sido = '대전광역시'
AND sigungu = '유성구'
AND gb = '버거킹'; --1

SELECT count(*)
FROM fastfood
WHERE sido = '대전광역시'
AND sigungu = '유성구'
AND gb = '맥도날드'; --3

SELECT count(*)
FROM fastfood
WHERE sido = '대전광역시'
AND sigungu = '유성구'
AND gb = 'KFC'; --0

SELECT count(*)
FROM fastfood
WHERE sido = '대전광역시'
AND sigungu = '유성구'
AND gb = '롯데리아'; --8

--대전시 유성구의 버거지수 4/8
--> 0.5


SELECT count(*)
FROM fastfood
WHERE sido = '대전광역시'
AND sigungu = '동구'
AND gb = '버거킹';  --2

SELECT count(*)
FROM fastfood
WHERE sido = '대전광역시'
AND sigungu = '동구'
AND gb = '맥도날드'; --2

SELECT count(*)
FROM fastfood
WHERE sido = '대전광역시'
AND sigungu = '동구'
AND gb = 'KFC';  --0

SELECT count(*)
FROM fastfood
WHERE sido = '대전광역시'
AND sigungu = '동구'
AND gb = '롯데리아'; --8

--대전시 동구의 버거지수 4 / 8
-->0.5

