������ SQL �����̶� : �ؽ�Ʈ�� �Ϻ��ϰ� ������ SQL
1. ��ҹ��� ����
2. ���鵵 �����ؾ���.
3. ��ȸ ����� ���ٰ� ������ SQL�� �ƴ�
4. �ּ��� ������ ��ħ

�׷��� ������ ���� �� ���� SQL������ ������ ������ �ƴ�;

SELECT * FROM dept;
select * FROM dept;
select   * FROM dept;
select *
FROM dept;


SQL ����� v$SQL �信 �����Ͱ� ��ȸ�Ǵ��� Ȯ��;
SELECT */*sql_test*/ 
FROM dept
WHERE deptno = 10;

SELECT */*sql_test*/ 
FROM dept
WHERE deptno = 20;
�� �ΰ��� SQL�� �˻��ϰ��� �ϴ� �μ���ȣ�� �ٸ��� ������ �ؽ�Ʈ�� �����ϴ�. 
������ �μ���ȣ�� �ٸ��� ������ DBMS ���忡���� ���� �ٸ� SQL�� �νĵȴ�.
==> �ٸ� SQL ���� ��ȹ�� �����.
==> ���� ��ȹ�� �������� ���Ѵ�.
===> �ذ�å ���ε� ����
SQL�ּ� ����Ǵ� �κ��� ������ ������ �ϰ�
�����ȹ�� ������ ���Ŀ� ���ε� �۾��� ����
���� ����ڰ� ���ϴ� ���� ������ ġȯ �� ����
==> �����ȹ�� ���� ==> �޸� �ڿ� ���� ����;

SELECT *
FROM v$SQL
WHERE sql_text LIKE '%dept%';
-> �ý��� �������� �����ϸ� ��ȸ�� ���������� �� ���´�.


SELECT /*sql_test*/ *
FROM dept
WHERE deptno = :deptno;

SQL Ŀ�� : SQL���� �����ϱ� ���� �޸� ����
������ ����� SQL���� ������ Ŀ���� ���.
������ �����ϱ� ���� Ŀ�� : ����� Ŀ��
SELECT ��� ���� ���� TABLE Ÿ���� ������ ������ �� ������
�޸𸮴� �������̱� ������ ���� ���� �����͸� ��⿡�� ������ ����.

SQL Ŀ���� ���� �����ڰ� ���� �����͸� FETCH �����ν� SELECT �����
���� �ҷ����� �ʰ� ������ �����ϴ�.

--�ڹ� ���ͷ����Ϳ� ���
Ŀ�� ���� ���:
����ο��� ����
    CURSOR Ŀ���̸� IS 
        ������ ����;
�����(BEGIN)���� Ŀ�� ����
    OPEN Ŀ���̸�;
�����(BEGIN)���� Ŀ���κ��� ������ FETCH
    FETCH Ŀ���̸� INTO ����;
�����(BEGIN)���� Ŀ�� �ݱ�
    CLOSE Ŀ���̸�;
    
�μ� ���̺��� Ȱ���Ͽ� ��� �࿡ ���� �μ���ȣ�� �μ� �̸��� CURSOR �� ����
FETCH, FETCH �� ����� Ȯ��;

SET SERVEROUTPUT ON ;
DECLARE 
    v_deptno dept.deptno%TYPE;
    v_dname dept.dname%TYPE;
    
    CURSOR dept_cursor IS
        SELECT deptno, dname
        FROM dept;
        
BEGIN
    OPEN dept_cursor;
    
    FETCH dept_cursor INTO v_deptno , v_dname;
    DBMS_OUTPUT.PUT_LINE(v_deptno || ' : ' || v_dname);
    
      FETCH dept_cursor INTO v_deptno , v_dname;
    DBMS_OUTPUT.PUT_LINE(v_deptno || ' : ' || v_dname);
    
      FETCH dept_cursor INTO v_deptno , v_dname;
    DBMS_OUTPUT.PUT_LINE(v_deptno || ' : ' || v_dname);
    
      FETCH dept_cursor INTO v_deptno , v_dname;
    DBMS_OUTPUT.PUT_LINE(v_deptno || ' : ' || v_dname);
    
        
END;
/



CURSOR �� ���� �ݴ� ������ �ټ� �����彺����.
CURSOR �� �Ϲ������� LOOP�� �Բ� ����ϴ� ��찡 ����
==> ����� Ŀ���� FOR LOOP ���� ����� �� �ְԲ� �������� ����;

