TRUNCATE 테스트
1. REDO 로그를 생성하지 않기 때문에 삭제시 데이터 복구가 불가하다.
2. DML (SELECT, INSERT, UPDATE, DELETE)이 아니라 
    DDL로 분류 (ROLLBACK)이 불가
    
테스트 시나리오
EMP 테이블을 복사를 하여 EMP_COPY 라는 이름으로 테이블 생성
EMP_COPY 테이블을 대상으로 TRUNCATE TABLE EMP_COPY 실행

EMP_COPY 테이블에 데이터가 존재하는지(정상적으로 삭제가 되었는지) 확인;

EMP_COPY 테이블 복사;
CREATE -> DDL (ROLLBACK이 안된다);

CREATE TABLE EMP_COPY AS
SELECT *
FROM emp;

SELECT *
FROM emp_copy;

TRUNCATE TABLE emp_copy;

TRUNCATE TABLE 명령어는 DDL 이기 때문에 ROLLBACK 이 불가하다.
ROLLBACK 후 SELECT 를 해 보면 데이터가 복구되지 않은 것을 알 수 있다;
ROLLBACK;

고립화 레벨 -->어려움, 이해 안돼도 그냥 넘어갈것

-------------------

테이블과 컬럼명 규칙 ppt3 잘못씀
숫자도 가능

------------------

DDL : Date Definition Language - 데이터 정의어
객체를 생성, 수정, 삭제시 사용;
ROLLBACK 불가
자동 COMMIT;

테이블 생성
CREATE TABLE [스키마명.]테이블명(
    컬럼명 컬럼타입 [DEFAULT 기본값] , 
    컬럼2명 컬럼2타입 [DEFAULT 기본값] ,... 
);

ranger라는 이름의 테이블 생성;
CREATE TABLE ranger(
    ranger_no NUMBER,
    ranger_nm VARCHAR2(50),
    reg_dt DATE DEFAULT SYSDATE
);

SELECT *
FROM ranger;

INSERT INTO ranger (ranger_no, ranger_nm ) VALUES (1,'brown');
COMMIT;
-->스키마명: 접속계정명

테이블 삭제 
DROP TABLE 테이블명; 

ranger 테이블 삭제(drop)
DROP TABLE ranger;

DDL은 롤백 불가
ROLLBACK;

테이블이 롤백되지 않은 것을 확인할 수 있다.
SELECT *
FROM ranger;

데이터타입
문자열(VARCHAR2 사용, CHAR 타입 사용 지양)

VARCHAR(10) : 가변길이 문자열, 사이즈 1~4000BYTE 
             입력되는 값이 컬럼 사이즈보다 작아도 남은 공간을 공백으로 채우지 않는다.
             
CHAR(10) : 고정길이 문자열
           해당 컬럼에 문자열을 5byte 만 지정하면 나머지 5 byte는 공백으로 채워진다.
           'test' ==> 'test     '
           --주의! 'text' != 'text     '

숫자
NUMBER(p,s) : p - 전체자리수 (38), s - 소수점 자리수
INTEGER ==> NUMBER(38,0)
ranger_no NUMBER ==> NUMBER(38,0)

날짜
DATE - 일자와 시간 정보를 저장
       7BYTE 

날짜 - DATE
       VARCHAR2(8) - '20200207' 
      위 두개의 타입은 하나의 데이터당 1BYTE의 사이즈가 차이가 난다.
      데이터 양이 많아지게 되면 무시할 수 없는 사이즈로, 설계시 타입에 대한 고려가 필요;

LOB(Large OBject) - 최대 4GB
CLOB - Character Large OBject
        VARCHAR2로 담을 수 없는 사이즈의 문자열(4000byte 초과 문자열)
        ex: 웹 에디터에 생성된 html 코드
