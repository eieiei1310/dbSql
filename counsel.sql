
CREATE TABLE tb_job(
    j_cd VARCHAR(20),
    j_nm VARCHAR(50) NOT NULL,
    ord NUMBER,
    CONSTRAINT PK_tb_job_j_cd PRIMARY KEY (j_cd)
   
);

DROP TABLE tb_job;

SELECT *
FROM tb_job;

CREATE TABLE tb_dept(
    d_cd VARCHAR(20) ,
    d_nm VARCHAR(50) NOT NULL,
    p_d_cd VARCHAR(20),
    CONSTRAINT PK_tb_dept_d_cd PRIMARY KEY (d_cd)
);

DROP TABLE tb_dept;

SELECT *
FROM tb_dept;

CREATE TABLE tb_grade(
    g_cd VARCHAR(20),
    g_nm VARCHAR(50) NOT NULL,
    ord NUMBER,
    CONSTRAINT PK_tb_grad_g_cd PRIMARY KEY (g_cd)
);

DROP TABLE tb_grade;

SELECT *
FROM tb_grade;

CREATE TABLE tb_emp(
    e_no NUMBER,
    e_nm VARCHAR(50) NOT NULL,
    g_cd VARCHAR(20) NOT NULL,
    j_cd VARCHAR(20) NOT NULL,
    d_cd VARCHAR(20) NOT NULL,
    CONSTRAINT PK_tb_emp_e_no PRIMARY KEY (e_no),
    CONSTRAINT FK_tb_emp_tb_grade FOREIGN KEY (g_cd) REFERENCES tb_grade(g_cd),
    CONSTRAINT FK_tb_emp_tb_dept FOREIGN KEY (d_cd) REFERENCES tb_dept(d_cd),
    CONSTRAINT FK_tb_emp_tb_job FOREIGN KEY (j_cd) REFERENCES tb_job(j_cd)
);
DROP TABLE tb_emp;

SELECT *
FROM tb_emp;

CREATE TABLE tb_cs_cd(
    cs_cd VARCHAR(20),
    cs_nm VARCHAR(50) NOT NULL,
    p_cs_cd VARCHAR(20),
    CONSTRAINT PK_tb_cs_cd_cs_cd PRIMARY KEY (cs_cd)
    
);

DROP TABLE tb_cs_cd;

SELECT *
FROM tb_cs_cd;

CREATE TABLE tb_counsel(
    cs_id VARCHAR(20),
    cs_reg_dt DATE  NOT NULL,
    cs_cont VARCHAR(4000) NOT NULL,
    e_no NUMBER  NOT NULL,
    cs_cd1 VARCHAR(20) NOT NULL,
    cs_cd2 VARCHAR(20),
    cs_cd3 VARCHAR(20),
    
    CONSTRAINT PK_tb_counsel_cs_id PRIMARY KEY (cs_id),
    CONSTRAINT FK_tb_counsel_e_no FOREIGN KEY (e_no) REFERENCES tb_emp(e_no),
    CONSTRAINT FK_tb_counsel_cs_cd3 FOREIGN KEY (cs_cd1) REFERENCES tb_cs_cd(cs_cd)
);


DROP TABLE tb_counsel;

SELECT *
FROM tb_counsel;


