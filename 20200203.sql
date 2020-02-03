SELECT *
FROM customer;

SELECT *
FROM product;

SELECT *
FROM cycle; --일요일부터 1번

--판매점 : 200~250
--고객당 2.5개 제품
--하루 : 500~7500
--한달 : 15000~17500

SELECT *
FROM daily;

SELECT *
FROM batch;
--
--join 4 join 을 하면서 (3개 테이블) ROW를 제한하는 조건을 결합;
SELECT customer.cid, customer.cnm, cycle.pid, cycle.day, cycle.cnt
FROM customer, cycle, product
WHERE customer.cid = cycle.cid
AND cycle.pid = product.pid
AND customer.cnm IN ('brown', 'sally');


--join 5 join 을 하면서 (3개 테이블) ROW를 제한하는 조건을 결합;
SELECT customer.cid, customer.cnm, cycle.pid, pnm, cycle.day, cycle.cnt
FROM customer, cycle, product
WHERE customer.cid = cycle.cid
AND cycle.pid = product.pid
AND customer.cnm IN ('brown', 'sally');


--join 6 GROUP BY 사용해야함.
SELECT customer.cid, customer.cnm, cycle.pid, product.pnm ,sum(cycle.cnt)
FROM customer, cycle, product
WHERE customer.cid = cycle.cid
  AND cycle.pid = product.pid
GROUP BY customer.cid, customer.cnm, cycle.pid, pnm, cycle.cnt;


--join 7 GROUP BY 사용해야함.
SELECT cycle.pid, product.pnm , sum(cycle.cnt)
FROM customer, cycle, product
WHERE customer.cid = cycle.cid
  AND cycle.pid = product.pid
GROUP BY  cycle.pid, product.pnm;

--join 8 GROUP BY 사용해야함.

-------------------------8~13 까지 모두 과제

--left : 기준이 왼쪽
--right : 기준이 오른쪽

--아우터 조인이 필요할 때:
--셀프조인을 했을 때는...
--두 테이블을 조인할 때 연결 조건을 만족시키지 못하는 데이터를
--기준으로 지정한 테이블의 데이터만이라도 조회되게끔 하는 조인 방식.

--연결조건 : e.mgr = m.empno : KING 의 MGR이 NULL 이기 때문에 조인에 실패한다.
--emp 테이블의 데이터는 총 14건이지만 아래와 같은 쿼리에서는 결과가 13건이 된다.
--(1건이 조인실패);

SELECT e.empno, e.ename, e.mgr, m.ename
FROM emp e, emp m 
WHERE e.mgr = m.empno;

--ANSI OUTER 조인 해보기
--1. 조인에 실패하더라도 조회가 될 테이블을 선정한다. 
--(mgr 정보가 없어도 사원정보는 나오게 하고 싶음--> 기준점: 사원정보)

--left outer
SELECT e.empno, e.ename, e.mgr, m.ename
FROM emp e LEFT OUTER JOIN emp m ON (e.mgr = m.empno); 
--> 이제 king 이라는 데이터가 나온다.

--right outer
SELECT e.empno, e.ename, e.mgr, m.ename
FROM emp e RIGHT OUTER JOIN emp m ON (e.mgr = m.empno); 

--> 테이블 순서만 바꿔 주면 됨

--오라클 아우터 조인

--데이터가 없는 쪽의 테이블 컬럼 뒤에 (+)기호를 붙여준다.
SELECT e.empno, e.ename, e.mgr, m.ename
FROM emp e , emp m
WHERE e.mgr = m.empno(+);



SELECT e.empno, e.ename, e.mgr, m.ename, m.deptno
FROM emp e , emp m
WHERE e.mgr = m.empno(+);

--위의 sql을 안시 문법으로 변경해보세요.
--매니저의 부서번호가 10번인 직원만 조회;

--left outer
SELECT e.empno, e.ename, e.mgr, m.ename
FROM emp e LEFT OUTER JOIN emp m ON (e.mgr = m.empno); 
--> 일반적인 아우터 조인

