-- dml_work.sql

/*
 * DML : SELECT, INSERT, UPDATE, DELETE
 *  commit : 작업 내용 db 반영 
 *  commit 대상 : INSERT, UPDATE, DELETE
 *    -> 기본 쿼리 실습 
 *    -> 서브쿼리 실습 
 *  select : commit 대상 아님 
 */


-- table 생성 
drop table dept01 purge;

CREATE TABLE DEPT01( 
DEPTNO NUMBER(4), 
DNAME VARCHAR2(30), 
LOC VARCHAR2(20) 
);

-- 1. 레코드 삽입 
INSERT INTO DEPT01(DEPTNO, DNAME, LOC) 
   VALUES(10, 'ACCOUNTING', 'NEW YORK');

-- 전체 칼럼 입력 시 -> 칼럼명 생략 가 
INSERT INTO DEPT01 VALUES(20, 'RESEARCH', 'DALLAS');

--<문제1>
-- 1) EMP 테이블의 4개 칼럼의 구조를 이용하여 SAM01 테이블을 생성하시오.
--   조건> 서브쿼리 이용 
CREATE TABLE SAM01 
AS
(SELECT EMPNO, ENAME, JOB, SAL FROM EMP WHERE 1=0); 

-- 2) SAM01 테이블에 다음과 같은 데이터를 추가하시오.
INSERT INTO SAM01 VALUES(1000, 'APPLE', 'POLICE', 10000);
INSERT INTO SAM01 VALUES(1010, 'BANANA', 'NURSE', 15000);
INSERT INTO SAM01 VALUES(1020, 'ORANGE', 'DOCTOR', 25000);

-- NULL 입력 

-- 1) 묵시적 NULL 입력 
INSERT INTO DEPT01(DEPTNO, DNAME) VALUES (30, 'SALES');

-- 2) 명시적 NULL 입력 
INSERT INTO DEPT01 VALUES (40, 'OPERATIONS', NULL); 

SELECT * FROM DEPT01;

-- <문제2> SAM01에 NULL값 입력 
INSERT INTO SAM01 VALUES(1030,'VERY',NULL,25000); -- '' or NULL
INSERT INTO SAM01(EMPNO,ENAME,SAL) VALUES(1040,'CAT',2000);

SELECT * FROM SAM01;

-- 서브쿼리를 이용한 레코드 삽입 

-- 1) table 준비 
drop table dept02 purge;

create table dept02
as
select * from dept where 1=0;

-- 2) 레코드 삽입 : 서브쿼리 
insert into dept02  -- 주의 : AS 없음 
select * from dept;

select * from dept02

-- <문제3> SAM01 테이블에 부서번호 10번 사원정보 추가 
insert into sam01
select empno, ename, job, sal from emp
where deptno = 10;

select * from sam01;

-- 2. 다중 테이블에 다중 행 삽입하기 

-- 1) table(2개) 준비 
create table EMP_HIR
as
select EMPNO, ENAME, HIREDATE from EMP 
WHERE 1=0;

create table EMP_MGR
as
select EMPNO, ENAME, MGR from EMP
where 1=0;

-- 2) 다중 테이블에 다중 행 삽입하기 
INSERT ALL 
INTO EMP_HIR VALUES(EMPNO, ENAME, HIREDATE)
INTO EMP_MGR VALUES(EMPNO, ENAME, MGR) 
SELECT EMPNO, ENAME, HIREDATE, MGR FROM EMP 
WHERE DEPTNO=20;

select * from EMP_HIR;
select * from EMP_MGR;

-- 3. UPDATE
select * from emp01;
-- table 준비 
create table emp01 -- 전체 구조+내용 
as 
select * from emp;

-- 기본 쿼리문 : 레코드 수정 
UPDATE EMP01 SET DEPTNO=30; -- 전체 레코드 수정  
select * from emp01;
-- 전체 사원 급여 10% 인상 
UPDATE EMP01 SET SAL=SAL*1.1;
select * from emp01;
-- 입사년도 수정 
UPDATE EMP01 SET HIREDATE = SYSDATE;

-- WHERE절 이용 
UPDATE EMP01 SET SAL = SAL*1.1 where sal <= 2000;
select * from emp01;

-- 특정 입사년도에서 입사한 사원만 수정 
UPDATE EMP01 SET HIREDATE = SYSDATE 
WHERE SUBSTR(HIREDATE, 1, 2)='87';

-- <문제4> SAM01 테이블에 저장된 사원 중 급여가 10000 이상인 사원들의 급여만 5000원씩 삭감하시오.
UPDATE SAM01 SET SAL = SAL-5000 WHERE SAL >= 10000; 
SELECT * FROM SAM01;

-- 두 개 이상 칼럼 수정 
UPDATE EMP01 SET DEPTNO=20, JOB='MANAGER'
WHERE ENAME='SCOTT'; 
SELECT * FROM EMP01;

-- 서브쿼리 이용 UPDATE
UPDATE DEPT01 
SET LOC=(SELECT LOC FROM DEPT01 WHERE DEPTNO=10)  
WHERE DEPTNO=20;

SELECT * FROM DEPT01;

-- <문제5> 서브 쿼리문을 사용하여 EMP 테이블에 저장된 데이터의 특정 컬럼만으로 구성된 SAM02 테이블을 생성하시오.
create table SAM02
AS
(SELECT ENAME, SAL, HIREDATE, DEPTNO FROM EMP);

SELECT * FROM SAM02;

-- <문제6> 생성 후 DALLAS 에 위치한 부서 소속 사원들의 급여를 1000 인상하시오. 
-- 메인 : SAM02, 서브 : DEPT
UPDATE SAM02 SET SAL = SAL + 1000
WHERE DEPTNO = 
(SELECT DEPTNO FROM DEPT WHERE LOC = 'DALLAS'); -- 20

SELECT * FROM SAM02;

-- 서버쿼리 이용 두개 이상 칼럼 수정
UPDATE DEPT01 SET (DNAME, LOC)
=(SELECT DNAME, LOC FROM DEPT01 WHERE DEPTNO=10) 
WHERE DEPTNO=40; 

SELECT * FROM DEPT01;

-- <문제7> 서브 쿼리문을 사용하여 SAM02 테이블의 모든 사원의 급여와 입사 일을 이름이 KING 인 사원의 급여와 입사일로 변경하시오. 
UPDATE SAM02 SET (SAL, HIREDATE) = 
(SELECT SAL, HIREDATE FROM SAM02 WHERE ENAME = 'KING');

SELECT * FROM SAM02;

-- 4. DELETE
DELETE FROM DEPT01 WHERE DEPTNO=30;
SELECT * FROM DEPT01;

-- 수당을 받는 사원 -> 삭제 
SELECT * FROM EMP01;
DELETE FROM EMP01 WHERE COMM IS NOT NULL;

-- 전체 레코드 삭제 
DELETE FROM DEPT01; -- 주의  요망 

-- <문제8> JOB이 없는 레코드 삭제 
DELETE FROM SAM01 WHERE JOB IS NULL;
SELECT * FROM SAM01;

-- 서브쿼리 이용 레코드 삭제 
DELETE FROM EMP01 WHERE DEPTNO=
(SELECT DEPTNO FROM DEPT WHERE DNAME='SALES'); -- 30

SELECT * FROM EMP01;





