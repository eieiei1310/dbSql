SELECT *
FROM customer;

SELECT *
FROM product;

SELECT *
FROM cycle; --�Ͽ��Ϻ��� 1��

--�Ǹ��� : 200~250
--���� 2.5�� ��ǰ
--�Ϸ� : 500~7500
--�Ѵ� : 15000~17500

SELECT *
FROM daily;

SELECT *
FROM batch;
--
--join 4 join �� �ϸ鼭 (3�� ���̺�) ROW�� �����ϴ� ������ ����;
SELECT customer.cid, customer.cnm, cycle.pid, cycle.day, cycle.cnt
FROM customer, cycle, product
WHERE customer.cid = cycle.cid
AND cycle.pid = product.pid
AND customer.cnm IN ('brown', 'sally');


--join 5 join �� �ϸ鼭 (3�� ���̺�) ROW�� �����ϴ� ������ ����;
SELECT customer.cid, customer.cnm, cycle.pid, pnm, cycle.day, cycle.cnt
FROM customer, cycle, product
WHERE customer.cid = cycle.cid
AND cycle.pid = product.pid
AND customer.cnm IN ('brown', 'sally');


--join 6 GROUP BY ����ؾ���.
SELECT customer.cid, customer.cnm, cycle.pid, product.pnm ,sum(cycle.cnt)
FROM customer, cycle, product
WHERE customer.cid = cycle.cid
  AND cycle.pid = product.pid
GROUP BY customer.cid, customer.cnm, cycle.pid, pnm, cycle.cnt;


--join 7 GROUP BY ����ؾ���.
SELECT cycle.pid, product.pnm , sum(cycle.cnt)
FROM customer, cycle, product
WHERE customer.cid = cycle.cid
  AND cycle.pid = product.pid
GROUP BY  cycle.pid, product.pnm;

--join 8 GROUP BY ����ؾ���.

-------------------------8~13 ���� ��� ����

--left : ������ ����
--right : ������ ������

--�ƿ��� ������ �ʿ��� ��:
--���������� ���� ����...
--�� ���̺��� ������ �� ���� ������ ������Ű�� ���ϴ� �����͸�
--�������� ������ ���̺��� �����͸��̶� ��ȸ�ǰԲ� �ϴ� ���� ���.

--�������� : e.mgr = m.empno : KING �� MGR�� NULL �̱� ������ ���ο� �����Ѵ�.
--emp ���̺��� �����ʹ� �� 14�������� �Ʒ��� ���� ���������� ����� 13���� �ȴ�.
--(1���� ���ν���);

SELECT e.empno, e.ename, e.mgr, m.ename
FROM emp e, emp m 
WHERE e.mgr = m.empno;

--ANSI OUTER ���� �غ���
--1. ���ο� �����ϴ��� ��ȸ�� �� ���̺��� �����Ѵ�. 
--(mgr ������ ��� ��������� ������ �ϰ� ����--> ������: �������)

--left outer
SELECT e.empno, e.ename, e.mgr, m.ename
FROM emp e LEFT OUTER JOIN emp m ON (e.mgr = m.empno); 
--> ���� king �̶�� �����Ͱ� ���´�.

--right outer
SELECT e.empno, e.ename, e.mgr, m.ename
FROM emp e RIGHT OUTER JOIN emp m ON (e.mgr = m.empno); 

--> ���̺� ������ �ٲ� �ָ� ��

--����Ŭ �ƿ��� ����

--�����Ͱ� ���� ���� ���̺� �÷� �ڿ� (+)��ȣ�� �ٿ��ش�.
SELECT e.empno, e.ename, e.mgr, m.ename
FROM emp e , emp m
WHERE e.mgr = m.empno(+);



SELECT e.empno, e.ename, e.mgr, m.ename, m.deptno
FROM emp e , emp m
WHERE e.mgr = m.empno(+);

--���� sql�� �Ƚ� �������� �����غ�����.
--�Ŵ����� �μ���ȣ�� 10���� ������ ��ȸ;

--left outer
SELECT e.empno, e.ename, e.mgr, m.ename
FROM emp e LEFT OUTER JOIN emp m ON (e.mgr = m.empno); 
--> �Ϲ����� �ƿ��� ����

