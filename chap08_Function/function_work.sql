-- 1. 숫자처리 함수 

-- 1) abs
select -10, abs(-10) from dual;

-- 2) round - 반올림 
select 12.345, round(12.345, 2) from dual; -- 소숫점
select 34.5678, ROUND(34.5678, -1) from dual; -- 30(1자리)

-- 3) mod - 나머지 값 (if(num % 2) == 0)
select mod(10,2), mod(27,2) from dual;

select * from professor where mod(deptno, 2)=0;
-- 학과(deptno) 짝수인 경우 

-- 문) 사번이 홀수인 사람들을 검색해 보십시오.(EMP 테이블) 
select * from emp where mod(empno, 2)!=0;

-- 2. 문자처리 함수 

-- 1) UPPER : 소문자 -> 대문자 
SELECT 'Welcome to Oracle', 
UPPER('Welcome to Oracle') FROM DUAL; 

-- 2) LOWER : 대문자 -> 소문자 
SELECT 'Welcome to Oracle', LOWER('Welcome to Oracle') 
FROM DUAL; 

-- 3) INITCAP : 단어 첫자 대문자 
SELECT 'WELCOME TO ORACLE',                
       INITCAP('WELCOME TO ORACLE') FROM DUAL; 

-- 문2) 다음과 같이 쿼리문을 구성하면  직급이 'manager'인 사원을 검색할까?  
SELECT EMPNO, ENAME, JOB  FROM EMP  
       WHERE JOB=UPPER('manager'); 
       
-- 4) LENGTH/LENGTHB  
SELECT * FROM EMP;     

SELECT ENAME, LENGTH(ENAME), LENGTHB(ENAME) FROM EMP;
SELECT NAME, LENGTH(NAME), LENGTHB(NAME) FROM STUDENT;
       
-- 5) SUBSTR
SELECT SUBSTR('Welcome to Oracle', 4, 3) FROM DUAL;        
SELECT SUBSTR('191020-1234567', 3,2) FROM DUAL;       
SELECT * FROM STUDENT;       

-- 10월생 학생 선택하기 
SELECT NAME, BIRTHDAY, SUBSTR(BIRTHDAY, 4, 2)
FROM STUDENT WHERE SUBSTR(BIRTHDAY, 4, 2) = 10;

-- 문3) 9월에 입사한 사원을 출력해보세요. (EMP 테이블)
SELECT * FROM EMP WHERE SUBSTR(HIREDATE, 4, 2) = 9;

-- 6) TRIM/LTRIM/RTRIM : 앞/뒤 공백 
SELECT LTRIM(' Oracle ')  FROM DUAL; -- 앞부분 공백
SELECT RTRIM(' Oracle ')  FROM DUAL; -- 뒷부분 공백
SELECT TRIM(' Oracle ')  FROM DUAL; -- 앞/뒤 공백 

-- 3. 날짜처리 함수 

-- 1) SYSDATE
SELECT SYSDATE FROM DUAL;

-- 2) ADD_MONTHS 
-- 형식) ADD_MONTHS(칼럼명, 월수)
SELECT HIREDATE, ADD_MONTHS(HIREDATE, 12) FROM PROFESSOR;

-- 3) NEXT_DAY
SELECT SYSDATE, NEXT_DAY(SYSDATE, '금요일')  FROM DUAL; 


-- 4. 형 변환 함수 
/*
 * 기존 자료형 -> 다른 자료형 
 * to_char() : 날짜형, 숫자형 -> 문자형 변환 
 * to_date() : 숫자형, 문자형 -> 날짜형 변환 
 * to_number() : 특정 문자 -> 숫자형 변환 
 */

-- 1) to_char(칼럼명, 'format')
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY-MM-DD') FROM DUAL; 
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YY/MM/DD') FROM DUAL;

SELECT HIREDATE, TO_CHAR (HIREDATE, 'YYYY/MM/DD DAY') FROM EMP; 

SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD, HH24:MI:SS') FROM DUAL; 
-- 급여 표현 
SELECT ENAME, SAL, TO_CHAR (SAL, 'L999,999')  FROM EMP; 

-- 2) TO_DATE() : date 컬럼 
SELECT ENAME, HIREDATE FROM EMP WHERE HIREDATE=TO_DATE(19810220,'YYYYMMDD'); 
SELECT ENAME, HIREDATE FROM EMP WHERE HIREDATE=TO_DATE('1981/02/20','YYYY/MM/DD');

-- 3) TO_NUMBER('string', 'format')
SELECT TO_NUMBER('20,000', '99,999') - TO_NUMBER('10,000', '99,999') FROM DUAL; 

-- 5. NULL 처리 함수 
/*
 * 1. NVL(칼럼명, 값) : 해당 칼럼명 값이 NULL -> 값 대체 
 * 2. NVL2(칼럼명, 값1, 값2) : 칼럼명 NULL -> 값2, NOT NULL -> 값1
 */
select name, pay, bonus, nvl2(bonus, bonus*2, 0) 
from professor where deptno = 101;

-- 6. decode() 함수 
-- 형식) decode(칼럼명, 값, 디코딩내용)
select ename, deptno, 
decode(deptno, 10, '기획실',
               20, '연구실', '영업부') 부서명
from emp;















