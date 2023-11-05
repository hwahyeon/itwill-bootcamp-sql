select * from STUDENT; -- profno, deptno01
select * from PROFESSOR; -- profno

-- [문1] STUDENT 테이블 검색 결과(sub)를 이용하여 STUDENT01 테이블 생성(main) 
-- Sub(STUDENT), Main(STUDENT01)
CREATE TABLE STUDENT01
AS
SELECT * FROM STUDENT;

SELECT * FROM STUDENT01;

-- [문2] 교수번호가 2001인 지도교수를 모시는 전체 학생 명부 출력
-- Sub(PROFESSOR), Main(STUDENT01)
SELECT * FROM STUDENT01
WHERE PROFNO = 
(SELECT PROFNO FROM PROFESSOR WHERE PROFNO = 2001);--2001

-- [문3] 보너스를 받는 교수들의 이름, 직위, 급여, 보너스 출력
-- 조건) IN()함수 이용 : 다중 행 처리  
SELECT NAME, POSITION, BONUS FROM PROFESSOR
WHERE PROFNO IN
(SELECT PROFNO FROM PROFESSOR WHERE BONUS IS NOT NULL);

-- [문4] 301 학과(DEPTNO) 교수들 보다 더 많은 급여를 받는 교수들의 이름, 직위, 급여, 학과 출력
-- 조건) ALL()함수 이용 : 다중 행 처리 
SELECT NAME, POSITION, PAY, DEPTNO FROM PROFESSOR
WHERE PAY > 
ALL(SELECT PAY FROM PROFESSOR WHERE DEPTNO = 301);--290
      
      
       
       
       