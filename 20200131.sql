--���� �� ���� JOIN!!!!!!!��û �߿���!!!!

SELECT *
FROM EMP;
-->��ȸ������ �μ���ȣ�� �����µ� �μ����� �ȳ��´�. 

SELECT *
FROM dept;
-->�μ���(dname)�� dept ���̺� ����

-->��.......ppt190,191 �� ����

--JOIN �� ���̺��� �����ϴ� �۾�

--JOIN ���� //ȸ�縶�� �ٸ� �� ����
--1. ANSI ���� (�̱� ����ǥ��)
--2. ORACLE ����

--Natural Join
--�� ���̺� �� �÷� ���� ���� �� �ش� �÷����� ����(����)
--emp, dept ���̺��� deptno ��� �÷��� ����

--//����: �� ��ġ�� �÷��� ������ �ڵ����� ġȯ�Ǵ°ǰ�...? 
--//���� ������ �����൵ ��?
SELECT * 
FROM emp NATURAL JOIN dept;
--*�� ����ص� �ǰ� �����ϰ� ���� �Ϻ� �÷��� �����ص� ��.


--Natual join �� ���� ���� �÷�(deptno)�� ������(ex: ���̺��, ���̺� ��Ī)�� ������� �ʰ�
--�÷� �� ����Ѵ�. (dep.deptno --> deptno)
SELECT emp.ename, emp.ename , dept.dname -->���� , dept.deptno 
FROM emp NATURAL JOIN dept;

--���̺� ���� ��Ī�� ��� ����
SELECT e.empno, d.dname, deptno
FROM emp e NATURAL JOIN dept d;



--ORACLE Join
--FROM ���� ������ ���̺� ����� , �� �����Ͽ� �����Ѵ�.
--������ ���̺��� ���������� WHERE ���� ����Ѵ�.
--emp, dept ���̺� �����ϴ� deptno �÷��� (���� ��) ����

SELECT emp.ename, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno; 

--�� ���εǾ����� ������ �Ǽ��� ���� �� Ȯ���غ���.

SELECT emp.ename, dept.dname
FROM emp, dept
WHERE emp.deptno != dept.deptno; 
--�� �ϸ� 42���� ���� // --> �μ���ȣ�� �ٸ� 3���� ���� ������ �Ǿ 3��� ��Ƣ���

--TMI : sql�� �������� ¥�� �� �ƴ�, EXPLAN ��¼���� ���౸���� ���� ���� �� ������ ������� ����

--����Ŭ ������ ���̺� ��Ī
SELECT e.empno, e.ename, d.dname -->���� ,deptno -->����Ŭ ���ο����� �����ڰ� ������ ������ ����.
FROM emp e, dept d
WHERE e.deptno = d.deptno;

SELECT e.empno, e.ename, d.dname ,e.deptno --> �� �����ڸ� �־��־�� ��.
FROM emp e, dept d
WHERE e.deptno = d.deptno;

--ANSI : join with USING 
--�����Ϸ��� �ΰ��� ���̺� �̸��� ���� �÷��� �ΰ�������
--�ϳ��� �÷����θ� ������ �ϰ��� �� ��
--�����Ϸ��� ���� �÷��� ���;

--emp, dept ���̺��� ���� �÷�: deptno;
SELECT emp.ename, dept.dname, deptno
FROM emp JOIN dept USING (deptno);

--JOIN WITH USING �� ORACLE�� ǥ���ϸ�? (�ٸ� �� ����)
SELECT emp.ename, dept.dname, emp.deptno
FROM emp, dept
WHERE emp.deptno = dept.deptno;

--ANSI : JOIN WITH ON
--�����Ϸ��� ���̺��� �÷� �̸��� ���� �ٸ� ��;
--(���� �ֵ��� �÷� �̸��� ���� �� ���� �Ŷ� Ȱ�뵵�� �� ������)

SELECT emp.ename, dept.dname, emp.deptno --<��� �� �����ڸ� ���־�� �Ѵ�. ���ϸ� �򰥸�.
FROM emp JOIN dept ON (emp.deptno = dept.deptno);


--JOIN WITH ON -->ORACLE //�� �Ȱ���
SELECT emp.ename, dept.dname, emp.deptno
FROM emp, dept
WHERE emp.deptno = dept.deptno;

--SELF JOIN : ���� ���̺� ���� ����;
SELECT *
FROM emp;
--���� ���̺� �ȿ�... ���̽� ����� ����� '�̸�'�� �˰� ���� �� ����.
--mgr ��ȣ�� �ְ� �̸��� �ٷ� ������ �����Ƿ� self ������ �Ѵ�.

--emp ���̺��� �����Ǵ� ����� ������ ����� �̿��Ͽ� ������ �̸��� ��ȸ�غ���
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e JOIN emp m ON (e.mgr = m.empno); -->�򰥸��ϱ� emp�鿡 �̸��� �ٿ��༭ ��������.
-->mgr �÷��� null�� PRESIDENT �� �����������. 

--������ �� ���� ����Ŭ �������� �ۼ��غ���.
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e, emp m
WHERE e.mgr = m.empno;

--���±��� ��� ���� equal ����
-- equal ����: =
-- non-equal ���� : !=, >, <, BETWEEN AND

