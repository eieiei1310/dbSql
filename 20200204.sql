CROSS JOIN 
dept ���̺�� emp ���̺��� ������ �ϱ� ���� FROM ���� �ΰ��� ���̺��� ���
where ���� �� ���̺��� ���� ������ ����;

SELECT *
FROM dept;
-->4��
SELECT *
FROM emp;
-->14��

SELECT dept.dname, emp.empno, emp.ename
FROM dept, emp;
--> 56���� �����Ͱ� ����

SELECT dept.dname, emp.empno, emp.ename--, dept.deptno
FROM dept, emp
WHERE dept.deptno = 10;
--> 14���� �����Ͱ� ���� (������ �̷��� �ϴ� �ͺ��� ���� ������ ��Ȯ�� ����ϴ� ���� ����)


CROSS JOIN--> ī�ͼ� ���δ�Ʈ (Cartesian product)
�����ϴ� �� ���̺��� ���� ������ �����Ǵ� ���
������ ��� ���տ� ���� ����(����)�� �õ�,
dept(4��), emp(14)�� CROSS JOIN �� ����� 4* 14 = 56��

dept ���̺�� emp ���̺��� ������ �ϱ� ���� FROM ���� �ΰ��� ���̺��� ���;
-->������ ��ü�� ���⺸�ٴ� ����, ������ ���� ���� ���� ���


 CROSS JOIN �ǽ�1;

SELECT  *
FROM customer, product;

 SUBQUERY : ���� �ȿ� �ٸ� ������ �� �ִ� ���
    SUBQUERY�� ���� ��ġ�� ���� 3������ �з�
    - SELECT �� : SCALA SUBQUERY --�ϳ��� ��, �ϳ��� �÷��� �����ؾ� ������ �߻����� ����.
    - FROM �� : INLINE - VIEW 
    - WHERE �� : SUBQUERY 
SMITH�� ���� �μ��� ���ϴ� �������� ������ ��ȸ
1. SMITH�� ���ϴ� �μ� ��ȣ�� ���Ѵ�.
2. 1������ ���� �μ� ��ȣ�� ���ϴ� �������� ������ ��ȸ�Ѵ�.

1.;
SELECT deptno
FROM emp
WHERE ename = 'SMITH';

2. 1������ ���� �μ���ȣ�� �̿��Ͽ� �ش� �μ��� ���ϴ� ���� ������ ��ȸ;
SELECT *
FROM emp
WHERE deptno = 20;
-->���ϴ� ����� ��� ���� �ι��� ������ �ۼ��Ͽ���.

SUBQUERY�� �̿��ϸ� �ΰ��� ������ ���ÿ� �ϳ��� SQL�� ������ �����ϴ�;

SELECT *
FROM emp
WHERE deptno = (SELECT deptno
                FROM emp
                WHERE ename = 'SMITH');
                
                
SUBQUERY �ǽ� 1;
1.��� �޿� ���ϱ�
2. ���� ��� �޿����� ���� �޿��� �޴� ���;

SELECT COUNT(*)
FROM emp
WHERE sal > (SELECT AVG(sal)
             FROM emp);
-->WHERE ���� ���������� �޿� ����� �ִ´�. 

SUBQUERY �ǽ� 2;

SELECT empno,ename, job, mgr,hiredate, sal, comm, deptno
FROM emp
WHERE sal > (SELECT AVG(sal)
             FROM emp);
             
���� �� ������
IN : ���������� ���� �� �� ��ġ�ϴ� ���� ������ ��
ANY (Ȱ�뵵�� �ټ� ������) : ���������� ���� �� �� �� ���̶� ������ ������ ��
ALL (Ȱ�뵵�� �ټ� ������) : ���������� ���� �� �� ��� ������ ������ ��

�������� - SMITH�� ���ϴ� �μ��� ��� ������ ��ȸ
-->SMITH�� WARD ������ ���ϴ� �μ��� ��� ������ ��ȸ

SELECT deptno
FROM emp
WHERE ename IN ('SMITH','WARD');

���������� ����� ���� ���� ���� = �����ڸ� ����� �� ����;

SELECT *
FROM emp
WHERE deptno IN (SELECT deptno
                 FROM emp
                 WHERE ename IN ('SMITH','WARD'));
                 
SMITH, WARD ����� �޿����� �޿��� ���� ������ ��ȸ
(SMITH, WARD�� �޿� �� �ƹ� ���̳�)
SMITH : 800
WARD : 1250
-->1250���� ���� ���;
;
SELECT *
FROM emp
WHERE sal < ANY (800 , 1250);

SELECT sal
FROM emp
WHERE ename IN ('SMITH','WARD');

SELECT *
FROM emp
WHERE sal < ANY (SELECT sal
                 FROM emp
                 WHERE ename IN ('SMITH','WARD'));

SMITH, WARD ����� �޿����� �޿��� ���� ������ ��ȸ
(SMITH, WARD�� �޿� 2���� ��ο� ���� ���� ��.);

SMITH : 800
WARD : 1250
-->1250���� ���� ���;

SELECT *
FROM emp
WHERE sal > ALL (SELECT sal
                 FROM emp
                 WHERE ename IN ('SMITH','WARD'));

IN, NOT IN �� NULL �� ���õ� ���� ����;


������ ������ ����� 7566�̰ų�(OR) null;
IN �����ڴ� OR �����ڷ� ġȯ �����ϴ�.

