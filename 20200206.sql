
�����ÿ� �ִ� 5���� �ܹ�������
(kfc + ����ŷ + �Ƶ�����) /�Ե�����;

SELECT sido, count(*)
FROM fastfood
WHERE sido LIKE '%����%'
GROUP BY sido;

����������	�߱�	7
����������	����	4
����������	������	4
����������	����	17
����������	�����	2

����(KFC, ����ŷ, �Ƶ�����);

SELECT sido, sigungu, COUNT(*)
FROM fastfood
WHERE sido = '����������'
AND gb IN ('KFC', '����ŷ', '�Ƶ�����')
GROUP BY sido, sigungu;

����������	�߱�	6
����������	����	8
����������	����	12
����������	������	8
����������	�����	7

������ �ñ����� �Ե�����;

SELECT sido, sigungu, COUNT(*)
FROM fastfood
WHERE sido = '����������'
AND gb IN ('�Ե�����')
GROUP BY sido, sigungu;

���� ���ڸ� ����ϴ¹�;

SELECT a.sido, a.sigungu, ROUND(a.c1/b.c2, 2)hambuger_score
FROM
(SELECT sido, sigungu, COUNT(*)c1
FROM fastfood
WHERE /*sido = '����������'
AND */gb IN ('KFC', '����ŷ', '�Ƶ�����')
GROUP BY sido, sigungu)a ,

(SELECT sido, sigungu, COUNT(*) c2
FROM fastfood
WHERE/* sido = '����������'
AND*/ gb IN ('�Ե�����')
GROUP BY sido, sigungu)b
WHERE a.sido = b.sido
AND a.sigungu = b.sigungu
ORDER BY hambuger_score DESC;

--�õ��ñ����� ��Ȯ�� ������ ���� �ʾұ� ������ �ٸ������� ���� �ٸ� �� �ִ�.

fastfood ���̺��� �ѹ��� �д� ������� �ۼ��ϱ�;

SELECT sido, sigungu, ROUND((kfc + bugerking + mac)/lot  ,2) burger_score
FROM 
(SELECT sido, sigungu, 
       NVL(SUM(DECODE(gb, 'KFC',1)),0) kfc, 
       NVL(SUM(DECODE(gb, '����ŷ', 1)),0) bugerking,
       NVL(SUM(DECODE(gb, '�Ƶ�����',1)),0) mac, 
       NVL(SUM(DECODE(gb, '�Ե�����', 1)),1) lot
       
FROM fastfood
WHERE gb IN ('KFC','����ŷ','�Ƶ�����','�Ե�����')
GROUP BY sido, sigungu)
ORDER BY burger_score DESC;

�ܹ�������, ���κ� �ٷμҵ� �ݾ� ������ ���� �õ����� [����]
����, ���κ� �ٷμҵ� �ݾ����� ���� �� ROWNUM �� ���� ������ �ο�
���� ������ �ೢ�� ����

�ܹ������� �õ�, �ܹ������� �ñ���, �ܹ������� ����, �õ�, ���� �ñ���, ���κ� �ٷμҵ��
����Ư���� �߱� 5.67         ����Ư���� ������ 70
����Ư���� ������ 2          ����Ư���� ���ʱ� 69
��⵵ ������ 5             ����Ư���� ��걸 57
����Ư���� ������ 4.57       ��⵵ ��õ�� 54
����Ư���� ���߱� 4          ����Ư���� ���α� 47

SELECT *
FROM fastfood
WHERE sido = '��⵵'
AND sigungu = '������';

SELECT sido, sigungu, ROUND(sal/people) pri_sal
FROM tax
ORDER BY pri_sal DESC;

------------------------------------------
SELECT ROWNUM a, a. *
FROM
(SELECT sido, sigungu, ROUND((kfc + bugerking + mac)/lot  ,2) burger_score
FROM 
(SELECT sido, sigungu, 
       NVL(SUM(DECODE(gb, 'KFC',1)),0) kfc, 
       NVL(SUM(DECODE(gb, '����ŷ', 1)),0) bugerking,
       NVL(SUM(DECODE(gb, '�Ƶ�����',1)),0) mac, 
       NVL(SUM(DECODE(gb, '�Ե�����', 1)),1) lot
       
FROM fastfood
WHERE gb IN ('KFC','����ŷ','�Ƶ�����','�Ե�����')
AND sido IN ('����Ư����', '��⵵')
GROUP BY sido, sigungu)
ORDER BY burger_score DESC)a;


