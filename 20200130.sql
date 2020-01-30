
--DECODE �ȿ� CASE�� DECODE ������ ��ø�� �����ϴ�.

--������ Ǯ��
SELECT ename, job, sal,
        DECODE(job, 'SALESMAN', CASE
                                    WHEN sal > 1400 THEN sal * 1.05
                                    WHEN sal < 1400 THEN sal * 1.1
                                    END,
                    'MANADER', sal * 1.1,
                    'PRESIDENT', sal * 1.2, sal) bonus_sal
FROM emp;

--�� Ǯ��
SELECT ename, job, sal,
       DECODE(job, 'PRESIDENT', sal * 1.2, 
                   'MANAGER',sal * 1.1,
                        CASE 
                            WHEN job = 'SALESMAN' AND sal >= 1400 THEN sal * 1.05
                            WHEN job = 'SALESMAN' AND sal <= 1400 THEN sal * 1.1
                            ELSE sal
                        END 
                )AS "BONUS_SAL"
FROM emp; 

--ĥ������--> DECODE �Ǵ� CASE ���ÿ� 3�� �̻� ��ø���� ����.. ��������


--�ǽ� cond1 //decode

SELECT empno, ename,
DECODE(deptno, 10, 'ACCOUNTING',
               20, 'RESEARCH',
               30, 'SALES',
               40, 'OPERARTION',
               'DDIT')dname
FROM emp;

--�ǽ� cond1 //case

SELECT empno, ename,
    CASE
        WHEN deptno = 10 THEN 'ACCOUNTING'
        WHEN deptno = 20 THEN 'RESEARCH'
        WHEN deptno = 30 THEN 'SALES'
        WHEN deptno = 40 THEN 'OPERARTION'
        ELSE 'DDIT'
    END dname
FROM emp;

--hiredate�� ¦�� : �ǰ����� , Ȧ��: �ǰ����� x

--���� Ǯ�� �� �밡�� ���

SELECT empno, ename, hiredate,
    CASE 
        WHEN hiredate > TO_DATE('1980/01/01','YYYY/MM/DD') AND hiredate < TO_DATE('1980/12/31','YYYY/MM/DD') THEN '�ǰ����� �����'
        WHEN hiredate > TO_DATE('1982/01/01','YYYY/MM/DD') AND hiredate < TO_DATE('1982/12/31','YYYY/MM/DD') THEN '�ǰ����� �����'
        
        WHEN hiredate > TO_DATE('1981/01/01','YYYY/MM/DD') AND hiredate < TO_DATE('1981/12/31','YYYY/MM/DD') THEN '�ǰ����� ������'
        WHEN hiredate > TO_DATE('1983/01/01','YYYY/MM/DD') AND hiredate < TO_DATE('1983/12/31','YYYY/MM/DD') THEN '�ǰ����� ������'
        
    END AS "CONTACT_TO_DOCTOR"
FROM emp;

--������ Ǯ��
--���س⵵�� ¦���� �� �ǰ����� �����
--      �Ի�⵵�� ¦���� �� �˰����� �����
--      �Ի�⵵�� Ȧ���� �� �˰����� ������
--���س⵵�� Ȧ���̸�
--      �Ի�⵵�� ¦���� �� �˰����� ������
--      �Ի�⵵�� Ȧ���� �� �˰����� �����

--���س⵵�� ¦������ Ȧ������ Ȯ��
--DATEŸ�� - > ���ڿ�(�������� ����, yyyy-mm-dd hh24:mi:ss)
--¦�� -> 2�� ������ �� ������ 0
--Ȧ�� -> 2�� ������ �� ������ 1
-- % 2 <�ѻ�� ������... ����Ŭ�� ���� -> MOD �Լ��� �������!

