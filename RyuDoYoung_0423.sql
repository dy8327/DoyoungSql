select * from emp 
where sal>null and comm is null;

select * from emp;

--중복이 최소화 되는 합집합--
select empno, ename, sal, deptno 
from emp where deptno =10 
union 
SELECT 
empno, ename, sal, deptno 
from emp where deptno =20;

--중복을 허용하는 합집합--
select empno, ename, sal ,deptno 
from emp 
where deptno =10 
union all 
select empno, ename, sal, deptno 
from emp 
where deptno = 10;

--차집합--
select empno, ename, sal, deptno 
from emp 
minus 
select empno, ename, sal,
deptno 
from emp 
where deptno=10; //DEPTNO 10을 제외한 나머지 표출

--교집합--
select empno, ename, sal, deptno 
from emp 
intersect 
select empno, ename, sal, deptno 
from emp 
where deptno = 10;

--문자 함수(사용법이 조금 다르네)--
select lower(ename) 
--이름을 소문자로 표현
from emp; 

select ename, 
--대문자로
upper(ename), 
--소문자로
lower(ename),
--앞에만 대문자로
initcap(ename) 
from emp;

select * 
from emp 
--이름찾기
where upper(ename) = upper('scott');

--문자열 추출(데이터 베이스는 포인터 자리를 준다. [0]인덱스-- 
select * from emp;
select job, 
substr(job,1,2),substr(job,3,2),substr(job,5) 
from emp;

-- 문자열 데이터 내 특정문자 찾기--
select * from emp;
select * 
from emp 
where instr(ename,'S')>0;

--특정 문자 대체--
select '010-1234-5678' as replace_before, 
replace('010-1234-5678','-',' ') as replace_1, 
replace('010-1234-5678','-') as replace_2 
from DUAL;

--데이터 빈공간 채우기--
select 'Oracle',
lpad('Oracle',10,'#') as lpad_1,
rpad('Oracle',10,'*') as rpad_1 
from DUAL;

--두 문자열 데이터 합치기--
select * from emp;
select concat(empno, ename), 
concat(empno,concat(':',ename))
from emp 
where ename='SCOTT';

--반올림--
select 
round(1234.5678) as round,
round(1234.5678,0) as round_0, 
round(1234.5678,1) as round_1,
round(1234.5678,2) as round_2, 
round(1234.5678,-1) as round_minus1,
round(1234.5678,-2) as round_minus2 
from DUAL;

--버림--
select 
trunc(1234.5678) as trunc, 
trunc(1234.5678, 0) as trunc_0,
trunc(1234.5678,1) as trunc_1, 
trunc(1234.5678,2) as trunc_2,
trunc(1234.5678,-1) as trunc_minus1, 
trunc(1234.5678,-2) as trunc_minus2
from DUAL;

--CEIL, FLOOR--
select 
ceil(3.14), 
floor(3.14), 
ceil(-3.14), 
floor(-3.14) 
from DUAL;

--날짜 함수--
select 
sysdate as now, 
sysdate-1 as yesterday, 
sysdate+1 as tomorrow
from dual;

--ADD_MONTH(오라클에서만 제공하는 함수)--
select 
sysdate, add_months(sysdate,3) 
from dual;

select * from emp;
--10년째 되는날 
select 
empno, ename, hiredate, add_months(hiredate,120)as work10yrar
from emp;

--ADD해서 sysdate보다 크면 보여줘--
select 
empno, ename, hiredate, sysdate 
from emp 
where add_months(hiredate, 384)>sysdate;

--숫자 또는 날자 데이터를 문자데이터로 --
select sysdate, to_char(sysdate,'HH24:MI:SS') as HH24,
to_char(sysdate,'HH12:MI:SS AM') as HH12, to_char(sysdate,'HH:MI:SS P.M.') as PM
from dual;

--문자를 숫자데이터로--
select to_number('1,300','999,999') - to_number('1,500','999,999') from dual;
--다시 해보기--
select 1300-to_number('1500') as minus, to_number('1300')+1500 as sum from dual;

--문자를 날짜 데이터로--
select to_date('2018-07-14', 'YYYY-MM-DD') as todate1,
to_date('20180714','YYYY-MM-DD') as todate2 from dual;

select * from emp where hiredate>to_date('1981/06/01','YYYY/MM/DD');

--null함수처리(nvl)--
select * from emp;

select empno, ename, sal, comm, sal+comm, nvl(comm,0), sal+nvl(comm,0) from emp;

select empno, ename, sal, comm, nvl2(comm,'O','X'), nvl2(comm, sal*12+comm, sal*12)
as annsal from emp;

--case-when--
select empno, ename, job, sal,
case job
when 'MANAGER' then sal*1.1
when 'SALESMAN' then sal*1.05
when 'ANALYST' then sal
else sal*1.03
end as upsal from emp;

select empno, ename, comm,
case
when comm is null then '해당사항 없음'
when comm = 0 then '수당없음'
when comm > 0 then '수당: '||comm /*concat도 해보자*/
end as comm_text from emp;

--다중행 함수--
select * from emp; /*항시 전체 자료보고, 필요한 코드 작성하자. 예상결과물 미리 확인!!*/

select sum(sal) from emp; /*다시 해보기 sum*/

select count(comm)
from emp;

select count(comm)
from emp
where comm is not null; /*위 코드보다 정확도가 더 좋다. 위 코드보다 아래코드 추천!*/

select max(sal) from emp where deptno=10;

select max(hiredate) from emp where deptno = 20; /*최대값 찾기-현재 원천데이터에 오류있음*/

select min(sal) from emp where deptno=10;

select avg(sal) from emp where deptno=30;

select round(avg(sal)) from emp where deptno=30; /*소수점 반올림*/

select round(avg(sal)), '10' as deptno from emp where deptno=10
union ALL
select round(avg(sal)), '20' as deptno from emp where deptno=20
union all
select round(avg(sal)), '30' as deptno from emp where deptno=30; /*부분합 계산*/

--Group By-- /*union all로 할꺼를 한방에*/
select * from emp;

select round(avg(sal)), deptno from emp group by deptno;

select deptno, job, avg(sal) from emp group by deptno, job
order by deptno, job;

select deptno, job, avg(sal) from emp
group by deptno, job
having avg(sal) >=2000
order by deptno, job;

select deptno, job, avg(sal) from emp /*where과 having, where가 더 높은 위치*/
where sal <=3000
group by deptno, job
having avg(sal) >=2000
order by deptno, job;

select * from emp where mgr is not null;

SELECT *
FROM EMP
WHERE SAL > NULL
OR COMM IS NULL;

SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
WHERE DEPTNO = 10
UNION ALL
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP
WHERE DEPTNO = 10;

--salgreade / bonus 테이블 추가생성--
create table salgrade(
  grade number,
  losal number,
  hisal number
);
insert into salgrade values (1, 700, 1200);
insert into salgrade values (2, 1201, 1400);
insert into salgrade values (3, 1401, 2000);
insert into salgrade values (4, 2001, 3000);
insert into salgrade values (5, 3001, 9999);

commit;
create table bonus(
  ename varchar2(10),
  job   varchar2(9),
  sal   number,
  comm  number
);

commit;

--join--
SELECT * FROM SALGRADE;

SELECT * FROM EMP;
SELECT * FROM DEPT;

--등가조인--
SELECT * FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
ORDER BY EMPNO;

SELECT E.EMPNO, E.ENAME, E.SAL, D.DEPTNO, D.DNAME, D.LOC
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
AND SAL>=3000;

--셀프 조인 나름 중요하다. "니 상사 누구야!!" 하는 거당--
SELECT E1.EMPNO, E1.ENAME, E1.MGR,
        E2.EMPNO AS 상사번호,
        E2.ENAME AS 상사이름
FROM EMP E1, EMP E2
WHERE E1.MGR = E2.EMPNO;

SELECT E1.EMPNO, E1.ENAME, E1.MGR,
        E2.EMPNO AS 상사번호,
        E2.ENAME AS 상사이름
FROM EMP E1, EMP E2
WHERE E1.MGR = E2.EMPNO(+) 
ORDER BY E1.EMPNO; //오른쪽에 NULL 값을 채우라는 뜻 (NULL이 있어도 보여줘)

--NATURAL JOIN--
SELECT * 
FROM EMP E NATURAL JOIN DEPT D //왼쪽이 기준이다.
ORDER BY DEPTNO, E.EMPNO;

--JOIN~USING--
 SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, 
E.HIREDATE, E.SAL, E.COMM,
DEPTNO, D.DNAME, D.LOC
FROM EMP E JOIN DEPT D USING (DEPTNO); //DEPTNO를 기준으로 조인한다.
ORDER BY DEPTNO, E.EMPNO; //정렬

--JOIN~ON--
SELECT E.EMPNO, E.ENAME, E.JOB, E.MGR, E.HIREDATE, E.SAL, E.COMM, E.DEPTNO,
D.DNAME, D.LOC
FROM EMP E JOIN DEPT D ON(E.DEPTNO = D.DEPTNO)
ORDER BY E.DEPTNO, EMPNO;

--OUTER JOIN(셀프조인의 표준형이라 생각하자)--
SELECT E1.EMPNO, E1.ENAME, E1.MGR, 
E2.EMPNO AS MGR_NO,
E2.ENAME AS MGR_NAME
FROM EMP E1 LEFT OUTER JOIN EMP E2 ON(E1.MGR = E2.EMPNO)
ORDER BY E1.EMPNO;

SELECT E1.EMPNO, E1.ENAME, E1.MGR, 
E2.EMPNO AS MGR_NO,
E2.ENAME AS MGR_NAME
FROM EMP E1 RIGHT OUTER JOIN EMP E2 ON(E1.MGR = E2.EMPNO)
ORDER BY E1.EMPNO;

SELECT E1.EMPNO, E1.ENAME, E1.MGR, 
E2.EMPNO AS MGR_NO,
E2.ENAME AS MGR_NAME
FROM EMP E1 FULL OUTER JOIN EMP E2 ON(E1.MGR = E2.EMPNO)
ORDER BY E1.EMPNO;