SELECT ROWNUM b , b.*
FROM
(SELECT sido, sigungu, ROUND(sal/people) pri_sal
FROM tax
WHERE sido IN ('����Ư����', '��⵵')

ORDER BY pri_sal DESC)b;

--�������� ROWNUM �� �ٷμҵ� ROWNUM�� �����ϱ�
SELECT *
FROM  
    --�������� 
    (SELECT ROWNUM anm, a. *
        FROM
        (SELECT sido, sigungu, ROUND((kfc + bugerking + mac)/lot  ,2) burger_score
        FROM 
        (SELECT sido, sigungu, 
               NVL(SUM(DECODE(gb, 'KFC',1)),0) kfc, 
               NVL(SUM(DECODE(gb, '����ŷ', 1)),0) bugerking,
               NVL(SUM(DECODE(gb, '�Ƶ�����',1)),0) mac, 
               NVL(SUM(DECODE(gb, '�Ե�����', 1)),1) lot
               
        FROM fastfood
        WHERE gb IN ('KFC','����ŷ','�Ƶ�����','�Ե�����')
        AND sido IN ('����Ư����', '��⵵')
        GROUP BY sido, sigungu)
        ORDER BY burger_score DESC)a)a , 
        
    --�ٷμҵ� �ݾ�
        (SELECT ROWNUM bnm , b.*
            FROM
            (SELECT sido, sigungu, ROUND(sal/people) pri_sal
            FROM tax
            WHERE sido IN ('����Ư����', '��⵵')
            
            ORDER BY pri_sal DESC)b)b
WHERE a.anm = b.bnm;
--> �� ������ �ۼ��� �� �ʿ��� �͵�
ROWNUM, ORDER BY, ROUND, GROUP BY, SUM, JOIN, DECODE, NVL, IN;

ROWNUM ���� ����
1. SELECT --> ORDER BY
    ���ĵ� ����� ROWNUM �� �����ϱ� ���ؼ��� INLINE-VIEW �̿�
2. 1������ ���������� ��ȸ�� �Ǵ� ���ǿ� ���ؼ��� WHERE ������ ����� �� �ִ�.
    ROWNUM = 1(O)
    ROWNUM = 2(X)
    ROWNUM < 10(O)
    ROWNUM > 10(X)
    


SELECT �� ��--------------------------------------------------------------------------------------;

-->[]���ȣ ��? �ɼ�. ���ü��� �ְ� ������ ���� ���� �ִ�.;
;
DESC emp;

ppt 291 �ǽ�;

empno �÷��� NOT NULL ���� ������ �ִ� - INSERT �� �ݵ�� ���� �����ؾ� ���������� �Էµȴ�.
empno �÷��� ������ ������ �÷��� NULLABLE �̴�. (NULL ���� ����� �� �ִ�. )
INSERT INTO emp (empno, ename, job)
VALUES (9999, 'brown', NULL);

SELECT *
FROM emp;
--> �� �������� ���� �ϳ� �þ �ִ�. 

INSERT INTO emp (ename, job)
VALUES ('sally', 'SALESMAN');
--> empno �� ���� ������ ���� �� ����. 

���ڿ� : '���ڿ�' ==> "���ڿ�" 
���� : 10
��¥ : TO_DATE('20200206','YYYYMMDD') ,SYSDATE;

emp ���̺��� hiredate �÷��� date Ÿ��
emp ���̺��� 8���� �÷��� ���� �Է�;

DESC emp;

INSERT INTO emp VALUES (9998, 'sally','SALESMAN',NULL, SYSDATE, 1000, NULL, 99 );
ROLLBACK;

�������� �����͸� �ѹ��� INSERT 
INSERT INTO ���̺�� (�÷���1, �÷���2.....)
SELECT ....
FROM ; --> SELECT �� ������� �ٷ� INSERT �Ѵ�.

INSERT INTO emp 
SELECT 9998, 'sally','SALESMAN',NULL, SYSDATE, 1000, NULL, 99 
FROM dual
    UNION ALL
SELECT 9999, 'brown','CLEAK',NULL,TO_DATE('20200205','YYYYMMDD'), 1100, NULL, 99 
FROM dual;


