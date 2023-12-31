﻿/*
 * 주요 함수 
 * 작업 대상 테이블 : STUDENT, EMP, PROFESSOR 
 */

--Q1. STUDENT 테이블에서 JUMIN 칼럼을 사용하여 
-- 태어난 달이 8월인 사람의 이름과 생년월일 출력하기
-- 힌트 : substr() 함수 이용
SELECT NAME, BIRTHDAY, JUMIN, SUBSTR(JUMIN, 3, 2)
FROM STUDENT 
WHERE SUBSTR(JUMIN, 3, 2) = '08';

--Q2. EMP 테이블에서 사번이 홀수인 사람들을 검색하기
-- 힌트 : mod() 함수 이용
SELECT * FROM EMP WHERE MOD(EMPNO, 2) != 0;

--Q3. Professor 테이블에서 교수명, 급여, 보너스, 연봉을 출력하기 
-- 조건) 연봉 = pay*12+bonus 으로 계산, bonus가 없으면 pay*12 처리
-- 힌트 : nvl2() 함수 이용
SELECT NAME, PAY, BONUS, 
NVL2(BONUS, pay*12+bonus, pay*12) AS 연봉 FROM PROFESSOR;

--Q4. Professor 테이블에서 교수명, 학과명을 출력하되 
--  deptno가 101번이면 ‘컴퓨터 공학과’, 102번이면 
-- ‘멀티미디어 공학과’, 103번이면 ‘소프트웨어 공학과’, 
-- 나머지는 ‘기타학과’로 출력하기
-- decode()함수 이용
SELECT DISTINCT DEPTNO FROM PROFESSOR; --7개 학과 

SELECT NAME, DEPTNO, 
DECODE(DEPTNO, 101, '컴퓨터 공학',
               102, '멀티미디어공학',
               103, '소프트웨어공학', '기타학과') AS 학과명 
FROM PROFESSOR;




