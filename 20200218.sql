SELECT dept_h.*, level, lpad(' ', (LEVEL-1)*4, ' ') || deptnm
FROM dept_h 
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd; 
----------------------------

����� �������� (leaf ==> root node (���� node))
��ü ��带 �湮�ϴ� ���� �ƴ϶� �ڽ��� �θ� ��常 �湮(����İ� �ٸ� ��)
������ : ��������
������ : �����μ�;

SELECT deptcd, LPAD(' ',(LEVEL - 1) * 4 ) || deptnm ,p_deptcd
FROM dept_h
START WITH deptnm = '��������'
CONNECT BY PRIOR p_deptcd = deptcd;

h_4�ǽ�;

SELECT h_sum.*
FROM h_sum;

SELECT LPAD(' ', (LEVEL-1)*4, ' ') || s_id s_id , value
FROM h_sum
START WITH s_id = '0'
CONNECT BY PRIOR s_id = ps_id;

�ǽ� h_5;

SELECT *
FROM no_emp;

SELECT LPAD(' ',(LEVEL-1)*4,' ' ) || org_cd org_cd, no_emp
FROM no_emp
START WITH org_cd = 'XXȸ��'
CONNECT BY PRIOR org_cd = parent_org_cd;

-------------------------------���� ���� ����ġ��

�ǽ�5������ ����;

������ ������ �� ���� ���� ��� ��ġ�� ���� ��� ��(pruning branch - ����ġ��)
FROM = > START WITH, CONNECT BY = > WHERE
1. WHERE : ���� ������ �ϰ� ���� ���� ����
2. CONNECT BY : ���� ������ �ϴ� �������� ���� ����;


SELECT *
FROM no_emp;

WHERE �� ��� �� : �� 9���� ���� ��ȸ�Ǵ� �� Ȯ��
WHERE �� (org_cd != '������ȹ��') : ������ȹ�θ� ������ 8���� �� ��ȸ�Ǵ� �� Ȯ��;
CONNECT BY ���� ���� ��� : 6���� �� ��ȸ��;

SELECT LPAD(' ',(LEVEL-1)*4,' ' ) || org_cd org_cd, no_emp
FROM no_emp
WHERE org_cd!= '������ȹ��'
START WITH org_cd = 'XXȸ��'
CONNECT BY PRIOR org_cd = parent_org_cd;

CONNECT BY ���� ������ ���;
SELECT LPAD(' ',(LEVEL-1)*4,' ' ) || org_cd org_cd, no_emp
FROM no_emp
START WITH org_cd = 'XXȸ��'
CONNECT BY PRIOR org_cd = parent_org_cd AND org_cd != '������ȹ��';


-----------------
�������� Ư���Լ� �ǽ�;

1. CONNECT_BY_ROOT(�÷�) : �ش� �÷��� �ֻ��� ���� ���� ��ȯ;
2. SYS_CONNECT_BY_PATH(�÷�, ������) : �ش� ���� �÷��� ���Ŀ� �÷� ���� ��õ, �����ڷ� �̾��ش�;
3. CONNECT_BY_ISLEAF : �ش� ���� LEAF �������(����� �ڽ��� ������)���� ���� [1:leaf, 0:no leaf];

SELECT LPAD(' ',(LEVEL-1)*4,' ' ) || org_cd org_cd, no_emp,
        CONNECT_BY_ROOT(org_cd) root,
        LTRIM(SYS_CONNECT_BY_PATH(org_cd, '-'),'-')path, --SYS��¼�� �Լ��� -�� ������ ���̱� ������ TRIM �Լ��� �Ἥ �������ش�.
        CONNECT_BY_ISLEAF leaf
FROM no_emp
START WITH org_cd = 'XXȸ��'
CONNECT BY PRIOR org_cd = parent_org_cd;


--------------------
�ǽ� h6

SELECT *
FROM board_test;

SELECT seq, LPAD(' ',(LEVEL-1)*4,' ') || title
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq;


�ǽ� h7
SELECT seq, LPAD(' ',(LEVEL-1)*4,' ') || title
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq
ORDER BY seq DESC;