SELECT *
FROM emp;
-->insert �ι� �� �� �ѹ� �� -> �� ����



UPDATE ����
UPDATE ���̺�� �÷���1 = ������ �÷� ��1,�÷���2 = ������ �÷� ��2 ....
WHERE �� ���� ����;

������Ʈ ���� �ۼ��� WHERE ���� �������� ������ �ش� ���̺���
��� ���� ������� ������Ʈ�� �Ͼ��.
UPDATE, DELETE ���� WHERE ���� ������ �ǵ��� �� �´��� �ٽ� �ѹ� Ȯ���Ѵ�.
WHERE ���� �ִٰ� �ϴ��� �ش� �������� �ش� ���̺��� SELECT �ϴ� ������ �ۼ��Ͽ� �����ϸ�
UPDATE ��� ���� ��ȸ�� �� �����Ƿ� Ȯ���ϰ� �����ϴ� �͵� ��� �߻� ������ ������ �ȴ�;

99�� �μ���ȣ�� ���� �μ� ������ DEPT ���̺� �ִ� ��Ȳ
INSERT INTO dept VALUES (99, 'ddit', 'deajeon');
COMMIT;

SELECT *
FROM dept;

99�� �μ���ȣ�� ���� �μ��� dname �÷��� ���� '���IT', loc �÷��� ���� '���κ���' ���� ������Ʈ

UPDATE  ���̺�� SET �÷���1 = ������ �÷� ��1,�÷���2 = ������ �÷� ��2 ....
WHERE �� ���� ����;

UPDATE dept SET dname = '���IT', loc = '���κ���'
WHERE deptno = 99;

SELECT *
FROM dept;
ROLLBACK;

�Ǽ��� WHERE ���� ������� �ʾ��� ���
UPDATE dept SET dname = '���IT', loc = '���κ���';
/*WHERE deptno = 99;*/ --> WHERE���� �������� �ʾ����Ƿ� ��� ���� ������Ʈ�ȴ�. 
ROLLBACK;

SELECT *
FROM dept;

����� �ý��� ��ȣ�� �ؾ���� ==> �Ѵ޿� �ѹ��� ��� ������� �������
                                ���� �ֹι�ȣ ���ڸ��� ��й�ȣ�� ������Ʈ
�ý��� ����� : �����(12,000��), ������(550), ����(1,300)
UPDATE ����� SET ��й�ȣ = �ֹι�ȣ���ڸ�;
WHERE ����� ���� = '�����'; -->�̷��� �߾�� ��. 
--> WHERE ���� ���� ���� ��� : WEHER ���� �������� �ʾ����Ƿ� ��� ���� �ٲ�

10 --> SUBQUERY ;
SMITH, WARD�� ���� �μ��� �Ҽӵ� ���� ����;

SELECT *
FROM emp
WHERE deptno IN (20,30);

SELECT *
FROM emp
WHERE deptno IN (SELECT deptno
                 FROM emp
                 WHERE ename IN ('SMITH','WARD'));
                 
            
UPDATE �ÿ��� ���� ���� ����� ����;
SELECT *
FROM emp;

INSERT INTO emp (empno, ename) VALUES (9999, 'brown');
9999�� ��� deptno, job ������ SMITH ����� ���� �μ�����, �������� ������Ʈ;

UPDATE emp SET deptno = (SELECT deptno FROM emp WHERE ename = 'SMITH'), 
                job = (SELECT job FROM emp WHERE ename = 'SMITH')
WHERE empno = 9999;
ROLLBACK;


DELETE SQL :  Ư�� ���� ����
DELCTE [FROM] ���̺��
WHERE �� ���� ����;


SELECT *
FROM dept;

99�� �μ���ȣ�� �ش��ϴ� �μ� ���� ����
DELETE dept
WHERE deptno = 99;
COMMIT;

SUBQUERY �� ���ؼ� Ư�� ���� �����ϴ� ������ ���� DELETE ;
�Ŵ����� 76978 ����� ������ �����ϴ� ������ �ۼ�;

DELETE emp
WHERE empno IN (7499, 7521, 7654, 7844, 7900);

���� �Ʒ��� ���� ��;

DELETE emp
WHERE empno IN (SELECT empno
                FROM emp
                WHERE mgr = 7698);
ROLLBACK;

SELECT *
FROM emp;