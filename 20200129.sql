SELECT TO_DATE('2019/12/31','YYYY/MM/DD') AS "LASTDAY", 
        TO_DATE('2019/12/31','YYYY/MM/DD') -5 AS "LASTDAY_BEFORE5",
        SYSDATE AS "NOW",
        SYSDATE -3 AS "NOW_BEFORE3" 
FROM dual;

SELECT TO_DATE('2019/12/31','YYYY/MM/DD')
FROM dual;

--DATE : TO_DATE ���ڿ�->��¥(DATE)
--       TO_CHAR ��¥ -> ���ڿ�(��¥ ���� ����)
--> TO CHAR �� ����ϸ� ��¥ ���� ������ �ڱⰡ ���� �� �ִ�. (ȯ�漳�� â ���� �ʾƵ�.)
--> JAVA������ ��¥ ������ ��ҹ��ڸ� ������(MM/mm-> ��, ��)
--> SQL������ ��MM �� MI ��.
--> �ְ�����(1~7) : �Ͽ����� 1, �������� 2....����� 7
-->���� IW : ISO ǥ�� - �ش� ���� ������� �������� ������ ������
--              2019/12/31 ȭ���� --> 2020/01/02(�����) -- > �׷��� ������ 1������ ����

SELECT TO_CHAR(SYSDATE, 'YYYY-MM/DD HH24:MI:SS') AS "TIME"-->12�ð� ������ �ֱ⵵ �ϰ� 24 ������ �ֱ⵵ ��
FROM dual;

SELECT TO_CHAR(SYSDATE, 'YYYY-MM/DD HH24:MI:SS') "ALL",
       TO_CHAR(SYSDATE,'D') "DAY",
       TO_CHAR(SYSDATE, 'IW') "WEEK",
       TO_CHAR(TO_DATE('2019/12/31','YYYY/MM/DD'),'IW' )"WEEK"
FROM dual;

--emp ���̺��� hiredate(�Ի�����)�÷��� ����� ��:��:��

SELECT ename,hiredate,
       TO_CHAR(hiredate,'YYYY-MM-DD HH24:MI:SS') Ư����¥,
       TO_CHAR(hiredate + 1,'YYYY-MM-DD HH24:MI:SS') "Ư����¥+1��",
       TO_CHAR(hiredate + 1/24,'YYYY-MM-DD HH24:MI:SS') "Ư����¥+1�ð�",
       --hiredate�� 30���� ���Ͽ� TO_CHAR�� ǥ���ϱ�
       TO_CHAR(hiredate + (1/24)/2,'YYYY-MM-DD HH24:MI:SS')"Ư����¥+30��"
       --�������� �Ѵٸ� �� �� ���������� ǥ���� �� ������ ���ٰ� ��.
       TO_CHAR(hiredate + (1/24/60)*30,'YYYY-MM-DD HH24:MI:SS')"Ư����¥+30��"
       -->60���� ���� �ڿ� 30�� ���ؼ� ���̶�� �� �� �� �� ���̰� ����.
FROM EMP;

--> �ú��� ������ 00000���� ����.. ������ ���ٴ� ��


SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD') "DT_DASH",
       TO_CHAR(SYSDATE,'YYYY-MM-DD HH24-MI-SS') "DT_DASH_WHIT_TIME",
       TO_CHAR(SYSDATE,'DD-MM-YYYY') "DT_DD_MM_YYYY"
FROM dual;

-- ��¥ Ÿ�Կ����� �ݿø��� �� �� �ִ�. 

--��¥ ���� �Լ� ù��° ���� �ſ� �� �� 

--MONTHS_BETWEEN(DATE, DATE)
--���ڷ� ���� �� ��¥ ������ �������� ����

SELECT ename, hiredate,
       MONTHS_BETWEEN(sysdate, hiredate) "SYSDATE���� �ټӳ��",
       MONTHS_BETWEEN(TO_DATE('2020-01-17','YYYY-MM-DD'),hiredate) "TO_DATE���� �ټӿ���",
       469/12
FROM emp
WHERE ename = 'SMITH';

--ADD MONTH(DATE, ����-���ϰų� ��(������) ������)
SELECT ADD_MONTHS(SYSDATE, 5)
FROM dual;

--ADD MONTH(5���� ���� �ñ��ϸ� ���� ��)
SELECT ADD_MONTHS(SYSDATE, -5)
FROM dual;

