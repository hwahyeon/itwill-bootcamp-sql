--1. 테이블 생성
select * from dept01;
drop table dept01 purge;

--구조 복사
create table dept01
as
select * from dept where 0=1;

--2. sequence 생성
CREATE SEQUENCE DEPT_DEPTNO_SEQ
INCREMENT BY 1
START WITH 1;

-- 3. 레코드 삽입
insert into dept01 values(DEPT_DEPTNO_SEQ.nextval, 'test', '서울시');
insert into dept01 values(DEPT_DEPTNO_SEQ.nextval, 'test2', '대전시');

--DEPT_DEPTNO_SEQ(객체).nextval(멤버) 객체가 멤버를 호출하는 것.
--CURRVAL(현재 값을 반환한다) 이 멤버도 호출할 수 있다.

select * from dept01;

DESC USER_SEQUENCES --이클립스에서 실행 불가

--4. sequence 목록 보기
select * from tab; --전체 테이블 목록
select * from user_tables; -- 전체 테이블 목록
select * from user_sequences; --현재 접속한 사람의 시퀀스 목록 // 이런 것을 사용자 딕셔너리라고 부름

SELECT DEPT_DEPTNO_SEQ.NEXTVAL FROM DUAL; --DUAL은 오라클에서의 의사테이블, 테스트를 목적으로 하는 테이블이다. // 시퀀서를 select로 확인할 때 사용함.

--[실습]
--1. 시퀀스 생성

CREATE SEQUENCE EMP_SEQ
START WITH 1
INCREMENT BY 1
MAXVALUE 100000; -- 1부터 1씩 증가하여 십만까지

--2. 테이블 생성
DROP TABLE EMP01 purge;
CREATE TABLE EMP01(
EMPNO NUMBER(4) PRIMARY KEY,
ENAME VARCHAR2(10),
HIREDATE DATE);

--3. 레코트 삽입
INSERT INTO EMP01 VALUES(EMP_SEQ.NEXTVAL, 'JULIA' , SYSDATE);
INSERT INTO EMP01 VALUES(EMP_SEQ.NEXTVAL, 'JULIA2' , SYSDATE);

select * from emp01;
delete from emp01 where empno = 2; --부서번호가 2번인 레코드 제거

INSERT INTO EMP01 VALUES(EMP_SEQ.NEXTVAL, 'JULIA3' , SYSDATE); --지우고 다시 추가하면 지워졌던 레코드 번호는 복원이 안됨.
--시퀀스는 한번 삭제된 번호는 복원이 안된다.

--5. 시퀀스 삭제
DROP SEQUENCE DEPT_DEPTNO_SEQ; --시퀀스는 임시파일 안남고 완전 제거됨.
select * from user_sequences; --시퀀스가 지워진 것을 확인할 수 있음.

--6. 문자열+시퀀스 숫자
create table board(
bno varchar(10) primary key, -- 게시물 번호
writer varchar(20) not null -- 작성자
);

alter table board modify(bno varchar(20));

--시퀀스 생성
create sequence bno_seq
start with 1001
increment by 1;

--홍길동1001, 이순신1002
insert into board values('홍길동'||to_char(bno_seq.nextval), '홍길동');  --char로 바꾸라는 오라클의 함수
insert into board values('이순신'||to_char(bno_seq.nextval), '이순신');
insert into board values('홍길동'||to_char(bno_seq.nextval), '홍길동');


--시퀀스 : 은행의 번호표와 같음





