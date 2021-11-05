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
	select contentsno, wname, tag, rdate, likecnt, r
		from (
		select contentsno, cateno, pname, price, filename, stock, rdate,
		rownum r
		from(
		select contentsno, cateno, pname, price, filename,
		stock, rdate
		from contents
		<where>
			<choose>
				<when test="col=='pname'">
					pname like '%'||#{word}||'%'
				</when>
				<when test="col=='price'">
					price like '%'||#{word}||'%'
				</when>
				<when test="col=='cateno'">
					cateno like '%'||#{word}||'%'
				</when>
			</choose>
		</where>
		order by contentsno desc
		)
        <![CDATA[       
                )where r >= #{sno} and r <= #{eno}
        ]]><!-- 오라클에서는 이렇게 나눠서 해줘야함 -->