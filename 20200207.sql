TRUNCATE �׽�Ʈ
1. REDO �α׸� �������� �ʱ� ������ ������ ������ ������ �Ұ��ϴ�.
2. DML (SELECT, INSERT, UPDATE, DELETE)�� �ƴ϶� 
    DDL�� �з� (ROLLBACK)�� �Ұ�
    
�׽�Ʈ �ó�����
EMP ���̺��� ���縦 �Ͽ� EMP_COPY ��� �̸����� ���̺� ����
EMP_COPY ���̺��� ������� TRUNCATE TABLE EMP_COPY ����

EMP_COPY ���̺� �����Ͱ� �����ϴ���(���������� ������ �Ǿ�����) Ȯ��;

EMP_COPY ���̺� ����;
CREATE -> DDL (ROLLBACK�� �ȵȴ�);

CREATE TABLE EMP_COPY AS
SELECT *
FROM emp;

SELECT *
FROM emp_copy;

TRUNCATE TABLE emp_copy;

TRUNCATE TABLE ��ɾ�� DDL �̱� ������ ROLLBACK �� �Ұ��ϴ�.
ROLLBACK �� SELECT �� �� ���� �����Ͱ� �������� ���� ���� �� �� �ִ�;
ROLLBACK;

��ȭ ���� -->�����, ���� �ȵŵ� �׳� �Ѿ��

-------------------

���̺�� �÷��� ��Ģ ppt3 �߸���
���ڵ� ����

------------------

DDL : Date Definition Language - ������ ���Ǿ�
��ü�� ����, ����, ������ ���;
ROLLBACK �Ұ�
�ڵ� COMMIT;

���̺� ����
CREATE TABLE [��Ű����.]���̺��(
    �÷��� �÷�Ÿ�� [DEFAULT �⺻��] , 
    �÷�2�� �÷�2Ÿ�� [DEFAULT �⺻��] ,... 
);

ranger��� �̸��� ���̺� ����;
CREATE TABLE ranger(
    ranger_no NUMBER,
    ranger_nm VARCHAR2(50),
    reg_dt DATE DEFAULT SYSDATE
);

SELECT *
FROM ranger;

INSERT INTO ranger (ranger_no, ranger_nm ) VALUES (1,'brown');
COMMIT;
-->��Ű����: ���Ӱ�����

���̺� ���� 
DROP TABLE ���̺��; 

ranger ���̺� ����(drop)
DROP TABLE ranger;

DDL�� �ѹ� �Ұ�
ROLLBACK;

���̺��� �ѹ���� ���� ���� Ȯ���� �� �ִ�.
SELECT *
FROM ranger;

������Ÿ��
���ڿ�(VARCHAR2 ���, CHAR Ÿ�� ��� ����)

VARCHAR(10) : �������� ���ڿ�, ������ 1~4000BYTE 
             �ԷµǴ� ���� �÷� ������� �۾Ƶ� ���� ������ �������� ä���� �ʴ´�.
             
CHAR(10) : �������� ���ڿ�
           �ش� �÷��� ���ڿ��� 5byte �� �����ϸ� ������ 5 byte�� �������� ä������.
           'test' ==> 'test     '
           --����! 'text' != 'text     '

����
NUMBER(p,s) : p - ��ü�ڸ��� (38), s - �Ҽ��� �ڸ���
INTEGER ==> NUMBER(38,0)
ranger_no NUMBER ==> NUMBER(38,0)

��¥
DATE - ���ڿ� �ð� ������ ����
       7BYTE 

��¥ - DATE
       VARCHAR2(8) - '20200207' 
      �� �ΰ��� Ÿ���� �ϳ��� �����ʹ� 1BYTE�� ����� ���̰� ����.
      ������ ���� �������� �Ǹ� ������ �� ���� �������, ����� Ÿ�Կ� ���� ����� �ʿ�;

LOB(Large OBject) - �ִ� 4GB
CLOB - Character Large OBject
        VARCHAR2�� ���� �� ���� �������� ���ڿ�(4000byte �ʰ� ���ڿ�)
        ex: �� �����Ϳ� ������ html �ڵ�
