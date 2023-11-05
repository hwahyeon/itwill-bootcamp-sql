-- select_work.sql

/*
  여러 줄의 주석문 
*/

select * from tab;

-- 1. 전체 검색(특정 칼럼 검색)

-- 전체 칼럼 조회 
SELECT * FROM emp;
-- 특정 칼럼 조회 
SELECT empno, ename, sal, job FROM emp;
SELECT ename, sal, sal+300  FROM emp; -- 산술표현 
select ename, sal, sal*1.1 FROM emp; -- 급여 10% 인상 
 
SELECT empno, ename, sal, comm, sal+comm/100 FROM emp;

-- null 처리 함수 이용 : 연봉+수당 
SELECT ename,sal,comm, sal*12+NVL(comm,0) FROM emp;

-- 열에 별칭(Alias) 부여 
SELECT ename,sal,comm, sal*12+NVL(comm,0) AS 실급여 FROM emp;
SELECT ename,sal,comm, sal*12+NVL(comm,0) 실급여 FROM emp;
SELECT ename,sal,comm, sal*12+NVL(comm,0) AS "실 급 여" FROM emp;

--  연결 연산자(||)
SELECT ename || ' ' || job from emp;
SELECT ename || ' ' || job AS "employees" FROM emp;

-- DISTINCT : 범주형(집단) 칼럼(gender) 적용 
select distinct job from emp;
-- 1차 칼럼 -> 2차 칼럼 
SELECT DISTINCT deptno, job FROM emp;

-- 2. 조건 검색(특정 행 검색)
SELECT empno, ename, job, sal FROM emp 
WHERE sal >= 3000;

-- 문자 literal : 문자 칼럼, 날짜 칼럼 
SELECT empno, ename, job, sal, deptno FROM emp 
WHERE job = 'MANAGER'; -- job = 'manager'(x)

select empno,ename,job,sal,hiredate,deptno from emp 
where hiredate >= to_date('1982/01/01', 'yyyy/mm/dd');
-- to_date('문자상수', format) : 문자상수 -> 날짜 형식으로 변환 

-- SQL 연산자 
SELECT ename, job, sal, deptno FROM emp 
WHERE sal BETWEEN 1300 AND 1500; -- 1300 ~ 1500

-- 관계/논리 연산자 
SELECT ename, job, sal, deptno FROM emp 
WHERE sal >= 1300 and sal <= 1500; -- 1300 ~ 1500

-- IN 연산자 
SELECT empno,ename,job,sal,hiredate FROM emp 
WHERE empno IN (7902,7788,7566);

-- 관계/논리 연산자 
SELECT empno,ename,job,sal,hiredate,deptno FROM emp 
where hiredate >= to_date('1982/01/01', 'yyyy/mm/dd') 
and hiredate <= to_date('1982/12/31', 'yyyy/mm/dd');

-- BETWEEN a AND b 적용 
SELECT empno,ename,job,sal,hiredate,deptno FROM emp
where hiredate BETWEEN to_date('1982/01/01', 'yyyy/mm/dd') 
AND to_date('1982/12/31', 'yyyy/mm/dd');

-- LIKE 연산자  : 포함문자 상수 검색 
SELECT empno,ename,job,sal,hiredate,deptno FROM emp 
where hiredate like '87%'; -- command line에서 날짜 확인 

select * from emp where ename like 'M%';

-- 서재수 
select * from student where name like '서%'; -- 시작
select * from student where name like '%재%'; -- 전체 
select * from student where name like '%수'; -- 종료 

-- 관계/논리연산자 
SELECT empno,ename,job,sal,hiredate,deptno FROM emp 
WHERE sal >= 1100 AND job = 'MANAGER';

-- 문1) 부서번호(deptno)가 10번이고, 급여가 2500 이상 사원 조회 
select * from emp where deptno = 10 and sal >= 2500;

-- 문2) 직책(job)이 사원('CLERK')이거나 부서번호(deptno)가 30인 사원 조회 
select * from emp where job='CLERK' OR deptno = 30;

-- is null
SELECT empno,ename,job,sal,comm,deptno FROM 
emp WHERE comm IS NULL; -- 수당 없음 

SELECT empno,ename,job,sal,comm,deptno FROM 
emp WHERE comm IS not NULL; -- 수당 있음 

-- 3. 검색 레코드 정렬
SELECT hiredate,empno,ename,job,sal,deptno FROM emp 
ORDER BY hiredate; -- default : 오름차순 

SELECT hiredate,empno,ename,job,sal,deptno FROM emp 
ORDER BY hiredate desc; -- 내림차순 

-- 별칭 이용 정렬 
SELECT empno,ename,job,sal,sal*12 년봉 FROM emp 
ORDER BY 년봉;
-- 수식 이용 정렬 
SELECT empno,ename,job,sal,sal*12 annsal FROM emp 
ORDER BY sal*12;
-- 컬럼 위치 정렬 
SELECT empno,ename,job,sal,sal*12 annsal FROM emp 
ORDER BY 5;

-- 두 개 이상 칼럼으로 정렬 
SELECT deptno,sal,empno,ename,job FROM emp 
ORDER BY deptno ASC, sal DESC;
-- 1차 정렬 : 부서번호 오름차순 
-- 2차 정렬 : 급여 내림차순 정렬 











