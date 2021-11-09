insert into zagook_member(id, password, mname, email,job, mdate)
values('user1', 1234, '홍길동', 'user1@com', '학생', sysdate);
/*게시글, 태그 생성*/
insert	into zagook_contents(contentsno, ID, FILENAME, contents,
rdate, privacy)
values((select nvl(max(contentsno),0)+1
from zagook_contents),
'user1', 'filename1', 'contents1', sysdate, 1);

select * from zagook_contents;

insert into zagook_tag(tag_id, tag)
values ((select nvl(max(tag_id),0)+1
from zagook_tag), '태그new');

insert into zagook_posttag(contentsno, tag_id)
values ((select max(contentsno)
from zagook_contents), (select max(tag_id)
from zagook_tag));

/*수정*/
update zagook_contents
set contents='내용 수정',
privacy='2'
where contentsno = 1;

update zagook_tag
set tag='태그 수정'
where tag_id=1;

/*삭제*/
delete from zagook_posttag
where contentsno=302;

delete from zagook_tag
where tag_id=1;

delete from zagook_contents
where contentsno=302;

/*목록*/
select c.contentsno, m.mname, t.tag, c.rdate, c.likecnt, r
from (
select c.contentsno, m.mname, t.tag, c.rdate, c.likecnt, rownum r
from(
select c.contentsno, m.mname, t.tag, c.rdate, c.likecnt
from zagook_contents c, zagook_tag t, zagook_posttag p, zagook_member m
where m.id=c.id
and c.contentsno=p.contentsno
and t.tag_id=p.tag_id
));