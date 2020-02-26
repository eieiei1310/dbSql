users ���̺� ��й�ȣ�� ����� �� ����Ǳ� ���� ��й�ȣ��
users_history ���̺�� �̷��� �����ϴ� Ʈ���� ����;

SELECT *
FROM users;

1. users_history ���̺� ����;
DESC users;

key(�ĺ���) : �ش� ���̺��� �ش� �÷��� �ش� ���� �ѹ��� ����

CREATE TABLE users_history(
    userid VARCHAR2(20) ,
    pass VARCHAR2(100),
    mod_dt DATE, 
    CONSTRAINT pk_users_history PRIMARY KEY (userid, mod_dt)

);

SELECT *
FROM USERS_HISTORY;

COMMENT ON TABLE users_history IS '����� ��й�ȣ �̷�';
COMMENT ON COLUMN users_history.userid IS '����� ���̵�';
COMMENT ON COLUMN users_history.pass IS '��й�ȣ';
COMMENT ON COLUMN users_history.mod_dt IS '�����Ͻ�';

SELECT *
FROM user_col_comments
WHERE table_name = 'USERS_HISTORY';

2. USERS ���̺��� PASS �÷� ������ ������ TRIGGER�� ����;

CREATE OR REPLACE TRIGGER make_history
    BEFORE UPDATE ON users
    FOR EACH ROW 
    
    BEGIN 
        --��й�ȣ�� ����� ��츦 üũ
        --���� ��й�ȣ / ������Ʈ �Ϸ��� �ϴ� �ű� ��й�ȣ 
        --:OLD.�÷� / :NEW.�÷�
        IF :OLD.pass != :NEW.pass THEN 
            INSERT INTO users_history VALUES (:NEW.userid, :OLD.pass, SYSDATE);
        END IF;
    END;   
/

3. Ʈ���� Ȯ��
    1. USERS_HISTORY�� �����Ͱ� ���� ���� Ȯ��
    2. USERS ���̺��� BROWN ������� ��й�ȣ�� ������Ʈ
    3. USERS_HISTORY ���̺� �����Ͱ� ������ �Ǿ�����(trigger�� ����) Ȯ��
    4. users���̺��� brown ������� ����(alias)�� ������Ʈ
    5. users_history ���̺� �����Ͱ� ������ �Ǿ����� Ȯ��;
    SELECT *
    FROM users;

1.
SELECT *
FROM users_history;

2.
UPDATE USERS SET pass = 'test'
WHERE userid = 'brown';

3. 
SELECT *
FROM users_history;

4. 
UPDATE users SET alias = '����'
WHERE userid = 'brown';

5.;
SELECT *
FROM users_history;

ROLLBACK;


mybatis : 
java�� �̿��Ͽ� �����ͺ��̽� ���α׷��� : jdbc
java�� �ڵ��� �ߺ��� ���ϴ�
sql�� ������ �غ� 
sql�� ������ �غ� 
sql�� ������ �غ� 
sql�� ������ �غ� 
sql�� ������ �غ� 

sql ����

sql ���� ȯ�� close
sql ���� ȯ�� close
sql ���� ȯ�� close
sql ���� ȯ�� close
sql ���� ȯ�� close
... �䷱ ����

1. ���� ==> mybatis �����ڵ��� ���س��� ������� �����...
    sql �����ϱ� ���ؼ���... dbms �� �ʿ� (�������� �ʿ�) ==> xml 
    mybatis���� �������ִ� class�� �̿�.
    sql�� �ڹ� �ڵ忡�� ���� �ۼ��ϴ� ���� �ƴ϶�
    xml ������ sql�� ���Ƿ� �ο��ϴ� id�� ���� ����
    
2. Ȱ�� 


