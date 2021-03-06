users 테이블에 비밀번호가 변경될 때 변경되기 전의 비밀번호를
users_history 테이블로 이력을 생성하는 트리거 생성;

SELECT *
FROM users;

1. users_history 테이블 생성;
DESC users;

key(식별자) : 해당 테이블의 해당 컬럼에 해당 값이 한번만 존재

CREATE TABLE users_history(
    userid VARCHAR2(20) ,
    pass VARCHAR2(100),
    mod_dt DATE, 
    CONSTRAINT pk_users_history PRIMARY KEY (userid, mod_dt)

);

SELECT *
FROM USERS_HISTORY;

COMMENT ON TABLE users_history IS '사용자 비밀번호 이력';
COMMENT ON COLUMN users_history.userid IS '사용자 아이디';
COMMENT ON COLUMN users_history.pass IS '비밀번호';
COMMENT ON COLUMN users_history.mod_dt IS '수정일시';

SELECT *
FROM user_col_comments
WHERE table_name = 'USERS_HISTORY';

2. USERS 테이블의 PASS 컬럼 변경을 감지할 TRIGGER를 생성;

CREATE OR REPLACE TRIGGER make_history
    BEFORE UPDATE ON users
    FOR EACH ROW 
    
    BEGIN 
        --비밀번호가 변경된 경우를 체크
        --기존 비밀번호 / 업데이트 하려고 하는 신규 비밀번호 
        --:OLD.컬럼 / :NEW.컬럼
        IF :OLD.pass != :NEW.pass THEN 
            INSERT INTO users_history VALUES (:NEW.userid, :OLD.pass, SYSDATE);
        END IF;
    END;   
/

3. 트리거 확인
    1. USERS_HISTORY에 데이터가 없는 것을 확인
    2. USERS 테이블의 BROWN 사용자의 비밀번호를 업데이트
    3. USERS_HISTORY 테이블에 데이터가 생성이 되었는지(trigger를 통해) 확인
    4. users테이블의 brown 사용자의 별명(alias)을 없데이트
    5. users_history 테이블에 데이터가 생성이 되었는지 확인;
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
UPDATE users SET alias = '수정'
WHERE userid = 'brown';

5.;
SELECT *
FROM users_history;

ROLLBACK;


mybatis : 
java를 이용하여 데이터베이스 프로그래밍 : jdbc
java는 코드의 중복이 심하다
sql을 실행할 준비 
sql을 실행할 준비 
sql을 실행할 준비 
sql을 실행할 준비 
sql을 실행할 준비 

sql 실행

sql 실행 환경 close
sql 실행 환경 close
sql 실행 환경 close
sql 실행 환경 close
sql 실행 환경 close
... 요런 느낌

1. 설정 ==> mybatis 개발자들이 정해놓은 방식으로 따라야...
    sql 실행하기 위해서는... dbms 가 필요 (연결정보 필요) ==> xml 
    mybatis에서 제공해주는 class를 이용.
    sql을 자바 코드에다 직접 작성하는 것이 아니라
    xml 문서에 sql에 임의로 부여하는 id를 통해 관리
    
2. 활용 


