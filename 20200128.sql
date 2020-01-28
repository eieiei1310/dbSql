SELECT *
FROM emp
WHERE job = 'SALESMAN' 
OR hiredate > TO_DATE('1981/06/01','YYYY/MM/DD');

--emp ���̺��� 10�� �μ�(deptno) Ȥ�� 30�� �μ��� ���ϴ� ��� �� 
--�޿�(sal)�� 1500�� �Ѵ� ����鸸 ��ȸ�ϰ� �̸����� �������� ���ĵǵ��� ������ �ۼ��ϼ���. 
SELECT *
FROM emp
WHERE deptno IN(10,30) 
AND sal > 1500
ORDER BY ename DESC;

--tool���� �������ִ� ���� ��ȣ�� �÷����� ���� �� ������?
--ROWNUM : ���ȣ�� ��Ÿ���� �÷�
SELECT ROWNUM, empno, ename
FROM emp;

SELECT ROWNUM rn, empno, ename
FROM emp;
--�Ϲ������� as�� �ش�. rownum�� �ý��۳����̶�.

--ROWNUM�� WHERE �������� ��� ����
--�����ϴ°� : = (1�� �ǰ�, 2�� �ȵ�)
--�����ϴ°� : ROWNUM = 1, ROWNUM <= 2  --> ROWNUM =1, ROWNUM <= N
--�������� �ʴ� �� : ROWNUM -2, ROWNUM > = 2 --> ROWENUM -N (N�� 1�� �ƴ� ����), ROWNUM >- N (N�� 1�� �ƴ� ����)
--ROWNUM �� �̹� ���� �����Ϳ��ٰ� ������ �ο�
--������1.  ���� ���� ������ ����(ROWNUM�� �ο����� ���� ��)�� ��ȸ�� ���� ����. 
--���뵵: ����¡ ó��
-- ���̺� �ִ� ��� ���� ��ȸ�ϴ� ���� �ƴ϶� �츮�� ���ϴ� �������� �ش��ϴ� �� �����͸� ��ȸ�� �Ѵ�. 
--NAVER �Խñ� �������� 1, 2, 3, 4...�� �������� �ִ� ��ó��

--����¡ ó���� ������� : 1�������� �Ǽ�, ���� ����
--EMP ���̺� �� row �Ǽ� : 14
--����¡�� 5���� �����͸� ��ȸ
-- 1page : 1~5
-- 2page : 6~10
-- 3page : 11~15
--������2. ORDER BY ���� SELECT �� ���Ŀ� ������ �ȴ�. 

SELECT ROWNUM rn, empno, ename
FROM emp --�Ϲ������δ� �����͸� �Է��� ������� ���´�...
ORDER BY ename; --> ������ ���׹����� ��. orderby�� select ���Ŀ� ����Ǳ� ����

--���ĵ� ����� rownum�� �ο��ϱ� ���ؼ��� in line view�� ����Ѵ�.
--�������� : 1. ���� 2. ROWNUM �ο�

--SELECT���� *�� ����� ��� �ٸ� EXPRESSION �� ǥ���ϱ� ���ؼ�
--���̺��.* ���̺��Ī.* �� ǥ���ؾ��Ѵ�.
SELECT ROWNUM, emp.*
FROM emp;

SELECT ROWNUM, e.*
FROM emp e;
--��Ī�� �� ��� ��Ī���� �־��� �� �ִ�. 

SELECT ROWNUM,a.*
FROM 
    (SELECT empno, ename
    FROM emp
    ORDER BY ename) a; --��ȣ : ���̺�, �̷��� ���Ƿ� ������ ���̺��� �̸��� ����?(�ζ��� ���̺�)
    --�̸��� �ٿ��� �� �ִ�. 

SELECT *
    FROM (SELECT ROWNUM rn,a.*
        FROM 
            (SELECT empno, ename
            FROM emp
            ORDER BY ename) a )
WHERE rn = 2;
--�ѹ� �� �����ָ� rn�� ��ġ �÷��� ��ó�� ����� �� �ִ�.

--����¡ ó���� �������: 1�������� �Ǽ�, ���� ����
-- 1page : 1~5
-- 2page : 6~10
-- 3page : 11~15

--�����غ���!
--ROWNUM --> rn
--page size : 5, ���ı����� ename
-- 1page : 1~5
-- 2page : 6~10
-- 3page : 11~15
-- n page :rn (page-1)*pageSize + 1 ~ page * pageSize
SELECT *
    FROM (SELECT ROWNUM rn,a.*
        FROM 
            (SELECT empno, ename
            FROM emp
            ORDER BY ename) a )
