SELECT *
FROM cycle;

1�� ���� 100�� ��ǰ�� �����ϳ� 1�� ����
2020�� 2���� ���� �� ������ ����
1. 2020�� 2���� �����Ͽ� ���� �� ���� ����
1 100 2  1   �� ���� ���� 4���� ������ �����Ǿ�� �Ѵ�.
1 100 20200203  1
1 100 20200210  1
1 100 20200217  1
1 100 20200224  1
--
SELECT TO_CHAR(TO_DATE('202002' || '01','YYYYMMDD') + (LEVEL -1),'YYYYMMDD') dt,
       TO_CHAR(TO_DATE('202002' || '01','YYYYMMDD') + (LEVEL -1),'D') d
FROM dual
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE('202002' || '01','YYYYMMDD')),'DD');


SELECT*
FROM cycle;
DESC cycle;

DESC daily;  --cid, pid, dt, cnt

SELECT *
FROM daily;

pro_4;

CREATE OR REPLACE PROCEDURE create_daily_sales(p_yyyymm IN daily.dt%TYPE) IS
    TYPE cal_row IS RECORD(
        dt VARCHAR2(8),
        d NUMBER);
    TYPE cal_tab IS TABLE OF cal_row INDEX BY BINARY_INTEGER;
    v_cal_tab cal_tab;
    
BEGIN 

    SELECT TO_CHAR(TO_DATE(p_yyyymm || '01','YYYYMMDD') + (LEVEL -1),'YYYYMMDD') dt,
            TO_CHAR(TO_DATE(p_yyyymm || '01','YYYYMMDD') + (LEVEL -1),'D') d
            BULK COLLECT INTO v_cal_tab
        FROM dual
        CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE('202002' || '01','YYYYMMDD')),'DD');
       --�Ͻ��� �����͸� �����ϱ� ���� ������ ������ �����͸� ����
       DELETE daily
       WHERE dt LIKE p_yyyymm || '%';
       
        --�����ֱ� ������ ��ȸ
         FOR daily_row IN (SELECT * FROM cycle) LOOP
         DBMS_OUTPUT.PUT_LINE(daily_row.cid || ' ' || daily_row.pid || daily_row.day || ' ' || daily_row.cnt);
         FOR i IN 1..v_cal_tab.COUNT LOOP
         
           -- OUTER LOOP(�����ֱ�)���� ���� �����̶� INNER LOOP(�޷�)���� ���� ������ ���� �����͸� üũ
            IF daily_row.day = v_cal_tab(i).d THEN
                INSERT INTO daily VALUES (daily_row.cid, daily_row.pid,v_cal_tab(i).dt, daily_row.cnt);
                 DBMS_OUTPUT.PUT_LINE(v_cal_tab(i).dt || ' ' || v_cal_tab(i).d);
            END IF;
         END LOOP;
    END LOOP;
    
    COMMIT;
END;
/
SET SERVEROUTPUT ON;

SELECT *
FROM daily;

EXEC create_daily_sales('202002');


SELECT *
FROM daily;
WHERE dt LIKE '202002%';


create_daily_sales ���ν������� �Ǻ��� insert �ϴ� ������
INSERT SELECT ����, ONE-QUERY ���·� �����Ͽ� �ӵ��� ����;

SELECT *
FROM cycle;

DELETE daily
WHERE dt LIKE '202002%';

SELECT cycle.cid, cycle.pid, cal.dt, cycle.cnt
FROM cycle,
    (SELECT TO_CHAR(TO_DATE('202002','YYYYMM') + (LEVEL - 1),'YYYYMMDD')dt,
           TO_CHAR(TO_DATE('202002','YYYYMM') + (LEVEL - 1),'D')d
    FROM dual
    CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE('202002','YYYYMM')),'DD')) cal
WHERE cycle.day = cal.d;



-------����--------

PL/SQL ������ SELECT ����� ��� ���� : NO_DATE_FOUND;

DECLARE
    v_dname dept.dname%TYPE;
BEGIN
    SELECT dname INTO v_dname
    FROM dept
    WHERE deptno = 70;
EXCEPTION
    WHEN no_data_found THEN
        DBMS_OUTPUT.PUT_LINE('NO_DATE_FOUND');
    WHEN too_many_rows THEN
        DBMS_OUTPUT.PUT_LINE('TOO_MANY_ROWS');
END;
/


����� ���� ����
NO_DATE_FOUND ==> �츮�� ���� ���� ����� ���ܷ� �����Ͽ� ���Ӱ� ���ܸ� ������ ����;

