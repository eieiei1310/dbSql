SUB4:-------------------------------------------------------------------------------------------
dept ���̺��� 5���� �����Ͱ� ����
emp ���̺��� 14���� ������ �ְ�, ������ �ϳ��� �μ��� ���� �ִ�. (deptno)
�μ� �� ������ ���� ���� ���� �μ� ������ ��ȸ;

������������ �������� ������ �´��� Ȯ���� ������ �ϴ� �������� �ۼ�; 

SELECT *
FROM dept 
WHERE deptno NOT IN (SELECT deptno
                     FROM emp);

SELECT DISTINCT deptno
FROM emp; --DISTINCT�� �������ִ� �÷��� ���� �ߺ��� �����Ѵ�,
         --GROUP BY �� ����� ȿ��
         
SUB5:;
SELECT *
FROM cycle; --cycle ��ü

SELECT *
FROM product; --product ��ü

SELECT pid
FROM cycle
WHERE cid = 1; --cid�� 1�� ���� �����ϴ� ��ǰ

SELECT *
FROM product
WHERE pid NOT IN (SELECT pid
                  FROM cycle
                  WHERE cid = 1); --��
         
SUB6:; -------------------------------------------------------------------------------------------   
cid = 2�� ���� �����ϴ� ��ǰ �� cid = 1�� ���� �����ϴ� ��ǰ�� ���������� ��ȸ�ϴ� ���� �ۼ�;

SELECT *
FROM cycle; --cycle ��ü

SELECT *
FROM product; --product ��ü

--cid= 1�� ���� �������� ==> 100, 400�� ��ǰ�� ������
SELECT pid
FROM cycle
WHERE cid = 1; --1������ �����ϴ� ��ǰ


--cid =2�� ���� ������ǰ - > 100, 200�� ��ǰ�� ������
SELECT pid
FROM cycle
WHERE cid = 2;

--cid = 1, cid2�� ���� ���ÿ� �����ϴ� ��ǰ�� 100����ǰ

SELECT *
FROM cycle
WHERE cid = 1 
and pid IN (SELECT pid
            FROM cycle
            WHERE cid = 2);
            
SUB7:; -------------------------------------------------------------------------------------------   

SELECT *
FROM cycle; --cycle ��ü

SELECT *
FROM product; --product ��ü

SELECT *
FROM customer;

--���� ���� ��. 
SELECT cycle.cid, cnm, cycle.pid, pnm, day, cnt
FROM cycle JOIN product on (cycle.pid = product.pid)
           JOIN customer on (cycle.cid = customer.cid)
WHERE cycle.cid = 1 
and cycle.pid IN (SELECT cycle.pid
                   FROM cycle
                    WHERE cycle.cid = 2);
--������ ��

SELECT *
FROM 
      ( SELECT *
        FROM cycle
        WHERE cid = 1 
        and pid IN (SELECT pid
                    FROM cycle
                    WHERE cid = 2)) a, customer, product
WHERE a.cid = customer.cid
AND a.pid = product.pid;

--��Į�� ���������� �̿��ϴ� �͵� �����ϴ�. �̿��ϸ� ������ �ʿ� ����. 
--�׷��� ���� ���� ����� �ƴ�. ����x 

--EXISTS ������

�Ŵ����� �����ϴ� ���� ��ȸ
�ǽ�8;

SELECT *
FROM emp
WHERE mgr IS NOT NULL;  -->EXISTS �����ڸ� �̿����� �ʰ� �ۼ��غ�����.

SELECT *
FROM emp a
WHERE EXISTS (SELECT 'x'
              FROM emp b
              WHERE b.empno = a.mgr); 
              
EXSITS ���ǿ� �����ϴ� ���� ���� �ϴ��� Ȯ���ϴ� ������
�ٸ� �����ڿ� �ٸ��� WHERE ���� �÷��� ������� �ʴ´�. --�ٸ� �����ڿ� �ٸ��� ������ �� ���ٴ� ���̴�...
 - WHERE empno = 7369
 - WHERE EXISTS (SELECT 'X'
                 FROM .....)