�ǽ� h8;
-------------�� ��(Ʋ����)--------------
SELECT board_test.*, level
FROM board_test
START WITH seq = 11
CONNECT BY PRIOR seq = (seq + 1);

-------------������ ��--------------
SELECT seq, LPAD(' ',(LEVEL-1)*4,' ') || title
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq
ORDER SIBLINGS BY seq DESC; -->���� ������ ������ ���¿��� �����ϴ� ���


�ǽ� h9;

SELECT seq, LPAD(' ',(LEVEL-1)*4,' ') || title 
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq
ORDER SIBLINGS BY seq DESC;


SELECT *
FROM board_test;

�׷��ȣ�� ������ �÷��� �߰�;
ALTER TABLE board_test ADD (gn NUMBER);

UPDATE board_test SET gn = 4
WHERE seq IN (4,5,6,7,8,10,11);

UPDATE board_test SET gn = 2
WHERE seq IN (2,3);

UPDATE board_test SET gn = 1
WHERE seq IN (1,9);

COMMIT;
--������ ��
SELECT gn, seq, LPAD(' ', (LEVEL-1)*4) || title title
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq
ORDER SIBLINGS BY gn DESC, seq ASC;
--���� https://m.blog.naver.com/PostView.nhn?blogId=dasomiy&logNo=60193969125&proxyReferer=https%3A%2F%2Fwww.google.com%2F

----�������� ��

SELECT seq, LPAD(' ', (LEVEL-1)*4) || title title, DECODE(parent_seq, NULL, seq, parent_seq) root
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq
ORDER SIBLINGS BY root DESC, seq ASC;


-------------------------
SELECT *
FROM board_test;
---------�Խñ� �𸣰����� �� �ܿ���-----!!!!!!!!!!!!!!!!!!!!!


SELECT seq, LPAD(' ', (LEVEL-1)*4) || title title, DECODE(parent_seq, NULL, seq, parent_seq) root, parent_seq
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq
ORDER SIBLINGS BY root DESC, seq ASC;


------------------

SELECT *
FROM emp
ORDER BY deptno DESC;

SELECT *
FROM emp
ORDER BY deptno DESC, empno ASC;

-----------------window �Լ�
SELECT *
FROM emp
WHERE sal = (SELECT MAX(sal)
            FROM emp);

--> ���� �޿��� ���� �޴� ����� �̸��� �˷��� �̷��� �ؾ� �Ѵ�.

--�ణ ������ �������ִ� �Լ�

�ǽ�an0;

SELECT ename, sal, deptno
FROM emp;

SELECT A.*, ROWNUM
FROM
(SELECT deptno, sal, ename
FROM emp
ORDER BY deptno, sal)A;


SELECT B.*
FROM 
(SELECT A.*,ROWNUM
FROM
(SELECT deptno, sal, ename
FROM emp
GROUP BY deptno, sal, ename)A
ORDER BY A.deptno, sal)B;

SELECT A.*, ROWNUM
FROM 
(SELECT ename, sal, deptno
FROM emp
WHERE deptno IN (10)
ORDER BY sal DESC)A;


--------------���� (�¾���)-----------
SELECT *
FROM    (SELECT a.*, ROWNUM
        FROM 
        (SELECT ename, sal, deptno
        FROM emp
        WHERE deptno = 10
        ORDER BY sal DESC)a)
        
        UNION  ALL
        
        (SELECT b.*, ROWNUM
        FROM 
        (SELECT ename, sal, deptno
        FROM emp
        WHERE deptno = 20
        ORDER BY sal DESC)b)
        
        UNION ALL 
        (SELECT c.*, ROWNUM
        FROM 
        (SELECT ename, sal, deptno
        FROM emp
        WHERE deptno = 30
        ORDER BY sal DESC)c)
;
        
----------------------������ Ǯ��-------------------


SELECT *
FROM
    (SELECT LEVEL lv
    FROM dual
    CONNECT BY LEVEL <= 14) a, 
    
    (SELECT deptno, COUNT(*) cnt  
    FROM emp
    GROUP BY deptno) b
    
WHERE b.cnt >= a.lv
ORDER BY b.deptno, a.lv;