BLOB - Byte Large OBject
       ������ �����ͺ��̽��� ���̺��� ������ ��
       
       �Ϲ������� �Խñ� ÷�������� ���̺� ���� �������� �ʰ�
       ���� ÷�������� ��ũ�� Ư�� ������ �����ϰ�, �ش� [���]�� ���ڿ��� ����
       
       ������ �ſ� �߿��� ��� : �� ������� ���Ǽ� - > [����] �� ���̺� ����
PPT 10������ ���� �߿��� ���� �ƴ�

�������� : �����Ͱ� ���Ἲ�� ��Ű���� �ϱ� ���� ����
1.  UNIQUE ���� ����
    �ش� �÷��� ���� �ٸ� ���� �����Ϳ� �ߺ����� �ʵ��� ����
    ex : ����� ���� ����� ���� �� ����.
    
2. NOT NULL ���� ���� (CHECK ���� ����)
    �ش� �÷��� ���� �ݵ�� �����ؾ� �ϴ� ����.
    ex : ��� �÷��� NULL�� ����� ������ �� ����.
          ȸ�����Խ� �ʼ� �Է»���(GITHUB - �̸���, �̸�)
         
3. PRIMARY KEY ���� ����
    UNIQUE + NOT NULL
      ex : ����� ���� ����� ���� �� ����, ����� ���� ����� ���� ���� ����.
      PRIMARY KEY ���� ������ ������ ��� UNIQUE INDEX�� �����ȴ�.
      
4. FOREIGN KEY ���� ���� (�������Ἲ)
    �ش� �÷��� �����ϴ� �ٸ� ���̺� ���� �����ϴ� ���� �־�� �Ѵ�.
    emp ���̺��� deptno �÷��� dept ���̺��� deptno�÷��� ����(����)
    emp ���̺��� deptno �÷����� dept ���̺� �������� �ʴ� �μ���ȣ�� �Էµ� �� ����.
    ex : ���� dept ���̺��� �μ���ȣ�� 10, 20, 30, 40���� ������ ���
        emp ���̺� ���ο� ���� �߰� �ϸ鼭 �μ���ȣ ���� 99������ ����� ���
        �� �߰��� �����Ѵ�. 
        
5. CHECK ���� ����(���� üũ)
    NOT NULL ���� ���ǵ� CHECK ���࿡ ����
    emp ���̺� job �÷��� ���� �� �ִ� ���� 'SALESMAN', 'PRESIDENT','CLEAK' ���� �����Ѵ�.
    
�������� ���� ���
1. ���̺��� �����ϸ鼭 �÷��� ���
2. ���̺��� �����ϸ鼭 �÷� ��� ���Ŀ� ������ ���������� ���
3. ���̺��� ������ ������ �߰������� ���������� �߰�

CREAT TABLE ���̺��(
    �÷�1 �÷� Ÿ��[1.��������], 
    �÷�2 �÷� Ÿ��[1.��������],
    
   (2.TABLE_CONSTRAINT)
);

3. ALTER TABLE emp........

PRIMARY KEY ���������� �÷� ������ ����(1�� ���)
dept�� ���̺��� �����Ͽ� dept_test ���̺��� PRIMARY KEY �������ǰ� �Բ� ����
�� �� ����� ���̺��� KEY �÷��� �����÷��� �Ұ�, �����÷��� ���� �����ϴ�.;

CREATE TABLE dept_test(
    deptno NUMBER(2) PRIMARY KEY ,
    dname VARCHAR2(14),
    loc VARCHAR2(13)
);

INSERT INTO dept_test(deptno) VALUES (99); ���������� ����
INSERT INTO dept_test(deptno) VALUES (99); �ٷ� ���� ������ ���� ���� ���� �����Ͱ� �̹� ����� --����

�������, �츮�� ���ݱ��� ����� dept ���̺��� deptno �÷�����
UNIQUE �����̳� PRIMARY KEY ���� ������ ������ ������
�Ʒ� �ΰ��� INSERT ������ ���������� ����ȴ�;

INSERT INTO dept(deptno) VALUES (99);
INSERT INTO dept(deptno) VALUES (99);

ROLLBACK;

�������� Ȯ�� ���;
1. TOOL �� ���� Ȯ��
    Ȯ���ϰ��� �ϴ� ���̺��� ����
2. dictionary �� ���� Ȯ��(USER_TABLES);

SELECT *
FROM USER_CONSTRAINTS
WHERE table_name = 'DEPT_TEST';�빮�ڷ� �˻��ؾ� ����� ����; SYS_C007115;

