1. leaf ���(��)�� � ���������� Ȯ��
2. LEVEL ==> ����Ž���� �׷��� ���� ���� �ʿ��� ��
2. leaf ������ ���� Ž��, ROWNUM

SELECT LPAD(' ',(level-1)*4) || org_cd, total
FROM
(SELECT org_cd, parent_org_cd, SUM(total) total
FROM
(SELECT org_cd, parent_org_cd, no_emp, gno,
        SUM(no_emp) OVER (PARTITION BY gno ORDER BY rn ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)total
FROM
(SELECT org_cd, parent_org_cd,lv, ROWNUM rn , lv+ROWNUM gno,
        no_emp/ COUNT(*) OVER (PARTITION BY org_cd) no_emp
FROM
    (SELECT no_emp.*, LEVEL lv, CONNECT_BY_ISLEAF leaf
    FROM no_emp
    START WITH parent_org_cd IS NULL
    CONNECT BY PRIOR org_cd = parent_org_cd)
START WITH leaf = 1
CONNECT BY PRIOR parent_org_cd = org_cd))
GROUP BY org_cd, parent_org_cd)
START WITH parent_org_cd IS NULL
CONNECT BY PRIOR org_cd = parent_org_cd;



�÷� �߰��Ϸ��ٰ� ���� ����...��.��....

gis_dt�� dt �÷����� 2020�� 2���� �ش��ϴ� ��¥�� �ߺ����� �ʰ� ���Ѵ� : �ִ� 29���� ��

----�� Ǯ�̵� : Ʋ�� -----
SELECT dt
FROM gis_dt
GROUP BY dt
HAVING dt = TO_DATE('02','MM');

DESC gis_dt;


SELECT dt
FROM
    (SELECT dt
    FROM gis_dt
    WHERE dt LIKE TO_CHAR(TO_DATE('02','MM')) )
GROUP BY dt;


