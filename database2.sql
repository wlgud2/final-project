insert into zagook_member(id, password, mname, email,job, mdate)
values('user1', 1234, '홍길동', 'user1@com', '학생', sysdate);
/*게시글, 태그 생성*/
insert into zagook_contents(contentsno, id, filename, contents,
rdate, privacy, x_site, y_site)
values((select nvl(max(contentsno),0)+1
from zagook_contents),
'user_3', 'paris.jpg', '다른 지역 게시글321', sysdate, 1,35.83709842555726, 128.6979583564257);

insert	into zagook_contents(contentsno, ID, FILENAME, contents,
rdate, privacy)
values((select nvl(max(contentsno),0)+1
from zagook_contents),
'user1', 'filename1', '중복태그테스트', sysdate, 1);

--중복확인 후 insert
merge into zagook_tag
using dual
on (tag='없는 태그')
when not matched then
insert (tag_id, tag)
values ((select nvl(max(tag_id),0)+1
from zagook_tag), '없는 태그');

insert into zagook_posttag(contentsno, tag_id)
values ((select max(contentsno)
from zagook_contents), (select tag_id from zagook_tag where tag='nice'));

insert into zagook_posttag(contentsno, tag_id)
values (320, (select tag_id from zagook_tag where tag='nice'));

alter table zagook_tag add constraint uniquekey unique (tag);

/*수정*/
update zagook_contents
set filename='eiffel_tower.jpg'
where contentsno =321;
--기존 태그 삭제
delete from zagook_posttag
where contentsno=310;

--새 태그 중복 확인 후 추가
--create의 merge 그대로 사용 후 insert
insert into zagook_posttag(contentsno, tag_id)
values (310, (select tag_id from zagook_tag where tag='새 태그'));

--수정 시 삭제했다면
delete from zagook_posttag
where contentsno=307;

/*삭제*/
delete from zagook_posttag
where contentsno=314;

delete from zagook_tag
where tag_id>20;

delete from zagook_contents
where contentsno>312;

/*구 디테일*/
select c.contentsno, c.contents, c.privacy, m.mname, c.filename, t.tag, c.rdate, c.likecnt
from zagook_contents c, zagook_tag t, zagook_posttag p, zagook_member m
where m.id=c.id
and c.contentsno=p.contentsno
and t.tag_id=p.tag_id
and c.contentsno=308;
/*디테일 수정*/
select c.contentsno, c.contents, c.privacy, m.mname, c.filename, c.rdate, c.likecnt,
'#'||(select listagg(t.tag,' #') within group(order by p.contentsno)
from zagook_tag t, zagook_posttag p
where EXISTS(
    select p.tag_id from zagook_contents c, zagook_posttag p
    where c.contentsno=p.contentsno
)
and t.tag_id=p.tag_id
and p.contentsno=313
)as tag
from zagook_contents c, zagook_member m
where m.id=c.id
and c.contentsno=313;

/*태그 공백제거*/
update zagook_tag set tag =(replace(tag,' ','_'));