:dt ==> 202002;

SELECT DECODE(d,1, iw+1,iw) i,
       MIN(DECODE(d, 1, dt )) sun,
       MIN(DECODE(d, 2, dt )) mon,
       MIN(DECODE(d, 3, dt )) tue,
       MIN(DECODE(d, 4, dt )) wed,
       MIN(DECODE(d, 5, dt )) tur,
       MIN(DECODE(d, 6, dt )) fri,
       MIN(DECODE(d, 7, dt )) sat
FROM 
    (SELECT TO_DATE(:dt,'yyyymm') + (LEVEL - 1) dt,
             TO_CHAR(TO_DATE(:dt,'yyyymm') + (LEVEL - 1),'D') d,
             TO_CHAR(TO_DATE(:dt,'yyyymm') + (LEVEL - 1),'iw') iw
    FROM dual
    CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:dt ,'yyyymm')),'DD'))
    GROUP BY DECODE(d,1, iw+1,iw) 
    ORDER BY DECODE(d,1, iw+1,iw);
--tmi ��Ŭ���� alt + shift + A ->�����������

--�ǽ�--�޷¿� ���� ���� �ڷᵵ ������ �Ͻÿ�

1. �ش� ���� 1���ڰ� ���� ���� �Ͽ��� ���ϱ�
2. �ش� ���� ������ ���ڰ� ���� ���� ����� ���ϱ�
3. 2-1�� �Ͽ� �� �ϼ� ���ϱ�


�޷¿��� �� ��, ���� �� ��¥�� ������ �Ϸ���????
20200401 --> 20200329(�Ͽ���)
20200430 --> 20200502(�����) 

--------------���� �غ� ��1(Ʋ����)
SELECT TO_DATE('20200401','YYYYMMDD') -3
FROM dual;
SELECT LAST_DAY(TO_DATE('20200401','YYYYMMDD')) + 2
FROM dual;


----------���� �غ� �� 2(Ʋ����)

:dt ==> 202002;

SELECT DECODE(d,1, iw+1,iw) i,
       MIN(DECODE(d, 1, dt )) sun,
       MIN(DECODE(d, 2, dt )) mon,
       MIN(DECODE(d, 3, dt )) tue,
       MIN(DECODE(d, 4, dt )) wed,
       MIN(DECODE(d, 5, dt )) tur,
       MIN(DECODE(d, 6, dt )) fri,
       MIN(DECODE(d, 7, dt )) sat
FROM 
    (SELECT TO_DATE(:dt,'yyyymm') + (LEVEL - 1) dt,
             TO_CHAR(TO_DATE(:dt,'yyyymm') + (LEVEL - 1),'D') d,
             TO_CHAR(TO_DATE(:dt,'yyyymm') + (LEVEL - 1),'iw') iw,
             TO_DATE('20200401','YYYYMMDD')-3 first,
             LAST_DAY(TO_DATE('20200401','YYYYMMDD')) + 2 second
    FROM dual
    CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:dt ,'yyyymm')),'DD'))
    GROUP BY DECODE(d,1, iw+1,iw) 
    ORDER BY DECODE(d,1, iw+1,iw);
--tmi ��Ŭ���� alt + shift + A ->�����������

-----------------�����Դ�-----------------

�������� 1��~������;
SELECT DECODE(d, 1, iw+1, iw) i,
       MIN(DECODE(d, 1, dt)) sun,
       MIN(DECODE(d, 2, dt)) mon,
       MIN(DECODE(d, 3, dt)) tue,
       MIN(DECODE(d, 4, dt)) wed,
       MIN(DECODE(d, 5, dt)) tur,
       MIN(DECODE(d, 6, dt)) fri,
       MIN(DECODE(d, 7, dt)) sat
FROM 
(SELECT TO_DATE(:dt, 'yyyymm') + (level-1) dt,
        TO_CHAR(TO_DATE(:dt, 'yyyymm')  + (LEVEL-1), 'D') d,
        TO_CHAR(TO_DATE(:dt, 'yyyymm')  + (LEVEL-1), 'iw') iw
 FROM dual
 CONNECT BY LEVEL <=  TO_CHAR(last_day(to_date(:dt,'yyyymm')), 'DD'))
 GROUP BY DECODE(d, 1, iw+1, iw)
 ORDER BY DECODE(d, 1, iw+1, iw);
 

1���ڰ� ���� ���� �Ͽ��ϱ��ϱ�
���������ڰ� ���� ���� ����ϱ� �ϱ�
�ϼ� ���ϱ�; 
SELECT 
        TO_DATE(:dt, 'yyyymm') - ( TO_CHAR(TO_DATE(:dt, 'yyyymm'), 'D') -1) st,
        LAST_DAY(TO_DATE(:dt, 'yyyymm')) + (7- TO_CHAR(LAST_DAY(TO_DATE(:dt, 'yyyymm')), 'D')) ed,
        LAST_DAY(TO_DATE(:dt, 'yyyymm')) + (7- TO_CHAR(LAST_DAY(TO_DATE(:dt, 'yyyymm')), 'D'))
                      - ( TO_DATE(:dt, 'yyyymm') - ( TO_CHAR(TO_DATE(:dt, 'yyyymm'), 'D'))) daycnt
FROM dual;      