SELECT *
FROM USER_CONS_COLUMNS
WHERE CONSTRAINT_NAME = 'SYS_C007115';

3. �𵨸� (ex: exerd) ���� Ȯ��;
�������� ���� ������� ���� ��� ����Ŭ���� �������� �̸��� ���Ƿ� �ο�(ex : SYS_C007115)
�������� �������� ������
����Ģ�� �����ϰ� �����ϴ� ���� ����, � ������ ����;
PRIMARY KEY �������� : PK_���̺��
FOREIGN KEY �������� : FK_������̺��_�������̺��;

DROP TABLE dept_test;

�÷� ������ ���������� �����ϸ鼭 �������� �̸��� �ο�;
CONSTRAINT �������� �� ��������Ÿ��(PRIMARY KEY);

CREATE TABLE dept_test(
    deptno NUMBER(2) CONSTRAINT pk_dept_test PRIMARY KEY ,
    dname VARCHAR2(14),
    loc VARCHAR2(13)
);
INSERT INTO dept_test (deptno) VALUES(99);
INSERT INTO dept_test (deptno) VALUES(99);

ORA-00001: unique constraint (DASEUL.SYS_C007115) violated --�������ǿ� �̸��� �ο��ϱ� �� �����ڵ�
ORA-00001: unique constraint (DASEUL.PK_DEPT_TEST) violated --�������ǿ� �̸��� �ο��� ���� �����ڵ�

2. ���̺� ������ �÷� ��� ���� ������ �������� ���;

DROP TABLE dept_test;

CREATE TABLE dept_test(
    deptno NUMBER(2),
    dname VARCHAR2(14),
    loc VARCHAR2(13),
    
    CONSTRAINT pk_dept_test PRIMARY KEY (deptno)

);

NOT NULL �������� �����ϱ�
1. �÷��� ����ϱ� (O);
    �� �÷��� ����ϸ鼭 �������� �̸��� �ο��ϴ� ���� �Ұ���;

DROP TABLE dept_test;

CREATE TABLE dept_test(
    deptno NUMBER(2),
    dname VARCHAR2(14) NOT NULL,
    loc VARCHAR2(13),
    
    CONSTRAINT pk_dept_test PRIMARY KEY (deptno)

);

NOT NULL �������� Ȯ�� ; 

INSERT INTO dept_test (deptno, dname) VALUES (99,NULL);
�����ڵ� : ORA-01400: cannot insert NULL into ("DASEUL"."DEPT_TEST"."DNAME");


2. ���̺� ���� �� �÷� ���Ŀ� ���� ���� �߰�;

DROP TABLE dept_test;

CREATE TABLE dept_test(
    deptno NUMBER(2),
    dname VARCHAR2(14) --�� �ڸ��� CONSTRAINT NN_dept_test CHECK (deptno IS NOT NULL)�� ������ �̸��� �ο��ϸ鼭 �÷������� ������ ���� �� ����. ,
    loc VARCHAR2(13),
    
    CONSTRAINT NN_dept_test CHECK (deptno IS NOT NULL)

);

UNIQUE ���� : �ش� �÷��� �ߺ��Ǵ� ���� ������ ���� ����, �� NULL�� �Է��� �����ϴ�.
PRIMARY KEY = UNIQUE + NOT NULL;


1.���̺� ������ �÷� ���� UNIQUE ��������;

DROP TABLE dept_test;

CREATE TABLE dept_test(
    deptno NUMBER(2) CONSTRAINT PK_dept_test PRIMARY KEY,
    dname VARCHAR2(14) UNIQUE,
    loc VARCHAR2(13)
);

dept_test ���̺��� dname �÷��� ������ UNIQUE ���������� Ȯ��;
INSERT INTO dept_test VALUES (98, 'ddit' ,'daejeon');
INSERT INTO dept_test VALUES (99, 'ddit' ,'daejeon');

2. ���̺� ������ �÷��� �������� ���, �������� �̸� �ο�;

DROP TABLE dept_test;

CREATE TABLE dept_test(
    deptno NUMBER(2) CONSTRAINT PK_dept_test PRIMARY KEY,
    dname VARCHAR2(14) CONSTRAINT UK_dept_test_dname UNIQUE,
    loc VARCHAR2(13)
);

