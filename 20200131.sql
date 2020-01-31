--오늘 할 것은 JOIN!!!!!!!엄청 중요해!!!!

SELECT *
FROM EMP;
-->조회했을때 부서번호는 나오는데 부서명은 안나온다. 

SELECT *
FROM dept;
-->부서명(dname)은 dept 테이블에 있음

-->오.......ppt190,191 등 참조

--JOIN 두 테이블을 연결하는 작업

--JOIN 문법 //회사마다 다를 수 있음
--1. ANSI 문법 (미국 국가표준)
--2. ORACLE 문법

--Natural Join
--두 테이블 간 컬럼 명이 같을 때 해당 컬럼으로 연결(조인)
--emp, dept 테이블에는 deptno 라는 컬럼이 존재

--//질문: 걍 겹치는 컬럼이 있으면 자동으로 치환되는건가...? 
--//내가 설정을 안해줘도 돼?
SELECT * 
FROM emp NATURAL JOIN dept;
--*를 사용해도 되고 연결하고 싶은 일부 컬럼만 선택해도 됨.


--Natual join 에 사용된 조인 컬럼(deptno)는 한정자(ex: 테이블명, 테이블 별칭)을 사용하지 않고
--컬럼 명만 기술한다. (dep.deptno --> deptno)
SELECT emp.ename, emp.ename , dept.dname -->에러 , dept.deptno 
FROM emp NATURAL JOIN dept;

--테이블에 대한 별칭도 사용 가능
SELECT e.empno, d.dname, deptno
FROM emp e NATURAL JOIN dept d;



--ORACLE Join
--FROM 절에 조인할 테이블 목록을 , 로 구분하여 나열한다.
--조인할 테이블의 연결조건을 WHERE 절에 기술한다.
--emp, dept 테이블에 존재하는 deptno 컬럼이 (같을 때) 조인

SELECT emp.ename, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno; 

--잘 조인되었는지 데이터 건수를 보며 잘 확인해보자.

SELECT emp.ename, dept.dname
FROM emp, dept
WHERE emp.deptno != dept.deptno; 
--로 하면 42개가 나옴 // --> 부서번호가 다른 3개와 각각 연결이 되어서 3배로 뻥튀기됨

--TMI : sql은 논리구조를 짜는 게 아님, EXPLAN 어쩌구로 실행구조를 보면 내가 쓴 순서로 실행되지 않음

--오라클 조인의 테이블 별칭
SELECT e.empno, e.ename, d.dname -->오류 ,deptno -->오라클 조인에서는 한정자가 없으면 오류가 난다.
FROM emp e, dept d
WHERE e.deptno = d.deptno;

SELECT e.empno, e.ename, d.dname ,e.deptno --> 꼭 한정자를 넣어주어야 함.
FROM emp e, dept d
WHERE e.deptno = d.deptno;

--ANSI : join with USING 
--조인하려는 두개의 테이블에 이름이 같은 컬럼이 두개이지만
--하나의 컬럼으로만 조인을 하고자 할 때
--조인하려는 기준 컬럼을 기술;

--emp, dept 테이블의 공통 컬럼: deptno;
SELECT emp.ename, dept.dname, deptno
FROM emp JOIN dept USING (deptno);

--JOIN WITH USING 을 ORACLE로 표현하면? (다른 게 없다)
SELECT emp.ename, dept.dname, emp.deptno
FROM emp, dept
WHERE emp.deptno = dept.deptno;

--ANSI : JOIN WITH ON
--조인하려는 테이블의 컬럼 이름이 서로 다를 때;
--(위에 애들은 컬럼 이름이 같을 때 쓰는 거라 활용도가 좀 떨어짐)

SELECT emp.ename, dept.dname, emp.deptno --<얘는 또 한정자를 써주어야 한다. 안하면 헷갈림.
FROM emp JOIN dept ON (emp.deptno = dept.deptno);


--JOIN WITH ON -->ORACLE //또 똑같음
SELECT emp.ename, dept.dname, emp.deptno
FROM emp, dept
WHERE emp.deptno = dept.deptno;

--SELF JOIN : 같은 테이블 같의 조인;
SELECT *
FROM emp;
--같은 테이블 안에... 스미스 사원의 상사의 '이름'을 알고 싶을 때 쓴다.
--mgr 번호만 있고 이름이 바로 나오진 않으므로 self 조인을 한다.

--emp 테이블에서 관리되는 사원의 관리자 사번을 이용하여 관리자 이름을 조회해보자
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e JOIN emp m ON (e.mgr = m.empno); -->헷갈리니까 emp들에 이름을 붙여줘서 구별하자.
-->mgr 컬럼이 null인 PRESIDENT 가 사라져버렸음. 

--위에서 한 것을 오라클 문법으로 작성해보자.
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e, emp m
WHERE e.mgr = m.empno;

--여태까지 배운 것은 equal 조인
-- equal 조인: =
-- non-equal 조인 : !=, >, <, BETWEEN AND

--사원의 급여 정보와 급여 등급 테이블을 이용하여 해당사원의 급여 등급을 구해보자.
--급여 정보
SELECT ename, sal
FROM emp;
--급여 등급 테이블
SELECT *
FROM salgrade;