SELECT dt
FROM
    (SELECT dt
    FROM gis_dt
    WHERE dt BETWEEN  TO_CHAR(TO_DATE('02','MM'))
GROUP BY dt;



----�л��� Ǯ��1------

SELECT TO_CHAR(dt,'YYYY-MM-DD')
FROM gis_dt
WHERE dt BETWEEN TO_DATE('20200201','YYYYMMDD') AND TO_DATE('20200229 23:59:59','YYYYMMDD hh24:mi:ss')
GROUP BY TO_CHAR(dt,'YYYY-MM-DD')
ORDER BY TO_CHAR(dt,'YYYY-MM-DD');


-----������ Ǯ��----
SELECT *
FROM 
(SELECT TO_DATE('20200201','YYYYMMDD') + (LEVEL-1)dt
FROM dual
CONNECT BY LEVEL <= 29) a
WHERE EXISTS (SELECT 'X'
              FROM gis_dt
              WHERE gis_dt.dt BETWEEN dt AND TO_DATE(TO_CHAR( dt, 'YYYYMMDD') || '235959', 'YYYYMMDDHH24MISS'));


PL/SQL ��� ����;

DECLARE : ����, ��� ���� [���� ����];
BEGIN : ���� ��� [���� �Ұ�]
EXCEPTION : ���� ó�� [���� ����]

PL/SQL ������;
�ߺ��Ǵ� ������ ���� Ư����
���� �����ڰ� �Ϲ����� ���α׷��� ���� �ٸ���.
java = 
pl/sql :=

PL/SQL ���� ����
JAVA : Ÿ�� ������ (String str);
PL/SQL : ������ Ÿ�� (deptno NUMBER(2);)

PL/SQL �ڵ� ������ �� ����� JAVA�� �����ϰ� �����ݷ��� ����Ѵ�.
java : String str;
pl/sql : deptno NUMBER(2);

PL/SQL ����� ���� ǥ���ϴ� ���ڿ� : /
SQL�� ���� ���ڿ� : ;

;

Hello World ���;

SET SERVEROUTPUT ON;

DECLARE
    msg VARCHAR2(50);
BEGIN 
    msg := 'Hello, World!';
    DBMS_OUTPUT.PUT_LINE(msg);
END;
/

�μ� ���̺��� 10�� �μ��� �μ���ȭ��, �μ��̸��� PL/SQL ������ �����ϰ�
������ ���;

DESC dept;

DECLARE
    v_deptno NUMBER(2);
    v_dname VARCHAR2(14);
BEGIN
    SELECT deptno, dname INTO v_deptno, v_dname
    FROM dept
    WHERE deptno = 10;
    
    DBMS_OUTPUT.PUT_LINE(v_deptno || ' : ' || v_dname);
END;
/


--------------
PL/SQL ���� Ÿ��
�μ� ���̺��� �μ���ȣ, �μ����� ��ȸ�Ͽ� ������ ��� ����
�μ���ȣ, �μ����� Ÿ���� �μ� ���̺� ���ǰ� �Ǿ� ����.

NUMBER, VARCHAR2 Ÿ���� ���� ����ϴ� �� �ƴ϶� �ش� ���̺��� �÷��� Ÿ���� �����ϵ���
���� Ÿ���� ���� �� �� �ִ�;

v_deptno NUMBER(2) ==> dept.deptno%TYPE ; 
;

DECLARE
    v_deptno dept.deptno%TYPE;
    v_dname dept.dname%TYPE;
BEGIN
    SELECT deptno, dname INTO v_deptno, v_dname
    FROM dept
    WHERE deptno = 10;
    
    DBMS_OUTPUT.PUT_LINE(v_deptno || ' : ' || v_dname);
END;
/

���ν��� ��� ����
�͸� ��(�̸��� ���� ��)
 . ������ �Ұ��� �ϴ� (IN-LINE VIEW VS VIEW)
���ν��� (�̸��� �ִ� ��)
 . ������ �����ϴ�.
 . �̸��� �ִ�.
 . ���ν����� ������ �� �Լ�ó�� ���ڸ� ���� �� �ִ�.
 
�Լ� (�̸��� �ִ� ��)
 . ���� �����ϴ�.
 . �̸��� �ִ�.
 . ���ν����� �ٸ� ���� ���� ���� �ִ�;
 
���ν��� ����
CREATE OR REPLACE PROCEDURE ���ν����̸� IS ( IN param, OUT param, IN OUT param )
    ����� (DECLARE ���� ������ ����)
    BEGIN 
    EXCEPTION (�ɼ�)
END;
/

�μ� ���̺��� 10�� �μ��� �μ���ȣ�� �μ��̸��� PL/SQL ������ �����ϰ�
DBMS_OUT.PUT_LINE �Լ��� �̿��Ͽ� ȭ�鿡 ����ϴ� printdept ���ν����� ����;

CREATE OR REPLACE PROCEDURE printdept IS
    v_deptno dept.deptno%TYPE;
    v_dname dept.dname%TYPE;
    
    BEGIN 
        SELECT deptno, dname INTO v_deptno, v_dname
        FROM dept
        WHERE  deptno = 10;
        
        DBMS_OUTPUT.PUT_LINE(v_deptno || ' : ' || v_dname );
    END;
/

���ν��� ���� ���
exec ���ν����� (����...);

EXEC printdept_sem;

printdept_p ���ڷ� �μ���ȣ�� �޾Ƽ�
�ش� �μ���ȣ�� �ش��ϴ� �μ��̸��� ���������� �ֿܼ� ����ϴ� ���ν���;

CREATE OR REPLACE PROCEDURE printdept_p(p_deptno IN dept.deptno%TYPE) IS
    v_dname dept.dname%TYPE;
    v_loc dept.loc%TYPE;
BEGIN 
    SELECT dname, loc INTO v_dname, v_loc
    FROM dept
    WHERE deptno = p_deptno;
    
    DBMS_OUTPUT.PUT_LINE(v_dname || ', ' || v_loc);
END;
/

EXEC printdept_p(40);


CREATE OR REPLACE PROCEDURE printemp (p_empno IN emp.empno%TYPE) IS
    v_ename emp.ename%TYPE;
    v_dname dept.dname%TYPE;
BEGIN 
    SELECT e.ename, d.dname INTO v_ename, v_dname
    FROM emp e JOIN dept d ON (e.deptno = d.deptno)  
    WHERE e.empno = p_empno;
    
    DBMS_OUTPUT.PUT_LINE(v_ename || ', ' || v_dname);
END;
/

EXEC printemp(7369);


SELECT *
FROM emp;

SELECT *
FROM dept;