SELECT e.empno, e.ename, e.mgr, m.ename , m.deptno
FROM emp e LEFT OUTER JOIN emp m ON (e.mgr = m.empno AND m.deptno = 10);
-->이경우 14건 10번인것 먼저 하고 그 뒤 조인

SELECT e.empno, e.ename, e.mgr, m.ename , m.deptno
FROM emp e LEFT OUTER JOIN emp m ON (e.mgr = m.empno)
WHERE m.deptno = 10;
-->이경우 아우터조인 한 뒤 10번 걸러넴-> //아우터조인이 제대로 이루어지지 않음


-------------------오라클outer join 
--오라클 outer join 시 기준 테이블의 반대편 테이블의 모든 컬럼에 (+)를 붙여야
--정상적인 outer join 으로 동작한다.
--한 컬럼이라도 (+)를 누락하면 inner 조인으로 동작

--아래 oracle outer 조인은 inner 조인으로 동작: m.deptno 컬럼에 (+)가 붙지 않음.
SELECT e.empno, e.ename, e.mgr, m.ename, m.deptno
FROM emp e, emp m
WHERE e.mgr = m.empno(+)
AND m.deptno = 10;
--> 위에서 했던 실패한 안시 outer문법이랑 똑같음

SELECT e.empno, e.ename, e.mgr, m.ename, m.deptno
FROM emp e, emp m
WHERE e.mgr = m.empno(+)
AND m.deptno(+) = 10;
--> 이렇게 해야 함.

--사원 - 매니저 간 RIGHT OUTER JOIN 
SELECT empno, ename, mgr
FROM emp e;

SELECT empno, ename
FROM emp m;

SELECT e.empno, e.ename, e.mgr, m.empno, m.ename
FROM emp e LEFT OUTER JOIN emp m ON (e.mgr = m.empno);

SELECT e.empno, e.ename, e.mgr, m.empno, m.ename
FROM emp e RIGHT OUTER JOIN emp m ON (e.mgr = m.empno);

--full outer join 
--자주 쓰이진 않는다. 너무 모르겠음 넘어가도 됨
--full outer : LEFT OUTER + RIGHR OUTER - 중복 제거;

SELECT e.empno, e.ename, e.mgr, m.empno, m.ename
FROM emp e FULL OUTER JOIN emp m ON (e.mgr = m.empno);

---------------------


--outerjoin1 실습

SELECT * --count(*)함수를 이용해 전체를 확인해볼 수 있다. 
FROM buyprod;


SELECT *
FROM prod;
--내가 풀은 방식 - ansi
SELECT buyprod.buy_date , 
       buyprod.buy_prod , 
       prod.prod_id, 
       prod.prod_name, 
       buyprod.buy_qty
FROM buyprod RIGHT OUTER JOIN prod ON (prod.prod_id = buyprod.buy_prod 
                                   AND buy_date = TO_DATE(20050125, 'YYYYMMDD')); 

--선생님이 풀은 방식 -oracle
SELECT buyprod.buy_date, buyprod.buy_prod, prod.prod_id, prod.prod_name, buyprod.buy_qty
FROM prod, buyprod
WHERE prod.prod_id = buyprod.buy_prod(+)
AND buyprod.buy_date(+) = TO_DATE('20050125','YYYYMMDD');
--74건의 데이터가 나옴. 

--ORACLE 문법에서는 OUTER JOIN 에서는 (+)기호를 이용하여 full outer 문법을 지원하지 않는다.


--outerjoin2 실습

SELECT nvl(buyprod.buy_date,TO_DATE('20050125','YYYYMMDD')) AS "BUY_DATE", 
        buyprod.buy_prod, 
        prod.prod_id,
        prod.prod_name, 
        buyprod.buy_qty
FROM prod, buyprod
WHERE prod.prod_id = buyprod.buy_prod(+)
AND buyprod.buy_date(+) = TO_DATE('20050125','YYYYMMDD');

--나는...NVL 함수로 싹 밀어버렸음... 정답 맞대!!!!!!!!!!!!!



