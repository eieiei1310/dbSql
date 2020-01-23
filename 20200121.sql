-- PROD ���̺��� ��� �÷��� �ڷ� ��ȸ

SELECT *
FROM PROD;

--PROD ���̺��� PROD_ID, PROD_NAME �÷��� �ڷḸ ��ȸ
SELECT prod_id, prod_name
FROM PROD;

--1prod ���̺��� ��� �����͸� ��ȸ�ϴ� ������ �ۼ��ϼ���

SELECT *
FROM LPROD;

--buyer ���̺��� ��� �����͸� ��ȸ�ϴ� ������ �ۼ��ϼ���

SELECT buyer_id, buyer_name
FROM BUYER;

--cart ���̺��� ��� �����͸� ��ȸ�ϴ� ������ �ۼ��ϼ���

SELECT *
FROM CART;

--member ���̺��� mem_id, mem_pass, mem_name ��ȸ�ϴ� ������ �ۼ��ϼ���

SELECT mem_id, mem_pass, mem_name
FROM MEMBER;

--users ���̺� ��ȸ

SELECT *
FROM users;

--���̺� � Į���� �ִ��� Ȯ���ϴ� ���
1. SELECT * �ؼ� ���� ��ȸ�غ���.
2. TOOL�� ��� (����� -TABLES )
3. DESC ���̺�� (DESC - DESCRIBE�� ����)
DESC users

--users ���̺��� userid, usernm, reg_dt Į���� ��ȸ�ϴ� sql�� �ۼ��ϼ���.
-- ��¥ ����(reg_dt �÷��� date ������ ���� �� �ִ� Ÿ��)
-- SQL ��¥ Į�� + (���ϱ� ����) : 
-- �������� ��Ģ������ �ƴѰ͵� (5 + 5)
-- String h = "hello";
-- String w = "world";
-- String hw = h+w; --�ڹٿ����� �� ���ڿ��� �����ض� ��� ��
-- SQL ���� ���ǵ� ��¥ ���� : ��¥ + ���� = ��¥���� ������ ���ڷ� ����Ͽ� ���� ��¥�� �ȴ�.
-- ex) (2019/01/28 + 5 = 2019/02/02)
--reg_dt : ������� �÷�

--null : ���� �𸣴� ����
--null�� ���� ���� ����� �׻� null �̴�.


SELECT userid u_id, usernm, reg_dt,
       reg_dt + 5 AS reg_dt_atter_5day
FROM users;

--prod ���̺��� prod_id, prod_name �� Į���� ��ȸ�ϴ� ������ �ۼ��Ͻÿ�. 
SELECT prod_id AS id, prod_name AS name
FROM PROD;


--lprod ���̺��� lprod_gu, lprod_nm �� Į���� ��ȸ�ϴ� ������ �ۼ��Ͻÿ�. 
SELECT lprod_gu AS gu, lprod_nm AS nm
FROM LPROD;

--buyer ���̺��� buyer_id, buyer_name �� Į���� ��ȸ�ϴ� ������ �ۼ��Ͻÿ�. 
SELECT buyer_id AS ���̾���̵�, buyer_name AS �̸�
FROM BUYER;


--���ڿ� ����
-- �ڹ� ���� ���ڿ� ���� : ("Hello + "World")
-- SQL������ : ||  ('Hello' || 'world')
-- SQL������ : concat('Hello','world')

--userid, usernm �÷��� ����, ��Ī�� id_name�� �غ���. 

SELECT userid || usernm AS id_name,
CONCAT (userid, usernm) AS concat_id_name
FROM users;



--����, ���
--int a = 5; String msg = "Hello, World";
--System.out.println(msg); //����� �̿��� ���
--System.out.println("Hello, World"); //������ �̿��� ���

--SQL������ ������ ����(�÷��� ����� ����,pl/sql ���� ������ ����)
--SQL���� ���ڿ� ����� �̱� �����̼����� ǥ��
-- "Hello, World" --> 'Hello, World'

-- ���ڿ� ����� �÷����� ����
--user id: brown
--user id: cony

SELECT 'user id : ' || userid AS "use rid"
FROM USERS;

SELECT 'SELECT * FROM ' || table_name || ';' AS "QUREY"
FROM USER_TABLES;

-- || --> CONCAT

SELECT CONCAT(CONCAT('SELECT * FROM ' ,table_name ),';')AS "QUREY"
FROM USER_TABLES;

--users�� ���̺��� ��� �࿡ ���ؼ� ��ȸ
--users���� 5���� �����Ͱ� ����

SELECT *
FROM users;

--WHERE �� : ���̺� �����͸� ��ȸ�� �� ���ǿ� �´� �ุ ��ȸ
--ex: userid �÷��� ���� brown�� �ุ ��ȸ
--brown, 'brown' ���� �� �ϱ�!
--�÷�
SELECT *
FROM users
WHERE userid != 'brown';
DESC USERS;

--emp ���̺� �����ϴ� �÷��� Ȯ�� �غ�����.
SELECT *
FROM EMP;

--emp ���̺��� ename �÷� ���� JONES�� �ุ ��ȸ 

SELECT *
FROM EMP
WHERE ename = 'JONES';

SELECT *
FROM emp;
DESC emp;

-- emp ���̺��� deptno(�μ���ȣ) �� 30���� ũ�ų� ���� ����鸸 ��ȸ

SELECT *
FROM emp
WHERE deptno >= 30;

--���ڿ� : '���ڿ�'
--���ڿ� : 50
--��¥ : ??? --> �Լ��� ���ڿ��� �������� ǥ����. ���ڿ��� �̿��ص� ǥ���� ���������� �������� ����
--(�������� ��¥ ǥ�� ����� �ٸ�)
--�ѱ�: �⵵ 4�ڸ�-��2�ڸ�-��2�ڸ�
--�̱�:��2�ڸ�-��2�ڸ�-��4�ڸ�
--�Ի����ڰ� 1980�� 12�� 17�� ������ ��ȸ�ϱ�

SELECT *
FROM emp
WHERE hiredate = '80/12/17';

--TO_DATE : ���ڿ��� date Ÿ������ �����ϴ� �Լ�
--TO_DATE(��¥���� ���ڿ�, ù��°, ������ ����)
--'1980/02/03'

SELECT *
FROM emp
WHERE hiredate = TO_DATE('19801217','YYYYMMDD');
--WHERE hiredate = TO_DATE(1980/12/17, 'YYYY/MM/DD')�� ǥ�����־�� ��. 


--sal �÷��� ���� 1000���� 2000������ ���

SELECT *
FROM emp
WHERE sal >= 1000 
AND sal <= 2000;

--���������ڸ� �ε�ȣ ��ſ� BETWEEN AND �����ڷ� ��ü
SELECT * 
FROM emp
WHERE sal BETWEEN 1000 AND 2000;

--WHERE�� ���� Ǯ���

SELECT hiredate, ename
FROM emp
WHERE hiredate BETWEEN TO_DATE('19820101','YYYYMMDD') AND TO_DATE('19830101','YYYYMMDD');