�Ŵ����� �����ϴ� ������ EXISTS �����ڸ� ���� ��ȸ;
�Ŵ����� �����̴�.
SELECT empno, ename, mgr
FROM emp e
WHERE EXISTS (SELECT 'X'
              FROM emp m
              WHERE e.mgr = m.empno);


�ǽ�9;
SELECT *
FROM product
WHERE EXISTS (SELECT 'X'
              FROM cycle
              WHERE cycle.pid = product.pid AND cycle.cid = 1);



�ǽ�10;
SELECT *
FROM product
WHERE NOT EXISTS (SELECT 'X'
                  FROM cycle
                  WHERE cycle.pid = product.pid AND cycle.cid = 1);
                  
SELECT *
FROM product
WHERE EXISTS (SELECT 'X'
                  FROM cycle
                  WHERE cycle.pid = product.pid AND cycle.cid IN(2,3)); --> �� �̰� �ȵ�???
                  

���տ���
������: UNION - �ߺ����� (���հ���) /UNION ALL - �ߺ��� �������� ����(�ӵ� ���)
������: INTERSECT (���հ���)
������: MINUS (���հ���);
���տ��� �������
�� ������ �÷��� ����, Ÿ���� ��ġ�ؾ��Ѵ�. 

SELECT empno, ename
FROM emp 
WHERE empno IN(7566,7698)

UNION

SELECT empno, ename
FROM emp 
WHERE empno IN(7566,7698); 
--> ������ ������ �����ϱ� ������ �ߺ��Ǵ� �����ʹ� �ѹ��� ����ȴ�.

SELECT empno, ename
FROM emp 
WHERE empno IN(7566,7698)

UNION ALL 

SELECT empno, ename
FROM emp 
WHERE empno IN(7566,7698); 
--> ������, �Ϲ��� ������ ���信�� �ߺ��� �������� ����.
--> ���Ʒ� ������ �ܼ� �����Ѵ�. 

-->UNION ALL�����ڴ� UNION�����ڿ� �ٸ��� �ߺ��� ����Ѵ�.


INTERSECT(������) : ��, �Ʒ� ���տ��� ���� ���� �ุ ��ȸ;

SELECT empno, ename
FROM emp 
WHERE empno IN(7566,7698,7369)

INTERSECT

SELECT empno, ename
FROM emp 
WHERE empno IN(7566,7698); 

MINUS(������) : �� ���տ��� �Ʒ� ������ �����͸� ������ ������ ����;

SELECT empno, ename
FROM emp 
WHERE empno IN(7566,7698,7369)

MINUS

SELECT empno, ename
FROM emp 
WHERE empno IN(7566,7698); 

������ ��� ������ ������ ���� ���տ�����
A UNION B                    B UNION A ==> ����
A UNION ALL B                B UNION ALL A ==> ���� 
A INTERSECT B                B INTERSECT A ==> ����
A MINUS B                    B MINUS A ==> �ٸ�;

���տ����� ��� �÷� �̸��� ù��° ������ �÷����� ������;

SELECT 'X' ,'B' sec 
FROM dual

UNION

SELECT 'Y' ,'A'
FROM dual;

����(ORDER BY)�� ���տ��� ���� ������ ���� ������ ���;

SELECT deptno, dname, loc
FROM dept
WHERE deptno IN (10,20)

UNION 

SELECT deptno, dname, loc --> *�� �ƴ϶� ��ü ���� �ٽ��...?
FROM dept
WHERE deptno IN (30, 40)
ORDER BY dname; -->�̰��� ����� �Ѵ�. 


-----------------


SELECT deptno, dname, loc
FROM (SELECT deptno, dname, loc
      FROM dept
      WHERE deptno IN (10,20)
      ORDER BY deptno DESC)

UNION ALL

SELECT deptno, dname, loc --> *�� �ƴ϶� ��ü ���� �ٽ��...?
FROM (SELECT deptno, dname, loc
      FROM dept
      WHERE deptno IN (30,40)
      ORDER BY deptno);

�ܹ��� ���� ��������;
��ü:;
SELECT sido, sigungu, gb
FROM fastfood
WHERE gb NOT IN ('������ġ');