BLOB - Byte Large OBject
       파일을 데이터베이스의 테이블에서 관리할 때
       
       일반적으로 게시글 첨부파일을 테이블에 직접 관리하지 않고
       보통 첨부파일을 디스크의 특정 공간에 저장하고, 해당 [경로]만 문자열로 관리
       
       파일이 매우 중요한 경우 : 고객 정보사용 동의서 - > [파일] 을 테이블에 저장
PPT 10페이지 별로 중요한 것은 아님

제약조건 : 데이터가 무결성을 지키도록 하기 위한 설정
1.  UNIQUE 제약 조건
    해당 컬럼의 값이 다른 행의 데이터와 중복되지 않도록 제약
    ex : 사번이 같은 사원이 있을 수 없다.
    
2. NOT NULL 제약 조건 (CHECK 제약 조건)
    해당 컬럼에 값이 반드시 존재해야 하는 제약.
    ex : 사번 컬럼이 NULL인 사원은 존재할 수 없다.
          회원가입시 필수 입력사항(GITHUB - 이메일, 이름)
         
3. PRIMARY KEY 제약 조건
    UNIQUE + NOT NULL
      ex : 사번이 같은 사원이 있을 수 없고, 사번이 없는 사원이 있을 수가 없다.
      PRIMARY KEY 제약 조건을 생성할 경우 UNIQUE INDEX가 생성된다.
      
4. FOREIGN KEY 제약 조건 (참조무결성)
    해당 컬럼이 참조하는 다른 테이블에 값이 존재하는 행이 있어야 한다.
    emp 테이블의 deptno 컬럼이 dept 테이블의 deptno컬럼을 참조(관계)
    emp 테이블의 deptno 컬럼에는 dept 테이블에 존재하지 않는 부서번호가 입력될 수 없다.
    ex : 만약 dept 테이블의 부서번호가 10, 20, 30, 40번만 존재할 경우
        emp 테이블에 새로운 행을 추가 하면서 부서번호 값을 99번으로 등록할 경우
        행 추가가 실패한다. 
        
5. CHECK 제약 조건(값을 체크)
    NOT NULL 제약 조건도 CHECK 제약에 포함
    emp 테이블에 job 컬럼에 들어올 수 있는 값을 'SALESMAN', 'PRESIDENT','CLEAK' 으로 한정한다.
    
제약조건 생성 방법
1. 테이블을 생성하면서 컬럼에 기술
2. 테이블을 생성하면서 컬럼 기술 이후에 별도로 제약조건을 기술
3. 테이블을 생성과 별도로 추가적으로 제약조건을 추가

CREAT TABLE 테이블명(
    컬럼1 컬럼 타입[1.제약조건], 
    컬럼2 컬럼 타입[1.제약조건],
    
   (2.TABLE_CONSTRAINT)
);

3. ALTER TABLE emp........

PRIMARY KEY 제약조건을 컬럼 레벨로 생성(1번 방법)
dept를 테이블을 참고하여 dept_test 테이블을 PRIMARY KEY 제약조건과 함께 생성
단 이 방식은 테이블의 KEY 컬럼이 복합컬럼은 불가, 단일컬럼일 때만 가능하다.;

CREATE TABLE dept_test(
    deptno NUMBER(2) PRIMARY KEY ,
    dname VARCHAR2(14),
    loc VARCHAR2(13)
);

INSERT INTO dept_test(deptno) VALUES (99); 정상적으로 실행
INSERT INTO dept_test(deptno) VALUES (99); 바로 위의 쿼리를 통해 같은 값의 데이터가 이미 저장됨 --에러

참고사항, 우리가 지금까지 사용한 dept 테이블의 deptno 컬럼에는
UNIQUE 제약이나 PRIMARY KEY 제약 조건이 없었기 때문에
아래 두개의 INSERT 구문이 정상적으로 실행된다;

INSERT INTO dept(deptno) VALUES (99);
INSERT INTO dept(deptno) VALUES (99);

ROLLBACK;

