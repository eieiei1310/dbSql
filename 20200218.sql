SELECT dept_h.*, level, lpad(' ', (LEVEL-1)*4, ' ') || deptnm
FROM dept_h 
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd; 
----------------------------

상향식 계층쿼리 (leaf ==> root node (상위 node))
전체 노드를 방문하는 것이 아니라 자신의 부모 노드만 방문(하향식과 다른 점)
시작점 : 디자인팀
연결은 : 상위부서;

SELECT deptcd, LPAD(' ',(LEVEL - 1) * 4 ) || deptnm ,p_deptcd
FROM dept_h
START WITH deptnm = '디자인팀'
CONNECT BY PRIOR p_deptcd = deptcd;

h_4실습;

SELECT h_sum.*
FROM h_sum;

SELECT LPAD(' ', (LEVEL-1)*4, ' ') || s_id s_id , value
FROM h_sum
START WITH s_id = '0'
CONNECT BY PRIOR s_id = ps_id;

실습 h_5;

SELECT *
FROM no_emp;

SELECT LPAD(' ',(LEVEL-1)*4,' ' ) || org_cd org_cd, no_emp
FROM no_emp
START WITH org_cd = 'XX회사'
CONNECT BY PRIOR org_cd = parent_org_cd;

-------------------------------계층 쿼리 가지치기

실습5번으로 연습;

계층형 쿼리의 행 제한 조건 기술 위치에 따른 결과 비교(pruning branch - 가지치기)
FROM = > START WITH, CONNECT BY = > WHERE
1. WHERE : 계층 연결을 하고 나서 행을 제한
2. CONNECT BY : 계층 연결을 하는 과정에서 행을 제한;


SELECT *
FROM no_emp;

WHERE 절 기술 전 : 총 9개의 행이 조회되는 것 확인
WHERE 절 (org_cd != '정보기획부') : 정보기획부를 제외한 8개의 행 조회되는 것 확인;
CONNECT BY 절에 조건 기술 : 6개의 행 조회됨;

SELECT LPAD(' ',(LEVEL-1)*4,' ' ) || org_cd org_cd, no_emp
FROM no_emp
WHERE org_cd!= '정보기획부'
START WITH org_cd = 'XX회사'
CONNECT BY PRIOR org_cd = parent_org_cd;

CONNECT BY 절에 조건을 기술;
SELECT LPAD(' ',(LEVEL-1)*4,' ' ) || org_cd org_cd, no_emp
FROM no_emp
START WITH org_cd = 'XX회사'
CONNECT BY PRIOR org_cd = parent_org_cd AND org_cd != '정보기획부';


-----------------
계층쿼리 특수함수 실습;

1. CONNECT_BY_ROOT(컬럼) : 해당 컬럼의 최상위 행의 값을 반환;
2. SYS_CONNECT_BY_PATH(컬럼, 구분자) : 해당 행의 컬럼이 거쳐온 컬럼 값을 추천, 구분자로 이어준다;
3. CONNECT_BY_ISLEAF : 해당 행이 LEAF 노드인자(연결된 자식이 없는지)값을 리턴 [1:leaf, 0:no leaf];

SELECT LPAD(' ',(LEVEL-1)*4,' ' ) || org_cd org_cd, no_emp,
        CONNECT_BY_ROOT(org_cd) root,
        LTRIM(SYS_CONNECT_BY_PATH(org_cd, '-'),'-')path, --SYS어쩌구 함수는 -을 무조건 붙이기 때문에 TRIM 함수를 써서 제거해준다.
        CONNECT_BY_ISLEAF leaf
FROM no_emp
START WITH org_cd = 'XX회사'
CONNECT BY PRIOR org_cd = parent_org_cd;


--------------------
실습 h6

SELECT *
FROM board_test;

SELECT seq, LPAD(' ',(LEVEL-1)*4,' ') || title
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq;


실습 h7
SELECT seq, LPAD(' ',(LEVEL-1)*4,' ') || title
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq
ORDER BY seq DESC;