DECLARE
    no_emp EXCEPTION; 
    v_ename emp.ename%TYPE;
    
BEGIN
    BEGIN 
        SELECT ename INTO v_ename
        FROM emp
        WHERE empno = 8000;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN 
            RAISE no_emp;
    END;
EXCEPTION 
    WHEN no_emp THEN
        DBMS_OUTPUT.PUT_LINE('no_emp');
        
END;
/

emp ���̺��� ���ؼ��� �μ� �̸��� �� ���� ����. (�μ��̸� dept ���̺� ����)
==> 1. join
    2. �������� - ��Į�� ��������(SELECT)

SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno;

SELECT emp.* , (SELECT dname 
              FROM dept 
              WHERE dept.deptno = emp.deptno) dname
FROM emp;

�μ���ȣ�� ���ڹް� �μ� ���� �������ִ� �Լ� ����
getDeptName;

CREATE OR REPLACE FUNCTION getDeptName(p_deptno dept.deptno%TYPE) RETURN VARCHAR2 IS
    v_dname dept.dname%TYPE;
BEGIN
    SELECT dname INTO v_dname
    FROM dept
    WHERE deptno = p_deptno;
    
    RETURN v_dname;
END;
/

SELECT emp.*, getDeptName(emp.deptno)
FROM emp;


getDeptName �Լ��� ����
������ȣ�� ���ڷ� �ϰ�
�ش� ������ �̸��� �������ִ� �Լ��� �����غ�����.

SMITH;
SELECT getEmpname(7369) smith
FROM dual;

SELECT *
FROM emp;

CREATE OR REPLACE FUNCTION getEmpname(p_empno emp.empno%TYPE) RETURN VARCHAR2 IS
    v_ename emp.ename%TYPE;
BEGIN
    SELECT ename INTO v_ename
    FROM emp
    WHERE empno = p_empno;
    
    RETURN v_ename;
END;
/

SELECT dept_h.*, level
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd;


SELECT LPAD(' ' , (LEVEL-1)*4) || deptnm 
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd;


------------����
SELECT getPadding(LEVEL,2) || deptnm 
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd;

SELECT *
FROM dept_h;   

SELECT *
FROM dual;

-----Ǯ����!!!!------
CREATE OR REPLACE FUNCTION getPadding(p_level NUMBER, p_blank NUMBER ) RETURN VARCHAR2 IS
    padding VARCHAR2(20);
BEGIN
    SELECT LPAD(' ' , (p_level-1)*p_blank) INTO padding
    FROM dual;
    RETURN padding;
END;
/

SELECT getPadding(LEVEL,4) || deptnm 
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd;

-------------------������Ǯ��--------------

CREATE OR REPLACE FUNCTION getPadding_sem(p_lv NUMBER, p_indent NUMBER , p_padding VARCHAR2) RETURN VARCHAR2 IS
    v_padding VARCHAR2(200);
BEGIN
    SELECT LPAD(' ',(p_lv - 1) * p_indent ,p_padding) INTO v_padding
    FROM dual;
    
    RETURN v_padding;
    
END;
/

SELECT getPadding_sem(LEVEL,5,'-') || deptnm 
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd;

SELECT * 
FROM TABLE(dbms_xplan.display);

PACKAGE - ������ PL/SQL ����� �����ִ� ����Ŭ ��ü
�����
��ü(������)�� ����

getempname, getdeptname == >replace NAMES ��Ű���� ��´�;

CREATE OR REPLACE PACKAGE names AS 
    FUNCTION getEmpname(p_empno emp.empno%TYPE) RETURN VARCHAR2;
    FUNCTION getDeptName(p_deptno dept.deptno%TYPE) RETURN VARCHAR2;
END names;
/

CREATE OR REPLACE PACKAGE BODY names AS

    FUNCTION getDeptName(p_deptno dept.deptno%TYPE) RETURN VARCHAR2 AS
        v_dname dept.dname%TYPE;
    BEGIN
        SELECT dname INTO v_dname
        FROM dept
        WHERE deptno = p_deptno;
        
        RETURN v_dname;
    END;
    
    FUNCTION getEmpname(p_empno emp.empno%TYPE) RETURN VARCHAR2 AS
        v_ename emp.ename%TYPE;
    BEGIN
        SELECT ename INTO v_ename
        FROM emp
        WHERE empno = p_empno;
        
        RETURN v_ename;
    END;
END;
/ 

SELECT emp.*, NAMES.GETDEPTNAME(emp.deptno) dname
FROM emp;