-- NEXT_DAY(DARE, �ְ�����), ex: NEXT_DAY(SYSDATE, 5) -->SYSDATE ���� ó�� �����ϴ� �ְ����� 5�� �ش��ϴ� ����
--                              SYSDATE 2020/01/29(��) ���� ó������ �����ϴ� 5(��)���� --> 2020/01/30(��)

SELECT NEXT_DAY(SYSDATE, 5)
FROM dual;

-- LAST_DAY(DATE) DATE�� ���� ���� ������ ���ڸ� ����
SELECT LAST_DAY(SYSDATE) --SYSDATE : 2020/01/29 --> 2020/01/31�� ������
FROM dual;

--LAST_DAY�� ���� ���ڷ� ���� date�� ���� ���� ������ ���ڸ� ���� �� �ִµ�
--date�� ù��° ���ڴ� ��� ���ұ�?

SELECT SYSDATE,
       LAST_DAY(SYSDATE),
       TRUNC(SYSDATE,'MM'),
       TRUNC(TO_DATE('1994/07/06','YYYY/MM/DD'), 'MM'),
       
       ADD_MONTHS(TO_CHAR(LAST_DAY(SYSDATE)+1,'YYYY/MM/DD'),-1) nn,
       -->������ ��¥�� 1�� ���ϸ� ������ ���� �� 1��
       -->ADD_MONTHS�� ���μ� 1�� ��
       
       TO_DATE('01','DD'),
       --ADD_MONTH(LAST_DAY(SYSDATE)+1,-1)
       TO_CHAR(SYSDATE, 'YYYY-MM'),
       TO_DATE(TO_CHAR(SYSDATE,'YYYY-MM') || '01','YYYY-MM-DD')
       
FROM dual;

--hiredate ���� �̿��Ͽ� �ش� ���� ù��° ���ڷ� ǥ��
SELECT ename, hiredate,
       ADD_MONTHS(TO_CHAR(LAST_DAY(hiredate)+1,'YYYY/MM/DD'),-1) nn,
       TO_DATE(TO_CHAR(hiredate,'YYYY-MM') || '01','YYYY-MM-DD')
       --�ι�°�� ���ظ� ���߾�....
       --�� �����ߴ�! 01 ���Ѵ����� TODATE�� ��¥�� �ٲ���
       
FROM emp;


--���ݱ��� �� ���� ����� ����ȯ... �Լ��� �̿��ؼ� �ٲپ���.
--������ ����ȯ�� �����ϱ� ��.(�ڵ�)

-->empno�� NUMBERŸ��, ���ڴ� ���ڿ�
--Ÿ���� ���� �ʱ� ������ ������ ����ȯ�� �Ͼ.
--���̺� �÷��� Ÿ�Կ� �°� �ùٸ� ���� ���� �ִ� �� �߿��ϴ�.
SELECT *
FROM emp
WHERE empno = '7369';
-->7369 ���ڿ��� �˻��ص� �ڵ� ġȯ�Ǽ� �˻���.
-->�̷��� ���� ��! ��Ȯ�� Ÿ���� �������

SELECT *
FROM emp
WHERE empno = 7369;
-->�̷��� �ٲ���!


SELECT *
FROM emp
WHERE hiredate = '80/12/17';
-->������ �۵� �ȵǴ� ����: YYYY�� �ٲ�� ����.
--> 1980���� �ٲٸ� �۵� �ȴ�.

-->hiredate�� ��� DATEŸ��, ���ڴ� ���ڿ��� �־����� ������ ������ ����ȯ�� �߻�,
--��¥ ���ڿ� ���� ��¥ Ÿ������ ��������� ����ϴ� ���� ����. 

SELECT *
FROM emp
WHERE hiredate = TO_DATE('1980/12/17', 'YYYY/MM/DD');

-->����ȯ�� ���ִ� �� �򰥸��� ���� �� �ִ�.

EXPLAIN PLAN FOR -->2�ܰ�, � ���� �������� �����ϰ�
SELECT *
FROM emp
WHERE empno = '7369';
--   1 - filter("EMPNO"=7369) --> ���͸� ���� 7369�� �Ǿ� �ִ� --> �ڵ��� ����ȯ

