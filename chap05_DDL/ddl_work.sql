-- ddl_work.sql
/*
 * DDL : 테이블 생성(제약조건), 구조변경, 삭제 
 *  - 자동 커밋(AUTO COMMIT)
 */
-- 1.의사컬럼 (rownum, rowid) : 가짜 칼럼
select * from emp; -- 14 row 

-- rownum : 레코드 순번(1~10row) 
SELECT ROWNUM, EMPNO, ENAME, ROWID
FROM EMP WHERE ROWNUM <=10;

-- rownum : 5~10
SELECT ROWNUM, EMPNO, ENAME, ROWID
FROM EMP WHERE ROWNUM >= 5 and ROWNUM <=10;

-- 특정 범위 행 검색 : 의사컬럼, 서브쿼리
SELECT rnum, EMPNO, ENAME
FROM (SELECT EMPNO, ENAME, ROWNUM as rnum from EMP)
WHERE rnum >= 5 AND rnum <= 10;
-- 서브쿼리 : 별칭 -> SELECT, WHERE 이용 

-- 2. 실수형 데이터 저장 테이블 
DROP TABLE EMP01 PURGE;

CREATE TABLE EMP01( 
EMPNO NUMBER(4), 
ENAME VARCHAR2(20), 
SAL NUMBER(7, 2)); -- (전체, 소숫점)

insert into emp01 values(1, '홍길동', 1234.1);
insert into emp01 values(2, '이순신', 1234.123);
insert into emp01 values(3, '강감찬', 1234.125);
insert into emp01 values(3, '강감찬', 123456.12345);--error

select * from emp01;

-- 3. 서브쿼리 이용 테이블 생성 

-- 전체내용+구조 복제
CREATE TABLE EMP02 -- MAIN
AS
SELECT * FROM EMP; -- SUB

SELECT * FROM EMP02;  

-- 특정 칼럼 + 내용 복제 
CREATE TABLE EMP03
AS
SELECT empno, ename, sal, comm FROM EMP;

SELECT * FROM EMP03;

-- <과제1> EMP 테이블을 복사하되 사원번호, 사원이름, 급여 컬럼으로 구성 된 테이블을 생성하시오.(단 테이블의 이름은 EMP04) 
CREATE TABLE EMP04
AS
SELECT EMPNO, ENAME, SAL FROM EMP;

SELECT * FROM EMP04;

-- 특정 행 구조+내용 복제  
CREATE TABLE EMP05 
AS 
SELECT * FROM EMP WHERE DEPTNO=10; -- 부서번호 : 10번 

SELECT * FROM EMP05;

-- 문) 직책(JOB)이 관리자(MANAGER)만 대상으로 테이블 생성하기(EMP_TEST)
CREATE TABLE EMP_TEST
AS
SELECT * FROM EMP WHERE JOB='MANAGER';

SELECT * FROM EMP_TEST;

-- 테이블 구조(스키마) 복제 
CREATE TABLE EMP06 
AS 
SELECT * FROM EMP WHERE 1=0; -- 조건식(FALSE)

SELECT * FROM EMP06;

-- <과제2> DEPT 테이블과 동일한 구조의 빈 테이블을 생성하시오.(테이블의 이름은 DEPT02)
CREATE TABLE DEPT02
AS
SELECT * FROM DEPT WHERE 10 = 20;

SELECT * FROM DEPT02;

INSERT INTO DEPT02 VALUES(1, '기획실', '대전');

--4. 제약조건 

-- 1) 기본키(Primary key) : 널, 중복 불가 
CREATE TABLE test_tab1( -- 컬럼 level
id number(2) primary key,
name varchar2(30)
);

CREATE TABLE test_tab2( -- table level
id number(2),
name varchar2(30),
primary key(id)
);


insert into test_tab1 values(11, '홍길동');
insert into test_tab1 values(22, '유관순');
-- null 허용 안됨 
insert into test_tab1(id, name) values(null, '유관순');
-- 중복 안됨 
insert into test_tab1 values(22, '이순신');

-- 2) 외래키 : 특정 테이블의 기본키를 다른 테이블에서 참조하는 키 
-- 작업절차 : 기본키 테이블 생성 -> 외래키 테이블 생성 