--��ü �õ��� �ñ����� ����


--�� ã�� ��������? ~�ñ����� ����ŷ ����.
SELECT sido, sigungu , count(*)
FROM fastfood
GROUP BY sido, sigungu;


SELECT *
FROM fastfood
WHERE sido = '������'
AND sigungu = '��õ��';



�õ�, �ñ���, ��������
--�ܹ��� ���� ��������
--(����ŷ, �Ƶ�����, kfc�� ����)/�Ե������� ����

--�õ�, �ñ����� �׷����� ����
SELECT sido, sigungu , count(*)
FROM fastfood
GROUP BY sido, sigungu;





--������ ����� �������� :0.28
--������ �߱� ��������   :1.66
--������ ���� ��������   :1.41
--������ ������ �������� :0.5
--������ ���� ��������   :0.5



SELECT count(*)
FROM fastfood
WHERE sido = '����������'
AND sigungu = '�����'
AND gb = '����ŷ'; --0

SELECT count(*)
FROM fastfood
WHERE sido = '����������'
AND sigungu = '�����'
AND gb = '�Ƶ�����'; --2

SELECT count(*)
FROM fastfood
WHERE sido = '����������'
AND sigungu = '�����'
AND gb = 'KFC'; --0

SELECT count(*)
FROM fastfood
WHERE sido = '����������'
AND sigungu = '�����'
AND gb = '�Ե�����'; --7

--������ ������� �������� : 2/7 = 0.28

---------
SELECT count(*)
FROM fastfood
WHERE sido = '����������'
AND sigungu = '�߱�'
AND gb = '����ŷ';  --2

SELECT count(*)
FROM fastfood
WHERE sido = '����������'
AND sigungu = '�߱�'
AND gb = '�Ƶ�����'; --4

SELECT count(*)
FROM fastfood
WHERE sido = '����������'
AND sigungu = '�߱�'
AND gb = 'KFC'; --1

SELECT count(*)
FROM fastfood
WHERE sido = '����������'
AND sigungu = '�߱�'
AND gb = '�Ե�����'; --6

--������ �߱��� �������� : 7/6 = 1.66

---------

SELECT count(*)
FROM fastfood
WHERE sido = '����������'
AND sigungu = '����'
AND gb = '����ŷ'; --6

SELECT count(*)
FROM fastfood
WHERE sido = '����������'
AND sigungu = '����'
AND gb = '�Ƶ�����'; --7

SELECT count(*)
FROM fastfood
WHERE sido = '����������'
AND sigungu = '����'
AND gb = 'KFC'; --4

SELECT count(*)
FROM fastfood
WHERE sido = '����������'
AND sigungu = '����'
AND gb = '�Ե�����';  --12

--������ ������ �������� 17/12 --> 1.41



SELECT count(*)
FROM fastfood
WHERE sido = '����������'
AND sigungu = '������'
AND gb = '����ŷ'; --1

SELECT count(*)
FROM fastfood
WHERE sido = '����������'
AND sigungu = '������'
AND gb = '�Ƶ�����'; --3

SELECT count(*)
FROM fastfood
WHERE sido = '����������'
AND sigungu = '������'
AND gb = 'KFC'; --0

SELECT count(*)
FROM fastfood
WHERE sido = '����������'
AND sigungu = '������'
AND gb = '�Ե�����'; --8

--������ �������� �������� 4/8
--> 0.5


SELECT count(*)
FROM fastfood
WHERE sido = '����������'
AND sigungu = '����'
AND gb = '����ŷ';  --2

SELECT count(*)
FROM fastfood
WHERE sido = '����������'
AND sigungu = '����'
AND gb = '�Ƶ�����'; --2

SELECT count(*)
FROM fastfood
WHERE sido = '����������'
AND sigungu = '����'
AND gb = 'KFC';  --0

SELECT count(*)
FROM fastfood
WHERE sido = '����������'
AND sigungu = '����'
AND gb = '�Ե�����'; --8

--������ ������ �������� 4 / 8
-->0.5

