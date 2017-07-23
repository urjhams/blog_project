create database btl_blog
go
use btl_blog

go

-- các bảng dữ liệu
create table tbl_user
(
	userName varchar(120) not null unique,
	pass varchar(120) not null,
	name nvarchar(120) not null,
	email nvarchar(120) not null,
	avatar varchar(120),
	accStatus bit,
	lastLogin datetime
)

go

create table tbl_post
(
	postID int not null identity,
	postTitle nvarchar(250) not null,
	postContent nvarchar(max) not null,
	postCover varchar(120),
	userName varchar(120) not null,
	createDate datetime not null,
	postPreContent nvarchar(max)
)

go

create table tbl_comment
(
	commentID int not null identity,
	commentContent nvarchar(max) not null,
	userName varchar(120) not null,
	postID int not null,
	createDate datetime not null
)

-- các bảng quan hệ
go

create table tbl_friends
(
	userName1 varchar(120) not null,
	userName2 varchar(120) not null
)

go

-- primary key

go

alter table tbl_user
add constraint PK_user primary key (userName);

alter table tbl_post
add constraint PK_post primary key (postID);

alter table tbl_comment
add constraint PK_comment primary key (commentID);

alter table tbl_friends
add constraint PK_friends primary key (userName1, userName2);

-- foreign key

go

alter table tbl_post
add constraint FK_post_of_user foreign key (userName) references tbl_user(userName);

alter table tbl_comment
add constraint FK_comment_of_user foreign key (userName) references tbl_user(userName);

alter table tbl_comment
add constraint FK_comment_of_post foreign key (postID) references tbl_post(postID);

alter table tbl_friends
add constraint FK_user1_tblFriends foreign key (userName1) references tbl_user(userName);

alter table tbl_friends
add constraint FK_user2_tblFriends foreign key (userName2) references tbl_user(userName);

-- proceduces

go

create proc prc_checkExistUSer
(
	@userName varchar(120)
)
as
begin
	select count(userName) from tbl_user where userName = @userName;
end

go

create proc prc_login_userName
(
	@userName varchar(120),
	@pwd varchar(120)
)
as
begin
	select count(*) from tbl_user where userName = @userName and tbl_user.pass = @pwd;
end

go

create proc prc_createUser
(
	@userName varchar(120),
	@pass varchar(120),
	@name nvarchar(120),
	@email nvarchar(120),
	@accStatus bit
)
as
begin
	insert into tbl_user(userName,pass,name,email,avatar,accStatus,lastLogin) values(@userName,@pass,@name,@email,null,1,null);
end

go

create proc prc_getAvatar
(
	@userName varchar(120)
)
as
begin
	select avatar from tbl_user where userName = @userName
end

insert into tbl_user(userName,pass,name,email,avatar,accStatus,lastLogin) values('urjhams','quanboy93',N'Quân Đinh',N'urjhams@gmail.com','quan.jpg',1,null);
select * from tbl_post


go

create proc prc_createPost
(
	@title nvarchar(250),
	@content nvarchar(max),
	@cover varchar(120),
	@username varchar(120),
	@date datetime,
	@preTitle nvarchar(max)
)
as
begin
	insert into tbl_post(postTitle,postContent,postCover,userName,createDate,postPreContent) values (@title,@content,@cover,@username,@date,@preTitle)
end

go

create proc allPost
(
	@username varchar(120)
)
as
begin
	select * from tbl_post inner join tbl_user on tbl_user.userName = tbl_post.userName where tbl_post.userName = @username
end

go

create proc numFriend
(
	@username varchar(120)
)
as
begin
	select count(*) as numFriends from tbl_friends
	where (tbl_friends.userName1 = @username or tbl_friends.userName2 = @username)
end


go

create proc getName
(
	@username varchar(120)
)
as
begin
	select name from tbl_user where userName = @username
end


go

create proc numPost
(
	@username varchar(120)
)
as
begin
	select count(*) as posts from tbl_post inner join tbl_user on tbl_user.userName = tbl_post.userName where tbl_post.userName = @username
end

go

create proc topPost
(
	@top Int,
	@username varchar(120)
)
as
begin
	select top(@top) * from tbl_post inner join tbl_user on tbl_post.userName = tbl_user.userName where tbl_post.userName = @username
end

go

create proc countPost
(
	@username varchar(120)
)
as
begin
	select count(*) from tbl_post inner join tbl_user on tbl_post.userName = tbl_user.userName where tbl_post.userName = @username
end

go

