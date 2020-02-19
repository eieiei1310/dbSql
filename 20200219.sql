���� ������ �м��Լ��� ����ؼ� ǥ���ϸ�....;

SELECT ename, sal, deptno, ROW_NUMBER() OVER (PARTITION BY deptno ORDER BY sal DESC) rank
FROM emp;

-----------------
���� ��-

���� ���� ��� 11��
����¡ ó��(�������� 10���� �Խñ�)
1������ : 1~10
2����¡ : 11~20
���ε庯�� : page, :pageSize;
SELECT *
FROM
(SELECT a.*, ROWNUM rn
    FROM
    (SELECT seq, 
           LPAD(' ', (LEVEL-1)*4) || title title, 
           DECODE(parent_seq, NULL, seq, parent_seq) root
    FROM board_test
    START WITH parent_seq IS NULL
    CONNECT BY PRIOR seq = parent_seq
    ORDER SIBLINGS BY root DESC, seq ASC) a)
WHERE rn BETWEEN (:page -1) * :pageSize + 1 AND :page * :pageSize ;

--> ���� ����� ���� ����¡ó�� �غ�

-------------------------�м��Լ�--------

���� ������ �м��Լ��� ����ؼ� ǥ���ϸ�....;
�μ��� �޿� ��ŷ;


SELECT ename, sal, deptno, ROW_NUMBER() OVER (PARTITION BY deptno ORDER BY sal DESC) rank
FROM emp;