--����� �޿� ������ �޿� ��� ���̺��� �̿��Ͽ� �ش����� �޿� ����� ���غ���.
--�޿� ����
SELECT ename, sal
FROM emp;
--�޿� ��� ���̺�
SELECT *
FROM salgrade;

--����Ŭ �������� Ǯ�� ����
SELECT ename, sal, salgrade.grade 
FROM emp, salgrade
WHERE emp.sal BETWEEN salgrade.losal
                  AND salgrade.hisal;
            
--�Ƚ� �������� Ǯ�� ����
SELECT emp.ename, emp.sal, salgrade.grade --<��� �� �����ڸ� ���־�� �Ѵ�. ���ϸ� �򰥸�.
FROM emp JOIN salgrade ON (emp.sal BETWEEN salgrade.losal
                                   AND salgrade.hisal);

--join0 �ǽ�

--����1
SELECT empno, ename, deptno
FROM emp;
--����2
SELECT deptno, dname
FROM dept;

--����Ŭ �������� Ǯ�� ����
SELECT emp.empno, emp.ename, emp.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno
ORDER BY deptno ASC;

--join on ���� Ǯ�� ����
SELECT emp.empno, emp.ename ,dept.deptno, dept.dname
FROM emp JOIN dept ON (emp.deptno = dept.deptno);


--join0_1 �ǽ�
--����1
SELECT empno, ename, deptno
FROM emp;
--����2
SELECT deptno, dname
FROM dept;

--����Ŭ �������� Ǯ�� ����
SELECT emp.empno, emp.ename, emp.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno AND emp.deptno IN (10,30); -->�ٵ� �� AND�� WHERE�� AND������ ��� ����...?

--join on ���� Ǯ�� ����
SELECT emp.empno, emp.ename ,dept.deptno, dept.dname
FROM emp JOIN dept ON (emp.deptno = dept.deptno)
WHERE dept.deptno IN (10,30);

--join0_2 �ǽ�
--����1
SELECT empno, ename, deptno
FROM emp;
--����2
SELECT deptno, dname
FROM dept;
--����Ŭ �������� Ǯ�� ����
SELECT emp.empno, emp.ename, sal, dept.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno AND sal > 2500
ORDER BY sal DESC;

--join on ���� Ǯ�� ����
SELECT emp.empno, emp.ename, emp.sal, dept.deptno, dept.dname
FROM emp JOIN dept ON (emp.deptno = dept.deptno)
WHERE  emp.sal > 2500
ORDER BY sal DESC;

--join0_3 �ǽ�
--����1
SELECT empno, ename, deptno
FROM emp;
--����2
SELECT deptno, dname
FROM dept;
--����Ŭ �������� Ǯ�� ����
 SELECT emp.empno, emp.ename, emp.sal, emp.deptno, dept.dname
 FROM emp, dept
 WHERE emp.deptno = dept.deptno AND sal > 2500 AND emp.empno > 7600; 
--join on ���� Ǯ�� ����
SELECT emp.empno, emp.ename, emp.sal, dept.deptno, dept.dname
FROM emp JOIN dept ON (emp.deptno = dept.deptno)
WHERE  emp.sal > 2500
AND emp.empno > 7600
ORDER BY sal DESC;

--join0_4 �ǽ�
--����Ŭ �������� Ǯ�� ����
 SELECT emp.empno, emp.ename, emp.sal, emp.deptno, dept.dname
 FROM emp, dept
 WHERE emp.deptno = dept.deptno 
 AND sal > 2500 
 AND emp.empno > 7600
 AND dept.dname = 'RESEARCH'; 
--join on ���� Ǯ�� ����
SELECT emp.empno, emp.ename, emp.sal, dept.deptno, dept.dname
FROM emp JOIN dept ON (emp.deptno = dept.deptno)
WHERE  emp.sal > 2500
AND emp.empno > 7600
AND dept.dname = 'RESEARCH' 
ORDER BY sal DESC;

--join1 �ǽ�
--PROD : PROD_LGU
--LPROD : LPROD_GU;

SELECT *
FROM prod;

SELECT *
FROM lprod;

--����Ŭ �������� Ǯ�� ����
 SELECT l.lprod_gu , l.lprod_nm, p.prod_id, p.prod_name --�ϳ��ϳ� ���� �Ⱥٿ��൵ �Ǵµ�..?
 FROM prod p, lprod l
 WHERE p.prod_lgu = l.lprod_gu;
 
 --JOIN ON ���� Ǯ���
 SELECT lprod_gu, lprod_nm, prod_id, prod_name
 FROM prod JOIN lprod ON (prod.prod_lgu = lprod.lprod_gu);
 
 
 ---tmi ������ ����Ʈ : okky
 
 --join2 �ǽ�
 
--����Ŭ �������� Ǯ�� ����
SELECT buyer_id , buyer_name , prod_id , prod_name
FROM prod, buyer
WHERE prod.prod_buyer = buyer.buyer_id;

--JOIN ON ���� Ǯ���
SELECT buyer_id, buyer_name , prod_id, prod_name
FROM prod JOIN buyer ON (prod.prod_buyer = buyer.buyer_id);

--join3 --> from ���� .�ϳ� �� ��� ������ֱ�
--join3 �����Դϴ�...

--join3 Ǯ���!!

SELECT mem_id, mem_name ,prod_id, prod_name, cart_qty
FROM prod, member, cart
WHERE prod.prod_id = cart.cart_prod AND cart.cart_member = member.mem_id;





 