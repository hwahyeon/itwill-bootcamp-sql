-- step02_join_work.sql

/*
 * 카티전 조인(Cartesian join)
 *  - 물리적 join 없이 논리적으로 테이블을 연결하는 기법(공통 칼럼 기준)
 *  - [종류]
 * 1. inner join
 *  - 조인 대상의 테이블에 모두 데이터가 존재하는 경우 
 * 2. outer join
 *  - 두 개 테이블 중 하나의 테이블에 데이터가 존재하는 경우 
 *  - left outer join, right outer join, full outer join
 */ 

-- 1. inner join : 학생(student) vs 학과(department)
select * from student; -- deptno01(주전공)
select * from department; -- deptno(학과번호)

-- 학생(이름, 주전공), 학과(학과이름) : 20개 레코드 
select s.name, s.deptno1, d.dname
from student s, department d -- 두 테이블 null 없음 
where s.deptno1 = d.deptno; -- join 조건 

-- ANSI 표준 : inner join  
select s.name, s.deptno1, d.dname
from student s inner join department d
on s.deptno1 = d.deptno;


-- [문1] 학생(student) 테이블과 교수(professor) 테이블 조인 
-- <조건1> 조인 칼럼 : profno(교수번호)
-- <조건2> 이름(s), 학과번호(s), 교수명(p), 교수번호(p) 칼럼 조회 
select * from student; -- profno : 20명 학생 
select * from professor; -- profno

select s.name, s.deptno1, p.name, p.profno
from student s, professor p
where s.profno = p.profno; -- join 조건 : 15명 학생 

-- [문2] 문1의 결과에서 101학과 학생만 검색되도록 하시오.
select s.name, s.deptno1, p.name, p.profno
from student s, professor p
where s.profno = p.profno and s.deptno1 = 101;

-- 2개 이상 테이블 join : 학생, 학과, 교수 
-- join 조건 : 학생 - deptno - 학과, 학생  -profno- 교수
select s.name "학생명", d.dname "학과명", p.name "교수명"
from student s, department d, professor p
where s.deptno1 = d.deptno and s.profno = p.profno;


-- 2. outer join 

-- 1) left outer join : 학생(기준) vs 교수 
-- join 조건 : 학생 <- profno -> 교수
select s.name "학생명", p.name "교수명"
from student s, professor p
where s.profno = p.profno(+); -- 왼쪽 기준 : 전체 학생 20명 

-- ANSI 표준 : left outer join
select s.name "학생명", p.name "교수명"
from student s left outer join professor p
on s.profno = p.profno(+); 


-- 2) right outer join : 학생 vs 교수(기준)
-- join 조건 : 학생 <- profno -> 교수
select s.name "학생명", p.name "교수명"
from student s, professor p
where s.profno(+) = p.profno; -- 오른쪽 기준 

-- ANSI 표준 : right outer join
select s.name "학생명", p.name "교수명"
from student s right outer join professor p
on s.profno(+) = p.profno; 


-- full outer join : 완전 outer join
select s.name "학생명", p.name "교수명"
from student s, professor p
where s.profno(+) = p.profno(+); -- error 

-- inner join
select s.name "학생명", p.name "교수명"
from student s, professor p
where s.profno = p.profno; 

-- ANSI 표준 제공 : full outer join
select s.name "학생명", p.name "교수명"
from student s full outer join professor p
on s.profno = p.profno; 