실습 h8;
-------------내 답(틀렸음)--------------
SELECT board_test.*, level
FROM board_test
START WITH seq = 11
CONNECT BY PRIOR seq = (seq + 1);

-------------선생님 답--------------
SELECT seq, LPAD(' ',(LEVEL-1)*4,' ') || title
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq
ORDER SIBLINGS BY seq DESC; -->계층 구조를 유지한 상태에서 정렬하는 방법


실습 h9;

SELECT seq, LPAD(' ',(LEVEL-1)*4,' ') || title 
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq
ORDER SIBLINGS BY seq DESC;


SELECT *
FROM board_test;

그룹번호를 저장할 컬럼을 추가;
ALTER TABLE board_test ADD (gn NUMBER);

UPDATE board_test SET gn = 4
WHERE seq IN (4,5,6,7,8,10,11);

UPDATE board_test SET gn = 2
WHERE seq IN (2,3);

UPDATE board_test SET gn = 1
WHERE seq IN (1,9);

COMMIT;
--선생님 답
SELECT gn, seq, LPAD(' ', (LEVEL-1)*4) || title title
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq
ORDER SIBLINGS BY gn DESC, seq ASC;
--참고 https://m.blog.naver.com/PostView.nhn?blogId=dasomiy&logNo=60193969125&proxyReferer=https%3A%2F%2Fwww.google.com%2F

----임종원씨 답

SELECT seq, LPAD(' ', (LEVEL-1)*4) || title title, DECODE(parent_seq, NULL, seq, parent_seq) root
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq
ORDER SIBLINGS BY root DESC, seq ASC;


-------------------------
SELECT *
FROM board_test;
---------게시글 모르겠으면 걍 외워라-----!!!!!!!!!!!!!!!!!!!!!


SELECT seq, LPAD(' ', (LEVEL-1)*4) || title title, DECODE(parent_seq, NULL, seq, parent_seq) root, parent_seq
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq
ORDER SIBLINGS BY root DESC, seq ASC;


------------------

SELECT *
FROM emp
ORDER BY deptno DESC;

SELECT *
FROM emp
ORDER BY deptno DESC, empno ASC;

-----------------window 함수
SELECT *
FROM emp
WHERE sal = (SELECT MAX(sal)
            FROM emp);

--> 가장 급여를 많이 받는 사람의 이름을 알려면 이렇게 해야 한다.

--행간 연산을 지원해주는 함수

실습an0;

SELECT ename, sal, deptno
FROM emp;

SELECT A.*, ROWNUM
FROM
(SELECT deptno, sal, ename
FROM emp
ORDER BY deptno, sal)A;


SELECT B.*
FROM 
(SELECT A.*,ROWNUM
FROM
(SELECT deptno, sal, ename
FROM emp
GROUP BY deptno, sal, ename)A
ORDER BY A.deptno, sal)B;

SELECT A.*, ROWNUM
FROM 
(SELECT ename, sal, deptno
FROM emp
WHERE deptno IN (10)
ORDER BY sal DESC)A;


--------------내답 (맞았음)-----------
SELECT *
FROM    (SELECT a.*, ROWNUM
        FROM 
        (SELECT ename, sal, deptno
        FROM emp
        WHERE deptno = 10
        ORDER BY sal DESC)a)
        
        UNION  ALL
        
        (SELECT b.*, ROWNUM
        FROM 
        (SELECT ename, sal, deptno
        FROM emp
        WHERE deptno = 20
        ORDER BY sal DESC)b)
        
        UNION ALL 
        (SELECT c.*, ROWNUM
        FROM 
        (SELECT ename, sal, deptno
        FROM emp
        WHERE deptno = 30
        ORDER BY sal DESC)c)
;
        
----------------------선생님 풀이-------------------


SELECT *
FROM
    (SELECT LEVEL lv
    FROM dual
    CONNECT BY LEVEL <= 14) a, 
    
    (SELECT deptno, COUNT(*) cnt  
    FROM emp
    GROUP BY deptno) b
    
WHERE b.cnt >= a.lv
ORDER BY b.deptno, a.lv;