SELECT *
FROM emp
WHERE mgr IN (7902, null); 

NULL �񱳴� =�����ڰ� �ƴ϶� IS NULL �� �ؾ� ������, IN�����ڴ� =�� ����Ѵ�;
--> NULL ������ ����
SELECT *
FROM emp
WHERE mgr = 7902
OR mgr = null;  

NOT IN (7902, NULL) ==> AND �� �ؼ�
�����ȣ�� 7902�� �ƴϸ鼭 (AND) NULL�� �ƴ� ������;
SELECT *
FROM emp
WHERE empno NOT IN (7902, NULL);

SELECT *
FROM emp
WHERE empno !=7902
AND   empno != NULL; -->null�� ���� ������ �׻� null. ���� �� ���´�.

SELECT *
FROM emp
WHERE empno !=7902
AND   empno IS NOT NULL; --> IS�� �ٲ۴�.

PAIRWISE(������)
�������� ����� ���ÿ� ������ų �� ;
(mgr, deptno);
(7698, 30), (7639, 10);

SELECT *
FROM emp
WHERE (mgr, deptno) IN 
                        (SELECT mgr, deptno
                        FROM emp
                        WHERE empno IN (7499,7782));

--non-pairwise�� �������� ���ÿ� ������Ű�� �ʴ� ���·� �ۼ�
--mgr ���� 7698 �̰ų� 7839 �̸鼭
--deptno �� 10���̰ų� 30���� ����.
MGR, DEPTNO
(7698,10), (7698, 30)
(7839,10), (7839, 30);

SELECT *
FROM emp
WHERE mgr IN (SELECT mgr
                FROM emp
                WHERE empno IN (7499,7782))
AND mgr IN (SELECT deptno
                FROM emp
                WHERE empno IN (7499,7782)); -->���Ⱑ �� �̰���? �� �� ���� ���ѵ�
                
                
��Į�� �������� : SELECT ���� ���, 1���� ROW, 1���� COL�� ��ȸ�ϴ� ����;
��Į�� ���������� MAIN ������ �÷��� ����ϴ� �� �����ϴ�. 


SELECT SYSDATE 
FROM dual;

SELECT (SELECT SYSDATE
        FROM dual), dept.*
FROM dept;

SELECT (SELECT SYSDATE FROM dual), dept.* --> ��Į�� �������������� �׳� ���ٷ� ���⵵ �Ѵ�.
FROM dept;

SELECT empno, ename, deptno, 
       (SELECT dname 
        FROM dept 
        WHERE deptno = emp.deptno) dname--�μ���
        --���߿� �δ��� �� �� �ֱ� ������ �׳� ������ �ϴ� �� �� ����.
FROM emp;

INLINE VIEW : FROM ���� ����Ǵ� ��������;

MAIN ������ �÷��� SUBQUERY ���� ��� �ϴ��� ������ ���� �з�
��� �Ұ�� : CORRELATEED SUBQUERY (��ȣ ���� ����), ���������� �ܵ����� �����ϴ� ���� �Ұ����ϴ�.
            ��������� �������ִ�(main - > sub)
������� ���� ��� : non-correlated subquery(�� ��ȣ ���� ��������) , ���������� �ܵ����� �����ϴ� ���� �����ϴ�.
            ��������� ������ ���� �ʴ�. (main -> sub, sub->main)
��� ������ �޿� ��պ��� �޿��� ���� ����� ��ȸ;

SELECT *
FROM emp
WHERE sal > ( SELECT AVG(sal)
              FROM emp );



������ ���� �μ��� �޿� ��պ��� �޿��� ���� ����� ��ȸ;
�μ��� �޿� ��պ��� ���غ���
--���� �Ѱ�
SELECT *
FROM emp
WHERE sal > ( SELECT AVG(sal)
              FROM emp );
       
--�μ��� �޿� ���
SELECT AVG(sal)
FROM emp
GROUP BY deptno ; �� �� Ʋ������????;
             
--������ ���� �μ��� �޿� ��պ��� �޿��� ���� ����� ��ȸ
SELECT *
FROM emp m
WHERE sal > ( SELECT AVG(sal)
              FROM emp s
              WHERE s.deptno = m.deptno);
       

���� ������ ������ �̿��ؼ� Ǯ���
1. ���� ���̺� ����
   emp, �μ��� �޿� ���(inline view)

SELECT emp.ename, sal, dept_sal.*
FROM emp, (SELECT deptno, ROUND(AVG(sal)) avg_sal
           FROM emp 
           GROUP BY deptno) dept_sal
WHERE emp.deptno = dept_sal.deptno
AND emp.sal > dept_sal.avg_sal;


--���������� Ǯ���

--�ǽ� SUB4
������ �߰�;
INSERT INTO dept VALUES (99,'ddit','deajeon');
COMMIT;

--Ŭ���̾�Ʈ�� ���� : ���������� ����
INSERT ��
ROLLBACK; : Ʈ����� ���
COMMIT; : Ʈ����� Ȯ��

--�ǽ� SUB4;

SELECT *
FROM dept;
SELECT *
FROM emp;


SELECT 
FROM NOT IN ;

SELECT emp.deptno, dname, loc
FROM emp JOIN dept ON(emp.deptno = dept.deptno);
--267�� join���ε� �ٲ� �� �־�� �Ѵ�.


