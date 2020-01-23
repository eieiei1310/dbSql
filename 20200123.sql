--WHERE2
--WHERE ���� ����ϴ� ���ǿ� ������ ��ȸ ����� ������ ��ġ�� �ʴ´�.
--SQL�� ������ ������ ���� �ִ�. (���� ������ ����.)
--���� : Ű�� 185 �̻��̰� �����԰� 70kg �̻��� ������� ����
--  --> �����԰� 70kg �̻��̰� Ű�� 185cm �̻��� ������� ����
-- ������ Ư¡: ���տ��� ������ ����.
-- (1, 5, 10) --> (10, 5, 1) : �� ������ ���� �����ϴ�
-- ���̺��� ������ ������� ����
--SEKECT ����� ������ �ٸ����� ���� �����ϸ� ����
--> ���ı�� ����(ORDER BY)
--  �߻��� ����� ���� --> ����x 

SELECT ename, hiredate
FROM EMP
WHERE hiredate >= TO_DATE('19820101','YYYYMMDD')
AND hiredate <= TO_DATE('19830101','YYYYMMDD');

--IN ������
-- Ư�� ���տ� ���ԵǴ��� ���θ� Ȯ��
-- �μ���ȣ�� 10�� Ȥ�� 20���� ���ϴ� ���� ��ȸ�ϱ�

SELECT empno, ename, deptno
FROM emp
WHERE deptno >= 10
AND deptno <= 20; --���� �μ���ȣ�� 15���� �� �ִٸ�?
--���±��� ��� �����δ� ��Ȯ�� ���� ã�� �� ����.
--�׷��� �ʿ��� �� IN!

SELECT empno, ename, deptno
FROM emp
WHERE deptno IN (10, 20);

--IN �����ڸ� ������� �ʰ� OR ������ ���

SELECT empno, ename, deptno
FROM emp
WHERE deptno = 10
OR deptno = 20;

-- emp ���̺��� ��� �̸��� SMITH, JONES�� ������ ��ȸ(empno, ename, deptno)
SELECT empno, ename, deptno
FROM emp
WHERE ename IN ('SMITH', 'JONES');

SELECT empno, ename, deptno
FROM emp
WHERE ename = 'SMITH'
OR ename = 'JONES';


--��ü �����͸� ��ȸ�ϴ� �Ͱ� ���� ����� ���´�. 
SELECT *
FROM users
WHERE userid = userid;

SELECT userid AS ���̵�, usernm AS �̸�
FROM users
WHERE userid = 'brown'
OR userid = 'cony'
OR userid = 'sally';
--where3
--users ���̺��� userid�� brown, cony, sally�� �����͸� ������ ���� ��ȸ�Ͻÿ�.

SELECT userid AS ���̵�, usernm AS �̸�, alias AS ����
FROM users
WHERE userid IN ('brown', 'cony' , 'sally');

SELECT *
FROM users;

--���ڿ� ��Ī ������: LIKE, %
--������ ������ ������ ���ڿ� ��ġ�� ���ؼ� �ٷ�
--�̸��� BR�� �����ϴ� ����� ��ȸ
--�̸��� R ���ڿ��� ���� ����� ��ȸ

SELECT *
FROM emp;

--��� �̸��� S�� �����ϴ� ����� ��ȸ�غ���
--SMITH, SCOTT
--% => � ���ڿ�(�ѱ���, ���ڰ� �������� �ְ�, ���� ���ڿ��� �� ���� �ִ�.)

SELECT *
FROM emp
WHERE ename LIKE 'S%';

--���ڼ��� ������ ���� ��Ī
-- ��Ȯ�� �ѹ���
-- ex���� �̸��� s�� �����ϰ� �̸��� ��ü ���̰� 5���� �� ����
--S____

SELECT *
FROM emp
WHERE ename LIKE 'S____';


--��� �̸��� S���ڰ� ���� ��� ��ȸ
-- ename LIKE '%S%';
SELECT *
FROM emp
WHERE ename LIKE '%S%';

--where �ǽ� 4

SELECT mem_id, mem_name
FROM MEMBER
WHERE mem_name LIKE '��%';

--where �ǽ� 5

SELECT mem_id, mem_name
FROM MEMBER
WHERE mem_name LIKE '%��%';

--NULL �� ���� (IS)
--COMM Į���� ���� NULL�� �����͸� ��ȸ(WHERE COMM = NULL)
SELECT *
FROM EMP
WHERE comm = null;

SELECT *
FROM EMP
WHERE comm = '';
-->�� �� �ȵ�. null���� ��ȸ�� ���� IS��� �ϴ� Ư�� �����ڸ� �̿��ؾ� ��.

SELECT *
FROM EMP
WHERE comm IS null;

-- is null where �ǽ� 6
--null���� �ִ� ���� ��ȸ�غ��ÿ�
SELECT *
FROM EMP
WHERE comm IS NULL;