SELECT e.empno, e.ename, e.mgr, m.ename , m.deptno
FROM emp e LEFT OUTER JOIN emp m ON (e.mgr = m.empno AND m.deptno = 10);
-->�̰�� 14�� 10���ΰ� ���� �ϰ� �� �� ����

SELECT e.empno, e.ename, e.mgr, m.ename , m.deptno
FROM emp e LEFT OUTER JOIN emp m ON (e.mgr = m.empno)
WHERE m.deptno = 10;
-->�̰�� �ƿ������� �� �� 10�� �ɷ���-> //�ƿ��������� ����� �̷������ ����


-------------------����Ŭouter join 
--����Ŭ outer join �� ���� ���̺��� �ݴ��� ���̺��� ��� �÷��� (+)�� �ٿ���
--�������� outer join ���� �����Ѵ�.
--�� �÷��̶� (+)�� �����ϸ� inner �������� ����

--�Ʒ� oracle outer ������ inner �������� ����: m.deptno �÷��� (+)�� ���� ����.
SELECT e.empno, e.ename, e.mgr, m.ename, m.deptno
FROM emp e, emp m
WHERE e.mgr = m.empno(+)
AND m.deptno = 10;
--> ������ �ߴ� ������ �Ƚ� outer�����̶� �Ȱ���

SELECT e.empno, e.ename, e.mgr, m.ename, m.deptno
FROM emp e, emp m
WHERE e.mgr = m.empno(+)
AND m.deptno(+) = 10;
--> �̷��� �ؾ� ��.

--��� - �Ŵ��� �� RIGHT OUTER JOIN 
SELECT empno, ename, mgr
FROM emp e;

SELECT empno, ename
FROM emp m;

SELECT e.empno, e.ename, e.mgr, m.empno, m.ename
FROM emp e LEFT OUTER JOIN emp m ON (e.mgr = m.empno);

SELECT e.empno, e.ename, e.mgr, m.empno, m.ename
FROM emp e RIGHT OUTER JOIN emp m ON (e.mgr = m.empno);

--full outer join 
--���� ������ �ʴ´�. �ʹ� �𸣰��� �Ѿ�� ��
--full outer : LEFT OUTER + RIGHR OUTER - �ߺ� ����;

SELECT e.empno, e.ename, e.mgr, m.empno, m.ename
FROM emp e FULL OUTER JOIN emp m ON (e.mgr = m.empno);

---------------------


--outerjoin1 �ǽ�

SELECT * --count(*)�Լ��� �̿��� ��ü�� Ȯ���غ� �� �ִ�. 
FROM buyprod;


SELECT *
FROM prod;
--���� Ǯ�� ��� - ansi
SELECT buyprod.buy_date , 
       buyprod.buy_prod , 
       prod.prod_id, 
       prod.prod_name, 
       buyprod.buy_qty
FROM buyprod RIGHT OUTER JOIN prod ON (prod.prod_id = buyprod.buy_prod 
                                   AND buy_date = TO_DATE(20050125, 'YYYYMMDD')); 

--�������� Ǯ�� ��� -oracle
SELECT buyprod.buy_date, buyprod.buy_prod, prod.prod_id, prod.prod_name, buyprod.buy_qty
FROM prod, buyprod
WHERE prod.prod_id = buyprod.buy_prod(+)
AND buyprod.buy_date(+) = TO_DATE('20050125','YYYYMMDD');
--74���� �����Ͱ� ����. 

--ORACLE ���������� OUTER JOIN ������ (+)��ȣ�� �̿��Ͽ� full outer ������ �������� �ʴ´�.


--outerjoin2 �ǽ�

SELECT nvl(buyprod.buy_date,TO_DATE('20050125','YYYYMMDD')) AS "BUY_DATE", 
        buyprod.buy_prod, 
        prod.prod_id,
        prod.prod_name, 
        buyprod.buy_qty
FROM prod, buyprod
WHERE prod.prod_id = buyprod.buy_prod(+)
AND buyprod.buy_date(+) = TO_DATE('20050125','YYYYMMDD');

--����...NVL �Լ��� �� �о������... ���� �´�!!!!!!!!!!!!!



