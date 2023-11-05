-- view_work.sql

-- 뷰(view) : 가상 테이블 

-- 1. 물리적 테이블 생성 
create table db_view_tab(
id varchar(15) primary key,
name varchar(20) not null,
email varchar(50),
regdate date not null
); 

insert into db_view_tab 
     values('hong','홍길동','hong@naver', sysdate)
insert into db_view_tab 
     values('admin','관리자','admin@naver', sysdate)
select * from db_view_tab;
commit work;

-- 2. view 생성 : 서브쿼리 이용 
create or replace view admin_view  -- 가상 테이블 
as
select * from db_view_tab 
where id = 'admin' with read only; -- 물리 테이블 
-- with read only : 읽기 전용 view 생성 

-- view 전체 목록 확인 
select * from user_views;

-- view 내용 보기 
select * from admin_view;

-- view 삭제 
drop view admin_view;

-- <실습3> 뷰 정의하기 
-- 물리적 테이블 : EMP, 가상 테이블 : EMP_VIEW30(사번,이름,부서번호)
-- 읽기 전용 VIEW 생성  
create or replace view EMP_VIEW30
as
select empno, ename, deptno from EMP
where deptno = 30 with read only;

select * from EMP_VIEW30;

-- 3. view 사용 용도(목적)
/*
 * 1) 복잡한 slq문 사용 시 
 * 2) 보안 목적 : 접근권한에 따라서 서로 다르게 정보 제공  
 */

-- 1) 복잡한 slq문 사용 시
select * from product;
select * from sale;

create or replace view join_view
as
(select p.code, p.name, s.price, s.sdate
from product p, sale s
where p.code = s.code and p.name like '%기')
with read only;

select * from join_view;

-- 2) 보안 목적 : 접근권한에 따라서 서로 다르게 정보 제공 
select * from emp;

-- (1) 영업사원에게 제공하는 view 
create or replace view sales_view
as
(select empno, ename, comm from emp
 where job = 'SALESMAN')
with read only;

select * from sales_view;
-- 읽기  전용 : error 
delete from sales_view where empno=7499;-- 7499

-- (2) 일반사원에게 제공하는 view
create or replace view clerk_view
as
(select empno, ename, mgr, hiredate, deptno
from emp where job = 'CLERK')
with read only;

select * from clerk_view;

-- (3) 관리자에게 제공하는 view
/*
 * 조건1> view 이름 : manager_view
 * 조건2> 대상 칼럼 : 전체 
 * 조건3> 직책(영업, 사원, 분석자)
 * 조건4> 물리적 테이블 : emp
 */
create or replace view manager_view
as
(select * from emp 
  where job in ('SALESMAN', 'CLERK', 'ANALYST'))
with read only;

select * from manager_view;


-- 4. 의사컬럼(rownum) 이용 view 생성 
-- ex) 최초 입사자 top5, 급여 수령자 top3
select rownum, empno, ename from emp
where rownum <= 5;

-- (1) 입사일 TOP5 view 생성

-- [1] 정렬 -> VIEW 
create or replace view top5_hire_view
as
select empno, ename, hiredate
from emp
order by hiredate
with read only;

-- [2] 입사자 TOP5
select rownum, empno, ename, hiredate 
from top5_hire_view
where rownum <= 5;

-- (2) 가장 많은 급여 수령자 TOP3 view 생성 
-- view 이름 : top3_sal_view
-- 선택할 칼럼 : 사번, 이름, 급여, 입사일
-- [1] 정렬 -> view 생성 
create or replace view top3_sal_view
as
select empno, ename, sal, hiredate
from emp order by sal desc
with read only;

-- [2] 급여수령자 TOP3
select rownum, empno, ename, sal, hiredate
from top3_sal_view
where rownum <=3;

