--오라클 문법으로 풀어 보기
SELECT ename, sal, salgrade.grade 
FROM emp, salgrade
WHERE emp.sal BETWEEN salgrade.losal
                  AND salgrade.hisal;
            
--안시 문법으로 풀어 보기
SELECT emp.ename, emp.sal, salgrade.grade --<얘는 또 한정자를 써주어야 한다. 안하면 헷갈림.
FROM emp JOIN salgrade ON (emp.sal BETWEEN salgrade.losal
                                   AND salgrade.hisal);

--join0 실습

--참고1
SELECT empno, ename, deptno
FROM emp;
--참고2
SELECT deptno, dname
FROM dept;

--오라클 문법으로 풀어 보기
SELECT emp.empno, emp.ename, emp.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
ORDER BY deptno ASC;

--join on 으로 풀어 보기
SELECT emp.empno, emp.ename ,dept.deptno, dept.dname
FROM emp JOIN dept ON (emp.deptno = dept.deptno);


--join0_1 실습
--참고1
SELECT empno, ename, deptno
FROM emp;
--참고2
SELECT deptno, dname
FROM dept;

--오라클 문법으로 풀어 보기
SELECT emp.empno, emp.ename, emp.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno AND emp.deptno IN (10,30); -->근데 이 AND가 WHERE절 AND인지는 어떻게 알지...?

--join on 으로 풀어 보기
SELECT emp.empno, emp.ename ,dept.deptno, dept.dname
FROM emp JOIN dept ON (emp.deptno = dept.deptno)
WHERE dept.deptno IN (10,30);

--join0_2 실습
--참고1
SELECT empno, ename, deptno
FROM emp;
--참고2
SELECT deptno, dname
FROM dept;
--오라클 문법으로 풀어 보기
SELECT emp.empno, emp.ename, sal, dept.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno AND sal > 2500
ORDER BY sal DESC;

--join on 으로 풀어 보기
SELECT emp.empno, emp.ename, emp.sal, dept.deptno, dept.dname
FROM emp JOIN dept ON (emp.deptno = dept.deptno)
WHERE  emp.sal > 2500
ORDER BY sal DESC;

--join0_3 실습
--참고1
SELECT empno, ename, deptno
FROM emp;
--참고2
SELECT deptno, dname
FROM dept;
--오라클 문법으로 풀어 보기
 SELECT emp.empno, emp.ename, emp.sal, emp.deptno, dept.dname
 FROM emp, dept
 WHERE emp.deptno = dept.deptno AND sal > 2500 AND emp.empno > 7600; 
--join on 으로 풀어 보기
SELECT emp.empno, emp.ename, emp.sal, dept.deptno, dept.dname
FROM emp JOIN dept ON (emp.deptno = dept.deptno)
WHERE  emp.sal > 2500
AND emp.empno > 7600
ORDER BY sal DESC;

--join0_4 실습
--오라클 문법으로 풀어 보기
 SELECT emp.empno, emp.ename, emp.sal, emp.deptno, dept.dname
 FROM emp, dept
 WHERE emp.deptno = dept.deptno 
 AND sal > 2500 
 AND emp.empno > 7600
 AND dept.dname = 'RESEARCH'; 
--join on 으로 풀어 보기
SELECT emp.empno, emp.ename, emp.sal, dept.deptno, dept.dname
FROM emp JOIN dept ON (emp.deptno = dept.deptno)
WHERE  emp.sal > 2500
AND emp.empno > 7600
AND dept.dname = 'RESEARCH' 
ORDER BY sal DESC;

--join1 실습
--PROD : PROD_LGU
--LPROD : LPROD_GU;

SELECT *
FROM prod;

SELECT *
FROM lprod;

--오라클 문법으로 풀어 보기
 SELECT l.lprod_gu , l.lprod_nm, p.prod_id, p.prod_name --하나하나 가명 안붙여줘도 되는듯..?
 FROM prod p, lprod l
 WHERE p.prod_lgu = l.lprod_gu;
 
 --JOIN ON 으로 풀어보기
 SELECT lprod_gu, lprod_nm, prod_id, prod_name
 FROM prod JOIN lprod ON (prod.prod_lgu = lprod.lprod_gu);
 
 
 ---tmi 개발자 사이트 : okky
 
 --join2 실습
 
--오라클 문법으로 풀어 보기
SELECT buyer_id , buyer_name , prod_id , prod_name
FROM prod, buyer
WHERE prod.prod_buyer = buyer.buyer_id;

--JOIN ON 으로 풀어보기
SELECT buyer_id, buyer_name , prod_id, prod_name
FROM prod JOIN buyer ON (prod.prod_buyer = buyer.buyer_id);

--join3 --> from 절에 .하나 더 찍고 기술해주기
--join3 숙제입니다...

--join3 풀어보기!!

SELECT mem_id, mem_name ,prod_id, prod_name, cart_qty
FROM prod, member, cart
WHERE prod.prod_id = cart.cart_prod AND cart.cart_member = member.mem_id;





 