-- 1. 기본키 테이블 생성 
CREATE TABLE DEPT_TAB(
deptno number(2) primary key, -- 기본키 
dname varchar(10) not null,
loc varchar(10) not null
);

-- 레코드 삽입 
insert into dept_tab values(10, '기획', '대전');
insert into dept_tab values(20, '총무', '서울');
insert into dept_tab values(30, '판매', '미국');
select * from dept_tab;

-- 2. 외래키 테이블 생성
drop table EMP_TAB purge;

CREATE TABLE EMP_TAB(
EMPNO number(4) primary key, -- 기본키 
ENAME varchar(30),
SAL number(7),
DEPTNO number(2) not null,
FOREIGN KEY(DEPTNO) REFERENCES DEPT_TAB(deptno) -- 외래키 
);

insert into EMP_TAB values(1111,'홍길동',1500000,10);
insert into EMP_TAB values(2222, '이순신', 2500000,20);
insert into EMP_TAB values(3333, '유관순', 1000000,30);
-- 참조무결성 위배 : error
insert into EMP_TAB values(4444, '강감찬', 3000000,40); 

-- 문) 서브쿼리를 이용하여 2222 사번을 갖는 사원의 부서 정보 출력하기
-- 서브(emp_tab), 메인(dept_tab)
select * from dept_tab
where deptno = 
(select deptno from emp_tab where empno = 2222); -- 20

-- 3. 유일키(unique key)
CREATE TABLE UNI_TAB1 ( 
DEPTNO NUMBER(2) UNIQUE, -- null 허용 
DNAME CHAR(14), 
LOC CHAR(13)
); 

insert into uni_tab1 values(11, '영업부', '서울');
insert into uni_tab1 values(22, '기획실', '대전');
-- null 허용 
insert into uni_tab1(dname, loc) values('기획실2', '대전');
-- error
insert into uni_tab1 values(22, '기획실', '대전');

select * from uni_tab1;

-- 4) NOT NULL : 컬럼 level에서만 가능 

-- 5) CHECK
CREATE TABLE CK_TAB1 ( 
DEPTNO NUMBER(2) NOT NULL CHECK (DEPTNO IN (10,20,30,40,50)), 
DNAME CHAR(14), 
LOC CHAR(13)
); 

insert into ck_tab1 values(10, '회계', '서울');
insert into ck_tab1 values(60, '연구부', '대전');--error
insert into ck_tab1(dname,loc) values('연구부', '대전');--error

-- 5. 테이블 구조 변경(alter table)

-- 1) 칼럼 추가 
select * from EMP01;

ALTER TABLE EMP01 ADD(JOB VARCHAR2(9)); 
-- 기존 내용 있는 경우 : error
ALTER TABLE EMP01 ADD(JOB2 VARCHAR2(9) NOT NULL);

-- <과제3> DEPT02 테이블에 문자 타입의 부서장(DMGR) 칼럼을 추가하시오.
select * from dept02;
ALTER TABLE DEPT02 ADD(DMGR VARCHAR2(10));

-- 2) 칼럼 수정 : 주의 - 칼럼명 수정 불가능 
ALTER TABLE EMP01 MODIFY(JOB VARCHAR2(30)); -- (9)->(30)
-- 컬럼 자료형, 크기, 기본값 수정 
SELECT * FROM EMP01;
DESC EMP01; -- COMMAND LINE

-- <과제4> DEPT02 테이블의 부서장(DMGR) 칼럼을 숫자 타입 으로 변경하시오.
ALTER TABLE DEPT02 MODIFY(DMGR NUMBER(2));
DESC DEPT02; -- COMMAND LINE

-- 3) 칼럼 삭제 
ALTER TABLE EMP01 DROP COLUMN JOB; 

SELECT * FROM EMP01;

--<과제5> DEPT02 테이블의 부서장(DMGR) 칼럼을 삭제하시오.
ALTER TABLE DEPT02 DROP COLUMN DMGR;

-- 6. 테이블의 모든 ROW(레코드) 제거
SELECT * FROM EMP01;

TRUNCATE TABLE EMP01; -- 내용 삭제 

-- 7. 테이블 삭제 
DROP TABLE EMP01;
-- 전체 테이블 목록 확인 
SELECT * FROM TAB; -- TAB : 의사 테이블 
-- 임시파일 삭제 
purge recyclebin;