create proc getPostContent
(
	@postID int
)
as
begin
	select postTitle, postContent, postCover, tbl_Post.userName, createDate, postPreContent, tbl_user.name, tbl_user.avatar from tbl_post inner join tbl_user on tbl_post.userName = tbl_user.userName where postID = @postID
end
go

create proc alterPost
(
	@postID int,
	@postTitle nvarchar(250),
	@postContent nvarchar(max),
	@postCover varchar(120),
	@createDate datetime,
	@postPreContent nvarchar(max),
	@userName varchar(120)
)
as
begin
	update tbl_post 
	set postTitle = @postTitle,
	postContent = @postContent,
	postCover = @postCover,
	createDate = @createDate,
	postPreContent = @postPreContent

	where postID = @postID
	and userName = @userName
end

go

create proc getComments
(
	@postID int
)
as
begin
	select commentID,commentContent,tbl_comment.userName,tbl_comment.createDate, tbl_user.name as name, tbl_user.avatar as avatar from (tbl_comment inner join tbl_user on tbl_user.userName = tbl_comment.userName) inner join tbl_post on tbl_post.postID = tbl_comment.postID 
	where tbl_comment.postID = @postID
end

go

create proc delComment
(
	@commentID int
)
as
begin
	delete from tbl_comment where commentID = @commentID
end

go

create proc createComment
(
	@commentContent nvarchar(max),
	@userName varchar(120),
	@postID int,
	@createDate datetime
)
as
begin
	insert into tbl_comment(commentContent,userName,postID,createDate) values(@commentContent, @userName, @postID, @createDate)
end

go

create proc addFriend
(
	@userName1 varchar(120),
	@userName2 varchar(120)
)
as
begin
	insert into tbl_friends values(@userName1,@userName2)
end

go

create proc delFriend
(
	@userName1 varchar(120),
	@userName2 varchar(120)
)
as
begin
	delete from tbl_friends where (userName1 = @userName1 and userName2 = @userName2) or (userName1 = @userName2 and userName2 = @userName1)
end

go

create proc getRandomUser
(
	@userName varchar(120)
)
as
begin
	select top 5 * from tbl_user where userName <> @userName  order by NEWID()
end

go

create proc getRandomUser2
as
begin
	select top 5 * from tbl_user order by NEWID()
end

go

create function friendShip (@userName varchar(120))	----------lấy hết các cặp bạn bè của người dùng
returns table
as
return
select * from tbl_friends 
where ((userName1 = @userName and userName2 <> @userName) 
or (userName2 = @userName and userName1 <> @userName))

go
create function myFriends1(@username varchar(120))
returns table
as
return
select userName1 from friendShip(@username) where friendShip.userName1 <> @username

go
create function myFriends2(@username varchar(120))
returns table
as
return
select userName2 from friendShip(@username) where friendShip.userName2 <> @username

go
create function myFriendAcc(@username varchar(120))
returns table
as
return
select userName1 as userName from myFriends1(@username) 
union
select userName2 as userName from myFriends2(@username) 

go
create proc loadFriends	--------------- lọc từ các cặp có chứa người dùng ở trên để ra bạn bè
(
	@userName varchar(120)
)
as
begin
	select tbl_user.userName, name, email, avatar from tbl_user 
	inner join myFriendAcc(@userName) on tbl_user.userName = myFriendAcc.userName
end

go


go

create proc checkFriendship
(
	@username1 varchar(120),
	@username2 varchar(120)
)
as
begin
	select count(*) from tbl_friends
	where ((userName1 = @username1 and userName2 = @username2) or (userName1 = @username2 and userName2 = @username1))
end


select count(*) from tbl_friends
	where ((userName1 = 'kindinh' and userName2 = 'urjhams') or (userName1 = 'urjhams' and userName2 = 'kindinh'))

create proc updateInfo
(
	@userName varchar(120),
	@name nvarchar(120),
	@email nvarchar(120),
	@avatar varchar(120)
)
as
begin
	update tbl_user
	set email = @email,
	name = @name,
	avatar = @avatar
	where userName = @userName
end

go

create proc getMyInfo
(
	@userName nvarchar(120)
)
as
begin
	select name,email from tbl_user where userName = @userName
end

go

create proc createUser
(
	@userName varchar(120),
	@pass varchar(120),
	@name nvarchar(120),
	@email nvarchar(120)
)
as
begin
	insert into tbl_user(userName,pass,name,email,avatar,lastLogin,accStatus) values(@userName,@pass,@name,@email,'unknownuser.png',null,1)
end

go

create proc checkExist
(
	@userName varchar(120)
)
as
begin
	select count(*) from tbl_user where userName = @userName
end
