-- groupFunction_work.sql

/*
 * 그룹 함수 : 그룹 단위 집계/통계 구하는 함수 
 *  - 사용 칼럼 : 범주형(집단형) 칼럼 
 */

-- 1. 그룹함수 

-- 1) sum() 
SELECT SUM(SAL) FROM EMP;
SELECT comm from emp;
SELECT SUM(COMM) FROM EMP; -- null 무시 

-- 2) avg()
SELECT ROUND(AVG(SAL), 3) FROM EMP;
SELECT AVG(COMM) FROM EMP; -- 550
SELECT SUM(COMM)/4 FROM EMP; -- 550

-- 3) min/max() 
SELECT MAX(SAL) FROM EMP;
SELECT MIN(SAL) FROM EMP;

-- 문) 가장 최근에 입사한 사원의 입사일과 입사한지 가장 오래된 사원의 입사일 을 출력하는 쿼리문을 작성하시오. 
SELECT MAX(HIREDATE) "최근 입사일", MIN(HIREDATE) "가장 오랜된 입사일" FROM EMP;

-- 5) COUNT : NULL 제외 
SELECT COUNT(COMM) FROM EMP; -- 4
SELECT COUNT(HPAGE) FROM PROFESSOR; -- 4
SELECT COUNT(*) FROM PROFESSOR; -- 16

-- 문2) 10번 부서 소속 사원중에서 커미션을 받는 사원의 수를 구해보시오.(EMP)
SELECT COUNT(COMM) FROM EMP WHERE DEPTNO = 10; -- 0
-- 문2-2) 'SCOTT' 사원와 같은 부서에 근무하는 사원에 대한 급여 합계,평균
-- 힌트) 서브쿼리 적용 
SELECT SUM(SAL), AVG(SAL) FROM EMP
WHERE DEPTNO =
 (SELECT DEPTNO FROM EMP WHERE ENAME = 'SCOTT');


-- 6) 분산/표준편차 : 산포도

-- 분산 = (편차)^2 총합 / 변수 개수  
SELECT VARIANCE(bonus) from PROFESSOR;
-- 표준편차 : 분산의 양의 제곱
SELECT STDDEV(bonus) from PROFESSOR; -- 30.8
SELECT sqrt(VARIANCE(bonus)) from PROFESSOR; -- 30.8

-- 2. GROUP BY 절 : 범주형 칼럼(집단형)
-- 동일한 집단별로 묶어서 집단별 집계를 구한다.
SELECT DEPTNO FROM EMP GROUP BY DEPTNO; -- 10,20,30
SELECT DEPTNO, SUM(SAL), AVG(SAL) FROM EMP GROUP BY DEPTNO;

SELECT DEPTNO, MAX(SAL), MIN(SAL) FROM EMP GROUP BY DEPTNO;

-- 교수 테이블에서 직급별(전임/조/부/정) 교수의 평균 급여 계산 
SELECT POSITION, ROUND(AVG(PAY), 3) 
FROM PROFESSOR
GROUP BY POSITION;

/*
 * SQL문에서 조건절
 * 1. SELECT * FROM 테이블명 WHERE 조건식;
 * 2. SELECT * FROM 테이블명  GROUP BY 칼럼명 HAVING 조건식;
 */

-- 3. HAVING 조건
SELECT DEPTNO, AVG(SAL) FROM EMP 
GROUP BY DEPTNO 
HAVING AVG(SAL) >= 2000;

SELECT DEPTNO, AVG(SAL) FROM EMP 
GROUP BY DEPTNO 
HAVING DEPTNO IN (10, 20); -- 30부서 제외 

SELECT DEPTNO, MAX(SAL), MIN(SAL) FROM EMP 
GROUP BY DEPTNO 
HAVING MAX(SAL) > 2900;

SELECT DEPTNO, MAX(SAL), MIN(SAL) FROM EMP 
GROUP BY DEPTNO 
HAVING MIN(SAL) > 900;

-- 문3) 학생(STUDENT) 테이블에서 학년(GRADE)별 
-- 몸무게 평균(WEIGHT)이 60이상인 학생 정보 조회하기 
SELECT GRADE, AVG(WEIGHT) FROM STUDENT
GROUP BY GRADE
HAVING AVG(WEIGHT) >= 60;

-- 문4) 교수(PROFESSOR) 테이블에서 학과(DEPTNO)별
-- 급여(PAY)의 평균이 300 미만인 교수 정보 조회하기 
SELECT DEPTNO, AVG(PAY) FROM PROFESSOR
GROUP BY DEPTNO
HAVING AVG(PAY) < 300; -- 7개 -> 2개 선택 

SELECT * FROM STUDENT;