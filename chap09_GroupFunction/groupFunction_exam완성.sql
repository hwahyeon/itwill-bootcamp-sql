/*
 * 집합 함수(COUNT,MAX,MIN,SUM,AVG) 
 * 작업 대상 테이블 : EMP, STUDENT, PROFESSOR
 */

--Q1. EMP 테이블에서 소속 부서별 최대 급여와 최소 급여 구하기
SELECT DEPTNO, MAX(SAL), MIN(SAL) FROM EMP
GROUP BY DEPTNO;

--Q2. EMP 테이블에서 JOB의 수 출력하기
SELECT COUNT(distinct JOB) FROM EMP; -- 5

--Q3. EMP 테이블에서 전체 사원의 급여에 대한 분산과 표준편차 구하기
SELECT VARIANCE(SAL), STDDEV(SAL) FROM EMP;

--Q4. Professor 테이블에서 학과별 급여(pay) 평균이 400 이상 레코드 출력하기
SELECT DEPTNO, AVG(PAY) FROM PROFESSOR
GROUP BY DEPTNO
HAVING AVG(PAY) >= 400; 

--Q5. Professor 테이블에서 학과별,직위별 급여(pay) 평균 구하기
-- 힌트) GROUP BY 학과번호, 직위; 
SELECT DEPTNO, POSITION, AVG(PAY) FROM PROFESSOR
GROUP BY DEPTNO, POSITION -- 1차 학과별 그룹 -> 2차 직위별 그룹
ORDER BY DEPTNO; -- 학과별 오름차순 정렬 

--Q6. Student 테이블에서 학년(grade)별로 
-- weight, height의 평균값, 최대값, 최소값을 구한 
-- 결과에서 키의 평균이 170 이하인 경우 구하기
SELECT GRADE, AVG(WEIGHT),AVG(HEIGHT),
MAX(WEIGHT),MAX(HEIGHT),MIN(WEIGHT),MIN(HEIGHT)
FROM STUDENT
GROUP BY GRADE
HAVING AVG(HEIGHT) <= 170; -- 1 ROW 검색 




