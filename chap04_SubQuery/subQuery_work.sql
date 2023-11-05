-- subQuery_work.sql

/*
 형식1)
 main query -> 2차 실행  
 as
 sub query; -> 1차 실행 
 
 형식2)
 main query 관계연산자 (sub query);
*/

-- 형식1)
create table dept01  -- main(2차) 
as
select * from dept; -- sub(1차)

select * from dept01; -- 내용(data) + 구조(desc) 

-- 형식2) : main(dept), sub(emp)
select * from emp; -- deptno(o), dname(x)

-- TABLE JOIN(DEPT vs EMP) 
select * from dept 
where deptno = 
(select deptno from emp where ename='SCOTT'); -- 20


-- 1. 단일행 서브쿼리 

-- <실습1> SCOTT과 같은 부서에서 근무하는 사원의 이름과 부서 번호를 출력 하는 SQL 문을 작성해 보시오. (EMP)
-- main(emp), sub(emp)
select ename, deptno from emp
where deptno = 
(select deptno from emp where ename = 'SCOTT');

-- <실습2> SCOTT와 동일한 직속상관(MGR)을 가진 사원을 출력하는 SQL 문을 작성해 보시오. (EMP)
-- main(emp), sub(emp)
select * from emp
where MGR = 
(select MGR from emp where ename = 'SCOTT'); -- 7566

-- <실습3> SCOTT의 급여와 동일하거나 더 많이 받는 사원 명과 급여를 출력하 시오.(EMP)
select ename, sal from emp
where sal >= 
(select sal from emp where ename = 'SCOTT'); -- 3000

-- <실습4> DALLAS에서 근무하는 사원의 이름, 부서 번호를 출력하시오. 
-- (서브쿼리 : DEPT01, 메인쿼리 : EMP)
SELECT ENAME, DEPTNO from emp
where deptno = 
(select DEPTNO from DEPT01 where LOC='DALLAS'); -- 20
-- where LOC in ('DALLAS')
SELECT ENAME, DEPTNO from emp
where deptno in 
(select DEPTNO from DEPT01 where LOC in ('DALLAS'));

-- <실습5> SALES(영업부) 부서에서 근무하는 모든 사원의 이름과 급여를 출력하시오.
-- (서브쿼리 : DEPT01, 메인쿼리 : EMP)
SELECT ENAME, SAL from emp
where deptno = 
(select DEPTNO from DEPT01 where dname='SALES'); -- 10

-- 문) 연구(RESEARCH)부서 에서 근무하는 모든 사원 정보를 출력하시오.
-- 서브쿼리 : DEPT01 , 메인쿼리 : EMP
SELECT * from emp
where deptno =
(select deptno from dept01 where dname='RESEARCH'); -- 20


-- 2. 단일행 서브쿼리(집합함수)
SELECT ENAME, SAL FROM EMP 
WHERE SAL 
> 
(SELECT AVG(SAL) FROM EMP); --2073

SELECT SUM(SAL) FROM EMP; -- 29025

-- 문) 평균 이하 급여 수령자 출력하기 
SELECT ENAME, SAL FROM EMP 
WHERE SAL 
<= 
(SELECT AVG(SAL) FROM EMP);

-- 3. 다중 행 서브쿼리(IN, ANY, ALL)

-- 1) IN (list)
SELECT ENAME, SAL, DEPTNO FROM EMP 
WHERE DEPTNO 
IN 
(SELECT DISTINCT DEPTNO FROM EMP WHERE SAL>=3000);--20,10

-- 단일 쿼리 
SELECT ENAME, SAL, DEPTNO FROM EMP 
WHERE DEPTNO IN (10, 20); 

-- <실습8> 직급(JOB)이 MANAGER인 사람이 속한 부서의 부서 번호와 부서명과 지역을 출력하시오.
-- (DEPT01과 EMP 테이블 이용)
select * from DEPT01
where deptno in 
(select deptno from emp where job='MANAGER');--10,20,30

-- 2) ALL(AND) : 서브쿼리의 최댓값 이상 검색 
SELECT ENAME, SAL FROM EMP 
WHERE SAL 
> ALL
(SELECT SAL FROM EMP WHERE DEPTNO=30);--950 ~ 2850

-- 3) ANY(OR) : 서브쿼리의 최솟값 이상 검색
SELECT ENAME, SAL FROM EMP 
WHERE SAL 
> ANY
(SELECT SAL FROM EMP WHERE DEPTNO=30);--950 ~ 2850



