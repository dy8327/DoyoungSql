-- 자바 오라클 커넥션--
/*오라클에서 테이블 만들고 자바에서 자료 넣기*/
create table boards(
    bno     number primary key,
    btitle  varchar2(100) not null,
    bcontent clob not null,
    bwriter varchar2(50) not null,
    bdate date default sysdate,
    bfilename varchar2(50) null,
    bfiledata blob null
);

COMMIT;

create table users(
userid varchar2(50) primary key,
username varchar2(50) not null,
userpassword varchar2(50) not null,
userage number(3) not null,
useremail varchar2(50) not null
);

create SEQUENCE SEQ_BNO NOCACHE;