SELECT *
FROM table(dbms_xplan.display);
-->�����ȹ�� ����. 
--> ������ �Ʒ��� ����. 
--> �鿩���Ⱑ �Ǿ������� : �ٷ� ���� ���� �θ��� ��
--> �ڽ��� ������ �ڽĺ��� �д´�.


EXPLAIN PLAN FOR 
SELECT *
FROM emp
WHERE TO_CHAR(empno) = '7369';
--   1 - filter(TO_CHAR("EMPNO")='7369') �� �ٲ���ִ�.


SELECT *
FROM table(dbms_xplan.display);

--���ڸ� ���ڿ��� �����ϴ� ��� : ����
--õ���� ������
--1000 �̶�� ���ڸ� 
--�ѱ�: 1,000.50
--����: 1.000,50 (�Ҽ���ǥ�ÿ� õ���� ǥ���ڸ� ���� �ٲپ� ��)



--EMP sal �÷�(NUMBER Ÿ��)�� ������
-- 9 :����
-- 0 :���� �ڸ� ����(0���� ǥ��)
-- L :��ȭ ����

SELECT ename, sal, TO_CHAR(sal,'L09,999') AS a -->00�� ������ 0�� ����, 999...�� �ڸ��� ǥ��
FROM emp;

--��� �󵵰� �׷��� ���� �ʽ��ϴ�. 


--NULL�� ���� ������ ����� �׻� NULL
--emp ���̺��� sal �÷����� null �����Ͱ� �������� ����.
--emp ���̺��� comm �÷����� null �����Ͱ� ���� (14���� �����Ϳ� ����)
--sal + comm --> comm �� null �࿡ ���ؼ��� ��� null�� ���´�.

--�䱸������ comm�� null�̸� sal �÷��� ���� ��ȸ
--�䱸������ ���� ��Ű�� ���Ѵ� -> sw������ [����]

--> NVL(Ÿ��, ��ü��)�̶�� �Լ� ���
-- Ÿ���� ���� NULL�̸� ��ü���� ��ȯ�ϰ�
-- Ÿ���� ���� NULL�� �ƴϸ� Ÿ�� ���� ��ȯ
--�ڹٶ��:
--\if( Ÿ�� == null ) 
--      return ��ü��;
-- else
--      return Ÿ��;

SELECT ename, sal, comm, sal+comm
FROM emp;

SELECT ename, sal, comm, NVL(comm,0),sal+NVL(comm,0) -->nvl�Լ��� ���� null����0���� ġȯ�Ǿ���.
FROM emp;

SELECT ename, sal, comm, NVL(comm,0),
    sal+comm,
    sal+NVL(comm,0),
    NVL(sal+comm,0) -->���� �Ʒ��� ���� �ٸ� ��! ��� ����� �ȵ�
FROM emp;


--NVL2 �Լ�
--NVL2(expr1, expr2, expr3) --���ڰ� �� ���� ��.
--if(expr1 ! = null)
--      return expr2; -->���� �ƴϸ� 2��°����
--else
--      return expr3; -->���̸� 3��° ����



SELECT ename, sal, comm, NVL2(comm, 10000, 0)
FROM emp;

-->NULLIF(expr1, expr2)
-->if(expr1 == expr2)
--      return null;
--else
--      return expr1;

SELECT ename, sal, comm, NULLIF(sal, 1250) a-- sal 1250�� ����� null�� ���Ϲް�, 1250�� �ƴ� ����� sal�� ���Ϲ���
FROM emp;

--��mvl�� �� �ܿ��� ��!! ���� ����. 

--��������, �޼ҵ� ���� ���� ���������� ����. 
--COALESS ���� �߿� ���� ó������ �����ϴ� null�� �ƴ�
--���ڸ� ��ȯ�Ѵ�. 

--COALESS(expr1, expr2....)
--if (expr !=  )
--  return expr1;
--else
--  return COALECE(expr2, expr3....);

--COALESCE(comm, sal) : comm�� null�� �ƴϸ� comm
--                      comm �� null�̸� sal(��, sal�÷��� ���� NULL�� �ƴ� ��.)
SELECT ename, sal, comm, COALESCE(comm, sal)
FROM emp;

--ppt 159�� Ǯ���

SELECT empno, ename, mgr,
       NVL(mgr, 9999) mgr,
       NVL2(mgr, mgr, 9999) mgr,
       COALESCE(mgr,9999) mgr