WHERE rn BETWEEN (:page - 1) * :pageSize  AND :page * :pageSize;

--�ǽ� row_1
SELECT *
FROM (SELECT ROWNUM rn, a.*
    FROM
        (SELECT empno, ename
        FROM emp)a )
WHERE rn BETWEEN 1 AND 10;

--����1

SELECT * 
FROM 
    (SELECT ROWNUM rn, a.*
    FROM
        (SELECT empno, ename
        FROM emp)a)
WHERE rn BETWEEN 1 AND 10;

--row_2 ����
SELECT *
FROM
    (SELECT ROWNUM rn, empno, ename
    FROM EMP)a
WHERE rn BETWEEN 11 AND 20;

--row_ 3 ����
SELECT *
FROM 
    (SELECT ROWNUM rn,a.* 
    FROM
        (SELECT empno, ename
        FROM emp
        ORDER BY ename)a)
WHERE rn BETWEEN 11 AND 14;

--row_ 1 �翬��
SELECT *
FROM
    (SELECT ROWNUM rn,empno, ename
    FROM emp)
WHERE rn BETWEEN 1 AND 10;

--row 2 �翬��
SELECT *
FROM 
    (SELECT ROWNUM rn,empno, ename
    FROM EMP)
WHERE rn BETWEEN 11 AND 14;

--row 3 �翬��
SELECT *
FROM
    (SELECT ROWNUM rn, a.*
    FROM
        (SELECT empno, ename
        FROM emp
        ORDER BY ename)a)
WHERE rn BETWEEN 11 AND 14;

--�Լ� ����!
--single row, multi row

--trim :�հ� �ڿ� ȭ��Ʈ �����̽��� ������ �� ������ ���� ���ڿ��� �������´�.
--�߰��� �ִ� ���鹮�ڴ� �������� ����.

--replace : ��ü -> ���ϴ� ���ڸ� ������ų �� ����.
--�Լ��� ���� �ܿ���� ���� �ʾƵ� ��

--DUAL ���̺� : �����Ϳ� �Լ��� �׽�Ʈ �غ� �������� ���

SELECT LENGTH('TEST')
FROM dual;

--���ڿ� ��ҹ��� : lower, upper, initcap
SELECT LOWER('Hello, World'), UPPER('Hello, World'), INITCAP('Hello, World')
FROM dual;
--lower->���� �ҹ���, upper ->���δ빮��, inicap -> ù��°�� �빮��
--Ȱ�뵵�� �� ������

SELECT LOWER('Hello, World'), UPPER('Hello, World'), INITCAP('Hello, World')
FROM emp;
--> �׳� emp ���̺�� �ϸ� emp ���̺��� ������ŭ �ٲ� ���´�.

SELECT LOWER(ename), UPPER(ename), INITCAP(ename)
FROM emp;
--> �׳� emp ���̺��� �÷��� ������ѵ� �ȴ�. 


--�Լ��� where �������� ����� �����ϴ�.
--��� �̸��� smith�� ����� ��ȸ�� �ϼ���

SELECT *
FROM emp
WHERE ename = 'SMITH';

SELECT *
FROM emp
WHERE ename = UPPER(:ename); -->���ε������� ġȯ�ϱ�
--> SMITH�� �ϸ� �ǰ� smith�� �����ϸ� �ȵ�.

--SQL �ۼ��� �Ʒ� ���´� �����ؾ��Ѵ�. 
SELECT *
FROM emp
WHERE LOWER(:ename) = :ename; 
--> LOWER��� ����� EMP���̺��� �Ǽ���ŭ ����ȴ�. 

--SQL ĥ������-���ھ�
--�º��� �������� ���� (���̺��ʿ� �ִ� �÷��� �������� ���ƶ�.)
--�º��� �����ϸ� �ӵ������� ����, 

--
SELECT CONCAT('Hello','World') concat, --�ڿ� concat�� �ֳִ°���????? �� �̸��̾���...
       SUBSTR('Hello, World', 1, 5) sub,--�ڹٶ� �ٸ�..�ڹٴ� 0���� ����
       LENGTH('Hello, World') len,
       INSTR('Hello, World', 'o', 6)ins, -->�ش�Ǵ� ���ڰ� �����ϴ� ��ġ�� ����, ~���� �����ϰ� ��.
       LPAD('Hello, World', 15, '*') lp, --> ������ ���ڿ��� ~�� ä���. LP-> ���ʿ� ä��
       RPAD('Hello, World', 15, '*') rp,
       REPLACE('Hello, World', 'H', 'T') rep, -->~���忡�� , ~�ܾ, ~�� �ٲ�
       TRIM('     Hello, World      ') trp,
       -->�յڰ����� ���ŵ� ä�� ����
       --> ������ ����, 
       TRIM('d' FROM 'Hello, World') tr --> ������ �ƴ϶� Ư�� ���ڸ� �����Ҽ��� �ִ�.
       