1����, �����ڰ� ���� �������� ǥ���� �޷�
SELECT DECODE(d, 1, iw+1, iw) i,
       MIN(DECODE(d, 1, dt)) sun,
       MIN(DECODE(d, 2, dt)) mon,
       MIN(DECODE(d, 3, dt)) tue,
       MIN(DECODE(d, 4, dt)) wed,
       MIN(DECODE(d, 5, dt)) tur,
       MIN(DECODE(d, 6, dt)) fri,
       MIN(DECODE(d, 7, dt)) sat
FROM 
(SELECT TO_DATE(:dt, 'yyyymm') - ( TO_CHAR(TO_DATE(:dt, 'yyyymm'), 'D') -1) + (level-1) dt,
        TO_CHAR(TO_DATE(:dt, 'yyyymm') - ( TO_CHAR(TO_DATE(:dt, 'yyyymm'), 'D') -1)  + (LEVEL-1), 'D') d,
        TO_CHAR(TO_DATE(:dt, 'yyyymm') - ( TO_CHAR(TO_DATE(:dt, 'yyyymm'), 'D') -1)  + (LEVEL-1), 'iw') iw
 FROM dual
 CONNECT BY LEVEL <=  last_day(to_date(:dt,'yyyymm'))+(7-to_char(last_day(to_date(:dt,'yyyymm')),'D'))
                    -to_date(:dt,'yyyymm')-(to_char(to_date(:dt,'yyyymm'),'D')-1)  )
 GROUP BY DECODE(d, 1, iw+1, iw)
 ORDER BY DECODE(d, 1, iw+1, iw);

---------------------------------------------------

���� : �������� 1��, ��������¥ : �ش���� ������ ��¥ 
SELECT TO_DATE('202002','YYYYMM') + (LEVEL-1)
FROM dual
CONNECT BY LEVEL <= 29;

���� : �������ڰ� : �ش� ���� 1���ڰ� ���� ���� �Ͽ���
       ��������¥ : �ش� ���� ���������ڰ� ���� ���� �����
       
SELECT TO_DATE('20200126', 'YYYYMMDD') + (LEVEL-1)
FROM dual
CONNECT BY LEVEL <= 35;


-----------�ǽ� CALENDAR1

---����---
SELECT TO_CHAR(dt, 'MM') dt ,SUM(sales) salse
FROM sales 
GROUP BY TO_CHAR(dt, 'MM')
ORDER BY dt;


SELECT SUM(JAN) JAN, 
       SUM(FEB) FEB, 
       NVL(SUM(MAR),0) MAR, --> NVL�� ������ ���� ���� �� �ո����̴�. 
       SUM(APR) APR, 
       SUM(MAY) MAY, 
       SUM(JUN) JUN
FROM
(SELECT 
       DECODE(TO_CHAR(dt, 'MM'),'01',SUM(sales)) JAN,
       DECODE(TO_CHAR(dt, 'MM'),'02',SUM(sales)) FEB,
       DECODE(TO_CHAR(dt, 'MM'),'03',SUM(sales)) MAR,
       DECODE(TO_CHAR(dt, 'MM'),'04',SUM(sales)) APR,
       DECODE(TO_CHAR(dt, 'MM'),'05',SUM(sales)) MAY,
       DECODE(TO_CHAR(dt, 'MM'),'06',SUM(sales)) JUN
       
FROM sales
GROUP BY TO_CHAR(dt, 'MM')
ORDER BY TO_CHAR(dt, 'MM'))


---------------��������
;

SELECT *
FROM dept_h;

����Ŭ ������ ���� ����
SELECT ...
FROM ...
WHERE
START WITH ���� : � ���� ���������� ������

CONNECT BY ��� ���� �����ϴ� ����
        PRIOR : �̹� ���� ��
        "   " : ������ ���� ��
        

����� : �������� �ڽ� ���� ����(�� ==>�Ʒ�);

XXȸ��(�ֻ��� ����)���� �����Ͽ� ���� �μ��� �������� ���� ����;

SELECT dept_h.*, level, lpad(' ', (LEVEL-1)*4, ' ') || deptnm
FROM dept_h 
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd; 

��� ���� ���� ����(PRIOR XXȸ�� - 3���� ��(�����κ�, ������ȹ��, �����ý��ۺ�));
PRIOR XXȸ��.deptno = �����κ�.p_deptcd
PRIOR �����κ�.deptcd = ��������.p_deptcd
PRIOR ��������.deptcd = .p_deptcd

PRIOR XXȸ��.deptno = ������ȹ��.p_deptcd
PRIOR ������ȹ��.deptcd = ��ȹ��.p_deptcd
PRIOR ��ȹ��.deptcd = ��ȹ��Ʈ.p_deptcd
PRIOR ��ȹ��Ʈ.deptcd = .p_deptcd

PRIOR XXȸ��.deptno = �����ý��ۺ�.p_deptcd
PRIOR �����ý��ۺ�.deptcd = ����1��.p_deptcd
PRIOR �����ý��ۺ�.deptcd = ����2��.p_deptcd




----�ǽ� h_2 ----����-----------------
SELECT level, deptcd, lpad(' ', (LEVEL-1)*4, ' ') || deptnm deptno, p_deptcd
FROM dept_h 
START WITH deptcd = 'dept0_02'
CONNECT BY PRIOR deptcd = p_deptcd; 