FROM emp;

--pair programing 
--2�� 1���� ��ǻ�͸� �ϳ����� ���� �������� �ڵ��ϱ�...�Ƿ��� ����� ������� �𿩾� ����

SELECT userid, usernm, reg_dt,
       NVL(reg_dt, sysdate) AS n_reg_dt
FROM USERS
WHERE userid NOT IN ('brown');

--���� ��¥ �� ����������� ����!
--�������ڵ��� ������ �ص���

--����Ŭ�� CASE���� ELSE IF�� ������.

-- CONDITION : ������
-- CASE : JAVA�� if - else if - else 

-- CASE 
--      WHEN ����1 TEHN ���ϰ�1:
--      WHEN ����2 THEN ���ϰ�2:
--      ELSE �⺻��
-- END


--emp ���̺��� job �÷��� ���� SALESMAN SAL * 1.05 ����
--                            MANAGER �̸� SAL * 1.1 ����
--                             PRESIDENT �̸� SAL * 1.2 ����
--                              �׹��� ������� SAL�� ���� ���ֱ�

SELECT ename, job, sal,
        CASE 
            WHEN job = 'SALEMAN' THEN sal * 1.05
            WHEN job = 'MANAGER' THEN sal * 1.1
            WHEN job = 'PRESIDENT' THEN sal * 1.2
            ELSE sal
        END AS "BONUS_SAL"            
        -->�̸�ŭ ����� �� �÷� �ϳ���!!!
FROM emp;


--DECODE �Լ� : CASE ���� ������ 
--(�ٸ��� CASE �� : WHEN ���� ���Ǻ񱳰� �����Ӵ�.
--      DECODE �Լ� : �ϳ��� ���� ���ؼ� = �񱳸� ���
--DECODE �Լ� : ��������(������ ������ ��Ȳ�� ���� �þ ���� ����.)
--DECODE(collexpr, ù��° ���ڿ� ���� ��1, ù��° ���ڿ� �ι�° ���ڰ� ���� ��� ��ȯ ��, 
--                 ù��° ���ڿ� ���� ��2, ù��° ���ڿ� �׹�° ���ڰ� ���� ��� ��ȯ ��.....
--                 option - else ���������� ��ȯ�� �⺻��)

SELECT ename, job, sal,
       DECODE(job, 'SALESMAN', sal * 1.05,
                    'MANAGER', sal * 1.1,
                    'PRESIDENT', sal * 1.2, sal)AS "BONUS_SAL"
FROM emp;


--emp ���̺��� job �÷��� ���� SALESMAN �̸鼭 sal�� 1400���� ũ��  SAL* 1.05 ����
--                            SALESMAN �̸鼭 sal�� 1400���� ������  SAL* 1.1 ����
--                            MANAGER �̸� SAL* 1.1 ����
--                             PRESIDENT �̸� SAL * 1.2 ����
--                              �׹��� ������� SAL�� ���� ���ֱ�

-- 1. CASE�� �̿��ؼ�
-- 2. DECODE, CASE ȥ���ؼ�.

--CASE�� �̿��� Ǯ��

SELECT ename, job, sal,
        CASE 
            WHEN job = 'SALESMAN' AND sal >= 1400 THEN sal * 1.05
            WHEN job = 'SALESMAN' AND sal <= 1400 THEN sal * 1.1
            WHEN job = 'MANAGER' THEN sal * 1.1
            WHEN job = 'PRESIDENT' THEN sal * 1.2
            ELSE sal
        END AS "BONUS_SAL"            
FROM emp;

-- DECODE, CASE ȥ���ؼ� Ǯ��

SELECT ename, job, sal,
       DECODE(job, 'SALESMAN',  DECODE(job, 'SMITH', 'STOUTHHHH'),
                    'MANAGER', sal * 1.1,
                    'PRESIDENT', sal * 1.2, sal)AS "BONUS_SAL"
FROM emp; --���� DECODE ������!!!


-------------------Ǯ����!!!!!!!!!!!!!!!!!!!----------------------

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




--�ش� ����Ÿ �÷��� �´� ���� ���...
--�����Լ��� ��� �߿�X
--NULL ó�� �߿�, NVL �ϳ������� ������
--CONDTION�� ���� ���� �߿�!