--null���� ���� ���� ��ȸ�غ��ÿ�
SELECT *
FROM EMP
WHERE comm >= 0
OR comm <= 0;

--����� �����ڰ� 7698, 7839 �׸��� null�� �ƴ� ������ ��ȸ

SELECT *
FROM EMP
WHERE mgr NOT IN (7698, 7839 ,NULL);

--NOT IN �����ڿ��� NULL ���� ���� ��Ű�� �ȵȴ�.
--> -->

SELECT *
FROM EMP
WHERE mgr NOT IN (7698, 7839)
AND mgr IS NOT NULL;

--  where �ǽ� 7

SELECT *
FROM EMP
WHERE job = 'SALESMAN'
AND hiredate >= TO_DATE('19810601','YYYYMMDD');

--  where �ǽ� 8

SELECT *
FROM EMP
WHERE hiredate >= TO_DATE('19810601','YYYYMMDD')
AND deptno <> 10;

-- where �ǽ� 9

SELECT *
FROM EMP
WHERE hiredate >= TO_DATE('19810601','YYYYMMDD')
AND deptno NOT IN (10);

-- where �ǽ� 10

SELECT *
FROM EMP
WHERE deptno IN (20, 30)
AND hiredate >= TO_DATE('19810601','YYYYMMDD');

-- where �ǽ� 11

SELECT *
FROM EMP
WHERE job = 'SALESMAN'
OR hiredate >= TO_DATE('19810601','YYYYMMDD');

-- where �ǽ� 12

SELECT *
FROM EMP
WHERE job = 'SALESMAN'
OR empno LIKE '78%';

-- where �ǽ� 13

SELECT *
FROM EMP
WHERE job = 'SALESMAN'
OR empno >= 7800 AND empno < 7900;

--������ �켱����
-- *,/ �����ڰ� +,-���� �켱������ ����.
-- �켱���� ���� : ()
-- AND > OR 

--emp ���̺��� ��� �̸��� SMITH �̰ų� ��� �̸��� ALLEN �̸鼭 �������� SALESMAN �� ��� ��ȸ
        
SELECT *
FROM EMP
WHERE ename = 'SMITH' 
OR( ename = 'ALLEN' AND job = 'SALESMAN');

--��� �̸��� SMITH �̰ų� ALLEN �̸鼭 
--�������� SALSMAN�� ������ ��ȸ

SELECT *
FROM EMP
WHERE (ename = 'SMITH' OR ename = 'ALLEN')
AND job = 'SALESMAN';

--WHERE �ǽ� 14

SELECT *
FROM EMP
WHERE job = 'SALESMAN' 
OR empno LIKE '78%' AND hiredate > TO_DATE('1981/06/01','YYYY/MM/DD');

--����
--SELECT *
--FROM table
--ORDER BY (�÷�|��Ī [ASC | DESC], .....)

-- emp ���̺��� ��� ����� ename �÷� ���� �������� �������� ������ ����� ��ȸ�ϼ���.

SELECT *
FROM EMP
ORDER BY ename ASC; --(ASC�� �⺻�̹Ƿ� �Ƚᵵ �ȴ�.)

-- emp ���̺��� ��� ����� ename �÷� ���� �������� �������� ������ ����� ��ȸ�ϼ���.

SELECT *
FROM EMP --DESC : DESCRIBE (�����ϴ�)
ORDER BY ename DESC; -- DESC : DESCENDING (��������)

--EMP ���̺��� ��� ������ ename �÷����� ��������, ename ���� ���� ��� mgr �÷����� �������� �����ϱ�

SELECT *
FROM EMP 
ORDER BY ename DESC, mgr ; 


--���Ľ� ��Ī�� ���

SELECT empno, ename nm , sal*12 year_sal
FROM EMP 
ORDER BY year_sal;

--���Ľ� ��Ī�� ���(2)

--�������̴� ������ ������ �÷��� �����ʹ� ���x 
--���������� ������ �ű��ڸ� enpno - 1, nm �� 2, ye..�� 3�̴�.
--sql column index : 1���� ������(�ڹٶ� �޶�!)

SELECT empno, ename nm , sal*12 year_sal
FROM EMP 
ORDER BY 3; --year_sal �� �������� �����Ѵ�.

--orderby �ǽ�1

SELECT *
FROM DEPT 
ORDER BY dname;

SELECT *
FROM DEPT 
ORDER BY loc DESC;

--orderby �ǽ�2

SELECT *
FROM EMP
WHERE comm > 0 
ORDER BY comm DESC, empno ASC;

SELECT *
FROM EMP
WHERE comm NOT IN (0) --NOT IN �Ẹ��
ORDER BY comm DESC, empno ASC;


--orderby �ǽ�3

SELECT *
FROM EMP
WHERE mgr IS NOT NULL
ORDER BY job , empno DESC;