dept_test ���̺��� dname �÷��� ������ UNIQUE ���������� Ȯ��;
INSERT INTO dept_test VALUES (98, 'ddit' ,'daejeon');
INSERT INTO dept_test VALUES (99, 'ddit' ,'daejeon');

2. ���̺� ������ �÷� ��� ���� �������� ���� - ���� �÷�(deptno-dname)(UNIQUE);
DROP TABLE dept_test;

CREATE TABLE dept_test(
     deptno NUMBER(2) ,
    dname VARCHAR2(14) ,
    loc VARCHAR2(13),
    
    CONSTRAINT UK_dept_test_deptno_dname UNIQUE (deptno,dname)
    
);

���� �÷��� ���� UNIQUE ���� Ȯ��(deptno, dname);
INSERT INTO dept_test VALUES (98, 'ddit' ,'daejeon'); --���� ����
INSERT INTO dept_test VALUES (99, 'ddit' ,'daejeon'); --���� ����
INSERT INTO dept_test VALUES (98, 'ddit' ,'����'); --����


FOREIGN KEY ��������
�����ϴ� ���̺��� �÷��� �����ϴ� ���� ��� ���̺��� �÷��� �Է��� �� �ֵ��� ����
EX : emp ���̺� deptno �÷��� ���� �Է��� ��, dept ���̺��� deptno �÷��� �����ϴ� �μ���ȣ��
    �Է��� �� �ֵ��� ����;
    �������� �ʴ� �μ���ȣ�� emp ���̺��� ������� ���ϰԲ� ����;
    
1. dept_test ���̺� ����
2. emp_test ���̺� ����
    .emp_test ���̺� ������ deptno �÷����� dept.deptno �÷��� �����ϵ��� FK�� ����;
    
DROP TABLE dept_test;
CREATE TABLE dept_test(
    deptno NUMBER(2),
    dename VARCHAR2(14),
    loc VARCHAR(13),
    CONSTRAINT pk_dept_test PRIMARY KEY (deptno)  
);

DROP TABLE emp_test;
CREATE TABLE emp_test(
    empno NUMBER(4),
    ename VARCHAR2(10),
    deptno NUMBER(2) REFERENCES dept_test (deptno) ,
    
    CONSTRAINT PK_EMP_TEST PRIMARY KEY (empno)
);

������ �Է¼���
emp_test ���̺� �����͸� �Է��ϴ� ���� �����Ѱ�? 
    . ���� ��Ȳ(dept_test, emp_test ���̺��� ��� ������ - �����Ͱ� �������� ���� �� )

INSERT INTO emp_test VALUES (9999,'brown',NULL); FK�� ������ �÷��� NULL�� ���;
INSERT INTO emp_test VALUES (9999,'brown',10);  10�� �μ��� dept_test ���̺� �������� �ʾƼ� ����;

dept_test ���̺� �����͸� �غ�;
INSERT INTO dept_test VALUES (99,'ddit','daejeon');
INSERT INTO emp_test VALUES (9998,'sally',10); 10�� �μ��� dept_test �� �������� �ʾƼ� ����
INSERT INTO emp_test VALUES (9998,'sally',99); 99�� �μ��� dept_test �� �����ϹǷ� ���� ����;



���̺� ������ �÷� ��� ���� FOREIGN KEY �������� ����
DROP TABLE emp_test;
DROP TABLE dept_test;

CREATE TABLE dept_test(
    deptno NUMBER(2),
    dename VARCHAR2(14),
    loc VARCHAR(13),
    CONSTRAINT pk_dept_test PRIMARY KEY (deptno)  
);
INSERT INTO dept_test VALUES (99,'ddit','daejeon');

CREATE TABLE emp_test(
    empno NUMBER(4),
    ename VARCHAR2(10),
    deptno NUMBER(2),
    CONSTRAINT FK_emp_test_dept_test FOREIGN KEY (deptno) REFERENCES dept_test(deptno)
);

INSERT INTO emp_test VALUES (9999,'brown',10); dept_test ���̺� 10�� �μ��� �������� �ʾ� ����;
INSERT INTO emp_test VALUES (9999,'brown',99); dept_test ���̺� 99�� �μ��� �����ϹǷ� ���� ����;

--tb job���� ����- > emp���� -> �ױ׵ڿ� tb_counsel ����
--counsel ���� ��� �θ� ��
--����� PRIMARY �� F�� FOREIGN �̰� NOT NULL�� �����ʿ��� ����. 