�м��Լ� ����
�м��Լ���([����] OVER ([PARTITION BY �÷�][ORDER BY �÷�][WINDOWING])
PARTITION BY �÷� : �ش� �÷��� ���� ROW ���� �ϳ��� �׷����� ���´�;
ORDER BY �÷� : PARTITION BY �� ���� ���� �׷� ������ ORDER BY �÷����� �����ϰڴ�.

ROW_NUMBER() OVER (PARTITION BY deptno ORDER BY sal DESC) rank;

���� ���� �м��Լ�
RANK() : ���� ���� ���� �� �ߺ� ������ ����, �ļ����� �ߺ� ����ŭ ������ ������ ����.
        2���� 2���̸� 3���� ���� 4����� �ļ����� �����ȴ�. 
DENSE_RANK() : ���� ���� ���� �� �ߺ� ������ ����, �ļ����� �ߺ� ���� �������� ����
            2���� 2���̴��� �ļ����� 3����� ����
ROW_NUMBER() : ROWNUM �� ����, �ߺ��� ���� ������� ����.


�μ���, �޿� ������ 3���� ��ŷ ���� �Լ��� ����;

SELECT ename, sal, deptno,
        RANK() OVER (PARTITION BY deptno ORDER BY sal) sal_rank,
        DENSE_RANK() OVER (PARTITION BY deptno ORDER BY sal) sal_dense_rank,
        ROW_NUMBER() OVER (PARTITION BY deptno ORDER BY sal) sal_row_number
FROM emp;

SELECT SUM(sal)
FROM emp;

-----------ana 1 �ǽ�

SELECT ename, sal, deptno,
     RANK() OVER(ORDER BY sal, empno) sal_rank,
     DENSE_RANK() OVER (ORDER BY sal, empno) sal_dense_rank,
     ROW_NUMBER() OVER (ORDER BY sal, empno) sal_row_number
FROM emp ;

�׷��Լ� : ��ü ���� ��
SELECT COUNT(*)
FROM emp;

ana1 : ��� ��ü �޿� ����
�м��Լ����� �׷� : PARTITION BY

-----------ana 2 �ǽ�
---------����(Ʋ��)
SELECT empno, ename, deptno
FROM emp a
ORDER BY deptno;

SELECT *
FROM
(SELECT COUNT(deptno)
FROM emp
GROUP BY deptno)cnt;


-----------������ Ǯ��
SELECT empno, ename, emp.deptno, cnt
FROM emp,
    (SELECT deptno, COUNT(*) cnt
     FROM emp
     GROUP BY deptno) dept_cnt
WHERE emp.deptno = dept_cnt.deptno
ORDER BY deptno;


������ �м��Լ� (GROUP �Լ����� �����ϴ� �Լ� ������ ����)
SUM(�÷�)
COUNT(*), COUNT(�÷�),
MIN(�÷�)
MAX(�÷�)
AVG(�÷�)

no_ana2�� �м��Լ��� ����Ͽ� �ۼ�;
�μ��� ���� �� ;

SELECT empno, ename, deptno, COUNT(*) OVER (PARTITION BY deptno) cnt
FROM emp;

�м��Լ� /window �Լ� �ǽ�(ana2);

SELECT  empno, ename, deptno, sal, ROUND(AVG(sal) OVER (PARTITION BY deptno),2) avg_sal
FROM emp

�м��Լ� /window �Լ� �ǽ�(ana3);

SELECT empno, ename, deptno, sal, MAX(sal) OVER (PARTITION BY deptno) cnt
FROM emp;

�м��Լ� /window �Լ� �ǽ�(ana4);
SELECT empno, ename, deptno, sal, MIN(sal) OVER (PARTITION BY deptno) cnt
FROM emp;

----PPT 115

�޿��� �������� �����ϰ�, �޿��� ���� ���� ��������� ���� �켱������ �ǵ��� �����Ͽ�
���� ���� ���� ��(LEAD)�� SAL �÷��� ���ϴ� ���� �ۼ�

SELECT empno, ename, hiredate, sal, LEAD(sal) OVER(ORDER BY sal DESC, hiredate) lead_sal
FROM emp;

ana5;
SELECT empno, ename, hiredate, sal, LAG(sal) OVER(ORDER BY sal DESC, hiredate) lag_sal
FROM emp;


ana6;
��� ����� ����, ������(job)�� �޿� ������ 1�ܰ� ���� ���
(�޿��� ���� ��� �Ի����� ���� ����� ���� ����);

SELECT empno, ename, hiredate, job, sal, �Ѵܰ� ���� ����� ����
FROM emp;

SELECT empno, ename, hiredate, job, sal, LAG(sal) OVER(PARTITION BY job ORDER BY sal DESC, hiredate) lag_sal
FROM emp;


�ǽ� no_ana3
SELECT a.empno, a.ename, a.sal, rownum rn
FROM 
    (SELECT empno, ename, sal
    FROM emp
    ORDER BY sal, empno)a;
    
    
SELECT lv
FROM 
(SELECT level lv
FROM dual
CONNECT BY LEVEL <= 14);


SELECT empno, ename, sal ,SUM(sal)
FROM 
(SELECT a.empno, a.ename, a.sal, rownum rn
FROM 
    (SELECT empno, ename, sal
    FROM emp
    ORDER BY sal, empno)a)
GROUP BY ROLLUP(empno, ename, sal);


---------------�� Ǯ��(Ʋ�� ��)
SELECT * 
FROM (SELECT a.empno, a.ename, a.sal, rownum rn
      FROM 
            (SELECT empno, ename, sal
            FROM emp
            ORDER BY sal, empno)a) a1,
      (SELECT lv
        FROM 
            (SELECT level lv
            FROM dual
            CONNECT BY LEVEL <= 14))b;
--RN, LV -1
SELECT *
FROM
(SELECT * 
FROM (SELECT a.empno, a.ename, a.sal, rownum rn
      FROM 
            (SELECT empno, ename, sal
            FROM emp
            ORDER BY sal, empno)a) a1,
    (SELECT lv
    FROM 
    (SELECT level lv
    FROM dual
    CONNECT BY LEVEL <= 14))b
WHERE rn = 1 AND lv = 1)

UNION ALL

(SELECT * 
FROM (SELECT a.empno, a.ename, a.sal, rownum rn
      FROM 
            (SELECT empno, ename, sal
            FROM emp
            ORDER BY sal, empno)a) a1,
    (SELECT lv
    FROM 
    (SELECT level lv
    FROM dual
    CONNECT BY LEVEL <= 14))b
WHERE rn IN (1,2) AND lv = 2)

UNION ALL

(SELECT * 
FROM (SELECT a.empno, a.ename, a.sal, rownum rn
      FROM 
            (SELECT empno, ename, sal
            FROM emp
            ORDER BY sal, empno)a) a1,
    (SELECT lv
    FROM 
    (SELECT level lv
    FROM dual
    CONNECT BY LEVEL <= 14))b
WHERE rn IN (1,2,3) AND lv = 3);


-------------��������������������--------------
(���ƾ� Ǯ�� �����ð�................);
(���ƾ� Ǯ��)
SELECT a.empno, a.ename, a.sal, SUM(b.sal) C_SUM
FROM 
    (SELECT a.*, rownum rn
     FROM 
        (SELECT *
         FROM emp
         ORDER BY sal)a)a,
    (SELECT a.*, rownum rn
     FROM 
        (SELECT *
         FROM emp
         ORDER BY sal, empno)a)b
WHERE a.rn >= b.rn
GROUP BY a.empno, a.ename, a.sal, a.rn
ORDER BY a.rn, a.empno;


no_ana3�� �м��Լ��� �̿��Ͽ� SQL �ۼ�;

SELECT empno, ename, sal, SUM(sal) OVER (ORDER BY sal, empno ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) cumm_sal
FROM emp;

ppt 126
���� ���� �������� ���� ������� ���� ������� �� 3������ sal �հ� ���ϱ�;

SELECT empno, ename, deptno, sal,
        SUM(sal) OVER (ORDER BY sal ROWS BETWEEN 1 preceding AND 1 following) c_sum
FROM emp;


�ǽ� ana7
�μ����� �޿�, �����ȣ �������� ���� ���� ��, �ڽ��� �޿��� �����ϴ� (����)������� �޿� ���� ��ȸ�ϴ� ���� �ۼ�
ORDER BY ��� �� WINDOWING ���� ������� ���� ��� ���� WINDOWING�� �⺻ ������ ���� �ȴ�.
RANGE UNBOUNDED PRECEDING
RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW;


SELECT *
FROM emp;

SELECT empno, ename, deptno, sal,
        SUM(sal) OVER (PARTITION BY deptno ORDER BY sal ROWS UNBOUNDED PRECEDING ) c_sum
FROM emp
ORDER BY deptno, sal;


---������ Ǯ��

SELECT empno, ename, deptno, sal,
        SUM(sal) OVER (PARTITION BY deptno ORDER BY sal, empno) c_sum
FROM emp
ORDER BY deptno, sal;


WINDOWING�� RANGE, ROWS ��
RANGE : ������ ���� ����, ���� ���� ������ �÷����� �ڽ��� ������ ���
ROWS : �������� ���� ����, (���� ��Ȯ)
ORDER BY ��� �� WINDOWING ���� ������� ���� ��� ���� WINDOWING�� �⺻ ������ ���� �ȴ�.;

SELECT empno, ename, deptno, sal,
        SUM(sal) OVER (PARTITION BY deptno ORDER BY sal ROWS UNBOUNDED PRECEDING) row_,
         SUM(sal) OVER (PARTITION BY deptno ORDER BY sal RANGE UNBOUNDED PRECEDING) range_,
         SUM(sal) OVER (PARTITION BY deptno ORDER BY sal) default_
FROM emp;
