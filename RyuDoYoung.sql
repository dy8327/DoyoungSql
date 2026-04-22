select * from emp ; 

select ename from emp;

select empno, ename from emp;

select distinct job from emp;

select job from emp;

select job as a from emp;

SELECT EMPNO AS EMPLOYEE_NO,
ENAME AS EMPLOYEE_NAME,
JOB,
MGR AS MANAGER,
HIREDATE,
SAL AS SALARY,
COMM AS COMMISSION,
DEPTNO AS DEPARTMENT_NO
FROM EMP
ORDER BY DEPTNO DESC, ENAME;

select * from emp;

select * from dept where deptno=20;

select * from emp where deptno=30 and job='SALESMAN';

select * from emp where deptno=30 or job='CLERK';

select * from emp where sal >=3000;

select * from emp where ename>='F';

select * from emp where not sal=3000;

select * from emp where job in('MANAGER', 'SALESMAN', 'CLERK');

select * from emp where sal between 2000 and 3000;

select * from emp where sal not between 2000 and 3000;

select ename from emp where not sal=3000;

select * from emp where ename like 'S%';

select * from emp where ename like '_L%';

select * from emp where ename like '%AM%';

select * from emp where ename not like '%AM%';