제약조건 확인 방법;
1. TOOL 을 통해 확인
    확인하고자 하는 테이블을 선택
2. dictionary 를 통해 확인(USER_TABLES);

SELECT *
FROM USER_CONSTRAINTS
WHERE table_name = 'DEPT_TEST';대문자로 검색해야 제대로 나옴; SYS_C007115;

SELECT *
FROM USER_CONS_COLUMNS
WHERE CONSTRAINT_NAME = 'SYS_C007115';

3. 모델링 (ex: exerd) 으로 확인;
제약조건 명을 기술하지 않을 경우 오라클에서 제약조건 이름을 임의로 부여(ex : SYS_C007115)
가독성이 떨어지기 때문에
명명규칙을 지정하고 생성하는 것이 개발, 운영 관리에 유리;
PRIMARY KEY 제약조건 : PK_테이블명
FOREIGN KEY 제약조건 : FK_대상테이블명_참조테이블명;

DROP TABLE dept_test;

컬럼 레벨의 제약조건을 생성하면서 제약조건 이름을 부여;
CONSTRAINT 제약조건 명 제약조건타입(PRIMARY KEY);

CREATE TABLE dept_test(
    deptno NUMBER(2) CONSTRAINT pk_dept_test PRIMARY KEY ,
    dname VARCHAR2(14),
    loc VARCHAR2(13)
);
INSERT INTO dept_test (deptno) VALUES(99);
INSERT INTO dept_test (deptno) VALUES(99);

ORA-00001: unique constraint (DASEUL.SYS_C007115) violated --제약조건에 이름을 부여하기 전 에러코드
ORA-00001: unique constraint (DASEUL.PK_DEPT_TEST) violated --제약조건에 이름을 부여한 뒤의 에러코드

2. 테이블 생성시 컬럼 기술 이후 별도로 제약조건 기술;

DROP TABLE dept_test;

CREATE TABLE dept_test(
    deptno NUMBER(2),
    dname VARCHAR2(14),
    loc VARCHAR2(13),
    
    CONSTRAINT pk_dept_test PRIMARY KEY (deptno)

);

NOT NULL 제약조건 생성하기
1. 컬럼에 기술하기 (O);
    단 컬럼에 기술하면서 제약조건 이름을 부여하는 것은 불가능;

DROP TABLE dept_test;

CREATE TABLE dept_test(
    deptno NUMBER(2),
    dname VARCHAR2(14) NOT NULL,
    loc VARCHAR2(13),
    
    CONSTRAINT pk_dept_test PRIMARY KEY (deptno)

);

NOT NULL 제약조건 확인 ; 

INSERT INTO dept_test (deptno, dname) VALUES (99,NULL);
오류코드 : ORA-01400: cannot insert NULL into ("DASEUL"."DEPT_TEST"."DNAME");


2. 테이블 생성 시 컬럼 이후에 제약 조건 추가;

DROP TABLE dept_test;

CREATE TABLE dept_test(
    deptno NUMBER(2),
    dname VARCHAR2(14) --이 자리에 CONSTRAINT NN_dept_test CHECK (deptno IS NOT NULL)를 넣으면 이름을 부여하면서 컬럼레벨에 제약을 넣을 수 있음. ,
    loc VARCHAR2(13),
    
    CONSTRAINT NN_dept_test CHECK (deptno IS NOT NULL)

);

UNIQUE 제약 : 해당 컬럼에 중복되는 값이 들어오는 것을 방지, 단 NULL은 입력이 가능하다.
PRIMARY KEY = UNIQUE + NOT NULL;


1.테이블 생성시 컬럼 레벨 UNIQUE 제약조건;

DROP TABLE dept_test;

CREATE TABLE dept_test(
    deptno NUMBER(2) CONSTRAINT PK_dept_test PRIMARY KEY,
    dname VARCHAR2(14) UNIQUE,
    loc VARCHAR2(13)
);