FROM dual;
--���� �Լ�
--round :�ݿø�(10.6�� �Ҽ��� ù��° �ڸ����� �ݿø� > 11)
--trunc :����(����)(10.6�� �Ҽ��� �ڸ����� ���� --> 10)
--round, trunc ���� ��� ���°�ڸ����� �ݿø�/�����Ұ����� ���Ѵ�. -> ���� 2 ��
--�������� ��� �����Լ��麸�� �� �߿���
--mod : �������� ������(���ϰ� ���� ���� ���� �ƴ϶� ���� ������ �� ������ ��)(13/5 -> �� 2, ������ 3)


--ROUND(��� ����, ���� ��� �ڸ�)
SELECT ROUND(105.54, 1) AS a, --�ݿø� ����� �Ҽ��� ù��°�ڸ����� ������ ��(�ι�° �ڸ����� �ݿø�)
       ROUND(105.55, 1) AS a,
       ROUND(105.55, 0) AS a, --�ݿø� ����� �����κи� ������ �Ѵ�.(ù��° �ڸ����� �ݿø�)
       ROUND(105.55, -1) AS a, --�ݿø� ����� ���� �ڸ����� ������ ��(���� �ڸ����� �ݿø�)
       ROUND(105.55) AS a --���ڰ� 1���� ���� ���ڰ� 0�� �Ͱ� ����. �����κи� ������ �ȴ�. 
FROM dual;
--> 1�� �Ҽ��� ù��°�� �������� ��.

SELECT TRUNC(105.54, 1) AS a, --������ ����� �Ҽ��� ù���� �ڸ����� ��������->�ι��� �ڸ����� ����
       TRUNC(105.55, 1) AS a,--�����̱� ������ ���� �ٲ� ��� X
       TRUNC(105.55, 0) AS a, --������ ����� ������(���� �ڸ�)���� �������� > �Ҽ��� ù��° �ڸ����� ����
       TRUNC(105.55, -1) AS a, --������ ����� 10���ڸ����� �������� --> �����ڸ����� ����
       TRUNC(105.55) AS a -- ���ڸ� 0���� �� �Ͱ� ����
FROM dual;

--EMP ���̺��� ����� �޿��� (sal)�� 1000����
--�������� �� ���� ���غ���

SELECT ename,sal, sal/1000, TRUNC(sal/1000,0),
       MOD(sal, 1000) --mod �� ����� divisdor ���� �׻� �۴�. 0 ~999������ ����������.       
FROM EMP;

DESC emp; 
--���̺��� ������ �˰� ���� �� ����ϴ� ��ɾ�
--null�� ������ �ƴ��� Ȯ���� �� ����.

--�⵵ 2�ڸ�/ �� 2�ڸ�/���� 2�ڸ� �� ����.
--�̰��� tool �� �����ϴ°�. ������ �ٲٸ� ��ȸ ����� �ٲ� ���� �ִ�. 
--����- ȯ�漳�� - �����ͺ��̽� NLS ���� RR/MM/DD�� YYYY/MM/DD�� �ٲ� �� �ִ�.
SELECT ename, hiredate
FROM emp;

--���,������ �� ���� ���� �ٿ���� ����. �츮�� ���� �� ��¥�� �ٿ�ɼ��� �ִ�.
--SYSDATE : ���� ����Ŭ ������ ��, �� �ʰ� ���Ե� ��¥ ������ �����ϴ� Ư���Լ�
--�Լ���(����1, ����2) �Լ��� ������ ������ �Ѵ�.
--date + ���� = ���� ����

SELECT SYSDATE
FROM dual;
--������ �ٲٸ� �ú��ʵ� ���̰� �� �� ����. tool���� �������־ ������ �ȳ���.
--2020/01/28 + 5
SELECT SYSDATE +5
FROM dual;
-- => ���� 1= �Ϸ�
-- => 1/24 = 1�ð�

--���� ǥ��: ����
--���� ǥ��: ''
--��¥ ǥ��: TO_DATE('���ڿ� ��¥��','���ڿ� ��¥���� ǥ������') ex) TO_DATE('2020-01-28','YYYY-MM-DD')


SELECT SYSDATE +5, SYSDATE + 1/24
FROM dual;