SELECT MOD(TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')),2)
FROM dual; --> ���س⵵�� ¦���̴�.

---------------------------------------------------------------------�Ʒ����� Ʋ����--------
--CASE�� Ǯ��
SELECT empno, ename, hiredate,
    CASE 
        WHEN MOD(TO_NUMBER(TO_CHAR(hiredate,'YYYY')),2) = 0 THEN '�ǰ����� �����'
        WHEN MOD(TO_NUMBER(TO_CHAR(hiredate,'YYYY')),2) = 1 THEN '�ǰ����� ������'
    END AS "CONTACT_TO_DOCTOR"
FROM emp;


--DECODE�� Ǯ��
SELECT empno, ename, hiredate,
DECODE(MOD(TO_NUMBER(TO_CHAR(hiredate,'YYYY')),2), 0, '�ǰ����� �����',
                                                   1, '�ǰ����� ������'
            )AS "CONTACT_TO_DOCTOR"
FROM emp;

--DECODE�� Ǯ�� - TO_NUMBER ��������-> ������ ����ȯ
SELECT empno, ename, hiredate
DECODE(MOD(TO_CHAR(hiredate,'YYYY'),2), 0, '�ǰ����� �����',
                                        1, '�ǰ����� ������'
            )AS "CONTACT_TO_DOCTOR"
FROM emp;

--������ ��--

--DECODE�� Ǯ�� - TO_NUMBER ��������-> ������ ����ȯ
SELECT empno, ename, hiredate,
        MOD(TO_NUMBER(TO_CHAR(hiredate,'YYYY')), 2) hire,
        MOD(TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')), 2),
        CASE
            WHEN MOD(TO_NUMBER(TO_CHAR(hiredate,'YYYY')),2) = MOD(TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')),2)
                    THEN '�ǰ����� �����'
                ELSE '�ǰ����� ������'
            END CONTACT_TO_DOCTOR,
            DECODE(MOD(TO_NUMBER(TO_CHAR(hiredate, 'YYYY')), 2),
                MOD(TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')),2),'�ǰ����� �����', '�ǰ����� ������') con2
FROM emp;

--������ ���� ���� ����

--DECODE�� Ǯ�� - TO_NUMBER ��������-> ������ ����ȯ
SELECT empno, ename, hiredate,
        CASE
            WHEN MOD(TO_NUMBER(TO_CHAR(hiredate,'YYYY')),2) = MOD(TO_NUMBER(TO_CHAR(SYSDATE,'YYYY')),2)
                    THEN '�ǰ����� �����'
                ELSE '�ǰ����� ������'
            END CONTACT_TO_DOCTOR
FROM emp;

---------------------------------------------------------------------������ Ʋ����--------�ٽ�Ǯ���!!

SELECT *
FROM emp;

SELECT *
FROM dept;

--GROUP BY ���� ���� ����
--�μ���ȣ ���� ROW ���� ���� ���: GROUP BY deptno
--�������� ���� ROW ���� ���� ���: GROUP BY job
--MGR�� ���� �������� ���� ROW���� ���� ���: GROUP BY mgr, job

--�׷��Լ��� ����
--SUM :�հ�
--COUNT : ���� - NULL���� �ƴ� ROW�� ����
--MAX : �ִ밪
--MIN : �ּҰ�
--AVE : ���


--�׷��Լ��� Ư¡
--�ش� �÷��� Null ���� ã�� Row�� ������ ��� �ش� ���� �����ϰ� ����Ѵ�. (NULL ������ ����� null)
--�μ��� �޿� ��
SELECT deptno,SUM(sal) sum_sal, MAX(sal) max_sal, MIN(sal), ROUND(AVG(sal),2), COUNT(sal)
FROM emp
GROUP BY deptno;

--�׷��Լ� ������
--GROUP BY ���� ���� �÷� �̿��� �ٸ� �÷��� SELECT���� ǥ���Ǹ� ������ ���´�. �߿�!!

SELECT deptno,ename, SUM(sal) sum_sal, MAX(sal) max_sal, MIN(sal), ROUND(AVG(sal),2), COUNT(sal)
FROM emp
GROUP BY deptno;



--GROUP BY ���� ���� ���¿��� �׷��Լ��� ����Ѱ��
--��ü ���� �ϳ� ������ ���´�. 
SELECT SUM(sal) sum_sal, MAX(sal) max_sal, MIN(sal), ROUND(AVG(sal),2), 
       COUNT(sal), --sal �÷��� ���� null �� �ƴ� row�� ����
       COUNT(comm), --comm �÷��� ���� null �� �ƴ� row�� ����
       COUNT(*) --����� �����Ͱ� �ִ���(count �� Ư���ϰ� * �� �� �� �ִ�. )
FROM emp;

--GROUP BY ������ empno �̸� ������� ���?? --����� �ߺ��Ǵ� ���� �����Ƿ� ��� ���� ���´�. 
SELECT SUM(sal) sum_sal, MAX(sal) max_sal, MIN(sal), ROUND(AVG(sal),2), 
       COUNT(sal) cn, --sal �÷��� ���� null �� �ƴ� row�� ����
       COUNT(comm) cn, --comm �÷��� ���� null �� �ƴ� row�� ����
       COUNT(*) cn--����� �����Ͱ� �ִ���(count �� Ư���ϰ� * �� �� �� �ִ�. )
FROM emp
GROUP BY empno;

--�̷��� �ٲ� ����? �׷�������� ������ �ʴ� ���� SELECT ���� ������ ������� �ߴµ�. �� ������ �ƴұ�?
--�׷�ȭ�� ���þ��� ������ ���ڿ�, �Լ�, ���� ���� SELECET ���� ������ ���� ����
SELECT 1, SYSDATE,'ACCOUNTNG', SUM(sal) sum_sal, MAX(sal) max_sal, MIN(sal), ROUND(AVG(sal),2), 
       COUNT(sal) cn, --sal �÷��� ���� null �� �ƴ� row�� ����
       COUNT(comm) cn, --comm �÷��� ���� null �� �ƴ� row�� ����
       COUNT(*) cn--����� �����Ͱ� �ִ���(count �� Ư���ϰ� * �� �� �� �ִ�. )
FROM emp
GROUP BY empno;


-- SINGLE ROW FUNCTION�� ��� WHERE ������ ����ϴ� ���� �����ϳ�
-- MULTI ROW FUNCTION �� ��� WHRER ������ ����ϴ� ���� �Ұ��� �ϰ�
-- HAVING ������ ������ ����Ѵ�.
-- �μ��� �޿� �� ��ȸ

--deptno, �޿���, �� �޿����� 9000�̻��� row �� ��ȸ

SELECT deptno, SUM(sal) sum_sal
FROM emp
GROUP BY deptno
HAVING SUM(sal) > 9000;

------�ǽ� grp1
SELECT MAX(sal)AS "MAX_SAL",
       MIN(sal)AS "MIN_SAL", 
       ROUND(AVG(sal),2)AS "AVG_SAL", 
       SUM(sal)AS "SUM_SAL", 
       COUNT(sal)AS "COUNT_SAL", 
       COUNT(mgr)AS "COUNT_MGR",
       COUNT(*)AS "COUNT_ALL"
FROM emp;


------�ǽ� grp2

SELECT 
       deptno, --�̰� ������ �ϸ� � �������� �˱� ����ϱ� �Ϲ������δ� �� �ִ´�. 
       MAX(sal)AS "MAX_SAL",
       MIN(sal)AS "MIN_SAL", 
       ROUND(AVG(sal),2)AS "AVG_SAL", 
       SUM(sal)AS "SUM_SAL", 
       COUNT(sal)AS "COUNT_SAL", 
       COUNT(mgr)AS "COUNT_MGR",
       COUNT(*)AS "COUNT_ALL"
FROM emp
GROUP BY deptno;

------�ǽ� grp3


SELECT 
       DECODE(deptno, 10, 'ACCOUNTING',
                      20, 'RESEARCH',
                      30, 'SALES'
                      )dname , --�̰� ������ �ϸ� � �������� �˱� ����ϱ� �Ϲ������δ� �� �ִ´�. 
       MAX(sal)AS "MAX_SAL",
       MIN(sal)AS "MIN_SAL", 
       ROUND(AVG(sal),2)AS "AVG_SAL", 
       SUM(sal)AS "SUM_SAL", 
       COUNT(sal)AS "COUNT_SAL", 
       COUNT(mgr)AS "COUNT_MGR",
       COUNT(*)AS "COUNT_ALL"
FROM emp
GROUP BY deptno --> ���⿡ DECODE�� �ֱ⵵ ��...
ORDER BY deptno; --< ORDER BY�� ����� ���� �ǳ�!!!
------�ٸ� ������� Ǯ���
SELECT  --�̰� ������ �ϸ� � �������� �˱� ����ϱ� �Ϲ������δ� �� �ִ´�. 
       MAX(sal)AS "MAX_SAL",
       MIN(sal)AS "MIN_SAL", 
       ROUND(AVG(sal),2)AS "AVG_SAL", 
       SUM(sal)AS "SUM_SAL", 
       COUNT(sal)AS "COUNT_SAL", 
       COUNT(mgr)AS "COUNT_MGR",
       COUNT(*)AS "COUNT_ALL"
FROM emp
GROUP BY DECODE(deptno, 10, 'ACCOUNTING',20, 'RESEARCH',30, 'SALES');


-------------
---grp4 �ǽ�
--ORACLE 9i���������� GROUP BY ���� ����� �÷����� ������ ����
--ORACLE 10i���������� GROUP BY ���� ����� �÷����� ������ �������� �ʴ´�(GROUP BY ����� �ӵ� UP)

SELECT TO_CHAR(hiredate,'YYYYMM')AS "HIRE_YYYY" ,
      COUNT(*) AS CNT
FROM emp
GROUP BY TO_CHAR(hiredate, 'YYYYMM')
ORDER BY TO_CHAR(hiredate, 'YYYYMM');

---grp5 �ǽ�

SELECT TO_CHAR(hiredate,'YYYY')AS "HIRE_YYYY" ,
      COUNT(*) AS CNT
FROM emp
GROUP BY TO_CHAR(hiredate, 'YYYY');

---grp6 �ǽ�

SELECT COUNT(*)
FROM dept;
-------????????


---grp7 �ǽ�
--������ ��
SELECT COUNT(*)
FROM  
    (SELECT deptno
       FROM emp
       GROUP BY deptno);
  

--���� ǯ

SELECT COUNT(COUNT(deptno)) CNT
FROM emp
GROUP BY deptno;

--C���� ���� ����Ʈ: �迭, ������, ���� �����
--�����ͺ��̽������� ����Ʈ: GROUP BY(���ù���), JOIN (���Ϲ���)
