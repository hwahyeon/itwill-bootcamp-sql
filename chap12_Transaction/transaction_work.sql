--transaction_work.sql
select * from dept;

--1. table 생성
create table dept_test
as
select * from dept;

--2. savepoint 저장하는 위치
savepoint s1;
delete from dept_test where deptno = 40;
select * from dept_test;

savepoint s2;
delete from dept_test where deptno = 30;
select * from dept_test;
--지금 commit하면 db에 최종반영되어 롤백이 불가.

savepoint s3;
delete from dept_test where deptno = 20;
select * from dept_test;

--레코드 복원하기
rollback to s3;
select * from dept_test;

rollback to s1;
select * from dept_test; --s1까지 '모든 내용'이 복원됨.

--4. commit : db반영 (rollback 불가)
delete from dept_test where deptno = 40;
commit; -- db 반영
savepoint s4;

delete from dept_test where deptno = 30;

rollback s4; -- = rollback to s4;
select * from dept_test; --40번 레코드는 복원이 안됨. 나머진 복원이 됨.


--Oracle SQL Developer툴에서 실습한 것을 옮긴 것임. 툴과 툴의 인코딩 방식이 달라서 한글이 깨지는 경우가 있다.