List<String> userNameList = new ArraysList<String>();
userNameList.add("brown");
userNameList.add("cony");
userNameList.add("sally");

�Ϲ� for
for(int i = 0; i < userNameList.size(); i++){
    String userName = userNameList.get(i);
}
���� for
for(String userName : userNameList){
    userName���� ���.....
}

java�� ���� for���� ����
FOR record_name(�� ���� ������ ���� �����̸� / ������ ���� �������)IN Ŀ���̸� LOOP
    record_name.�÷���
END LOOP; ;


DECLARE
    v_deptno dept.deptno%TYPE;
    v_deptno dept.dname%TYPE;
    
    CURSOR dept_cursor IS
        SELECT deptno, dname
        FROM dept;
BEGIN 
    FOR rec IN dept_cursor LOOP
        DBMS_OUTPUT.PUT_LINE(rec.deptno || ' : ' || rec.dname);
    END LOOP;
END;
/


���ڰ� �ִ� ����� Ŀ��
���� Ŀ�� ������
    CURSOR Ŀ���̸� IS
        ��������...;
���ڰ� �ִ� Ŀ�� ������
    CURSOR Ŀ���̸�(����1 ����1Ÿ��.....) IS
        ��������
        (Ŀ�� ����ÿ� �ۼ��� ���ڸ� ������������ ����� �� �ִ�.);
        
DECLARE
    v_deptno dept.deptno%TYPE;
    v_deptno dept.dname%TYPE;
    
    CURSOR dept_cursor(p_deptno dept.deptno%Type) IS
        SELECT deptno, dname
        FROM dept
        WHERE deptno <= p_deptno;
BEGIN 
    FOR rec IN dept_cursor(20) LOOP
        DBMS_OUTPUT.PUT_LINE(rec.deptno || ' : ' || rec.dname);
    END LOOP;
END;
/


�������̽��� �̿��Ͽ� ��ü�� ���� �����Ѱ�?

FOR LOOP ���� Ŀ���� �ζ��� ���·� �ۼ�;
FOR ���ڵ��̸� IN Ŀ���̸�
==> 
FOR ���ڵ��̸� IN (��������);

DECLARE
BEGIN 
    FOR rec IN (SELECT deptno, dname FROM dept) LOOP
        DBMS_OUTPUT.PUT_LINE(rec.deptno || ' : ' || rec.dname);
    END LOOP;
END;
/

SELECT *
FROM DT;


PL/SQL �������� �ǽ� PRO_3;


----�����Ѱ�(�ϼ�������)----
DECLARE 
    TYPE dt_tab IS TABLE OF dt%ROWTYPE INDEX BY BINARY_INTEGER;
    v_dt_tab dt_tab;
BEGIN
    SELECT * BULK COLLECT INTO v_dt_tab
    FROM dt;

    FOR i IN 1..v_dt_tab.count -1 LOOP
    DBMS_OUTPUT.PUT_LINE(v_dt_tab(i).dt - v_dt_tab(i + 1).dt);
    END LOOP;

END;
/


----�������� �Ѱ�----

CREATE OR REPLACE PROCEDURE avgdt IS
    TYPE dt_tab IS TABLE OF dt%ROWTYPE INDEX BY BINARY_INTEGER;
    v_dt_tab dt_tab;
    v_diff_sum NUMBER := 0;
BEGIN
    SELECT * BULK COLLECT INTO v_dt_tab
    FROM dt;
    
    --DT ���̺��� 8���� �ִµ� 1~7�� ������� LOOP�� ����
    FOR i IN 1..v_dt_tab.count -1 LOOP
       v_diff_sum := v_diff_sum + v_dt_tab(i).dt - v_dt_tab(i+1).dt;
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE (v_diff_sum / (v_dt_tab.count -1 ));
    
END;
/

EXEC avgdt;


------------PLSQL ������� �ʰ� SQL���θ� �غ���---------

--1.    
SELECT dt , (LAG(dt) OVER(ORDER BY dt))
FROM dt;

--2.
SELECT SUM(dt) / count(dt) result
FROM
    (SELECT (dt -(LAG(dt) OVER(ORDER BY dt) ))dt 
    FROM dt);

------------PLSQL ������� �ʰ� SQL���θ� �غ���(������)----------
--(1)
SELECT AVG(diff)
FROM
(SELECT dt - LEAD(dt) OVER (ORDER BY dt DESC) diff
FROM dt);

--(2)
MAX, MIN, COUNT

SELECT (MAX(dt) - MIN(dt)) / (COUNT(dt) - 1) result
FROM dt;