dept_test 테이블의 dname 컬럼에 설정된 UNIQUE 제약조건을 확인;
INSERT INTO dept_test VALUES (98, 'ddit' ,'daejeon');
INSERT INTO dept_test VALUES (99, 'ddit' ,'daejeon');

2. 테이블 생성시 컬럼에 제약조건 기술, 제약조건 이름 부여;

DROP TABLE dept_test;

CREATE TABLE dept_test(
    deptno NUMBER(2) CONSTRAINT PK_dept_test PRIMARY KEY,
    dname VARCHAR2(14) CONSTRAINT UK_dept_test_dname UNIQUE,
    loc VARCHAR2(13)
);

dept_test 테이블의 dname 컬럼에 설정된 UNIQUE 제약조건을 확인;
INSERT INTO dept_test VALUES (98, 'ddit' ,'daejeon');
INSERT INTO dept_test VALUES (99, 'ddit' ,'daejeon');

2. 테이블 생성시 컬럼 기술 이후 제약조건 생성 - 복합 컬럼(deptno-dname)(UNIQUE);
DROP TABLE dept_test;

CREATE TABLE dept_test(
     deptno NUMBER(2) ,
    dname VARCHAR2(14) ,
    loc VARCHAR2(13),
    
    CONSTRAINT UK_dept_test_deptno_dname UNIQUE (deptno,dname)
    
);

복합 컬럼에 대한 UNIQUE 제약 확인(deptno, dname);
INSERT INTO dept_test VALUES (98, 'ddit' ,'daejeon'); --삽입 가능
INSERT INTO dept_test VALUES (99, 'ddit' ,'daejeon'); --삽입 가능
INSERT INTO dept_test VALUES (98, 'ddit' ,'대전'); --오류


FOREIGN KEY 제약조건
참조하는 테이블의 컬럼에 존재하는 값만 대상 테이블의 컬럼에 입력할 수 있도록 설정
EX : emp 테이블에 deptno 컬럼에 값을 입력할 때, dept 테이블의 deptno 컬럼에 존재하는 부서번호만
    입력할 수 있도록 설정;
    존재하지 않는 부서번호를 emp 테이블에서 사용하지 못하게끔 방지;
    
1. dept_test 테이블 생성
2. emp_test 테이블 생성
    .emp_test 테이블 생성시 deptno 컬럼으로 dept.deptno 컬럼을 참조하도록 FK를 설정;
    
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

데이터 입력순서
emp_test 테이블에 데이터를 입력하는 것이 가능한가? 
    . 지금 상황(dept_test, emp_test 테이블을 방금 생성함 - 데이터가 존재하지 않을 때 )

INSERT INTO emp_test VALUES (9999,'brown',NULL); FK가 설정된 컬럼에 NULL은 허용;
INSERT INTO emp_test VALUES (9999,'brown',10);  10번 부서가 dept_test 테이블에 존재하지 않아서 에러;

dept_test 테이블에 데이터를 준비;
INSERT INTO dept_test VALUES (99,'ddit','daejeon');
INSERT INTO emp_test VALUES (9998,'sally',10); 10번 부서가 dept_test 에 존재하지 않아서 에러
INSERT INTO emp_test VALUES (9998,'sally',99); 99번 부서는 dept_test 에 존재하므로 정상 실행;



테이블 생성시 컬럼 기술 이후 FOREIGN KEY 제약조건 생성
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

INSERT INTO emp_test VALUES (9999,'brown',10); dept_test 테이블에 10번 부서가 존재하지 않아 에러;
INSERT INTO emp_test VALUES (9999,'brown',99); dept_test 테이블에 99번 부서가 존재하므로 정상 실행;

--tb job부터 생성- > emp생성 -> 그그뒤에 tb_counsel 생성
--counsel 같은 경우 부모가 둘
--열쇠는 PRIMARY 고 F가 FOREIGN 이고 NOT NULL은 오른쪽에서 본다. 

